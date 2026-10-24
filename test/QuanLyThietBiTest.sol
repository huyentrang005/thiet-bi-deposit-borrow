// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../contracts/QuanLyThietBi.sol";

/// @title Kiem thu hop dong QuanLyThietBi (He thong kho thiet bi CLB EquiTech)
/// @notice Kiem tra quy trinh them thiet bi, bat/tat bao tri, muon coc, hoan coc va khau tru hao mon
contract QuanLyThietBiTest {
    QuanLyThietBi public ql;

    event TestPassed(string caseName);

    constructor() payable {
        ql = new QuanLyThietBi();
    }

    /// @notice Test 1: Admin them thiet bi moi vao kho
    function testThemThietBi() external {
        ql.themThietBi("May anh Canon EOS R5", 0.1 ether);
        ql.themThietBi("Bo kit Arduino Uno R4", 0.02 ether);

        require(ql.tongSoThietBi() == 2, "Tong so thiet bi phai la 2");

        (, string memory ten1, uint256 coc1, QuanLyThietBi.TrangThai tt1,,) = ql.layThongTinThietBi(1);
        require(keccak256(bytes(ten1)) == keccak256(bytes("May anh Canon EOS R5")), "Ten thiet bi 1 sai");
        require(coc1 == 0.1 ether, "Tien coc thiet bi 1 sai");
        require(tt1 == QuanLyThietBi.TrangThai.SanSang, "Trang thai khoi tao phai la SanSang");

        emit TestPassed("Test 1: Them thiet bi thanh cong");
    }

    /// @notice Test 2: Chuyen doi trang thai bao tri
    function testCapNhatBaoTri() external {
        ql.capNhatBaoTri(2, true);
        (,,, QuanLyThietBi.TrangThai tt2,,) = ql.layThongTinThietBi(2);
        require(tt2 == QuanLyThietBi.TrangThai.BaoTri, "Thiet bi phai chuyen sang BaoTri");

        ql.capNhatBaoTri(2, false);
        (,,, QuanLyThietBi.TrangThai tt2Ready,,) = ql.layThongTinThietBi(2);
        require(tt2Ready == QuanLyThietBi.TrangThai.SanSang, "Thiet bi phai quay lai SanSang");

        emit TestPassed("Test 2: Cap nhat bao tri thanh cong");
    }

    /// @notice Test 3: Dat coc muon thiet bi
    function testMuonThietBi() external {
        ql.muonThietBi{value: 0.1 ether}(1);

        (,,, QuanLyThietBi.TrangThai tt1, address nguoiMuon,) = ql.layThongTinThietBi(1);
        require(tt1 == QuanLyThietBi.TrangThai.DangMuon, "Trang thai phai la DangMuon");
        require(nguoiMuon == address(this), "Nguoi muon phai la dia chi test contract");

        emit TestPassed("Test 3: Muon thiet bi thanh cong");
    }

    /// @notice Test 4: Nghiệm thu tra va hoan coc kem khau tru hao mon 10% (1000 bps)
    function testTraVaKhauTruHaoMon() external {
        uint256 balanceBefore = address(this).balance;
        // Khau tru 10% (1000 bps)
        ql.traVaHoanCoc(1, 1000);

        (,,, QuanLyThietBi.TrangThai ttSauTra, address nguoiMuonSau,) = ql.layThongTinThietBi(1);
        require(ttSauTra == QuanLyThietBi.TrangThai.SanSang, "Sau khi tra phai quay ve SanSang");
        require(nguoiMuonSau == address(0), "Nguoi muon phai duoc reset");
        require(address(this).balance > balanceBefore, "Phai nhan duoc tien hoan coc");

        emit TestPassed("Test 4: Tra va khau tru hao mon thanh cong");
    }

    /// @notice Nhan tien ETH hoan coc
    receive() external payable {}
}
