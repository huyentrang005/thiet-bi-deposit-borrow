// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

/// @title He thong Dat coc Muon tra Thiet bi (De tai 2 - ECO2432)
/// @notice Quan ly ky quy tien coc ETH, tu dong tinh tien phat tre han va khau tru hao mon theo quy tac CEI
contract ProjectCore is Ownable {
    enum TrangThai { SanSang, DangMuon, BaoTri }

    struct ThietBi {
        uint256 id;
        string ten;
        uint256 tienCoc;        // Tien coc yeu cau (wei)
        uint256 thoiHanMuon;    // So giay toi da duoc muon (vi du: 3 ngay = 259200s)
        uint256 phiPhatMoiNgay; // Muc phat moi ngay neu tra tre (wei)
        TrangThai trangThai;
        address nguoiMuon;
        uint256 thoiDiemMuon;
        uint256 hanChotTra;
    }

    uint256 public tongThietBi;
    mapping(uint256 => ThietBi) public danhSachThietBi;

    // Custom errors giup tiet kiem gas va ro nghia khi debug
    error ThietBiKhongTonTai(uint256 id);
    error ThietBiKhongSanSang(uint256 id);
    error KhongDungTienCoc(uint256 daGui, uint256 yeuCau);
    error KhauTruKhongHopLe(uint256 bps);
    error ChuyenTienThatBai();

    // Events ghi nhan moi bien dong trang thai tren Blockchain
    event ThietBiDaThem(uint256 indexed id, string ten, uint256 tienCoc, uint256 phiPhatMoiNgay);
    event ThietBiDuocMuon(uint256 indexed id, address indexed nguoiMuon, uint256 hanChotTra);
    event ThietBiDaTra(uint256 indexed id, address indexed nguoiMuon, uint256 tienHoan, uint256 tienPhat);
    event TrangThaiBaoTriCapNhat(uint256 indexed id, bool laBaoTri);

    constructor() Ownable(msg.sender) {}

    /// @notice Them thiet bi moi vao kho - Chi Quan tri vien (Owner)
    function themThietBi(
        string calldata _ten,
        uint256 _tienCoc,
        uint256 _thoiHanMuon,
        uint256 _phiPhatMoiNgay
    ) external onlyOwner {
        tongThietBi++;
        uint256 idMoi = tongThietBi;

        danhSachThietBi[idMoi] = ThietBi({
            id: idMoi,
            ten: _ten,
            tienCoc: _tienCoc,
            thoiHanMuon: _thoiHanMuon,
            phiPhatMoiNgay: _phiPhatMoiNgay,
            trangThai: TrangThai.SanSang,
            nguoiMuon: address(0),
            thoiDiemMuon: 0,
            hanChotTra: 0
        });

        emit ThietBiDaThem(idMoi, _ten, _tienCoc, _phiPhatMoiNgay);
    }

    /// @notice Sinh vien dat coc va nhan thiet bi
    function muonThietBi(uint256 _id) external payable {
        if (_id == 0 || _id > tongThietBi) revert ThietBiKhongTonTai(_id);
        ThietBi storage tb = danhSachThietBi[_id];

        // 1. Checks: Kiem tra trang thai va so tien coc
        if (tb.trangThai != TrangThai.SanSang) revert ThietBiKhongSanSang(_id);
        if (msg.value != tb.tienCoc) revert KhongDungTienCoc(msg.value, tb.tienCoc);

        // 2. Effects: Cap nhat trang thai truoc
        tb.trangThai = TrangThai.DangMuon;
        tb.nguoiMuon = msg.sender;
        tb.thoiDiemMuon = block.timestamp;
        tb.hanChotTra = block.timestamp + tb.thoiHanMuon;

        emit ThietBiDuocMuon(_id, msg.sender, tb.hanChotTra);
    }

    /// @notice Tinh tien phat neu thiet bi bi tra tre han
    function tinhTienPhat(uint256 _id, uint256 _thoiDiemTra) public view returns (uint256) {
        ThietBi storage tb = danhSachThietBi[_id];
        if (_thoiDiemTra <= tb.hanChotTra) {
            return 0;
        }
        uint256 soGiayTre = _thoiDiemTra - tb.hanChotTra;
        // Quy doi ra so ngay tre (lam tron len neu le gio)
        uint256 soNgayTre = (soGiayTre + 1 days - 1) / 1 days;
        uint256 phat = soNgayTre * tb.phiPhatMoiNgay;
        return phat > tb.tienCoc ? tb.tienCoc : phat;
    }

    /// @notice Nghiem thu tra thiet bi va hoan coc (Quy tac Checks-Effects-Interactions)
    /// @param _haoMonBps Ty le khau tru hu hong vat ly (1% = 100 bps, 10000 = 100%)
    function traVaHoanCoc(uint256 _id, uint256 _haoMonBps) external onlyOwner {
        if (_id == 0 || _id > tongThietBi) revert ThietBiKhongTonTai(_id);
        if (_haoMonBps > 10_000) revert KhauTruKhongHopLe(_haoMonBps);

        ThietBi storage tb = danhSachThietBi[_id];
        if (tb.trangThai != TrangThai.DangMuon) revert ThietBiKhongSanSang(_id);

        address nguoiMuon = tb.nguoiMuon;
        uint256 tongCoc = tb.tienCoc;

        // 1. Checks & Tinh toan tien phat tre han va khau tru hao mon
        uint256 phatTre = tinhTienPhat(_id, block.timestamp);
        uint256 khauTruHaoMon = ((tongCoc - phatTre) * _haoMonBps) / 10_000;
        uint256 tongKhauTru = phatTre + khauTruHaoMon;
        if (tongKhauTru > tongCoc) {
            tongKhauTru = tongCoc;
        }
        uint256 tienHoan = tongCoc - tongKhauTru;

        // 2. Effects: Xoa thong tin nguoi muon va mo khoa thiet bi TRUOC KHI chuyen tien
        tb.trangThai = TrangThai.SanSang;
        tb.nguoiMuon = address(0);
        tb.thoiDiemMuon = 0;
        tb.hanChotTra = 0;

        emit ThietBiDaTra(_id, nguoiMuon, tienHoan, tongKhauTru);

        // 3. Interactions: Chuyen tien cuoi cung
        if (tienHoan > 0) {
            (bool successUser, ) = payable(nguoiMuon).call{value: tienHoan}("");
            if (!successUser) revert ChuyenTienThatBai();
        }

        if (tongKhauTru > 0) {
            (bool successOwner, ) = payable(owner()).call{value: tongKhauTru}("");
            if (!successOwner) revert ChuyenTienThatBai();
        }
    }

    /// @notice Cap nhat trang thai bao tri thiet bi
    function capNhatBaoTri(uint256 _id, bool _laBaoTri) external onlyOwner {
        if (_id == 0 || _id > tongThietBi) revert ThietBiKhongTonTai(_id);
        ThietBi storage tb = danhSachThietBi[_id];
        if (tb.trangThai == TrangThai.DangMuon) revert ThietBiKhongSanSang(_id);

        tb.trangThai = _laBaoTri ? TrangThai.BaoTri : TrangThai.SanSang;
        emit TrangThaiBaoTriCapNhat(_id, _laBaoTri);
    }
}
