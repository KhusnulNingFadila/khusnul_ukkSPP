-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 25 Feb 2023 pada 04.20
-- Versi server: 10.4.18-MariaDB
-- Versi PHP: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `spp`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_siswa` ()  NO SQL
BEGIN
	SELECT `tbl_siswa`.*, `tbl_kelas`.`nama_kelas`, `tbl_spp`.`tahun`
                FROM `tbl_siswa` JOIN `tbl_kelas`
                ON `tbl_siswa`.`id_kelas` = `tbl_kelas`.`id_kelas`
                JOIN `tbl_spp` ON `tbl_siswa` .`id_spp` = `tbl_spp`.`id_spp` ORDER BY `tbl_siswa`.`NISN`, `tbl_siswa`.`id_kelas` ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kelas_get` ()  NO SQL
BEGIN
	SELECT `tbl_kelas`.*, `tbl_jurusan`.`jurusan` FROM `tbl_kelas` JOIN `tbl_jurusan` ON `tbl_kelas`.`id_jurusan` = `tbl_jurusan`.`id_jurusan` ORDER BY `tbl_kelas`.`id_jurusan` ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `level_get` (IN `level` INT)  NO SQL
BEGIN
	SELECT * FROM tbl_level WHERE level = id_level;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login_check` (IN `user` VARCHAR(100), IN `pass` VARCHAR(225))  NO SQL
BEGIN
	SELECT * FROM tbl_petugas WHERE user = username AND pass = password_petugas;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `siswa_check` (IN `user` VARCHAR(10), IN `pass` VARCHAR(225))  NO SQL
BEGIN
	SELECT * FROM tbl_siswa WHERE user = nisn AND pass = nis;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_jurusan`
--

