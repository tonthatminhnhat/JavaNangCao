-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th1 18, 2024 lúc 07:58 AM
-- Phiên bản máy phục vụ: 10.4.28-MariaDB
-- Phiên bản PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `webdobo`
--

DELIMITER $$
--
-- Thủ tục
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertAnh` (IN `Madssp` VARCHAR(5), IN `Mau` VARCHAR(20), IN `Path` VARCHAR(50))   BEGIN
  -- Không cần insert giá trị cho idanh, vì nó tự động tăng
  INSERT INTO `anh`(`madssp`, `mau`, `path`) VALUES (Madssp, Mau, Path);
  -- Lấy giá trị idanh sau khi insert
  SET @newIdanh = LAST_INSERT_ID();
  -- Cập nhật maanh
  UPDATE `anh`
  SET `maanh` = CONCAT(Madssp, @newIdanh)
  WHERE `idanh` = @newIdanh;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertAnhID` (IN `newIdanh` INT, IN `newMadssp` VARCHAR(5), IN `newMau` VARCHAR(20), IN `newPath` VARCHAR(20))   BEGIN
  INSERT INTO `anh`(`idanh`, `madssp`, `mau`, `path`) VALUES (newIdanh, newMadssp, newMau, newPath);
  -- Cập nhật maanh
  UPDATE `anh`
  SET `maanh` = CONCAT(newMadssp, newIdanh)
  WHERE `idanh` = newIdanh;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertSanPham` (IN `newNamesp` VARCHAR(100), IN `newIdmodel` VARCHAR(2))   BEGIN
  INSERT INTO `dssanpham`(`namesp`, `idmodel`) VALUES (newNamesp, newIdmodel);
  SET @newIddssp = LAST_INSERT_ID();
  UPDATE `dssanpham`
  SET `madssp` = CONCAT(@newIddssp, newIdmodel)
  WHERE `iddssp` = @newIddssp;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertSanPhamId` (IN `newIddssp` INT, IN `newNamesp` VARCHAR(100), IN `newIdmodel` VARCHAR(2))   BEGIN
  INSERT INTO `dssanpham`(`iddssp`, `namesp`, `idmodel`) VALUES (newIddssp, newNamesp, newIdmodel);
  UPDATE `dssanpham`
  SET `madssp` = CONCAT(newIddssp, newIdmodel)
  WHERE `iddssp` = newIddssp;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertSP` (IN `in_maanh` VARCHAR(9), IN `in_size` VARCHAR(3), IN `in_soluong` SMALLINT)   BEGIN
    DECLARE v_RemainingPart VARCHAR(12);
    DECLARE v_LastNumberPart INT;   
    -- Thêm mới vào bảng sanpham
    INSERT INTO sanpham (maanh, size, soluong)
    VALUES (in_maanh, in_size, in_soluong);  
    -- Lấy idsp của bản ghi vừa thêm mới
    SET v_LastNumberPart = LAST_INSERT_ID(); 
    -- Cập nhật masp và madssp
    SET v_RemainingPart = (
        SELECT
            REGEXP_REPLACE(maanh, '[0-9]+$', '') as RemainingPart
        FROM sanpham
        WHERE idsp = v_LastNumberPart
    );    
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            -- Nếu có lỗi trong quá trình UPDATE, thực hiện DELETE
            DELETE FROM sanpham WHERE idsp = v_LastNumberPart;
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Trùng mã rồi !!!!';
       
        END;
        
        UPDATE sanpham
        SET masp = CONCAT(maanh, in_size),
            madssp = v_RemainingPart
        WHERE idsp = v_LastNumberPart;
    END;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertUpdatemadssp` (IN `namesp` VARCHAR(100), IN `idmodel` VARCHAR(2), IN `gia` INT, IN `sale` INT, IN `hethang` BOOLEAN, IN `soluongban` INT, IN `loaivai` VARCHAR(15), IN `path` VARCHAR(40))   BEGIN
   DECLARE new_iddssp INT;
   -- Chèn dữ liệu vào bảng
   INSERT INTO dssanpham(namesp, idmodel, gia, sale, hethang, soluongban, loaivai, path)
   VALUES (namesp, idmodel, gia, sale, hethang, soluongban, loaivai, path);
   -- Lấy iddssp mới được tạo
   SET new_iddssp = LAST_INSERT_ID();
   -- Cập nhật madssp
   UPDATE dssanpham
   SET madssp = CONCAT(new_iddssp, idmodel)
   WHERE iddssp = new_iddssp;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `anh`
--

