// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract QuanLyThietBi is Ownable {
    // Dinh nghia trang thai thiet bi trong kho
    enum TrangThai {
        SanSang,     // 0: Thiet bi san sang cho muon
        DangMuon,    // 1: Thiet bi dang duoc muon
        BaoTri       // 2: Thiet bi dang bao tri hoac hong hoc
    }

    // Cau truc luu tru thong tin thiet bi
    struct ThietBi {
        uint256 id;
        string tenThietBi;
        uint256 tienCoc;
        TrangThai trangThai;
        address nguoiMuon;
        uint256 thoiDiemMuon;
    }

    uint256 public tongSoThietBi;
    mapping(uint256 => ThietBi) public danhSachThietBi;

    // Dinh nghia custom error de tiet kiem gas va ro nghia
    error ThietBiKhongTonTai(uint256 id);
    error KhongDungTienCoc(uint256 daGui, uint256 yeuCau);
    error ThietBiKhongKhaDung(uint256 id);
    error KhauTruKhongHopLe(uint256 khauTruBps);
    error ChuyenTienThatBai();

    // Cac event ghi nhan moi thay doi trang thai tren blockchain
    event ThietBiDaThem(uint256 indexed id, string tenThietBi, uint256 tienCoc);
    event TrangThaiCapNhat(uint256 indexed id, TrangThai trangThaiMoi);
    event ThietBiDuocMuon(uint256 indexed id, address indexed nguoiMuon, uint256 tienCoc);
    event ThietBiDaTra(uint256 indexed id, address indexed nguoiMuon);
    event TienCocDaHoan(uint256 indexed id, address indexed nguoiMuon, uint256 soTienHoan, uint256 soTienKhauTru);

    constructor() Ownable(msg.sender) {}

    // Ham them thiet bi moi vao kho - chi danh cho Owner
    function themThietBi(string calldata _tenThietBi, uint256 _tienCoc) external onlyOwner {
        tongSoThietBi++;
        uint256 idMoi = tongSoThietBi;

        danhSachThietBi[idMoi] = ThietBi({
            id: idMoi,
            tenThietBi: _tenThietBi,
            tienCoc: _tienCoc,
            trangThai: TrangThai.SanSang,
            nguoiMuon: address(0),
            thoiDiemMuon: 0
        });

        emit ThietBiDaThem(idMoi, _tenThietBi, _tienCoc);
    }

    // Ham cap nhat trang thai bao tri cho thiet bi - chi danh cho Owner
    function capNhatBaoTri(uint256 _id, bool _laBaoTri) external onlyOwner {
        if (_id == 0 || _id > tongSoThietBi) revert ThietBiKhongTonTai(_id);
        ThietBi storage tb = danhSachThietBi[_id];
        if (tb.trangThai == TrangThai.DangMuon) revert ThietBiKhongKhaDung(_id);

        tb.trangThai = _laBaoTri ? TrangThai.BaoTri : TrangThai.SanSang;
        emit TrangThaiCapNhat(_id, tb.trangThai);
    }

    // Ham muon thiet bi va ky quy tien coc ETH
    function muonThietBi(uint256 _id) external payable {
        if (_id == 0 || _id > tongSoThietBi) revert ThietBiKhongTonTai(_id);
        ThietBi storage tb = danhSachThietBi[_id];

        // Kiem tra dieu kien (Checks)
        if (tb.trangThai != TrangThai.SanSang) revert ThietBiKhongKhaDung(_id);
        if (msg.value != tb.tienCoc) revert KhongDungTienCoc(msg.value, tb.tienCoc);

        // Cap nhat trang thai hop dong (Effects)
        tb.trangThai = TrangThai.DangMuon;
        tb.nguoiMuon = msg.sender;
        tb.thoiDiemMuon = block.timestamp;

        emit ThietBiDuocMuon(_id, msg.sender, msg.value);
    }

    // Ham xac nhan nhan lai thiet bi va hoan tra tien coc - chi danh cho Owner
    // Khau tru dung basis point (1% = 100; 10000 = 100%) neu thiet bi bi ton hai
    function traVaHoanCoc(uint256 _id, uint256 _khauTruBps) external onlyOwner {
        if (_id == 0 || _id > tongSoThietBi) revert ThietBiKhongTonTai(_id);
        if (_khauTruBps > 10_000) revert KhauTruKhongHopLe(_khauTruBps);

        ThietBi storage tb = danhSachThietBi[_id];
        if (tb.trangThai != TrangThai.DangMuon) revert ThietBiKhongKhaDung(_id);

        address nguoiMuon = tb.nguoiMuon;
        uint256 tongCoc = tb.tienCoc;

        uint256 tienKhauTru = (tongCoc * _khauTruBps) / 10_000;
        uint256 tienHoan = tongCoc - tienKhauTru;

        // Cap nhat trang thai truoc khi chuyen tien (Checks - Effects - Interactions)
        tb.trangThai = TrangThai.SanSang;
        tb.nguoiMuon = address(0);
        tb.thoiDiemMuon = 0;

        emit ThietBiDaTra(_id, nguoiMuon);
        emit TienCocDaHoan(_id, nguoiMuon, tienHoan, tienKhauTru);

        // Tuong tac chuyen tien bang call (Interactions)
        if (tienHoan > 0) {
            (bool success, ) = nguoiMuon.call{value: tienHoan}("");
            if (!success) revert ChuyenTienThatBai();
        }

        if (tienKhauTru > 0) {
            (bool successOwner, ) = owner().call{value: tienKhauTru}("");
            if (!successOwner) revert ChuyenTienThatBai();
        }
    }

    // Ham xem chi tiet thiet bi (khong ton phi gas)
    function layThongTinThietBi(uint256 _id) external view returns (
        uint256 id,
        string memory tenThietBi,
        uint256 tienCoc,
        TrangThai trangThai,
        address nguoiMuon,
        uint256 thoiDiemMuon
    ) {
        if (_id == 0 || _id > tongSoThietBi) revert ThietBiKhongTonTai(_id);
        ThietBi storage tb = danhSachThietBi[_id];
        return (
            tb.id,
            tb.tenThietBi,
            tb.tienCoc,
            tb.trangThai,
            tb.nguoiMuon,
            tb.thoiDiemMuon
        );
    }
}