CREATE TABLE `tbl_jurusan` (
  `ID_JURUSAN` int(11) NOT NULL,
  `JURUSAN` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tbl_jurusan`
--

INSERT INTO `tbl_jurusan` (`ID_JURUSAN`, `JURUSAN`) VALUES
(1, 'Rekayasa Perangkat Lunak'),
(2, 'Teknik Jaringan Dan Komputer'),
(3, 'teknik kendaraan ringan'),
(4, 'multi media'),
(5, 'teknik sepeda motor');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_kelas`
--

CREATE TABLE `tbl_kelas` (
  `ID_KELAS` int(11) NOT NULL,
  `ID_JURUSAN` int(11) DEFAULT NULL,
  `NAMA_KELAS` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tbl_kelas`
--

INSERT INTO `tbl_kelas` (`ID_KELAS`, `ID_JURUSAN`, `NAMA_KELAS`) VALUES
(1, 1, 'XII RPL 2'),
(2, 2, 'XII TKJ 2'),
(3, 3, 'TKR');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_level`
--

CREATE TABLE `tbl_level` (
  `ID_LEVEL` int(11) NOT NULL,
  `LEVEL` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tbl_level`
--

INSERT INTO `tbl_level` (`ID_LEVEL`, `LEVEL`) VALUES
(1, 'Admin'),
(2, 'Petugas'),
(3, 'Siswa');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_log`
--

CREATE TABLE `tbl_log` (
  `log_id` int(11) NOT NULL,
  `log_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `log_user` varchar(50) NOT NULL,
  `log_tipe` varchar(50) NOT NULL,
  `log_aksi` varchar(50) NOT NULL,
  `log_assign_to` varchar(50) NOT NULL,
  `log_assign_type` enum('petugas','siswa','spp','kelas','jurusan','transaksi','cetak') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tbl_log`
--

INSERT INTO `tbl_log` (`log_id`, `log_time`, `log_user`, `log_tipe`, `log_aksi`, `log_assign_to`, `log_assign_type`) VALUES
(9, '2020-02-23 13:07:42', 'Administrator', 'petugas', 'menambah data petugas', '', ''),
(10, '2020-02-23 13:08:06', 'Administrator', 'petugas', 'menambah data petugas', '', ''),
(11, '2020-02-23 13:15:11', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(12, '2020-02-23 13:15:16', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(13, '2020-02-23 13:15:19', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(14, '2020-02-23 13:15:27', 'Administrator', 'petugas', 'Mengedit data petugas', '', ''),
(15, '2020-02-23 14:06:44', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(16, '2020-02-23 14:07:22', 'Administrator', 'kelas', 'Menambah data kelas', '', ''),
(17, '2020-02-23 14:07:36', 'Administrator', 'kelas', 'Mengedit data kelas', '', ''),
(18, '2020-02-23 14:08:13', 'Administrator', 'spp', 'Menambah data spp', '', ''),
(19, '2020-02-24 12:38:04', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(20, '2020-02-24 12:44:24', 'Petugas', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(21, '2020-02-25 12:00:19', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(22, '2020-02-26 10:52:37', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(23, '2020-02-26 10:54:51', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(24, '2020-02-26 10:55:23', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(25, '2020-02-26 10:56:25', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(26, '2020-02-26 10:58:30', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(27, '2020-02-26 11:01:44', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(28, '2020-02-26 11:02:05', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(29, '2020-02-26 11:41:33', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(30, '2020-02-26 11:41:37', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(31, '2020-02-26 11:41:41', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(32, '2020-02-26 11:43:40', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(33, '2020-02-26 12:03:14', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(34, '2020-02-26 12:07:03', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(35, '2020-02-26 12:07:53', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(36, '2020-02-26 15:22:58', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(37, '2020-02-26 15:23:43', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(38, '2020-02-26 15:33:49', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(39, '2020-02-26 15:35:29', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(40, '2020-02-26 16:26:12', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(41, '2020-02-26 16:30:38', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(42, '2020-02-26 16:36:52', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(43, '2020-02-26 16:37:34', 'Administrator', 'pembayaran', 'Menghapus data transaksi pembayaran', '', ''),
(44, '2020-02-26 16:39:35', 'Petugas', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(45, '2020-02-26 17:21:22', 'Petugas', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(46, '2020-02-27 12:05:28', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(47, '2020-02-27 12:05:50', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(48, '2020-02-27 12:56:21', 'Administrator', 'petugas', 'Merubah password petugas', '', ''),
(49, '2020-02-28 06:53:56', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(50, '2020-02-28 07:16:29', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(51, '2020-02-28 07:29:44', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(52, '2020-02-28 07:30:56', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(53, '2020-02-28 07:31:15', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(54, '2020-02-28 07:50:13', 'Administrator', 'cetak', 'Mencetak laporan data siswa', '', ''),
(55, '2020-02-28 08:29:01', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(56, '2020-02-28 08:30:11', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(57, '2020-02-28 08:31:13', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(58, '2020-02-28 08:31:34', 'Administrator', 'cetak', 'Mencetak laporan data siswa', '', ''),
(59, '2020-02-28 08:32:08', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', ''),
(60, '2020-02-28 08:35:07', 'Administrator', 'cetak', 'Mencetak laporan data siswa', '', ''),
(61, '2020-02-28 08:35:20', 'Administrator', 'cetak', 'Mencetak laporan data siswa', '', ''),
(62, '2020-02-28 08:35:34', 'Administrator', 'cetak', 'Mencetak laporan data siswa', '', ''),
(63, '2020-02-28 08:36:10', 'Administrator', 'cetak', 'Mencetak laporan data siswa', '', ''),
(64, '2020-02-28 08:36:21', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(65, '2020-02-28 08:36:37', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(66, '2020-02-28 08:37:18', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', ''),
(67, '2020-02-28 08:37:33', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(68, '2020-02-28 08:38:12', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', ''),
(69, '2020-02-28 08:38:18', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(70, '2020-02-28 09:21:03', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(71, '2020-02-28 09:21:34', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(72, '2023-02-01 01:04:32', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(73, '2023-02-01 01:04:53', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(74, '2023-02-01 03:19:35', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(75, '2023-02-01 03:19:44', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(76, '2023-02-01 03:19:49', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(77, '2023-02-01 03:20:56', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(78, '2023-02-01 03:22:09', 'Administrator', 'kelas', 'Menambah data kelas', '', ''),
(79, '2023-02-01 06:10:43', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(80, '2023-02-01 06:15:17', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(81, '2023-02-01 06:30:06', 'Administrator', 'spp', 'Menambah data spp', '', ''),
(82, '2023-02-01 06:30:42', 'Administrator', 'spp', 'Menghapus data spp', '', ''),
(83, '2023-02-01 06:30:47', 'Administrator', 'spp', 'Menghapus data spp', '', ''),
(84, '2023-02-01 06:33:00', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(85, '2023-02-01 07:24:35', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(86, '2023-02-01 07:41:08', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(87, '2023-02-03 02:41:54', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(88, '2023-02-03 02:44:43', 'Administrator', 'petugas', 'Mengedit data petugas', '', ''),
(89, '2023-02-03 02:45:24', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(90, '2023-02-03 02:46:25', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(91, '2023-02-03 02:46:39', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(92, '2023-02-03 07:17:20', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(93, '2023-02-03 08:31:18', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(94, '2023-02-03 08:35:11', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(95, '2023-02-03 09:04:34', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(96, '2023-02-03 09:04:37', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(97, '2023-02-03 09:05:26', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(98, '2023-02-03 09:11:15', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(99, '2023-02-03 09:12:54', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(100, '2023-02-03 09:13:47', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(101, '2023-02-03 09:17:13', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(102, '2023-02-03 08:51:35', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(103, '2023-02-03 18:52:51', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(104, '2023-02-03 18:52:58', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(105, '2023-02-03 23:59:57', 'Administrator', 'spp', 'Menambah data spp', '', ''),
(106, '2023-02-04 00:02:34', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(107, '2023-02-04 00:04:24', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(108, '2023-02-04 00:05:37', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(109, '2023-02-25 00:56:51', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(110, '2023-02-25 00:57:06', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(111, '2023-02-25 00:57:07', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(112, '2023-02-25 00:58:14', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(113, '2023-02-25 01:06:41', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(114, '2023-02-25 01:06:50', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', ''),
(115, '2023-02-25 01:31:20', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', ''),
(116, '2023-02-25 01:33:09', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', ''),
(117, '2023-02-25 02:56:33', 'Administrator', 'spp', 'Menghapus data spp', '', ''),
(118, '2023-02-25 02:57:13', 'Administrator', 'spp', 'Menambah data spp', '', ''),
(119, '2023-02-25 02:58:54', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(120, '2023-02-25 02:59:36', 'Administrator', 'siswa', 'Menambah data siswa', '', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pembayaran`
--

CREATE TABLE `tbl_pembayaran` (
  `ID_PEMBAYARAN` int(11) NOT NULL,
  `ID_PETUGAS` int(11) DEFAULT NULL,
  `NISN` char(10) DEFAULT NULL,
  `TGL_BAYAR` date DEFAULT NULL,
  `JATUH_TEMPO` date NOT NULL,
  `BULAN_DIBAYAR` varchar(9) DEFAULT NULL,
  `TAHUN_DIBAYAR` varchar(4) DEFAULT NULL,
  `ID_SPP` int(11) NOT NULL,
  `JUMLAH_BAYAR` int(11) NOT NULL,
  `KET` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tbl_pembayaran`
--

INSERT INTO `tbl_pembayaran` (`ID_PEMBAYARAN`, `ID_PETUGAS`, `NISN`, `TGL_BAYAR`, `JATUH_TEMPO`, `BULAN_DIBAYAR`, `TAHUN_DIBAYAR`, `ID_SPP`, `JUMLAH_BAYAR`, `KET`) VALUES
(188, 1, '5146587952', NULL, '2023-07-20', 'Juli', '2023', 4, 12000, ''),
(189, 1, '5146587952', NULL, '2023-08-20', 'Agustus', '2023', 4, 12000, ''),
(190, 1, '5146587952', NULL, '2023-09-20', 'September', '2023', 4, 12000, ''),
(191, 1, '5146587952', NULL, '2023-10-20', 'Oktober', '2023', 4, 12000, ''),
(192, 1, '5146587952', NULL, '2023-11-20', 'November', '2023', 4, 12000, ''),
(193, 1, '5146587952', NULL, '2023-12-20', 'Desember', '2023', 4, 12000, ''),
(194, 1, '5146587952', NULL, '2024-01-20', 'Januari', '2024', 4, 12000, ''),
(195, 1, '5146587952', NULL, '2024-02-20', 'Februari', '2024', 4, 12000, ''),
(196, 1, '5146587952', NULL, '2024-03-20', 'Maret', '2024', 4, 12000, ''),
(197, 1, '5146587952', NULL, '2024-04-20', 'April', '2024', 4, 12000, ''),
(198, 1, '5146587952', NULL, '2024-05-20', 'Mei', '2024', 4, 12000, ''),
(199, 1, '5146587952', NULL, '2024-06-20', 'Juni', '2024', 4, 12000, '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_petugas`
--

CREATE TABLE `tbl_petugas` (
  `ID_PETUGAS` int(11) NOT NULL,
  `ID_LEVEL` int(11) DEFAULT NULL,
  `USERNAME` varchar(100) DEFAULT NULL,
  `PASSWORD_PETUGAS` varchar(225) DEFAULT NULL,
  `NAMA_PETUGAS` varchar(50) DEFAULT NULL,
  `DESKRIPSI` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tbl_petugas`
--

INSERT INTO `tbl_petugas` (`ID_PETUGAS`, `ID_LEVEL`, `USERNAME`, `PASSWORD_PETUGAS`, `NAMA_PETUGAS`, `DESKRIPSI`) VALUES
(1, 1, 'khusnulningfadila', 'd95e4ab7ba46cbb975969fa33b1e085b', 'Administrator', 'admin'),
(19, 2, 'neneng', '827ccb0eea8a706c4c34a16891f84e7b', 'neneng', '12345');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_siswa`
--

CREATE TABLE `tbl_siswa` (
  `NISN` char(10) NOT NULL,
  `ID_KELAS` int(11) DEFAULT NULL,
  `ID_SPP` int(11) DEFAULT NULL,
  `NIS` char(8) DEFAULT NULL,
  `NAMA` varchar(100) DEFAULT NULL,
  `ALAMAT` text DEFAULT NULL,
  `NO_TELP` varchar(13) DEFAULT NULL,
  `TIMESTAMP` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tbl_siswa`
--

INSERT INTO `tbl_siswa` (`NISN`, `ID_KELAS`, `ID_SPP`, `NIS`, `NAMA`, `ALAMAT`, `NO_TELP`, `TIMESTAMP`) VALUES
('5146587952', 1, 4, '11225544', 'vivi anggraini', 'semboro', '081559740457', '2023-02-25 02:59:35');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_spp`
--

CREATE TABLE `tbl_spp` (
  `ID_SPP` int(11) NOT NULL,
  `TAHUN` varchar(16) DEFAULT NULL,
  `NOMINAL` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tbl_spp`
--

INSERT INTO `tbl_spp` (`ID_SPP`, `TAHUN`, `NOMINAL`) VALUES
(4, '2022/2023', 12000),
(5, '2022/2023', 400000);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tbl_jurusan`
--
ALTER TABLE `tbl_jurusan`
  ADD PRIMARY KEY (`ID_JURUSAN`);

--
-- Indeks untuk tabel `tbl_kelas`
--
ALTER TABLE `tbl_kelas`
  ADD PRIMARY KEY (`ID_KELAS`),
  ADD KEY `FK_JURUSAN` (`ID_JURUSAN`);

--
-- Indeks untuk tabel `tbl_level`
--
ALTER TABLE `tbl_level`
  ADD PRIMARY KEY (`ID_LEVEL`);

--
-- Indeks untuk tabel `tbl_log`
--
ALTER TABLE `tbl_log`
  ADD PRIMARY KEY (`log_id`);

--
-- Indeks untuk tabel `tbl_pembayaran`
--
ALTER TABLE `tbl_pembayaran`
  ADD PRIMARY KEY (`ID_PEMBAYARAN`),
  ADD KEY `FK_PETUGAS` (`ID_PETUGAS`),
  ADD KEY `FK_SISWA` (`NISN`);

--
-- Indeks untuk tabel `tbl_petugas`
--
ALTER TABLE `tbl_petugas`
  ADD PRIMARY KEY (`ID_PETUGAS`),
  ADD KEY `FK_LEVEL` (`ID_LEVEL`);

--
-- Indeks untuk tabel `tbl_siswa`
--
ALTER TABLE `tbl_siswa`
  ADD PRIMARY KEY (`NISN`),
  ADD KEY `FK_KELAS` (`ID_KELAS`),
  ADD KEY `FK_SPP` (`ID_SPP`);

--
-- Indeks untuk tabel `tbl_spp`
--
ALTER TABLE `tbl_spp`
  ADD PRIMARY KEY (`ID_SPP`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tbl_jurusan`
--
ALTER TABLE `tbl_jurusan`
  MODIFY `ID_JURUSAN` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `tbl_kelas`
--
ALTER TABLE `tbl_kelas`
  MODIFY `ID_KELAS` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tbl_level`
--
ALTER TABLE `tbl_level`
  MODIFY `ID_LEVEL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tbl_log`
--
ALTER TABLE `tbl_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT untuk tabel `tbl_pembayaran`
--
ALTER TABLE `tbl_pembayaran`
  MODIFY `ID_PEMBAYARAN` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=200;

--
-- AUTO_INCREMENT untuk tabel `tbl_petugas`
--
ALTER TABLE `tbl_petugas`
  MODIFY `ID_PETUGAS` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT untuk tabel `tbl_spp`
--
ALTER TABLE `tbl_spp`
  MODIFY `ID_SPP` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `tbl_kelas`
--
ALTER TABLE `tbl_kelas`
  ADD CONSTRAINT `FK_JURUSAN` FOREIGN KEY (`ID_JURUSAN`) REFERENCES `tbl_jurusan` (`ID_JURUSAN`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_pembayaran`
--
ALTER TABLE `tbl_pembayaran`
  ADD CONSTRAINT `FK_PETUGAS` FOREIGN KEY (`ID_PETUGAS`) REFERENCES `tbl_petugas` (`ID_PETUGAS`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_SISWA` FOREIGN KEY (`NISN`) REFERENCES `tbl_siswa` (`NISN`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_petugas`
--
ALTER TABLE `tbl_petugas`
  ADD CONSTRAINT `FK_LEVEL` FOREIGN KEY (`ID_LEVEL`) REFERENCES `tbl_level` (`ID_LEVEL`);

--
-- Ketidakleluasaan untuk tabel `tbl_siswa`
--
ALTER TABLE `tbl_siswa`
  ADD CONSTRAINT `FK_KELAS` FOREIGN KEY (`ID_KELAS`) REFERENCES `tbl_kelas` (`ID_KELAS`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SPP` FOREIGN KEY (`ID_SPP`) REFERENCES `tbl_spp` (`ID_SPP`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