CREATE TABLE `anh` (
  `idanh` int(11) NOT NULL,
  `madssp` char(5) DEFAULT NULL,
  `mau` char(25) DEFAULT NULL,
  `path` char(100) DEFAULT NULL,
  `maanh` char(9) NOT NULL,
  `hethang` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `anh`
--

INSERT INTO `anh` (`idanh`, `madssp`, `mau`, `path`, `maanh`, `hethang`) VALUES
(1, '1BD', 'Ghi milăng', '1BD Ghi milăng.webp', '1BD1', 0),
(2, '1BD', 'Tím lavender', '1BD Tím lavender.webp', '1BD2', 0),
(3, '1BD', 'Xanh ngọc bích', '1BD Xanh ngọc bích.webp', '1BD3', 0),
(4, '1BD', 'Đen', '1BD Đen.webp', '1BD4', 0),
(5, '2BD', 'Cacao', '2BD Cacao.webp', '2BD5', 0),
(6, '2BD', 'Hồng sen', '2BD Hồng sen.webp', '2BD6', 0),
(7, '2BD', 'Phấn Hồng', '2BD Phấn Hồng.webp', '2BD7', 0),
(8, '4BD', 'Cam đỏ', '4BD Cam đỏ.webp', '4BD8', 0),
(9, '4BD', 'Navy', '4BD Navy.webp', '4BD9', 0),
(10, '4BD', 'Nâu đất', '4BD Nâu đất.webp', '4BD10', 0),
(11, '5BD', 'Ghi mi lăng', '5BD Ghi mi lăng.webp', '5BD11', 0),
(12, '5BD', 'Nâu lạnh', '5BD Nâu lạnh.webp', '5BD12', 0),
(13, '5BD', 'Xanh than', '5BD Xanh than.webp', '5BD13', 1),
(14, '6BD', 'Trắng hoa ly', '6BD Trắng hoa ly.webp', '6BD14', 0),
(15, '6BD', 'Xanh vân đá', '6BD Xanh vân đá.webp', '6BD15', 0),
(16, '7BD', 'Cam đất', '7BD Cam đất.webp', '7BD16', 0),
(17, '7BD', 'Xanh biển', '7BD Xanh biển.webp', '7BD17', 0),
(18, '7BD', 'Đỏ đô', '7BD Đỏ đô.webp', '7BD18', 0),
(19, '7BD', 'Hồng tây', '7BD Hồng tây.webp', '7BD19', 0),
(20, '8BD', 'Nâu hoa hồng', '8BD Nâu hoa hồng.webp', '8BD20', 0),
(21, '8BD', 'Nâu đất hoa dây', '8BD Nâu đất hoa dây.webp', '8BD21', 0),
(22, '8BD', 'Trắng hoa tím', '8BD Trắng hoa tím.webp', '8BD22', 0),
(23, '9BD', 'Vàng kẻ', '9BD Vàng kẻ.webp', '9BD23', 0),
(24, '10BD', 'Be vệt sơn', '10BD Be vệt sơn.webp', '10BD24', 0),
(25, '10BD', 'Navy ho dây', '10BD Navy ho dây.webp', '10BD25', 0),
(26, '10BD', 'Trắng hoa xanh', '10BD Trắng hoa xanh.webp', '10BD26', 0),
(27, '10BD', 'Xanh nâu hình', '10BD Xanh nâu hình.webp', '10BD27', 0),
(28, '11BD', 'Bạc hà', '11BD Bạc hà.webp', '11BD28', 1),
(29, '11BD', 'Tím', '11BD Tím.webp', '11BD29', 1),
(30, '12BD', 'Trắng ghi', '12BD Trắng ghi.webp', '12BD30', 0),
(31, '12BD', 'Vàng nhạt', '12BD Vàng nhạt.webp', '12BD31', 1),
(32, '12BD', 'Xanh hoa hồng', '12BD Xanh hoa hồng.webp', '12BD32', 0),
(40, '20BĐ', 'Hồng đỏ', '20bđ hồng đỏ.webp', '20BĐ40', 0),
(41, '20BĐ', 'Navy', '20bđ navy.webp', '20BĐ41', 0),
(42, '20BĐ', 'Oải hương', '20bđ oải hương.webp', '20BĐ42', 0),
(43, '20BĐ', 'Xanh biển', '20bđ xanh biển.webp', '20BĐ43', 0),
(44, '21BĐ', 'Trắng hoa cam', '21bđ trắng hoa cam.webp', '21BĐ44', 0),
(45, '21BĐ', 'Trắng hoa hồng', '21bđ trắng hoa hồng.webp', '21BĐ45', 0),
(46, '21BĐ', 'Trắng hoa xanh dây', '21bđ Trắng hoa xanh dây.webp', '21BĐ46', 0),
(47, '22BĐ', 'Cam hoa cúc', '22bđ cam hoa cúc.webp', '22BĐ47', 0),
(48, '22BĐ', 'Trắng hoa lan xanh', '22bđ trắng hoa lan xanh.webp', '22BĐ48', 0),
(49, '23BĐ', 'Cam cháy hoa dây', '23bđ cam cháy hoa dây.webp', '23BĐ49', 0),
(50, '23BĐ', 'Ghi đá hoa nhí', '23bđ ghi đá hoa nhí.webp', '23BĐ50', 0),
(51, '23BĐ', 'Trắng hoa ban', '23bđ trắng hoa ban.webp', '23BĐ51', 0),
(52, '23BĐ', 'Trắng vệt sơn', '23bđ trắng vệt sơn.webp', '23BĐ52', 0),
(53, '24BĐ', 'Nâu đất hoa dây', '24bđ nâu đất hoa dây.webp', '24BĐ53', 0),
(54, '24BĐ', 'Vàng hoa cúc', '24bđ vàng hoa cúc.webp', '24BĐ54', 0),
(55, '24BĐ', 'Xanh biển hoa nhí', '24bđ xanh biển hoa nhí.webp', '24BĐ55', 0),
(56, '25BĐ', 'Tím hoa nhí', '25bđ tím hoa nhí.webp', '25BĐ56', 1),
(57, '25BĐ', 'Vàng hoa tiết', '25bđ vàng họa tiết.webp', '25BĐ57', 1),
(58, '25BĐ', 'Đỏ hoa dây', '25bđ đỏ hoa dây.webp', '25BĐ58', 1),
(59, '26BĐ', 'Navy hoa dây', '26bđ navy hoa dây.webp', '26BĐ59', 0),
(60, '26BĐ', 'Trắng hoa dây nâu', '26bđ trắng hoa dây nâu.webp', '26BĐ60', 0),
(61, '26BĐ', 'Trắng hoa vàng nhí', '26bđ trắng hoa vàng nhí.webp', '26BĐ61', 0),
(62, '27BĐ', 'Hồng phấn', '27bđ hồng phấn.webp', '27BĐ62', 0),
(63, '27BĐ', 'Vàng mơ', '27bđ vàng mơ.webp', '27BĐ63', 0),
(64, '27BĐ', 'Xanh dương', '27bđ xanh dương.webp', '27BĐ64', 0),
(65, '28BĐ', 'Cacao', '28bđ cacao.webp', '28BĐ65', 1),
(66, '28BĐ', 'Hồng sen', '28bđ hồng sen.webp', '28BĐ66', 0),
(67, '29BĐ', 'Xanh đậm', '29bđ xanh đậm.webp', '29BĐ67', 0),
(68, '30BĐ', 'Be sữa', '30bđ be sữa.webp', '30BĐ68', 0),
(69, '30BĐ', 'Xanh biển', '30bđ xanh biển.webp', '30BĐ69', 0),
(70, '31BĐ', 'Phấn hồng', '31bđ phấn hồng.webp', '31BĐ70', 0),
(71, '31BĐ', 'Trắng hoa vàng nhí', '31bđ trắng hoa vàng nhí.webp', '31BĐ71', 0),
(72, '32BĐ', 'Cát vàng', '32bđ cát vàng.webp', '32BĐ72', 1),
(73, '32BĐ', 'Gấu nâu', '32bđ gấu nâu.webp', '32BĐ73', 0),
(80, '40BL', 'Navy hoa dây', '40bl navy hoa dây.webp', '40BL80', 0),
(81, '40BL', 'Trắng hoa dây nâu', '40bl trắng hoa dây nâu.webp', '40BL81', 0),
(82, '40BL', 'Trắng hoa lam nhí', '40bl trắng hoa lam nhí.webp', '40BL82', 0),
(83, '40BL', 'Trắng hoa vàng nhí', '40bl trắng hoa vàng nhí.webp', '40BL83', 0),
(84, '41BL', 'Nâu cam hoa nhí', '41bl nâu cam hoa nhí.webp', '41BL84', 0),
(85, '41BL', 'Trắng hoa cam', '41bl trắng hoa cam.webp', '41BL85', 0),
(86, '41BL', 'Trắng hoa dây hồng', '41bl trắng hoa dây hồng.webp', '41BL86', 0),
(87, '42BL', 'Hồng hoa đỏ', '42bl hồng hoa đỏ.webp', '42BL87', 0),
(88, '42BL', 'Đen hình', '42bl đen hình.webp', '42BL88', 0),
(89, '42BL', 'Đỏ đô hoa dây', '42bl đỏ đô hoa dây.webp', '42BL89', 0),
(90, '43BL', 'Hồng đào', '43bl hồng đào.webp', '43BL90', 0),
(91, '43BL', 'Xanh dương', '43bl xanh dương.webp', '43BL91', 0),
(92, '44BL', 'Cam đất', '44bl cam đất.webp', '44BL92', 0),
(93, '44BL', 'Hồng tây', '44bl hồng tây.webp', '44BL93', 0),
(94, '45BL', 'Be lá cọ', '45bl be lá cọ.webp', '45BL94', 1),
(95, '45BL', 'Nâu họa tiết', '45bl nâu họa tiết.webp', '45BL95', 0),
(96, '45BL', 'Trắng hình đỏ', '45bl trắng hình đỏ.webp', '45BL96', 0),
(97, '46BL', 'Nâu họa tiết', '46bl nâu họa tiết.webp', '46BL97', 0),
(98, '46BL', 'Trắng hoa xanh', '46bl trắng hoa xanh.webp', '46BL98', 0),
(99, '46BL', 'Trắng lá thông', '46bl trắng lá thông.webp', '46BL99', 0),
(100, '47BL', 'Trắng nho xanh', '47bl trắng nho xanh.webp', '47BL100', 0),
(101, '47BL', 'Vàng họa tiết', '47bl vàng họa tiết.webp', '47BL101', 0),
(102, '47BL', 'Đỏ hoa dây', '47bl đỏ hoa dây.webp', '47BL102', 0),
(110, '60BP', 'Cam đất', '60bp cam đất.webp', '60BP110', 0),
(111, '60BP', 'Navy', '60bp navy.webp', '60BP111', 1),
(112, '60BP', 'Nâu tây', '60bp nâu tây.webp', '60BP112', 0),
(113, '60BP', 'Đỏ đô', '60bp đỏ đô.webp', '60BP113', 1),
(114, '61BP', 'Vàng kẻ', '61bp vàng kẻ.webp', '61BP114', 0),
(115, '62BP', 'Nâu vá', '62bp nâu vá.webp', '62BP115', 0),
(116, '63BP', 'Đen', '63bp đen.webp', '63BP116', 0),
(117, '64BP', 'Tím', '64bp tím.webp', '64BP117', 0),
(118, '64BP', 'Xanh ghi', '64bp xanh ghi.webp', '64BP118', 0),
(119, '64BP', 'Đen', '64bp đen.webp', '64BP119', 0),
(120, '65BP', 'Navy hình', '65bp navy hình.webp', '65BP120', 0),
(121, '65BP', 'Phấn hồng hoa cúc', '65bp phấn hồng hoa cúc.webp', '65BP121', 0),
(122, '65BP', 'Xanh ghi hình', '65bp xanh ghi hình.webp', '65BP122', 0),
(123, '66BP', 'Cát vàng', '66bp cát vàng.webp', '66BP123', 0),
(124, '66BP', 'Navy', '66bp navy.webp', '66BP124', 0),
(125, '66BP', 'Nâu tây', '66bp nâu tây.webp', '66BP125', 0),
(126, '67BP', 'Cát vàng', '67bp cát vàng.webp', '67BP126', 0),
(127, '67BP', 'Ghi đá hoa', '67bp ghi đá hoa.webp', '67BP127', 0),
(140, '80DL', 'Trắng ghi', '80dl trắng ghi.webp', '80DL140', 0),
(141, '80DL', 'Vàng nhạt', '80dl vàng nhạt.webp', '80DL141', 0),
(142, '80DL', 'Xanh hoa hồng', '80dl xanh hoa hồng.webp', '80DL142', 0),
(143, '81DL', 'Be hoa đỏ', '81dl be hoa đỏ.webp', '81DL143', 0),
(144, '81DL', 'Trắng cây đa', '81dl trắng cây đa.webp', '81DL144', 0),
(145, '81DL', 'Xanh cốm', '81dl xanh cốm.webp', '81DL145', 0),
(146, '81DL', 'Xanh hoa lam', '81dl xanh hoa lam.webp', '81DL146', 0),
(152, '1BD', '11111', '1BD Tím lavender.webp', '1BD152', 0),
(153, '1BD', 'ca cai', '2BD Cacao.webp', '1BD153', 0),
(157, '244BD', 'ca cai', '2BD Cacao.webp', '244BD157', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dssanpham`
--

CREATE TABLE `dssanpham` (
  `iddssp` int(11) NOT NULL,
  `madssp` varchar(5) DEFAULT NULL,
  `namesp` varchar(100) DEFAULT NULL,
  `idmodel` varchar(2) DEFAULT NULL,
  `gia` mediumint(8) UNSIGNED DEFAULT NULL,
  `sale` tinyint(4) NOT NULL,
  `hethang` tinyint(1) NOT NULL,
  `soluongban` smallint(5) UNSIGNED NOT NULL,
  `loaivai` varchar(15) NOT NULL,
  `path` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `dssanpham`
--

INSERT INTO `dssanpham` (`iddssp`, `madssp`, `namesp`, `idmodel`, `gia`, `sale`, `hethang`, `soluongban`, `loaivai`, `path`) VALUES
(1, '1BD', 'Bộ thu đông mặc nhà chất liệu tăm Hàn cổ thuyền tay lỡ bo gấu', 'BD', 220000, 0, 0, 857, 'Tăm Hàn', '1BD Ghi milăng.webp'),
(2, '2BD', 'Bộ cotton kẻ cổ tròn có túi', 'BD', 260000, 0, 0, 1442, 'Cotton', '2BD Cacao.webp'),
(4, '4BD', 'Set bộ công sở chất đũi Nhật quần suông áo cổ tròn tay xếp ly bồng dáng lỡ', 'BD', 200000, 0, 0, 1139, 'Đũi Nhật', '4BD Cam đỏ.webp'),
(5, '5BD', 'Bộ mặc nhà thu đông chất liệu tăm Hàn dáng quần suông tay phối bo gấu', 'BD', 200000, 40, 0, 867, 'Tăm Hàn', '5BD Ghi mi lăng.webp'),
(6, '6BD', 'Bộ lụa dài tay quần dài cổ sen chất lụa Latin cao cấp, thoáng mát', 'BD', 200000, 0, 0, 1921, 'Lụa Latin', '6BD Trắng hoa ly.webp'),
(7, '7BD', 'Bộ cotton mặc nhà cao cấp quần dài cổ tròn tay lửng', 'BD', 210000, 10, 0, 1999, 'Cotton', '7BD Cam đất.webp'),
(8, '8BD', 'Bộ lanh dáng dài kiểu dáng cổ thuyền tay cộc cạp chun', 'BD', 210000, 0, 0, 733, 'Lanh', '8BD Nâu hoa hồng.webp'),
(9, '9BD', 'Bộ mặc nhà chất thô thiết kế kẻ caro cổ vuông tay phồng', 'BD', 210000, 0, 0, 1672, 'Chất Thô', '9BD Vàng kẻ.webp'),
(10, '10BD', 'Bộ lanh dài sát nách cổ thuyền trẻ trung, cạp chun co giãn thoải mái mặc nhà', 'BD', 200000, 25, 0, 1159, 'Lanh', '10BD Be vệt sơn.webp'),
(11, '11BD', 'Đồ bộ nữ mặc nhà chất đũi, kiểu dáng quần ống rộng áo sát nách cúc sườn', 'BD', 200000, 0, 1, 1779, 'Đũi', '11BD Bạc hà.webp'),
(12, '12BD', 'Bộ mango họa tiết tay lửng, phối màu trang nhã, kiểu dáng thanh lịch đi chùa', 'BD', 210000, 30, 0, 1915, 'Mango', '12BD Trắng ghi.webp'),
(20, '20BĐ', 'Bộ đùi mặc nhà chất cotton Nhật dáng sát nách cổ tim', 'BĐ', 270000, 0, 0, 737, 'Cotton', '20bđ hồng đỏ.webp'),
(21, '21BĐ', 'Bộ đùi sát nách cạp chun mặc nhà 2 tầng chất Lanh Tre thoáng mát', 'BĐ', 220000, 20, 0, 1943, 'Lanh Tre', '21bđ trắng hoa cam.webp'),
(22, '22BĐ', 'Set tơ hoa sơ mi quần đùi thoáng mát - Tặng kèm áo 2 dây tăm lạnh', 'BĐ', 240000, 25, 0, 1001, 'Tơ', '22bđ cam hoa cúc.webp'),
(23, '23BĐ', 'Bộ mặc nhà chất lanh tre dáng quần đùi tay cộc cổ tim bèo', 'BĐ', 210000, 0, 0, 1677, 'Lanh Tre', '23bđ cam cháy hoa dây.webp'),
(24, '24BĐ', 'Bộ đùi mặc nhà chất Lanh Tre cổ tròn tay cánh tiên', 'BĐ', 220000, 0, 0, 1881, 'Lanh Tre', '24bđ nâu đất hoa dây.webp'),
(25, '25BĐ', 'Bộ Đùi Mặc Nhà Chất Lanh Tre Thoáng Mát, Mềm Mại Dáng Sát Nách Cổ Tròn Gấu Bèo', 'BĐ', 200000, 0, 1, 873, 'Lanh Tre', '25bđ tím hoa nhí.webp'),
(26, '26BĐ', 'Bộ lanh dáng lửng xếp bèo cổ có lé, đồ bộ mặc nhà cao cấp', 'BĐ', 220000, 25, 0, 1224, 'Lanh', '26bđ navy hoa dây.webp'),
(27, '27BĐ', 'Bộ quần áo mặc nhà chất đũi, kiểu dáng quần đùi áo cổ vuông tay hến', 'BĐ', 200000, 0, 0, 1499, 'Đũi', '27bđ hồng phấn.webp'),
(28, '28BĐ', 'Bộ đùi mặc nhà chất đũi bamboo kiểu dáng sát nách cổ V', 'BĐ', 220000, 0, 0, 1823, 'Đũi Bamboo', '28bđ cacao.webp'),
(29, '29BĐ', 'Bộ sơ mi cộc tay chất đũi, đồ bộ nữ cao cấp', 'BĐ', 200000, 20, 0, 1118, 'Đũi', '29bđ xanh đậm.webp'),
(30, '30BĐ', 'Bộ đùi mặc nhà chất linen, kiểu dáng áo sát nách quần đùi', 'BĐ', 220000, 0, 0, 1121, 'Linen', '30bđ be sữa.webp'),
(31, '31BĐ', 'Bộ hè mặc nhà chất lụa mango kiểu dáng quần đùi sát nách cổ tròn', 'BĐ', 230000, 0, 0, 1753, 'Lụa Mango', '31bđ phấn hồng.webp'),
(32, '32BĐ', 'Bộ pijama lụa Satin quần đùi áo cộc, bộ mặc nhà cao cấp Cardina', 'BĐ', 270000, 15, 0, 1901, 'Lụa Satin', '32bđ cát vàng.webp'),
(40, '40BL', 'Bộ lanh dáng lửng xếp bèo cổ có lé, đồ bộ mặc nhà cao cấp', 'BL', 200000, 15, 0, 745, 'Lanh', '40bl navy hoa dây.webp'),
(41, '41BL', 'Đồ bộ nữ chất lụa satin nhật cao cấp, kiểu dáng áo sát nách vai bèo lật quần lửng', 'BL', 240000, 0, 0, 523, 'Lụa Satin', '41bl nâu cam hoa nhí.webp'),
(42, '42BL', 'Bộ lụa mango mặc nhà dáng lửng cố V có lé cao cấp', 'BL', 220000, 0, 0, 1384, 'Lụa Mango', '42bl hồng hoa đỏ.webp'),
(43, '43BL', 'Bộ đồ nữ chất đũi cao cấp, kiểu dáng áo cổ tròn quần lửng', 'BL', 270000, 0, 0, 1846, 'Đũi', '43bl hồng đào.webp'),
(44, '44BL', 'Bộ đùi mặc nhà cao cấp, kiểu dáng cổ tim áo tay cánh tiên quần lửng', 'BL', 200000, 0, 0, 1578, 'Đũi', '44bl cam đất.webp'),
(45, '45BL', 'Bộ mặc nhà áo sát nách quần lửng chất lụa Satin co giãn nhẹ', 'BL', 250000, 0, 0, 1853, 'Lụa Satin', '45bl be lá cọ.webp'),
(46, '46BL', 'Đồ bộ nữ chất lanh tre nhật cao cấp quần lửng áo sát nách', 'BL', 250000, 25, 0, 1027, 'Lanh Tre', '46bl nâu họa tiết.webp'),
(47, '47BL', 'Đồ bộ kiểu nữ dáng lửng tay liền cổ tàu chất lanh tre Nhật cao cấp', 'BL', 200000, 0, 0, 581, 'Lanh Tre', '47bl trắng nho xanh.webp'),
(60, '60BP', 'Bộ Pijama chất nhung tăm cao cấp, kiểu dáng sang trọng', 'BP', 240000, 0, 0, 822, 'Nhung Tăm', '60bp cam đất.webp'),
(61, '61BP', 'Bộ pijama mặc nhà nữ chất liệu thô, kiểu dáng tay cộc quần dài', 'BP', 280000, 0, 0, 1871, 'Chất Thô', '61bp vàng kẻ.webp'),
(62, '62BP', 'Bộ Pijama mặc nhà chất lụa, kiểu dáng cộc tay phối cổ quần dài', 'BP', 270000, 0, 0, 1885, 'Lụa', '62bp nâu vá.webp'),
(63, '63BP', 'Bộ pijama nhung mềm mịn, thiết kế viền trắng sang trọng', 'BP', 200000, 0, 0, 1812, 'Nhung', '63bp đen.webp'),
(64, '64BP', 'Bộ Pijama thu đông chất nhung tăm, kiểu dáng phối cổ cao cấp', 'BP', 200000, 0, 0, 1406, 'Nhung Tăm', '64bp tím.webp'),
(65, '65BP', 'Bộ pijama lụa lửng họa tiết, đồ bộ mặc nhà nữ cao cấp', 'BP', 200000, 0, 0, 1092, 'Lụa', '65bp navy hình.webp'),
(66, '66BP', 'Bộ pijama lụa quần đùi áo cộc, set đồ bộ nữ mặc nhà', 'BP', 220000, 50, 0, 745, 'Lụa', '66bp cát vàng.webp'),
(67, '67BP', 'Bộ pijama lụa Satin quần đùi áo cộc, bộ mặc nhà cao cấp', 'BP', 230000, 0, 0, 1448, 'Lụa Satin', '67bp cát vàng.webp'),
(80, '80DL', 'Bộ mango họa tiết tay lửng, phối màu trang nhã, kiểu dáng thanh lịch đi chùa', 'DL', 255000, 0, 0, 1505, 'Mango', '80dl trắng ghi.webp'),
(81, '81DL', 'Đồ bộ mặc đi chùa vải đũi bamboo, thiết kế họa tiết tay lỡ lịch sự', 'DL', 200000, 15, 0, 1178, 'Đũi Bamboo', '81dl be hoa đỏ.webp'),
(243, '243BD', 'Bộ cotton kẻ cổ tròn có túi', 'BD', 260000, 0, 0, 1442, 'Cotton', '81dl be hoa đỏ.webp'),
(244, '244BD', 'ccccccccccccccccccccccc', 'BD', 220000, 0, 0, 857, 'Tăm Hàn', '1BD Tím lavender.webp');

--
-- Bẫy `dssanpham`
--
DELIMITER $$
CREATE TRIGGER `update_madssp` BEFORE INSERT ON `dssanpham` FOR EACH ROW BEGIN
   SET NEW.madssp = CONCAT(NEW.iddssp, NEW.idmodel);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `giohang`
--

CREATE TABLE `giohang` (
  `idgiohang` int(11) NOT NULL,
  `iduser` int(11) DEFAULT NULL,
  `masp` varchar(12) DEFAULT NULL,
  `soluong` tinyint(3) UNSIGNED DEFAULT NULL,
  `iddonhang` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `giohang`
--

INSERT INTO `giohang` (`idgiohang`, `iduser`, `masp`, `soluong`, `iddonhang`) VALUES
(101, 2, '9BD23S', 3, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `lichsudonhang`
--

CREATE TABLE `lichsudonhang` (
  `iddonhang` int(11) NOT NULL,
  `iduser` int(11) DEFAULT NULL,
  `ngaydatdon` date DEFAULT NULL,
  `trangthai` varchar(50) DEFAULT NULL,
  `diachigiao` varchar(255) DEFAULT NULL,
  `tongtien` mediumint(8) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Bẫy `lichsudonhang`
--
DELIMITER $$
CREATE TRIGGER `update_giohang_after_delete` BEFORE DELETE ON `lichsudonhang` FOR EACH ROW BEGIN
    UPDATE giohang, users, lichsudonhang
    SET giohang.iddonhang = NULL
    WHERE users.iduser = OLD.iduser AND giohang.iduser = users.iduser AND giohang.iddonhang = OLD.iddonhang;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_giohang_after_insert` AFTER INSERT ON `lichsudonhang` FOR EACH ROW BEGIN
    UPDATE giohang, users, lichsudonhang
    SET giohang.iddonhang = NEW.iddonhang
    WHERE users.iduser = NEW.iduser AND giohang.iduser = users.iduser AND giohang.iddonhang IS NULL;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_giohang_after_update` AFTER UPDATE ON `lichsudonhang` FOR EACH ROW BEGIN
    UPDATE giohang, users, lichsudonhang
    SET giohang.iddonhang = NEW.iddonhang
    WHERE users.iduser = NEW.iduser AND giohang.iduser = users.iduser AND giohang.iddonhang IS NULL;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `model`
--

CREATE TABLE `model` (
  `idmodel` varchar(2) NOT NULL,
  `namemodel` varchar(15) DEFAULT NULL,
  `note` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `model`
--

INSERT INTO `model` (`idmodel`, `namemodel`, `note`) VALUES
('BD', 'Bộ dài', 'Phù hợp cho mùa thu và đông, giữ ấm và thoải mái'),
('BĐ', 'Bộ đùi', 'Thích hợp cho mùa hè, chú trọng đến sự mát mẻ, thấm hút mồ hôi'),
('BL', 'Bộ lửng', 'Thích hợp cho mùa xuân và hạ, kiểu dáng trẻ trung và thoải mái'),
('BP', 'Bộ Pijama', 'Được thiết kế cho giấc ngủ thoải mái, với chất liệu êm dịu và thoải mái'),
('DL', 'Đồ lam', 'Phong cách truyền thống, thích hợp cho các dịp lễ hội và sự kiện đặc biệt');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sanpham`
--

CREATE TABLE `sanpham` (
  `idsp` int(11) NOT NULL,
  `masp` varchar(12) DEFAULT NULL,
  `maanh` varchar(9) DEFAULT NULL,
  `madssp` varchar(5) DEFAULT NULL,
  `size` varchar(3) DEFAULT NULL,
  `gia` mediumint(9) UNSIGNED DEFAULT NULL,
  `soluong` smallint(5) UNSIGNED NOT NULL,
  `sale` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sanpham`
--

INSERT INTO `sanpham` (`idsp`, `masp`, `maanh`, `madssp`, `size`, `gia`, `soluong`, `sale`) VALUES
(45, '1BD1S', '1BD1', '1BD', 'S', 230000, 4, 50),
(46, '1BD1M', '1BD1', '1BD', 'M', 230000, 2, NULL),
(47, '1BD1L', '1BD1', '1BD', 'L', 235000, 0, NULL),
(48, '1BD1XL', '1BD1', '1BD', 'XL', 240000, 9, NULL),
(49, '1BD1XXL', '1BD1', '1BD', 'XXL', 240000, 1, NULL),
(50, '1BD2S', '1BD2', '1BD', 'S', 250000, 7, NULL),
(51, '1BD2M', '1BD2', '1BD', 'M', 250000, 10, NULL),
(52, '1BD2L', '1BD2', '1BD', 'L', 255000, 3, NULL),
(53, '1BD2XL', '1BD2', '1BD', 'XL', 260000, 13, 10),
(54, '1BD2XXL', '1BD2', '1BD', 'XXL', 260000, 12, NULL),
(55, '1BD3S', '1BD3', '1BD', 'S', 250000, 0, NULL),
(56, '1BD3M', '1BD3', '1BD', 'M', 250000, 11, NULL),
(57, '1BD3L', '1BD3', '1BD', 'L', 255000, 10, NULL),
(58, '1BD3XL', '1BD3', '1BD', 'XL', 260000, 0, NULL),
(59, '1BD3XXL', '1BD3', '1BD', 'XXL', 260000, 4, 50),
(60, '1BD4S', '1BD4', '1BD', 'S', 220000, 5, NULL),
(61, '1BD4M', '1BD4', '1BD', 'M', 220000, 2, NULL),
(62, '1BD4L', '1BD4', '1BD', 'L', 225000, 8, NULL),
(63, '1BD4XL', '1BD4', '1BD', 'XL', 230000, 6, NULL),
(64, '1BD4XXL', '1BD4', '1BD', 'XXL', 230000, 5, NULL),
(65, '2BD5S', '2BD5', '2BD', 'S', 260000, 14, 10),
(66, '2BD5M', '2BD5', '2BD', 'M', 260000, 1, NULL),
(67, '2BD5L', '2BD5', '2BD', 'L', 265000, 9, NULL),
(68, '2BD5XL', '2BD5', '2BD', 'XL', 270000, 10, NULL),
(69, '2BD5XXL', '2BD5', '2BD', 'XXL', 270000, 8, NULL),
(70, '2BD6S', '2BD6', '2BD', 'S', 290000, 12, 10),
(71, '2BD6M', '2BD6', '2BD', 'M', 290000, 4, NULL),
(72, '2BD6L', '2BD6', '2BD', 'L', 295000, 0, 10),
(73, '2BD6XL', '2BD6', '2BD', 'XL', 300000, 9, NULL),
(74, '2BD6XXL', '2BD6', '2BD', 'XXL', 300000, 10, NULL),
(75, '2BD7S', '2BD7', '2BD', 'S', 260000, 2, NULL),
(76, '2BD7M', '2BD7', '2BD', 'M', 260000, 12, NULL),
(77, '2BD7L', '2BD7', '2BD', 'L', 265000, 0, NULL),
(78, '2BD7XL', '2BD7', '2BD', 'XL', 270000, 0, NULL),
(79, '2BD7XXL', '2BD7', '2BD', 'XXL', 270000, 9, NULL),
(80, '4BD8S', '4BD8', '4BD', 'S', 200000, 0, NULL),
(81, '4BD8M', '4BD8', '4BD', 'M', 200000, 1, NULL),
(82, '4BD8L', '4BD8', '4BD', 'L', 205000, 2, 40),
(83, '4BD8XL', '4BD8', '4BD', 'XL', 210000, 7, NULL),
(84, '4BD8XXL', '4BD8', '4BD', 'XXL', 210000, 13, NULL),
(85, '4BD9S', '4BD9', '4BD', 'S', 290000, 1, NULL),
(86, '4BD9M', '4BD9', '4BD', 'M', 290000, 10, NULL),
(87, '4BD9L', '4BD9', '4BD', 'L', 295000, 2, NULL),
(88, '4BD9XL', '4BD9', '4BD', 'XL', 300000, 10, NULL),
(89, '4BD9XXL', '4BD9', '4BD', 'XXL', 300000, 1, NULL),
(90, '4BD10S', '4BD10', '4BD', 'S', 230000, 7, NULL),
(91, '4BD10M', '4BD10', '4BD', 'M', 230000, 5, NULL),
(92, '4BD10L', '4BD10', '4BD', 'L', 235000, 5, NULL),
(93, '4BD10XL', '4BD10', '4BD', 'XL', 240000, 10, 20),
(94, '4BD10XXL', '4BD10', '4BD', 'XXL', 240000, 6, 25),
(95, '5BD11S', '5BD11', '5BD', 'S', 200000, 0, 30),
(96, '5BD11M', '5BD11', '5BD', 'M', 200000, 9, NULL),
(97, '5BD11L', '5BD11', '5BD', 'L', 205000, 7, NULL),
(98, '5BD11XL', '5BD11', '5BD', 'XL', 210000, 9, NULL),
(99, '5BD11XXL', '5BD11', '5BD', 'XXL', 210000, 9, 35),
(100, '5BD12S', '5BD12', '5BD', 'S', 220000, 8, NULL),
(101, '5BD12M', '5BD12', '5BD', 'M', 220000, 14, NULL),
(102, '5BD12L', '5BD12', '5BD', 'L', 225000, 0, NULL),
(103, '5BD12XL', '5BD12', '5BD', 'XL', 230000, 5, NULL),
(104, '5BD12XXL', '5BD12', '5BD', 'XXL', 230000, 10, 20),
(105, '5BD13S', '5BD13', '5BD', 'S', 250000, 0, NULL),
(106, '5BD13M', '5BD13', '5BD', 'M', 250000, 0, NULL),
(107, '5BD13L', '5BD13', '5BD', 'L', 255000, 0, NULL),
(108, '5BD13XL', '5BD13', '5BD', 'XL', 260000, 0, NULL),
(109, '5BD13XXL', '5BD13', '5BD', 'XXL', 260000, 0, NULL),
(110, '6BD14S', '6BD14', '6BD', 'S', 200000, 9, 10),
(111, '6BD14M', '6BD14', '6BD', 'M', 200000, 0, NULL),
(112, '6BD14L', '6BD14', '6BD', 'L', 205000, 4, NULL),
(113, '6BD14XL', '6BD14', '6BD', 'XL', 210000, 6, NULL),
(114, '6BD14XXL', '6BD14', '6BD', 'XXL', 210000, 2, NULL),
(115, '6BD15S', '6BD15', '6BD', 'S', 240000, 14, NULL),
(116, '6BD15M', '6BD15', '6BD', 'M', 240000, 5, 80),
(117, '6BD15L', '6BD15', '6BD', 'L', 245000, 0, NULL),
(118, '6BD15XL', '6BD15', '6BD', 'XL', 250000, 4, NULL),
(119, '6BD15XXL', '6BD15', '6BD', 'XXL', 250000, 0, NULL),
(120, '7BD16S', '7BD16', '7BD', 'S', 210000, 12, 40),
(121, '7BD16M', '7BD16', '7BD', 'M', 210000, 10, NULL),
(122, '7BD16L', '7BD16', '7BD', 'L', 215000, 14, NULL),
(123, '7BD16XL', '7BD16', '7BD', 'XL', 220000, 10, NULL),
(124, '7BD16XXL', '7BD16', '7BD', 'XXL', 220000, 7, NULL),
(125, '7BD17S', '7BD17', '7BD', 'S', 230000, 7, NULL),
(126, '7BD17M', '7BD17', '7BD', 'M', 230000, 5, NULL),
(127, '7BD17L', '7BD17', '7BD', 'L', 235000, 3, 60),
(128, '7BD17XL', '7BD17', '7BD', 'XL', 240000, 1, NULL),
(129, '7BD17XXL', '7BD17', '7BD', 'XXL', 240000, 12, NULL),
(130, '7BD18S', '7BD18', '7BD', 'S', 280000, 10, NULL),
(131, '7BD18M', '7BD18', '7BD', 'M', 280000, 13, NULL),
(132, '7BD18L', '7BD18', '7BD', 'L', 285000, 6, NULL),
(133, '7BD18XL', '7BD18', '7BD', 'XL', 290000, 5, NULL),
(134, '7BD18XXL', '7BD18', '7BD', 'XXL', 290000, 9, NULL),
(135, '7BD19S', '7BD19', '7BD', 'S', 210000, 8, NULL),
(136, '7BD19M', '7BD19', '7BD', 'M', 210000, 9, 25),
(137, '7BD19L', '7BD19', '7BD', 'L', 215000, 7, NULL),
(138, '7BD19XL', '7BD19', '7BD', 'XL', 220000, 8, NULL),
(139, '7BD19XXL', '7BD19', '7BD', 'XXL', 220000, 5, NULL),
(140, '8BD20S', '8BD20', '8BD', 'S', 210000, 1, NULL),
(141, '8BD20M', '8BD20', '8BD', 'M', 210000, 8, NULL),
(142, '8BD20L', '8BD20', '8BD', 'L', 215000, 9, 40),
(143, '8BD20XL', '8BD20', '8BD', 'XL', 220000, 0, NULL),
(144, '8BD20XXL', '8BD20', '8BD', 'XXL', 220000, 0, NULL),
(145, '8BD21S', '8BD21', '8BD', 'S', 210000, 7, NULL),
(146, '8BD21M', '8BD21', '8BD', 'M', 210000, 1, NULL),
(147, '8BD21L', '8BD21', '8BD', 'L', 215000, 1, NULL),
(148, '8BD21XL', '8BD21', '8BD', 'XL', 220000, 0, NULL),
(149, '8BD21XXL', '8BD21', '8BD', 'XXL', 220000, 0, NULL),
(150, '8BD22S', '8BD22', '8BD', 'S', 210000, 8, NULL),
(151, '8BD22M', '8BD22', '8BD', 'M', 210000, 4, NULL),
(152, '8BD22L', '8BD22', '8BD', 'L', 215000, 11, NULL),
(153, '8BD22XL', '8BD22', '8BD', 'XL', 220000, 13, NULL),
(154, '8BD22XXL', '8BD22', '8BD', 'XXL', 220000, 2, NULL),
(155, '9BD23S', '9BD23', '9BD', 'S', 210000, 3, NULL),
(156, '9BD23M', '9BD23', '9BD', 'M', 210000, 11, NULL),
(157, '9BD23L', '9BD23', '9BD', 'L', 215000, 2, NULL),
(158, '9BD23XL', '9BD23', '9BD', 'XL', 220000, 8, NULL),
(159, '9BD23XXL', '9BD23', '9BD', 'XXL', 220000, 5, NULL),
(160, '10BD24S', '10BD24', '10BD', 'S', 200000, 14, NULL),
(161, '10BD24M', '10BD24', '10BD', 'M', 200000, 13, 60),
(162, '10BD24L', '10BD24', '10BD', 'L', 205000, 6, NULL),
(163, '10BD24XL', '10BD24', '10BD', 'XL', 210000, 7, NULL),
(164, '10BD24XXL', '10BD24', '10BD', 'XXL', 210000, 4, NULL),
(165, '10BD25S', '10BD25', '10BD', 'S', 200000, 1, NULL),
(166, '10BD25M', '10BD25', '10BD', 'M', 200000, 9, NULL),
(167, '10BD25L', '10BD25', '10BD', 'L', 205000, 9, NULL),
(168, '10BD25XL', '10BD25', '10BD', 'XL', 210000, 4, NULL),
(169, '10BD25XXL', '10BD25', '10BD', 'XXL', 210000, 9, NULL),
(170, '10BD26S', '10BD26', '10BD', 'S', 220000, 3, NULL),
(171, '10BD26M', '10BD26', '10BD', 'M', 220000, 8, NULL),
(172, '10BD26L', '10BD26', '10BD', 'L', 225000, 2, NULL),
(173, '10BD26XL', '10BD26', '10BD', 'XL', 230000, 1, NULL),
(174, '10BD26XXL', '10BD26', '10BD', 'XXL', 230000, 13, NULL),
(175, '10BD27S', '10BD27', '10BD', 'S', 230000, 11, NULL),
(176, '10BD27M', '10BD27', '10BD', 'M', 230000, 1, NULL),
(177, '10BD27L', '10BD27', '10BD', 'L', 235000, 14, NULL),
(178, '10BD27XL', '10BD27', '10BD', 'XL', 240000, 8, NULL),
(179, '10BD27XXL', '10BD27', '10BD', 'XXL', 240000, 13, 10),
(180, '11BD28S', '11BD28', '11BD', 'S', 290000, 0, NULL),
(181, '11BD28M', '11BD28', '11BD', 'M', 290000, 0, NULL),
(182, '11BD28L', '11BD28', '11BD', 'L', 295000, 0, NULL),
(183, '11BD28XL', '11BD28', '11BD', 'XL', 300000, 0, NULL),
(184, '11BD28XXL', '11BD28', '11BD', 'XXL', 300000, 0, NULL),
(185, '11BD29S', '11BD29', '11BD', 'S', 200000, 0, NULL),
(186, '11BD29M', '11BD29', '11BD', 'M', 200000, 0, NULL),
(187, '11BD29L', '11BD29', '11BD', 'L', 205000, 0, NULL),
(188, '11BD29XL', '11BD29', '11BD', 'XL', 210000, 0, NULL),
(189, '11BD29XXL', '11BD29', '11BD', 'XXL', 210000, 0, NULL),
(190, '12BD30S', '12BD30', '12BD', 'S', 270000, 7, NULL),
(191, '12BD30M', '12BD30', '12BD', 'M', 270000, 0, 20),
(192, '12BD30L', '12BD30', '12BD', 'L', 275000, 10, NULL),
(193, '12BD30XL', '12BD30', '12BD', 'XL', 280000, 7, NULL),
(194, '12BD30XXL', '12BD30', '12BD', 'XXL', 280000, 7, NULL),
(195, '12BD31S', '12BD31', '12BD', 'S', 230000, 0, NULL),
(196, '12BD31M', '12BD31', '12BD', 'M', 230000, 0, NULL),
(197, '12BD31L', '12BD31', '12BD', 'L', 235000, 0, NULL),
(198, '12BD31XL', '12BD31', '12BD', 'XL', 240000, 0, NULL),
(199, '12BD31XXL', '12BD31', '12BD', 'XXL', 240000, 0, NULL),
(200, '12BD32S', '12BD32', '12BD', 'S', 210000, 9, NULL),
(201, '12BD32M', '12BD32', '12BD', 'M', 210000, 12, NULL),
(202, '12BD32L', '12BD32', '12BD', 'L', 215000, 1, NULL),
(203, '12BD32XL', '12BD32', '12BD', 'XL', 220000, 0, NULL),
(204, '12BD32XXL', '12BD32', '12BD', 'XXL', 220000, 11, NULL),
(205, '20BĐ40S', '20BĐ40', '20BĐ', 'S', 270000, 10, NULL),
(206, '20BĐ40M', '20BĐ40', '20BĐ', 'M', 270000, 1, NULL),
(207, '20BĐ40L', '20BĐ40', '20BĐ', 'L', 275000, 5, NULL),
(208, '20BĐ40XL', '20BĐ40', '20BĐ', 'XL', 280000, 9, NULL),
(209, '20BĐ40XXL', '20BĐ40', '20BĐ', 'XXL', 280000, 14, NULL),
(210, '20BĐ41S', '20BĐ41', '20BĐ', 'S', 280000, 6, NULL),
(211, '20BĐ41M', '20BĐ41', '20BĐ', 'M', 280000, 10, NULL),
(212, '20BĐ41L', '20BĐ41', '20BĐ', 'L', 285000, 14, NULL),
(213, '20BĐ41XL', '20BĐ41', '20BĐ', 'XL', 290000, 14, NULL),
(214, '20BĐ41XXL', '20BĐ41', '20BĐ', 'XXL', 290000, 14, NULL),
(215, '20BĐ42S', '20BĐ42', '20BĐ', 'S', 280000, 4, NULL),
(216, '20BĐ42M', '20BĐ42', '20BĐ', 'M', 280000, 13, NULL),
(217, '20BĐ42L', '20BĐ42', '20BĐ', 'L', 285000, 10, NULL),
(218, '20BĐ42XL', '20BĐ42', '20BĐ', 'XL', 290000, 13, NULL),
(219, '20BĐ42XXL', '20BĐ42', '20BĐ', 'XXL', 290000, 4, NULL),
(220, '20BĐ43S', '20BĐ43', '20BĐ', 'S', 270000, 13, NULL),
(221, '20BĐ43M', '20BĐ43', '20BĐ', 'M', 270000, 4, NULL),
(222, '20BĐ43L', '20BĐ43', '20BĐ', 'L', 275000, 12, NULL),
(223, '20BĐ43XL', '20BĐ43', '20BĐ', 'XL', 280000, 1, NULL),
(224, '20BĐ43XXL', '20BĐ43', '20BĐ', 'XXL', 280000, 0, NULL),
(225, '21BĐ44S', '21BĐ44', '21BĐ', 'S', 290000, 7, NULL),
(226, '21BĐ44M', '21BĐ44', '21BĐ', 'M', 290000, 11, NULL),
(227, '21BĐ44L', '21BĐ44', '21BĐ', 'L', 295000, 4, NULL),
(228, '21BĐ44XL', '21BĐ44', '21BĐ', 'XL', 300000, 1, NULL),
(229, '21BĐ44XXL', '21BĐ44', '21BĐ', 'XXL', 300000, 9, NULL),
(230, '21BĐ45S', '21BĐ45', '21BĐ', 'S', 280000, 4, NULL),
(231, '21BĐ45M', '21BĐ45', '21BĐ', 'M', 280000, 13, NULL),
(232, '21BĐ45L', '21BĐ45', '21BĐ', 'L', 285000, 11, NULL),
(233, '21BĐ45XL', '21BĐ45', '21BĐ', 'XL', 290000, 0, NULL),
(234, '21BĐ45XXL', '21BĐ45', '21BĐ', 'XXL', 290000, 12, NULL),
(235, '21BĐ46S', '21BĐ46', '21BĐ', 'S', 220000, 7, NULL),
(236, '21BĐ46M', '21BĐ46', '21BĐ', 'M', 220000, 11, NULL),
(237, '21BĐ46L', '21BĐ46', '21BĐ', 'L', 225000, 7, NULL),
(238, '21BĐ46XL', '21BĐ46', '21BĐ', 'XL', 230000, 3, NULL),
(239, '21BĐ46XXL', '21BĐ46', '21BĐ', 'XXL', 230000, 7, NULL),
(240, '22BĐ47S', '22BĐ47', '22BĐ', 'S', 290000, 1, NULL),
(241, '22BĐ47M', '22BĐ47', '22BĐ', 'M', 290000, 12, NULL),
(242, '22BĐ47L', '22BĐ47', '22BĐ', 'L', 295000, 12, NULL),
(243, '22BĐ47XL', '22BĐ47', '22BĐ', 'XL', 300000, 9, NULL),
(244, '22BĐ47XXL', '22BĐ47', '22BĐ', 'XXL', 300000, 10, NULL),
(245, '22BĐ48S', '22BĐ48', '22BĐ', 'S', 240000, 3, NULL),
(246, '22BĐ48M', '22BĐ48', '22BĐ', 'M', 240000, 14, NULL),
(247, '22BĐ48L', '22BĐ48', '22BĐ', 'L', 245000, 14, NULL),
(248, '22BĐ48XL', '22BĐ48', '22BĐ', 'XL', 250000, 0, NULL),
(249, '22BĐ48XXL', '22BĐ48', '22BĐ', 'XXL', 250000, 1, NULL),
(250, '23BĐ49S', '23BĐ49', '23BĐ', 'S', 240000, 14, NULL),
(251, '23BĐ49M', '23BĐ49', '23BĐ', 'M', 240000, 7, NULL),
(252, '23BĐ49L', '23BĐ49', '23BĐ', 'L', 245000, 10, NULL),
(253, '23BĐ49XL', '23BĐ49', '23BĐ', 'XL', 250000, 14, NULL),
(254, '23BĐ49XXL', '23BĐ49', '23BĐ', 'XXL', 250000, 11, NULL),
(255, '23BĐ50S', '23BĐ50', '23BĐ', 'S', 290000, 3, NULL),
(256, '23BĐ50M', '23BĐ50', '23BĐ', 'M', 290000, 4, NULL),
(257, '23BĐ50L', '23BĐ50', '23BĐ', 'L', 295000, 13, NULL),
(258, '23BĐ50XL', '23BĐ50', '23BĐ', 'XL', 300000, 8, NULL),
(259, '23BĐ50XXL', '23BĐ50', '23BĐ', 'XXL', 300000, 0, NULL),
(260, '23BĐ51S', '23BĐ51', '23BĐ', 'S', 210000, 13, NULL),
(261, '23BĐ51M', '23BĐ51', '23BĐ', 'M', 210000, 3, NULL),
(262, '23BĐ51L', '23BĐ51', '23BĐ', 'L', 215000, 6, NULL),
(263, '23BĐ51XL', '23BĐ51', '23BĐ', 'XL', 220000, 7, NULL),
(264, '23BĐ51XXL', '23BĐ51', '23BĐ', 'XXL', 220000, 0, NULL),
(265, '23BĐ52S', '23BĐ52', '23BĐ', 'S', 280000, 13, NULL),
(266, '23BĐ52M', '23BĐ52', '23BĐ', 'M', 280000, 0, NULL),
(267, '23BĐ52L', '23BĐ52', '23BĐ', 'L', 285000, 8, NULL),
(268, '23BĐ52XL', '23BĐ52', '23BĐ', 'XL', 290000, 12, NULL),
(269, '23BĐ52XXL', '23BĐ52', '23BĐ', 'XXL', 290000, 5, NULL),
(270, '24BĐ53S', '24BĐ53', '24BĐ', 'S', 220000, 3, NULL),
(271, '24BĐ53M', '24BĐ53', '24BĐ', 'M', 220000, 5, NULL),
(272, '24BĐ53L', '24BĐ53', '24BĐ', 'L', 225000, 1, NULL),
(273, '24BĐ53XL', '24BĐ53', '24BĐ', 'XL', 230000, 6, NULL),
(274, '24BĐ53XXL', '24BĐ53', '24BĐ', 'XXL', 230000, 10, NULL),
(275, '24BĐ54S', '24BĐ54', '24BĐ', 'S', 240000, 1, NULL),
(276, '24BĐ54M', '24BĐ54', '24BĐ', 'M', 240000, 0, NULL),
(277, '24BĐ54L', '24BĐ54', '24BĐ', 'L', 245000, 12, NULL),
(278, '24BĐ54XL', '24BĐ54', '24BĐ', 'XL', 250000, 4, NULL),
(279, '24BĐ54XXL', '24BĐ54', '24BĐ', 'XXL', 250000, 11, NULL),
(280, '24BĐ55S', '24BĐ55', '24BĐ', 'S', 290000, 4, NULL),
(281, '24BĐ55M', '24BĐ55', '24BĐ', 'M', 290000, 12, NULL),
(282, '24BĐ55L', '24BĐ55', '24BĐ', 'L', 295000, 3, NULL),
(283, '24BĐ55XL', '24BĐ55', '24BĐ', 'XL', 300000, 10, NULL),
(284, '24BĐ55XXL', '24BĐ55', '24BĐ', 'XXL', 300000, 12, NULL),
(285, '25BĐ56S', '25BĐ56', '25BĐ', 'S', 210000, 0, NULL),
(286, '25BĐ56M', '25BĐ56', '25BĐ', 'M', 210000, 0, NULL),
(287, '25BĐ56L', '25BĐ56', '25BĐ', 'L', 215000, 0, NULL),
(288, '25BĐ56XL', '25BĐ56', '25BĐ', 'XL', 220000, 0, NULL),
(289, '25BĐ56XXL', '25BĐ56', '25BĐ', 'XXL', 220000, 0, NULL),
(290, '25BĐ57S', '25BĐ57', '25BĐ', 'S', 210000, 0, NULL),
(291, '25BĐ57M', '25BĐ57', '25BĐ', 'M', 210000, 0, NULL),
(292, '25BĐ57L', '25BĐ57', '25BĐ', 'L', 215000, 0, NULL),
(293, '25BĐ57XL', '25BĐ57', '25BĐ', 'XL', 220000, 0, NULL),
(294, '25BĐ57XXL', '25BĐ57', '25BĐ', 'XXL', 220000, 0, NULL),
(295, '25BĐ58S', '25BĐ58', '25BĐ', 'S', 200000, 0, NULL),
(296, '25BĐ58M', '25BĐ58', '25BĐ', 'M', 200000, 0, NULL),
(297, '25BĐ58L', '25BĐ58', '25BĐ', 'L', 205000, 0, NULL),
(298, '25BĐ58XL', '25BĐ58', '25BĐ', 'XL', 210000, 0, NULL),
(299, '25BĐ58XXL', '25BĐ58', '25BĐ', 'XXL', 210000, 0, NULL),
(300, '26BĐ59S', '26BĐ59', '26BĐ', 'S', 220000, 14, NULL),
(301, '26BĐ59M', '26BĐ59', '26BĐ', 'M', 220000, 3, NULL),
(302, '26BĐ59L', '26BĐ59', '26BĐ', 'L', 225000, 1, NULL),
(303, '26BĐ59XL', '26BĐ59', '26BĐ', 'XL', 230000, 12, NULL),
(304, '26BĐ59XXL', '26BĐ59', '26BĐ', 'XXL', 230000, 14, NULL),
(305, '26BĐ60S', '26BĐ60', '26BĐ', 'S', 230000, 9, NULL),
(306, '26BĐ60M', '26BĐ60', '26BĐ', 'M', 230000, 3, NULL),
(307, '26BĐ60L', '26BĐ60', '26BĐ', 'L', 235000, 2, NULL),
(308, '26BĐ60XL', '26BĐ60', '26BĐ', 'XL', 240000, 3, NULL),
(309, '26BĐ60XXL', '26BĐ60', '26BĐ', 'XXL', 240000, 9, NULL),
(310, '26BĐ61S', '26BĐ61', '26BĐ', 'S', 250000, 10, NULL),
(311, '26BĐ61M', '26BĐ61', '26BĐ', 'M', 250000, 14, NULL),
(312, '26BĐ61L', '26BĐ61', '26BĐ', 'L', 255000, 8, NULL),
(313, '26BĐ61XL', '26BĐ61', '26BĐ', 'XL', 260000, 0, NULL),
(314, '26BĐ61XXL', '26BĐ61', '26BĐ', 'XXL', 260000, 6, NULL),
(315, '27BĐ62S', '27BĐ62', '27BĐ', 'S', 200000, 1, NULL),
(316, '27BĐ62M', '27BĐ62', '27BĐ', 'M', 200000, 4, NULL),
(317, '27BĐ62L', '27BĐ62', '27BĐ', 'L', 205000, 3, NULL),
(318, '27BĐ62XL', '27BĐ62', '27BĐ', 'XL', 210000, 5, NULL),
(319, '27BĐ62XXL', '27BĐ62', '27BĐ', 'XXL', 210000, 13, NULL),
(320, '27BĐ63S', '27BĐ63', '27BĐ', 'S', 250000, 13, NULL),
(321, '27BĐ63M', '27BĐ63', '27BĐ', 'M', 250000, 0, NULL),
(322, '27BĐ63L', '27BĐ63', '27BĐ', 'L', 255000, 4, NULL),
(323, '27BĐ63XL', '27BĐ63', '27BĐ', 'XL', 260000, 9, NULL),
(324, '27BĐ63XXL', '27BĐ63', '27BĐ', 'XXL', 260000, 0, NULL),
(325, '27BĐ64S', '27BĐ64', '27BĐ', 'S', 230000, 7, NULL),
(326, '27BĐ64M', '27BĐ64', '27BĐ', 'M', 230000, 7, NULL),
(327, '27BĐ64L', '27BĐ64', '27BĐ', 'L', 235000, 0, NULL),
(328, '27BĐ64XL', '27BĐ64', '27BĐ', 'XL', 240000, 9, NULL),
(329, '27BĐ64XXL', '27BĐ64', '27BĐ', 'XXL', 240000, 0, NULL),
(330, '28BĐ65S', '28BĐ65', '28BĐ', 'S', 220000, 0, NULL),
(331, '28BĐ65M', '28BĐ65', '28BĐ', 'M', 220000, 0, NULL),
(332, '28BĐ65L', '28BĐ65', '28BĐ', 'L', 225000, 0, NULL),
(333, '28BĐ65XL', '28BĐ65', '28BĐ', 'XL', 230000, 0, NULL),
(334, '28BĐ65XXL', '28BĐ65', '28BĐ', 'XXL', 230000, 0, NULL),
(335, '28BĐ66S', '28BĐ66', '28BĐ', 'S', 270000, 3, NULL),
(336, '28BĐ66M', '28BĐ66', '28BĐ', 'M', 270000, 12, NULL),
(337, '28BĐ66L', '28BĐ66', '28BĐ', 'L', 275000, 5, NULL),
(338, '28BĐ66XL', '28BĐ66', '28BĐ', 'XL', 280000, 5, NULL),
(339, '28BĐ66XXL', '28BĐ66', '28BĐ', 'XXL', 280000, 9, NULL),
(340, '29BĐ67S', '29BĐ67', '29BĐ', 'S', 200000, 7, NULL),
(341, '29BĐ67M', '29BĐ67', '29BĐ', 'M', 200000, 3, NULL),
(342, '29BĐ67L', '29BĐ67', '29BĐ', 'L', 205000, 12, NULL),
(343, '29BĐ67XL', '29BĐ67', '29BĐ', 'XL', 210000, 6, NULL),
(344, '29BĐ67XXL', '29BĐ67', '29BĐ', 'XXL', 210000, 7, NULL),
(345, '30BĐ68S', '30BĐ68', '30BĐ', 'S', 220000, 13, NULL),
(346, '30BĐ68M', '30BĐ68', '30BĐ', 'M', 220000, 10, NULL),
(347, '30BĐ68L', '30BĐ68', '30BĐ', 'L', 225000, 9, NULL),
(348, '30BĐ68XL', '30BĐ68', '30BĐ', 'XL', 230000, 3, NULL),
(349, '30BĐ68XXL', '30BĐ68', '30BĐ', 'XXL', 230000, 3, NULL),
(350, '30BĐ69S', '30BĐ69', '30BĐ', 'S', 250000, 14, NULL),
(351, '30BĐ69M', '30BĐ69', '30BĐ', 'M', 250000, 1, NULL),
(352, '30BĐ69L', '30BĐ69', '30BĐ', 'L', 255000, 9, NULL),
(353, '30BĐ69XL', '30BĐ69', '30BĐ', 'XL', 260000, 14, NULL),
(354, '30BĐ69XXL', '30BĐ69', '30BĐ', 'XXL', 260000, 14, NULL),
(355, '31BĐ70S', '31BĐ70', '31BĐ', 'S', 270000, 14, NULL),
(356, '31BĐ70M', '31BĐ70', '31BĐ', 'M', 270000, 10, NULL),
(357, '31BĐ70L', '31BĐ70', '31BĐ', 'L', 275000, 6, NULL),
(358, '31BĐ70XL', '31BĐ70', '31BĐ', 'XL', 280000, 1, NULL),
(359, '31BĐ70XXL', '31BĐ70', '31BĐ', 'XXL', 280000, 5, NULL),
(360, '31BĐ71S', '31BĐ71', '31BĐ', 'S', 230000, 8, NULL),
(361, '31BĐ71M', '31BĐ71', '31BĐ', 'M', 230000, 14, NULL),
(362, '31BĐ71L', '31BĐ71', '31BĐ', 'L', 235000, 13, NULL),
(363, '31BĐ71XL', '31BĐ71', '31BĐ', 'XL', 240000, 12, NULL),
(364, '31BĐ71XXL', '31BĐ71', '31BĐ', 'XXL', 240000, 6, NULL),
(365, '32BĐ72S', '32BĐ72', '32BĐ', 'S', 270000, 0, NULL),
(366, '32BĐ72M', '32BĐ72', '32BĐ', 'M', 270000, 0, NULL),
(367, '32BĐ72L', '32BĐ72', '32BĐ', 'L', 275000, 0, NULL),
(368, '32BĐ72XL', '32BĐ72', '32BĐ', 'XL', 280000, 0, NULL),
(369, '32BĐ72XXL', '32BĐ72', '32BĐ', 'XXL', 280000, 0, NULL),
(370, '32BĐ73S', '32BĐ73', '32BĐ', 'S', 280000, 8, NULL),
(371, '32BĐ73M', '32BĐ73', '32BĐ', 'M', 280000, 6, NULL),
(372, '32BĐ73L', '32BĐ73', '32BĐ', 'L', 285000, 0, NULL),
(373, '32BĐ73XL', '32BĐ73', '32BĐ', 'XL', 290000, 1, NULL),
(374, '32BĐ73XXL', '32BĐ73', '32BĐ', 'XXL', 290000, 10, NULL),
(375, '40BL80S', '40BL80', '40BL', 'S', 200000, 12, 45),
(376, '40BL80M', '40BL80', '40BL', 'M', 200000, 0, NULL),
(377, '40BL80L', '40BL80', '40BL', 'L', 205000, 0, NULL),
(378, '40BL80XL', '40BL80', '40BL', 'XL', 210000, 9, NULL),
(379, '40BL80XXL', '40BL80', '40BL', 'XXL', 210000, 13, NULL),
(380, '40BL81S', '40BL81', '40BL', 'S', 270000, 11, NULL),
(381, '40BL81M', '40BL81', '40BL', 'M', 270000, 11, NULL),
(382, '40BL81L', '40BL81', '40BL', 'L', 275000, 5, NULL),
(383, '40BL81XL', '40BL81', '40BL', 'XL', 280000, 11, NULL),
(384, '40BL81XXL', '40BL81', '40BL', 'XXL', 280000, 9, NULL),
(385, '40BL82S', '40BL82', '40BL', 'S', 280000, 5, NULL),
(386, '40BL82M', '40BL82', '40BL', 'M', 280000, 3, NULL),
(387, '40BL82L', '40BL82', '40BL', 'L', 285000, 3, NULL),
(388, '40BL82XL', '40BL82', '40BL', 'XL', 290000, 5, NULL),
(389, '40BL82XXL', '40BL82', '40BL', 'XXL', 290000, 1, NULL),
(390, '40BL83S', '40BL83', '40BL', 'S', 230000, 6, NULL),
(391, '40BL83M', '40BL83', '40BL', 'M', 230000, 1, NULL),
(392, '40BL83L', '40BL83', '40BL', 'L', 235000, 5, NULL),
(393, '40BL83XL', '40BL83', '40BL', 'XL', 240000, 7, NULL),
(394, '40BL83XXL', '40BL83', '40BL', 'XXL', 240000, 6, NULL),
(395, '41BL84S', '41BL84', '41BL', 'S', 260000, 13, NULL),
(396, '41BL84M', '41BL84', '41BL', 'M', 260000, 8, NULL),
(397, '41BL84L', '41BL84', '41BL', 'L', 265000, 3, NULL),
(398, '41BL84XL', '41BL84', '41BL', 'XL', 270000, 7, NULL),
(399, '41BL84XXL', '41BL84', '41BL', 'XXL', 270000, 11, 25),
(400, '41BL85S', '41BL85', '41BL', 'S', 240000, 10, NULL),
(401, '41BL85M', '41BL85', '41BL', 'M', 240000, 3, NULL),
(402, '41BL85L', '41BL85', '41BL', 'L', 245000, 14, 20),
(403, '41BL85XL', '41BL85', '41BL', 'XL', 250000, 2, NULL),
(404, '41BL85XXL', '41BL85', '41BL', 'XXL', 250000, 0, NULL),
(405, '41BL86S', '41BL86', '41BL', 'S', 270000, 8, NULL),
(406, '41BL86M', '41BL86', '41BL', 'M', 270000, 10, NULL),
(407, '41BL86L', '41BL86', '41BL', 'L', 275000, 10, NULL),
(408, '41BL86XL', '41BL86', '41BL', 'XL', 280000, 6, NULL),
(409, '41BL86XXL', '41BL86', '41BL', 'XXL', 280000, 14, 15),
(410, '42BL87S', '42BL87', '42BL', 'S', 270000, 8, NULL),
(411, '42BL87M', '42BL87', '42BL', 'M', 270000, 11, NULL),
(412, '42BL87L', '42BL87', '42BL', 'L', 275000, 2, NULL),
(413, '42BL87XL', '42BL87', '42BL', 'XL', 280000, 5, NULL),
(414, '42BL87XXL', '42BL87', '42BL', 'XXL', 280000, 7, NULL),
(415, '42BL88S', '42BL88', '42BL', 'S', 220000, 13, NULL),
(416, '42BL88M', '42BL88', '42BL', 'M', 220000, 9, NULL),
(417, '42BL88L', '42BL88', '42BL', 'L', 225000, 7, NULL),
(418, '42BL88XL', '42BL88', '42BL', 'XL', 230000, 10, NULL),
(419, '42BL88XXL', '42BL88', '42BL', 'XXL', 230000, 14, NULL),
(420, '42BL89S', '42BL89', '42BL', 'S', 260000, 8, NULL),
(421, '42BL89M', '42BL89', '42BL', 'M', 260000, 10, NULL),
(422, '42BL89L', '42BL89', '42BL', 'L', 265000, 12, NULL),
(423, '42BL89XL', '42BL89', '42BL', 'XL', 270000, 0, NULL),
(424, '42BL89XXL', '42BL89', '42BL', 'XXL', 270000, 12, NULL),
(425, '43BL90S', '43BL90', '43BL', 'S', 290000, 0, NULL),
(426, '43BL90M', '43BL90', '43BL', 'M', 290000, 8, NULL),
(427, '43BL90L', '43BL90', '43BL', 'L', 295000, 10, NULL),
(428, '43BL90XL', '43BL90', '43BL', 'XL', 300000, 12, NULL),
(429, '43BL90XXL', '43BL90', '43BL', 'XXL', 300000, 0, NULL),
(430, '43BL91S', '43BL91', '43BL', 'S', 270000, 8, NULL),
(431, '43BL91M', '43BL91', '43BL', 'M', 270000, 9, NULL),
(432, '43BL91L', '43BL91', '43BL', 'L', 275000, 6, NULL),
(433, '43BL91XL', '43BL91', '43BL', 'XL', 280000, 4, NULL),
(434, '43BL91XXL', '43BL91', '43BL', 'XXL', 280000, 1, NULL),
(435, '44BL92S', '44BL92', '44BL', 'S', 270000, 3, NULL),
(436, '44BL92M', '44BL92', '44BL', 'M', 270000, 14, NULL),
(437, '44BL92L', '44BL92', '44BL', 'L', 275000, 3, NULL),
(438, '44BL92XL', '44BL92', '44BL', 'XL', 280000, 3, NULL),
(439, '44BL92XXL', '44BL92', '44BL', 'XXL', 280000, 5, NULL),
(440, '44BL93S', '44BL93', '44BL', 'S', 200000, 6, NULL),
(441, '44BL93M', '44BL93', '44BL', 'M', 200000, 13, 50),
(442, '44BL93L', '44BL93', '44BL', 'L', 205000, 2, NULL),
(443, '44BL93XL', '44BL93', '44BL', 'XL', 210000, 3, NULL),
(444, '44BL93XXL', '44BL93', '44BL', 'XXL', 210000, 10, NULL),
(445, '45BL94S', '45BL94', '45BL', 'S', 280000, 0, NULL),
(446, '45BL94M', '45BL94', '45BL', 'M', 280000, 0, NULL),
(447, '45BL94L', '45BL94', '45BL', 'L', 285000, 0, NULL),
(448, '45BL94XL', '45BL94', '45BL', 'XL', 290000, 0, NULL),
(449, '45BL94XXL', '45BL94', '45BL', 'XXL', 290000, 0, NULL),
(450, '45BL95S', '45BL95', '45BL', 'S', 250000, 10, NULL),
(451, '45BL95M', '45BL95', '45BL', 'M', 250000, 13, 70),
(452, '45BL95L', '45BL95', '45BL', 'L', 255000, 7, NULL),
(453, '45BL95XL', '45BL95', '45BL', 'XL', 260000, 11, NULL),
(454, '45BL95XXL', '45BL95', '45BL', 'XXL', 260000, 3, NULL),
(455, '45BL96S', '45BL96', '45BL', 'S', 290000, 13, NULL),
(456, '45BL96M', '45BL96', '45BL', 'M', 290000, 10, NULL),
(457, '45BL96L', '45BL96', '45BL', 'L', 295000, 12, NULL),
(458, '45BL96XL', '45BL96', '45BL', 'XL', 300000, 14, 55),
(459, '45BL96XXL', '45BL96', '45BL', 'XXL', 300000, 7, NULL),
(460, '46BL97S', '46BL97', '46BL', 'S', 250000, 6, NULL),
(461, '46BL97M', '46BL97', '46BL', 'M', 250000, 5, NULL),
(462, '46BL97L', '46BL97', '46BL', 'L', 255000, 6, NULL),
(463, '46BL97XL', '46BL97', '46BL', 'XL', 260000, 2, NULL),
(464, '46BL97XXL', '46BL97', '46BL', 'XXL', 260000, 6, NULL),
(465, '46BL98S', '46BL98', '46BL', 'S', 270000, 4, NULL),
(466, '46BL98M', '46BL98', '46BL', 'M', 270000, 6, NULL),
(467, '46BL98L', '46BL98', '46BL', 'L', 275000, 4, NULL),
(468, '46BL98XL', '46BL98', '46BL', 'XL', 280000, 0, NULL),
(469, '46BL98XXL', '46BL98', '46BL', 'XXL', 280000, 0, NULL),
(470, '46BL99S', '46BL99', '46BL', 'S', 270000, 7, NULL),
(471, '46BL99M', '46BL99', '46BL', 'M', 270000, 3, NULL),
(472, '46BL99L', '46BL99', '46BL', 'L', 275000, 11, 10),
(473, '46BL99XL', '46BL99', '46BL', 'XL', 280000, 2, NULL),
(474, '46BL99XXL', '46BL99', '46BL', 'XXL', 280000, 7, NULL),
(475, '47BL100S', '47BL100', '47BL', 'S', 280000, 12, 15),
(476, '47BL100M', '47BL100', '47BL', 'M', 280000, 7, NULL),
(477, '47BL100L', '47BL100', '47BL', 'L', 285000, 1, NULL),
(478, '47BL100XL', '47BL100', '47BL', 'XL', 290000, 0, NULL),
(479, '47BL100XXL', '47BL100', '47BL', 'XXL', 290000, 13, 40),
(480, '47BL101S', '47BL101', '47BL', 'S', 200000, 13, NULL),
(481, '47BL101M', '47BL101', '47BL', 'M', 200000, 3, NULL),
(482, '47BL101L', '47BL101', '47BL', 'L', 205000, 0, NULL),
(483, '47BL101XL', '47BL101', '47BL', 'XL', 210000, 6, NULL),
(484, '47BL101XXL', '47BL101', '47BL', 'XXL', 210000, 7, NULL),
(485, '47BL102S', '47BL102', '47BL', 'S', 210000, 4, NULL),
(486, '47BL102M', '47BL102', '47BL', 'M', 210000, 1, NULL),
(487, '47BL102L', '47BL102', '47BL', 'L', 215000, 9, NULL),
(488, '47BL102XL', '47BL102', '47BL', 'XL', 220000, 0, NULL),
(489, '47BL102XXL', '47BL102', '47BL', 'XXL', 220000, 0, NULL),
(490, '60BP110S', '60BP110', '60BP', 'S', 290000, 8, 50),
(491, '60BP110M', '60BP110', '60BP', 'M', 290000, 1, NULL),
(492, '60BP110L', '60BP110', '60BP', 'L', 295000, 12, 60),
(493, '60BP110XL', '60BP110', '60BP', 'XL', 300000, 14, NULL),
(494, '60BP110XXL', '60BP110', '60BP', 'XXL', 300000, 5, NULL),
(495, '60BP111S', '60BP111', '60BP', 'S', 270000, 0, NULL),
(496, '60BP111M', '60BP111', '60BP', 'M', 270000, 0, NULL),
(497, '60BP111L', '60BP111', '60BP', 'L', 275000, 0, NULL),
(498, '60BP111XL', '60BP111', '60BP', 'XL', 280000, 0, NULL),
(499, '60BP111XXL', '60BP111', '60BP', 'XXL', 280000, 0, NULL),
(500, '60BP112S', '60BP112', '60BP', 'S', 250000, 11, NULL),
(501, '60BP112M', '60BP112', '60BP', 'M', 250000, 2, NULL),
(502, '60BP112L', '60BP112', '60BP', 'L', 255000, 6, NULL),
(503, '60BP112XL', '60BP112', '60BP', 'XL', 260000, 11, NULL),
(504, '60BP112XXL', '60BP112', '60BP', 'XXL', 260000, 8, NULL),
(505, '60BP113S', '60BP113', '60BP', 'S', 240000, 0, NULL),
(506, '60BP113M', '60BP113', '60BP', 'M', 240000, 0, NULL),
(507, '60BP113L', '60BP113', '60BP', 'L', 245000, 0, NULL),
(508, '60BP113XL', '60BP113', '60BP', 'XL', 250000, 0, NULL),
(509, '60BP113XXL', '60BP113', '60BP', 'XXL', 250000, 0, NULL),
(510, '61BP114S', '61BP114', '61BP', 'S', 280000, 13, NULL),
(511, '61BP114M', '61BP114', '61BP', 'M', 280000, 0, NULL),
(512, '61BP114L', '61BP114', '61BP', 'L', 285000, 7, NULL),
(513, '61BP114XL', '61BP114', '61BP', 'XL', 290000, 0, NULL),
(514, '61BP114XXL', '61BP114', '61BP', 'XXL', 290000, 3, 40),
(515, '62BP115S', '62BP115', '62BP', 'S', 270000, 3, NULL),
(516, '62BP115M', '62BP115', '62BP', 'M', 270000, 10, NULL),
(517, '62BP115L', '62BP115', '62BP', 'L', 275000, 14, NULL),
(518, '62BP115XL', '62BP115', '62BP', 'XL', 280000, 8, NULL),
(519, '62BP115XXL', '62BP115', '62BP', 'XXL', 280000, 14, NULL),
(520, '63BP116S', '63BP116', '63BP', 'S', 200000, 9, NULL),
(521, '63BP116M', '63BP116', '63BP', 'M', 200000, 11, NULL),
(522, '63BP116L', '63BP116', '63BP', 'L', 205000, 13, NULL),
(523, '63BP116XL', '63BP116', '63BP', 'XL', 210000, 4, NULL),
(524, '63BP116XXL', '63BP116', '63BP', 'XXL', 210000, 11, NULL),
(525, '64BP117S', '64BP117', '64BP', 'S', 290000, 8, NULL),
(526, '64BP117M', '64BP117', '64BP', 'M', 290000, 11, 20),
(527, '64BP117L', '64BP117', '64BP', 'L', 295000, 5, NULL),
(528, '64BP117XL', '64BP117', '64BP', 'XL', 300000, 4, NULL),
(529, '64BP117XXL', '64BP117', '64BP', 'XXL', 300000, 9, NULL),
(530, '64BP118S', '64BP118', '64BP', 'S', 200000, 5, NULL),
(531, '64BP118M', '64BP118', '64BP', 'M', 200000, 12, NULL),
(532, '64BP118L', '64BP118', '64BP', 'L', 205000, 13, NULL),
(533, '64BP118XL', '64BP118', '64BP', 'XL', 210000, 1, NULL),
(534, '64BP118XXL', '64BP118', '64BP', 'XXL', 210000, 12, NULL),
(535, '64BP119S', '64BP119', '64BP', 'S', 270000, 6, NULL),
(536, '64BP119M', '64BP119', '64BP', 'M', 270000, 10, NULL),
(537, '64BP119L', '64BP119', '64BP', 'L', 275000, 5, NULL),
(538, '64BP119XL', '64BP119', '64BP', 'XL', 280000, 10, NULL),
(539, '64BP119XXL', '64BP119', '64BP', 'XXL', 280000, 6, NULL),
(540, '65BP120S', '65BP120', '65BP', 'S', 200000, 11, NULL),
(541, '65BP120M', '65BP120', '65BP', 'M', 200000, 12, 50),
(542, '65BP120L', '65BP120', '65BP', 'L', 205000, 13, 50),
(543, '65BP120XL', '65BP120', '65BP', 'XL', 210000, 12, NULL),
(544, '65BP120XXL', '65BP120', '65BP', 'XXL', 210000, 0, NULL),
(545, '65BP121S', '65BP121', '65BP', 'S', 280000, 13, NULL),
(546, '65BP121M', '65BP121', '65BP', 'M', 280000, 14, 35),
(547, '65BP121L', '65BP121', '65BP', 'L', 285000, 4, NULL),
(548, '65BP121XL', '65BP121', '65BP', 'XL', 290000, 7, NULL),
(549, '65BP121XXL', '65BP121', '65BP', 'XXL', 290000, 9, NULL),
(550, '65BP122S', '65BP122', '65BP', 'S', 270000, 9, NULL),
(551, '65BP122M', '65BP122', '65BP', 'M', 270000, 14, NULL),
(552, '65BP122L', '65BP122', '65BP', 'L', 275000, 1, NULL),
(553, '65BP122XL', '65BP122', '65BP', 'XL', 280000, 6, NULL),
(554, '65BP122XXL', '65BP122', '65BP', 'XXL', 280000, 12, NULL),
(555, '66BP123S', '66BP123', '66BP', 'S', 280000, 12, NULL),
(556, '66BP123M', '66BP123', '66BP', 'M', 280000, 10, NULL),
(557, '66BP123L', '66BP123', '66BP', 'L', 285000, 0, NULL),
(558, '66BP123XL', '66BP123', '66BP', 'XL', 290000, 0, NULL),
(559, '66BP123XXL', '66BP123', '66BP', 'XXL', 290000, 1, NULL),
(560, '66BP124S', '66BP124', '66BP', 'S', 220000, 2, NULL),
(561, '66BP124M', '66BP124', '66BP', 'M', 220000, 0, NULL),
(562, '66BP124L', '66BP124', '66BP', 'L', 225000, 10, NULL),
(563, '66BP124XL', '66BP124', '66BP', 'XL', 230000, 7, NULL),
(564, '66BP124XXL', '66BP124', '66BP', 'XXL', 230000, 3, NULL),
(565, '66BP125S', '66BP125', '66BP', 'S', 260000, 6, NULL),
(566, '66BP125M', '66BP125', '66BP', 'M', 260000, 3, NULL),
(567, '66BP125L', '66BP125', '66BP', 'L', 265000, 0, NULL),
(568, '66BP125XL', '66BP125', '66BP', 'XL', 270000, 4, NULL),
(569, '66BP125XXL', '66BP125', '66BP', 'XXL', 270000, 6, NULL),
(570, '67BP126S', '67BP126', '67BP', 'S', 230000, 8, NULL),
(571, '67BP126M', '67BP126', '67BP', 'M', 230000, 10, NULL),
(572, '67BP126L', '67BP126', '67BP', 'L', 235000, 11, NULL),
(573, '67BP126XL', '67BP126', '67BP', 'XL', 240000, 12, NULL),
(574, '67BP126XXL', '67BP126', '67BP', 'XXL', 240000, 12, NULL),
(575, '67BP127S', '67BP127', '67BP', 'S', 270000, 3, NULL),
(576, '67BP127M', '67BP127', '67BP', 'M', 270000, 0, NULL),
(577, '67BP127L', '67BP127', '67BP', 'L', 275000, 4, NULL),
(578, '67BP127XL', '67BP127', '67BP', 'XL', 280000, 6, NULL),
(579, '67BP127XXL', '67BP127', '67BP', 'XXL', 280000, 6, NULL),
(580, '80DL140S', '80DL140', '80DL', 'S', 260000, 12, NULL),
(581, '80DL140M', '80DL140', '80DL', 'M', 260000, 6, NULL),
(582, '80DL140L', '80DL140', '80DL', 'L', 265000, 10, NULL),
(583, '80DL140XL', '80DL140', '80DL', 'XL', 270000, 14, NULL),
(584, '80DL140XXL', '80DL140', '80DL', 'XXL', 270000, 14, NULL),
(585, '80DL141S', '80DL141', '80DL', 'S', 280000, 6, NULL),
(586, '80DL141M', '80DL141', '80DL', 'M', 280000, 10, NULL),
(587, '80DL141L', '80DL141', '80DL', 'L', 285000, 14, NULL),
(588, '80DL141XL', '80DL141', '80DL', 'XL', 290000, 12, NULL),
(589, '80DL141XXL', '80DL141', '80DL', 'XXL', 290000, 3, NULL),
(590, '80DL142S', '80DL142', '80DL', 'S', 250000, 4, NULL),
(591, '80DL142M', '80DL142', '80DL', 'M', 250000, 12, 20),
(592, '80DL142L', '80DL142', '80DL', 'L', 255000, 1, NULL),
(593, '80DL142XL', '80DL142', '80DL', 'XL', 260000, 1, NULL),
(594, '80DL142XXL', '80DL142', '80DL', 'XXL', 260000, 3, NULL),
(595, '81DL143S', '81DL143', '81DL', 'S', 280000, 6, NULL),
(596, '81DL143M', '81DL143', '81DL', 'M', 280000, 10, 10),
(597, '81DL143L', '81DL143', '81DL', 'L', 285000, 0, NULL),
(598, '81DL143XL', '81DL143', '81DL', 'XL', 290000, 3, NULL),
(599, '81DL143XXL', '81DL143', '81DL', 'XXL', 290000, 2, NULL),
(600, '81DL144S', '81DL144', '81DL', 'S', 200000, 11, NULL),
(601, '81DL144M', '81DL144', '81DL', 'M', 200000, 8, NULL),
(602, '81DL144L', '81DL144', '81DL', 'L', 205000, 10, NULL),
(603, '81DL144XL', '81DL144', '81DL', 'XL', 210000, 12, NULL),
(604, '81DL144XXL', '81DL144', '81DL', 'XXL', 210000, 12, NULL),
(605, '81DL145S', '81DL145', '81DL', 'S', 280000, 12, 35),
(606, '81DL145M', '81DL145', '81DL', 'M', 280000, 8, NULL),
(607, '81DL145L', '81DL145', '81DL', 'L', 285000, 6, NULL),
(608, '81DL145XL', '81DL145', '81DL', 'XL', 290000, 4, NULL),
(609, '81DL145XXL', '81DL145', '81DL', 'XXL', 290000, 5, NULL),
(610, '81DL146S', '81DL146', '81DL', 'S', 290000, 10, NULL),
(611, '81DL146M', '81DL146', '81DL', 'M', 290000, 9, NULL),
(612, '81DL146L', '81DL146', '81DL', 'L', 295000, 1, NULL),
(613, '81DL146XL', '81DL146', '81DL', 'XL', 300000, 6, NULL),
(614, '81DL146XXL', '81DL146', '81DL', 'XXL', 300000, 0, NULL),
(617, '1BD153M', '1BD153', '1BD', 'M', NULL, 10, NULL),
(620, '1BD153XL', '1BD153', '1BD', 'XL', NULL, 10, NULL),
(621, '1BD153XXL', '1BD153', '1BD', 'XXL', NULL, 0, NULL),
(628, '1BD152L', '1BD152', '1BD', 'L', NULL, 10, NULL),
(629, '1BD152XL', '1BD152', '1BD', 'XL', NULL, 0, NULL),
(630, '1BD152XXL', '1BD152', '1BD', 'XXL', NULL, 10, NULL),
(634, '1BD153S', '1BD153', '1BD', 'S', NULL, 10, NULL);

--
-- Bẫy `sanpham`
--
DELIMITER $$
CREATE TRIGGER `update_gia_dsSP_after_delete` AFTER DELETE ON `sanpham` FOR EACH ROW BEGIN
  DECLARE min_gia int;
  SELECT MIN(gia) INTO min_gia FROM sanpham WHERE madssp = OLD.madssp;
  UPDATE dssanpham SET gia = min_gia WHERE madssp = OLD.madssp;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_gia_dsSP_after_update` AFTER UPDATE ON `sanpham` FOR EACH ROW BEGIN
  DECLARE min_gia int;
  SELECT MIN(gia) INTO min_gia FROM sanpham WHERE madssp = NEW.madssp;
  UPDATE dssanpham SET gia = min_gia WHERE madssp = NEW.madssp;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_hethang_anh_after_delete` AFTER DELETE ON `sanpham` FOR EACH ROW BEGIN
  DECLARE total_quantity int;
  SELECT SUM(soluong) INTO total_quantity FROM sanpham WHERE maanh = OLD.maanh;
  IF total_quantity = 0 THEN
    UPDATE anh SET hethang = true WHERE maanh = OLD.maanh;
  ELSE
    UPDATE anh SET hethang = false WHERE maanh = OLD.maanh;
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_hethang_anh_after_update` AFTER UPDATE ON `sanpham` FOR EACH ROW BEGIN
  DECLARE total_quantity int;
  SELECT SUM(soluong) INTO total_quantity FROM sanpham WHERE maanh = NEW.maanh;
  IF total_quantity = 0 THEN
    UPDATE anh SET hethang = true WHERE maanh = NEW.maanh;
  ELSE
    UPDATE anh SET hethang = false WHERE maanh = NEW.maanh;
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_hethang_dsSP_after_delete` AFTER DELETE ON `sanpham` FOR EACH ROW BEGIN
  DECLARE total_quantity int;
  SELECT SUM(soluong) INTO total_quantity FROM sanpham WHERE madssp = OLD.madssp;
  IF total_quantity = 0 THEN
    UPDATE dssanpham SET hethang = true WHERE madssp = OLD.madssp;
  ELSE
    UPDATE dssanpham SET hethang = false WHERE madssp = OLD.madssp;
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_hethang_dsSP_after_update` AFTER UPDATE ON `sanpham` FOR EACH ROW BEGIN
  DECLARE total_quantity int;
  SELECT SUM(soluong) INTO total_quantity FROM sanpham WHERE madssp = NEW.madssp;
  IF total_quantity = 0 THEN
    UPDATE dssanpham SET hethang = true WHERE madssp = NEW.madssp;
  ELSE
    UPDATE dssanpham SET hethang = false WHERE madssp = NEW.madssp;
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `iduser` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  `admin` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`iduser`, `name`, `email`, `phone`, `password`, `admin`) VALUES
(1, 'Tôn Thất Minh Nhật', 'toilaminhnhat01@gmail.com', '0854226954', '202cb962ac59075b964b07152d234b70', 1),
(2, 'Lê Thắm', 'tham@gmail.com', '0123123123', '202cb962ac59075b964b07152d234b70', NULL),
(4, '1', 'toilaminhnhat01@gmaul.com', '0111111111', '202cb962ac59075b964b07152d234b70', NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `anh`
--
ALTER TABLE `anh`
  ADD PRIMARY KEY (`idanh`),
  ADD UNIQUE KEY `maanh` (`maanh`),
  ADD KEY `madssp` (`madssp`);

--
-- Chỉ mục cho bảng `dssanpham`
--
ALTER TABLE `dssanpham`
  ADD PRIMARY KEY (`iddssp`) USING BTREE,
  ADD UNIQUE KEY `madssp` (`madssp`),
  ADD KEY `idmodel` (`idmodel`);

--
-- Chỉ mục cho bảng `giohang`
--
ALTER TABLE `giohang`
  ADD PRIMARY KEY (`idgiohang`),
  ADD KEY `masp` (`masp`),
  ADD KEY `iduser` (`iduser`),
  ADD KEY `iddonhang` (`iddonhang`);

--
-- Chỉ mục cho bảng `lichsudonhang`
--
ALTER TABLE `lichsudonhang`
  ADD PRIMARY KEY (`iddonhang`),
  ADD KEY `iduser` (`iduser`);

--
-- Chỉ mục cho bảng `model`
--
ALTER TABLE `model`
  ADD PRIMARY KEY (`idmodel`);

--
-- Chỉ mục cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  ADD PRIMARY KEY (`idsp`),
  ADD UNIQUE KEY `masp` (`masp`),
  ADD KEY `maanh` (`maanh`),
  ADD KEY `madssp` (`madssp`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`iduser`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `anh`
--
ALTER TABLE `anh`
  MODIFY `idanh` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=159;

--
-- AUTO_INCREMENT cho bảng `dssanpham`
--
ALTER TABLE `dssanpham`
  MODIFY `iddssp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=245;

--
-- AUTO_INCREMENT cho bảng `giohang`
--
ALTER TABLE `giohang`
  MODIFY `idgiohang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT cho bảng `lichsudonhang`
--
ALTER TABLE `lichsudonhang`
  MODIFY `iddonhang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  MODIFY `idsp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=635;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `iduser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `anh`
--
ALTER TABLE `anh`
  ADD CONSTRAINT `anh_ibfk_1` FOREIGN KEY (`madssp`) REFERENCES `dssanpham` (`madssp`);

--
-- Các ràng buộc cho bảng `dssanpham`
--
ALTER TABLE `dssanpham`
  ADD CONSTRAINT `dssanpham_ibfk_1` FOREIGN KEY (`idmodel`) REFERENCES `model` (`idmodel`);

--
-- Các ràng buộc cho bảng `giohang`
--
ALTER TABLE `giohang`
  ADD CONSTRAINT `giohang_ibfk_1` FOREIGN KEY (`masp`) REFERENCES `sanpham` (`masp`),
  ADD CONSTRAINT `giohang_ibfk_2` FOREIGN KEY (`iduser`) REFERENCES `users` (`iduser`),
  ADD CONSTRAINT `giohang_ibfk_3` FOREIGN KEY (`iddonhang`) REFERENCES `lichsudonhang` (`iddonhang`);

--
-- Các ràng buộc cho bảng `lichsudonhang`
--
ALTER TABLE `lichsudonhang`
  ADD CONSTRAINT `lichsudonhang_ibfk_1` FOREIGN KEY (`iduser`) REFERENCES `users` (`iduser`);

--
-- Các ràng buộc cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  ADD CONSTRAINT `sanpham_ibfk_1` FOREIGN KEY (`maanh`) REFERENCES `anh` (`maanh`),
  ADD CONSTRAINT `sanpham_ibfk_2` FOREIGN KEY (`madssp`) REFERENCES `dssanpham` (`madssp`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
