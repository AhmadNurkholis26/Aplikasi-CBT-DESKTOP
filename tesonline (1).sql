-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 06 Des 2022 pada 06.02
-- Versi server: 10.4.24-MariaDB
-- Versi PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tesonline`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AcakSoal` (`nomor` INT(10), `id_pel` INT(10), `id_kat` INT(10))   BEGIN
select * from tbl_soal where no_soal=nomor and id_pelajaran=id_pel and id_kategori=id_kat order by RAND() LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `bacaPesanMasuk` (`id` INT(10))   BEGIN
select id_hub,pengirim,penerima,pesan from tbl_hubungi where penerima=id order by id_hub DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `balasPesanAdmin` (`id_penerima` INT(10), `psn` VARCHAR(1500))   BEGIN
insert into tbl_hubungi(pengirim,penerima,pesan) values('admin',id_penerima,psn);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cekIkutSerta` (`idkat` VARCHAR(10), `idpel` VARCHAR(10), `nosoal` VARCHAR(10), `idsiswa` VARCHAR(10))   BEGIN
select * from tbl_hasil where id_kat_soal=idkat and id_pel=idpel and no_soal=nosoal and id_siswa=idsiswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `hapusKat` (`id` INT(10))   BEGIN
delete from tbl_kat_soal where id_kat=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `hapusMat` (`id` INT(10))   BEGIN
delete from tbl_pelajaran where id_pel=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `hapusSiswa` (`id` INT(10))   BEGIN
delete from tbl_siswa where no_induk=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `hapusSoal` (`id` INT(10))   BEGIN
delete from tbl_soal where id_soal=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kirimPesanClient` (`p_kirim` VARCHAR(100), `psn` VARCHAR(1500))   BEGIN
insert into tbl_hubungi(pengirim,penerima,pesan) values(p_kirim,'admin',psn);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lihatContact` ()   BEGIN
select tbl_hubungi.id_hub,tbl_siswa.nama_siswa,tbl_hubungi.pesan,tbl_hubungi.pengirim from tbl_hubungi left join tbl_siswa on tbl_hubungi.pengirim=tbl_siswa.no_induk where penerima='admin' order by id_hub DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lihatNilaiPerKat` (`id` INT(10), `id_kat` INT(10))   BEGIN
select tbl_hasil.no_soal,nama_pel,nama_kat,hasil from tbl_hasil left join (tbl_pelajaran,tbl_kat_soal) 
on tbl_hasil.id_pel=tbl_pelajaran.id_pel and tbl_hasil.id_kat_soal=tbl_kat_soal.id_kat where 
tbl_hasil.id_kat_soal=id_kat and id_siswa=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lihatNilaiPerKategori` (`id` INT(10))   BEGIN
select tbl_hasil.no_soal,nama_siswa,nama_pel,nama_kat,hasil from tbl_hasil left join (tbl_pelajaran,tbl_kat_soal,tbl_siswa) on tbl_hasil.id_pel=tbl_pelajaran.id_pel and tbl_hasil.id_kat_soal=tbl_kat_soal.id_kat and tbl_hasil.id_siswa=tbl_siswa.no_induk where tbl_hasil.id_kat_soal=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lihatNilaiPerMataPelajaran` (`id` INT(10))   BEGIN
select tbl_hasil.no_soal,nama_siswa,nama_pel,nama_kat,hasil from tbl_hasil left join (tbl_pelajaran,tbl_kat_soal,tbl_siswa) on tbl_hasil.id_pel=tbl_pelajaran.id_pel and tbl_hasil.id_kat_soal=tbl_kat_soal.id_kat and tbl_hasil.id_siswa=tbl_siswa.no_induk where tbl_hasil.id_pel=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lihatNilaiPerMatPel` (`id` INT(10), `id_pelajaran` INT(10))   BEGIN
select tbl_hasil.no_soal,nama_pel,nama_kat,hasil from tbl_hasil left join (tbl_pelajaran,tbl_kat_soal) 
on tbl_hasil.id_pel=tbl_pelajaran.id_pel and tbl_hasil.id_kat_soal=tbl_kat_soal.id_kat where 
tbl_hasil.id_pel=id_pelajaran and id_siswa=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lihatNilaiPerSiswa` (`id` INT(10))   BEGIN
select tbl_hasil.no_soal,nama_siswa,nama_pel,nama_kat,hasil from tbl_hasil left join (tbl_pelajaran,tbl_kat_soal,tbl_siswa) on tbl_hasil.id_pel=tbl_pelajaran.id_pel and tbl_hasil.id_kat_soal=tbl_kat_soal.id_kat and tbl_hasil.id_siswa=tbl_siswa.no_induk where id_siswa=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lihatPerKat` (`id` INT(10))   BEGIN
select id_soal,id_pelajaran,id_kategori,no_soal,nama_pel,nama_kat,lama_waktu  from tbl_soal left join (tbl_kat_soal,tbl_pelajaran) on tbl_soal.id_kategori=tbl_kat_soal.id_kat
and tbl_soal.id_pelajaran=tbl_pelajaran.id_pel where id_kategori=id group by no_soal;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lihatPerMat` (`id` INT(10))   BEGIN
select id_soal,id_pelajaran,id_kategori,no_soal,nama_pel,nama_kat,lama_waktu  from tbl_soal left join (tbl_kat_soal,tbl_pelajaran) on tbl_soal.id_kategori=tbl_kat_soal.id_kat
and tbl_soal.id_pelajaran=tbl_pelajaran.id_pel where id_pelajaran=id group by no_soal;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lihatRanking` ()   BEGIN
SELECT id_siswa, nama_siswa, avg(tbl_hasil.hasil) as jml FROM tbl_hasil left join tbl_siswa on tbl_hasil.id_siswa=tbl_siswa.no_induk group by tbl_hasil.id_siswa order by jml desc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lihatSemuaKategori` ()   BEGIN
select * from tbl_kat_soal;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lihatSemuaNilai` (`id` INT(10))   BEGIN
select tbl_hasil.no_soal,nama_pel,nama_kat,hasil from tbl_hasil left join (tbl_pelajaran,tbl_kat_soal) on tbl_hasil.id_pel=tbl_pelajaran.id_pel and tbl_hasil.id_kat_soal=tbl_kat_soal.id_kat where id_siswa=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lihatSemuaPelajaran` ()   BEGIN
select * from tbl_pelajaran;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lihatSemuaSoal` ()   BEGIN
select id_soal,id_pelajaran,id_kategori,no_soal,nama_pel,nama_kat,lama_waktu from tbl_soal left join (tbl_kat_soal,tbl_pelajaran) on tbl_soal.id_kategori=tbl_kat_soal.id_kat
and tbl_soal.id_pelajaran=tbl_pelajaran.id_pel group by no_soal,id_pelajaran,id_kategori;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lihatSiswa` ()   BEGIN
select no_induk,nama_siswa,alamat from tbl_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loginAdmin` (`user` VARCHAR(40), `pass` VARCHAR(40))   BEGIN
select * from tbl_admin where username=user and password=pass;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loginUser` (`user` VARCHAR(40), `pass` VARCHAR(40))   BEGIN
select * from tbl_siswa where no_induk=user and password=pass;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pilihSiswa` (`id` INT(10))   BEGIN
select * from tbl_siswa where no_induk=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `simpanHasil` (`id_kat` INT(10), `id_pel` INT(10), `no_soal` INT(10), `id_siswa` INT(10), `salah` INT(5), `benar` INT(5), `hasil` VARCHAR(10))   BEGIN
insert into tbl_hasil (id_kat_soal,id_pel,no_soal,id_siswa,salah,benar,hasil) values (id_kat,id_pel,no_soal,id_siswa,salah,benar,hasil);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `simpanJawaban` (`idsoal` INT(10), `idkat` INT(10), `nosoal` INT(10), `idpel` INT(10), `idsiswa` INT(10), `kuncijwb` VARCHAR(10))   BEGIN
insert into tbl_jawab_soal (id_soal,id_kat_soal,no_soal,id_pel,id_siswa,kunci) values (idsoal,idkat,nosoal,idpel,idsiswa,kuncijwb);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `simpanKategori` (`nama` VARCHAR(100))   BEGIN
insert into tbl_kat_soal(nama_kat) values(nama);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `simpanMatPel` (`nama` VARCHAR(100), `durasi` INT(20))   BEGIN
insert into tbl_pelajaran(nama_pel,lama_waktu) values (nama,durasi);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `simpanSiswa` (`induk` INT(20), `nama` VARCHAR(100), `lahir` VARCHAR(100), `almt` VARCHAR(200), `pass` VARCHAR(30))   BEGIN
insert into tbl_siswa(no_induk,nama_siswa,kelahiran,alamat,password,foto) values (induk,nama,lahir,almt,pass,'no-photo.jpg');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `simpanSoal` (`nosoal` INT(5), `idpel` INT(5), `idkat` INT(5), `soal` VARCHAR(800), `jwba` VARCHAR(100), `jwbb` VARCHAR(100), `jwbc` VARCHAR(100), `jwbd` VARCHAR(100), `knci` VARCHAR(3))   BEGIN
insert into tbl_soal(no_soal,id_pelajaran,id_kategori,pertanyaan,jwb_a,jwb_b,jwb_c,jwb_d,kunci) values (nosoal,idpel,idkat,soal,jwba,jwbb,jwbc,jwbd,knci);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilEditSoal` (`id` INT(10))   BEGIN
select * from tbl_soal where id_soal=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilHasilTesSementara` (`idkat` INT(10), `nosoal` INT(10), `idsiswa` INT(10), `jwb` VARCHAR(10))   BEGIN
select * from tbl_jawab_soal where id_kat_soal=idkat and no_soal=nosoal and id_siswa=idsiswa and kunci=jwb;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilKumpulanSoal` (`id` INT(10), `nosoal` INT(10), `idpel` INT(10))   BEGIN
select id_soal,pertanyaan  from tbl_soal left join (tbl_kat_soal,tbl_pelajaran) on tbl_soal.id_kategori=tbl_kat_soal.id_kat
and tbl_soal.id_pelajaran=tbl_pelajaran.id_pel where id_kategori=id and no_soal=nosoal and id_pelajaran=idpel;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `totalSiswa` ()   BEGIN
select * from tbl_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateDataSiswa` (`id_siswa` INT(10), `nama` VARCHAR(100), `lahir` VARCHAR(100), `almt` VARCHAR(200))   BEGIN
update tbl_siswa set nama_siswa=nama, kelahiran=lahir, alamat=almt where no_induk=id_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateFotoSiswa` (`n_induk` INT(10), `f_baru` VARCHAR(40))   BEGIN
update tbl_siswa set foto=f_baru where no_induk=n_induk;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateKat` (`nama` VARCHAR(100), `id` INT(10))   BEGIN
update tbl_kat_soal set nama_kat=nama where id_kat=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateMat` (`nama` VARCHAR(100), `durasi` INT(10), `id` INT(10))   BEGIN
update tbl_pelajaran set nama_pel=nama,lama_waktu=durasi where id_pel=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePasswordSiswa` (`id_siswa` INT(10), `pwd` VARCHAR(40))   BEGIN
update tbl_siswa set password=pwd where no_induk=id_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateSiswa` (`id` INT(10), `nama` VARCHAR(100), `lahir` VARCHAR(100), `almt` VARCHAR(200), `pass` VARCHAR(50))   BEGIN
update tbl_siswa set nama_siswa=nama,kelahiran=lahir,alamat=almt,password=pass where no_induk=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateSoal` (`id` INT(10), `soal` VARCHAR(500), `jwba` VARCHAR(200), `jwbb` VARCHAR(200), `jwbc` VARCHAR(200), `jwbd` VARCHAR(200), `knci` VARCHAR(2))   BEGIN
update tbl_soal set pertanyaan=soal,jwb_a=jwba,jwb_b=jwbb,jwb_c=jwbc,jwb_d=jwbd,kunci=knci where id_soal=id;
END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `tes` (`id_kat` INT(10), `no_soal` INT(10), `id_siswa` INT(10)) RETURNS INT(11) DETERMINISTIC BEGIN
declare hasil int;
select count(tbl_jawab_soal.kunci) as jml into hasil from tbl_jawab_soal where id_kat_soal=id_kat and no_soal=no_soal and id_siswa=id_siswa and kunci='benar';
return hasil;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_admin`
--

CREATE TABLE `tbl_admin` (
  `id_admin` int(10) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `nama_lengkap` varchar(200) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_admin`
--

INSERT INTO `tbl_admin` (`id_admin`, `username`, `password`, `nama_lengkap`) VALUES
(1, 'admin', 'admin', 'Ahmad Nurkholis');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_hasil`
--

CREATE TABLE `tbl_hasil` (
  `id_hasil` int(10) NOT NULL,
  `id_kat_soal` int(10) NOT NULL,
  `id_pel` int(10) NOT NULL,
  `no_soal` int(10) NOT NULL,
  `id_siswa` int(10) NOT NULL,
  `salah` int(5) NOT NULL,
  `benar` int(5) NOT NULL,
  `hasil` varchar(10) CHARACTER SET latin1 NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data untuk tabel `tbl_hasil`
--

INSERT INTO `tbl_hasil` (`id_hasil`, `id_kat_soal`, `id_pel`, `no_soal`, `id_siswa`, `salah`, `benar`, `hasil`) VALUES
(1, 1, 1, 1, 1101, 16, 4, '20'),
(2, 2, 1, 2, 1101, 4, 16, '80'),
(3, 1, 1, 3, 1101, 0, 5, '25'),
(4, 1, 1, 1, 1102, 0, 20, '100'),
(5, 1, 2, 4, 1102, 0, 20, '100'),
(6, 1, 1, 1, 1103, 16, 4, '20'),
(8, 1, 2, 4, 1101, 0, 20, '100'),
(9, 1, 6, 1, 1101, 44, 6, '30'),
(10, 2, 1, 2, 1102, 13, 8, '40');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_hubungi`
--

CREATE TABLE `tbl_hubungi` (
  `id_hub` int(10) NOT NULL,
  `pengirim` varchar(50) NOT NULL,
  `penerima` varchar(50) NOT NULL,
  `pesan` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_hubungi`
--

INSERT INTO `tbl_hubungi` (`id_hub`, `pengirim`, `penerima`, `pesan`) VALUES
(11, '1101', 'admin', 'Mas admin, saya mau tanya tentang fasilitas lupa password. Jika ada yang tidak bisa login, solusinya bagaimana tuh?\r\nTrims.'),
(12, 'admin', '1101', 'Reply from : ( Mas admin, saya mau tanya tentang fasilitas lupa password. Jika ada yang tidak bisa login, solusinya bagaimana tuh?\r\nTrims. ) ==> \nSilahkan menghubungi saya di ruang server.');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_jawab_soal`
--

CREATE TABLE `tbl_jawab_soal` (
  `id_jawaban` int(10) NOT NULL,
  `id_soal` int(10) NOT NULL,
  `id_kat_soal` int(10) NOT NULL,
  `no_soal` int(10) NOT NULL,
  `id_pel` int(10) NOT NULL,
  `id_siswa` int(10) NOT NULL,
  `kunci` varchar(10) CHARACTER SET latin1 NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data untuk tabel `tbl_jawab_soal`
--

INSERT INTO `tbl_jawab_soal` (`id_jawaban`, `id_soal`, `id_kat_soal`, `no_soal`, `id_pel`, `id_siswa`, `kunci`) VALUES
(1, 10, 1, 1, 1, 1101, 'salah'),
(2, 9, 1, 1, 1, 1101, 'salah'),
(3, 10, 1, 1, 1, 1101, 'salah'),
(4, 8, 1, 1, 1, 1101, 'salah'),
(5, 9, 1, 1, 1, 1101, 'salah'),
(6, 16, 1, 1, 1, 1101, 'salah'),
(7, 11, 1, 1, 1, 1101, 'benar'),
(8, 8, 1, 1, 1, 1101, 'salah'),
(9, 16, 1, 1, 1, 1101, 'salah'),
(10, 10, 1, 1, 1, 1101, 'salah'),
(11, 11, 1, 1, 1, 1101, 'benar'),
(12, 9, 1, 1, 1, 1101, 'salah'),
(13, 11, 1, 1, 1, 1101, 'benar'),
(14, 8, 1, 1, 1, 1101, 'salah'),
(15, 11, 1, 1, 1, 1101, 'benar'),
(16, 10, 1, 1, 1, 1101, 'salah'),
(17, 16, 1, 1, 1, 1101, 'salah'),
(18, 10, 1, 1, 1, 1101, 'salah'),
(19, 9, 1, 1, 1, 1101, 'salah'),
(20, 8, 1, 1, 1, 1101, 'salah'),
(21, 7, 2, 2, 1, 1101, 'benar'),
(22, 6, 2, 2, 1, 1101, 'benar'),
(23, 2, 2, 2, 1, 1101, 'benar'),
(24, 3, 2, 2, 1, 1101, 'benar'),
(25, 6, 2, 2, 1, 1101, 'benar'),
(26, 4, 2, 2, 1, 1101, 'benar'),
(27, 3, 2, 2, 1, 1101, 'benar'),
(28, 1, 2, 2, 1, 1101, 'salah'),
(29, 6, 2, 2, 1, 1101, 'benar'),
(30, 5, 2, 2, 1, 1101, 'salah'),
(31, 7, 2, 2, 1, 1101, 'benar'),
(32, 2, 2, 2, 1, 1101, 'benar'),
(33, 4, 2, 2, 1, 1101, 'benar'),
(34, 3, 2, 2, 1, 1101, 'benar'),
(35, 7, 2, 2, 1, 1101, 'benar'),
(36, 1, 2, 2, 1, 1101, 'salah'),
(37, 6, 2, 2, 1, 1101, 'benar'),
(38, 3, 2, 2, 1, 1101, 'benar'),
(39, 5, 2, 2, 1, 1101, 'salah'),
(40, 2, 2, 2, 1, 1101, 'benar'),
(41, 15, 1, 3, 1, 1101, 'benar'),
(42, 12, 1, 3, 1, 1101, 'benar'),
(43, 13, 1, 3, 1, 1101, 'benar'),
(44, 14, 1, 3, 1, 1101, 'benar'),
(45, 12, 1, 3, 1, 1101, 'benar'),
(46, 11, 1, 1, 1, 1102, 'benar'),
(47, 16, 1, 1, 1, 1102, 'benar'),
(48, 9, 1, 1, 1, 1102, 'benar'),
(49, 10, 1, 1, 1, 1102, 'benar'),
(50, 16, 1, 1, 1, 1102, 'benar'),
(51, 8, 1, 1, 1, 1102, 'benar'),
(52, 9, 1, 1, 1, 1102, 'benar'),
(53, 10, 1, 1, 1, 1102, 'benar'),
(54, 11, 1, 1, 1, 1102, 'benar'),
(55, 16, 1, 1, 1, 1102, 'benar'),
(56, 8, 1, 1, 1, 1102, 'benar'),
(57, 9, 1, 1, 1, 1102, 'benar'),
(58, 10, 1, 1, 1, 1102, 'benar'),
(59, 9, 1, 1, 1, 1102, 'benar'),
(60, 16, 1, 1, 1, 1102, 'benar'),
(61, 11, 1, 1, 1, 1102, 'benar'),
(62, 8, 1, 1, 1, 1102, 'benar'),
(63, 10, 1, 1, 1, 1102, 'benar'),
(64, 16, 1, 1, 1, 1102, 'benar'),
(65, 11, 1, 1, 1, 1102, 'benar'),
(66, 18, 1, 4, 2, 1102, 'benar'),
(67, 17, 1, 4, 2, 1102, 'benar'),
(68, 20, 1, 4, 2, 1102, 'benar'),
(69, 18, 1, 4, 2, 1102, 'benar'),
(70, 19, 1, 4, 2, 1102, 'benar'),
(71, 21, 1, 4, 2, 1102, 'benar'),
(72, 20, 1, 4, 2, 1102, 'benar'),
(73, 18, 1, 4, 2, 1102, 'benar'),
(74, 17, 1, 4, 2, 1102, 'benar'),
(75, 21, 1, 4, 2, 1102, 'benar'),
(76, 19, 1, 4, 2, 1102, 'benar'),
(77, 18, 1, 4, 2, 1102, 'benar'),
(78, 20, 1, 4, 2, 1102, 'benar'),
(79, 19, 1, 4, 2, 1102, 'benar'),
(80, 18, 1, 4, 2, 1102, 'benar'),
(81, 21, 1, 4, 2, 1102, 'benar'),
(82, 17, 1, 4, 2, 1102, 'benar'),
(83, 20, 1, 4, 2, 1102, 'benar'),
(84, 19, 1, 4, 2, 1102, 'benar'),
(85, 18, 1, 4, 2, 1102, 'benar'),
(86, 3, 2, 2, 1, 1102, 'benar'),
(87, 5, 2, 2, 1, 1103, 'benar'),
(88, 11, 1, 1, 1, 1103, 'benar'),
(89, 10, 1, 1, 1, 1103, 'salah'),
(90, 8, 1, 1, 1, 1103, 'salah'),
(91, 16, 1, 1, 1, 1103, 'salah'),
(92, 16, 1, 1, 1, 1103, 'salah'),
(93, 11, 1, 1, 1, 1103, 'benar'),
(94, 9, 1, 1, 1, 1103, 'salah'),
(95, 9, 1, 1, 1, 1103, 'salah'),
(96, 10, 1, 1, 1, 1103, 'salah'),
(97, 8, 1, 1, 1, 1103, 'salah'),
(98, 16, 1, 1, 1, 1103, 'salah'),
(99, 9, 1, 1, 1, 1103, 'salah'),
(100, 11, 1, 1, 1, 1103, 'benar'),
(101, 10, 1, 1, 1, 1103, 'salah'),
(102, 16, 1, 1, 1, 1103, 'salah'),
(103, 8, 1, 1, 1, 1103, 'salah'),
(104, 9, 1, 1, 1, 1103, 'salah'),
(105, 11, 1, 1, 1, 1103, 'benar'),
(106, 16, 1, 1, 1, 1103, 'salah'),
(107, 10, 1, 1, 1, 1103, 'salah'),
(108, 27, 1, 1, 6, 1101, 'salah'),
(109, 27, 1, 1, 6, 1101, 'salah'),
(110, 27, 1, 1, 6, 1101, 'salah'),
(111, 27, 1, 1, 6, 1101, 'salah'),
(112, 27, 1, 1, 6, 1101, 'salah'),
(113, 27, 1, 1, 6, 1101, 'salah'),
(114, 27, 1, 1, 6, 1101, 'salah'),
(115, 27, 1, 1, 6, 1101, 'salah'),
(116, 27, 1, 1, 6, 1101, 'salah'),
(117, 27, 1, 1, 6, 1101, 'salah'),
(118, 27, 1, 1, 6, 1101, 'salah'),
(119, 27, 1, 1, 6, 1101, 'salah'),
(120, 27, 1, 1, 6, 1101, 'salah'),
(121, 27, 1, 1, 6, 1101, 'salah'),
(122, 27, 1, 1, 6, 1101, 'salah'),
(123, 27, 1, 1, 6, 1101, 'salah'),
(124, 27, 1, 1, 6, 1101, 'salah'),
(125, 27, 1, 1, 6, 1101, 'salah'),
(126, 27, 1, 1, 6, 1101, 'salah'),
(127, 27, 1, 1, 6, 1101, 'salah'),
(128, 27, 1, 1, 6, 1101, 'salah'),
(129, 27, 1, 1, 6, 1101, 'salah'),
(130, 27, 1, 1, 6, 1101, 'benar'),
(131, 27, 1, 1, 6, 1101, 'benar'),
(132, 27, 1, 1, 6, 1101, 'salah'),
(133, 27, 1, 1, 6, 1101, 'salah'),
(134, 27, 1, 1, 6, 1101, 'salah'),
(135, 27, 1, 1, 6, 1101, 'salah'),
(136, 27, 1, 1, 6, 1101, 'salah'),
(137, 27, 1, 1, 6, 1101, 'salah'),
(138, 18, 1, 4, 2, 1101, 'benar'),
(139, 18, 1, 4, 2, 1101, 'benar'),
(140, 20, 1, 4, 2, 1101, 'benar'),
(141, 19, 1, 4, 2, 1101, 'benar'),
(142, 18, 1, 4, 2, 1101, 'benar'),
(143, 21, 1, 4, 2, 1101, 'benar'),
(144, 17, 1, 4, 2, 1101, 'benar'),
(145, 18, 1, 4, 2, 1101, 'benar'),
(146, 19, 1, 4, 2, 1101, 'benar'),
(147, 20, 1, 4, 2, 1101, 'benar'),
(148, 19, 1, 4, 2, 1101, 'benar'),
(149, 18, 1, 4, 2, 1101, 'benar'),
(150, 17, 1, 4, 2, 1101, 'benar'),
(151, 21, 1, 4, 2, 1101, 'benar'),
(152, 17, 1, 4, 2, 1101, 'benar'),
(153, 18, 1, 4, 2, 1101, 'benar'),
(154, 20, 1, 4, 2, 1101, 'benar'),
(155, 19, 1, 4, 2, 1101, 'benar'),
(156, 18, 1, 4, 2, 1101, 'benar'),
(157, 21, 1, 4, 2, 1101, 'benar'),
(158, 5, 2, 2, 1, 1102, 'salah'),
(159, 3, 2, 2, 1, 1102, 'salah'),
(160, 1, 2, 2, 1, 1102, 'benar'),
(161, 2, 2, 2, 1, 1102, 'salah'),
(162, 5, 2, 2, 1, 1102, 'salah'),
(163, 4, 2, 2, 1, 1102, 'benar'),
(164, 1, 2, 2, 1, 1102, 'benar'),
(165, 6, 2, 2, 1, 1102, 'salah'),
(166, 3, 2, 2, 1, 1102, 'salah'),
(167, 5, 2, 2, 1, 1102, 'salah'),
(168, 1, 2, 2, 1, 1102, 'benar'),
(169, 2, 2, 2, 1, 1102, 'salah'),
(170, 6, 2, 2, 1, 1102, 'salah'),
(171, 4, 2, 2, 1, 1102, 'benar'),
(172, 3, 2, 2, 1, 1102, 'salah'),
(173, 2, 2, 2, 1, 1102, 'salah'),
(174, 5, 2, 2, 1, 1102, 'salah'),
(175, 6, 2, 2, 1, 1102, 'salah'),
(176, 1, 2, 2, 1, 1102, 'benar'),
(177, 4, 2, 2, 1, 1102, 'benar');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_kat_soal`
--

CREATE TABLE `tbl_kat_soal` (
  `id_kat` int(10) NOT NULL,
  `nama_kat` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_kat_soal`
--

INSERT INTO `tbl_kat_soal` (`id_kat`, `nama_kat`) VALUES
(1, 'Soal Ujian Mid Semester'),
(2, 'Soal Ujian Semester'),
(3, 'Soal Ujian Harian');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pelajaran`
--

CREATE TABLE `tbl_pelajaran` (
  `id_pel` int(10) NOT NULL,
  `nama_pel` varchar(100) NOT NULL,
  `lama_waktu` int(5) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pelajaran`
--

INSERT INTO `tbl_pelajaran` (`id_pel`, `nama_pel`, `lama_waktu`) VALUES
(1, 'Pemrograman', 20),
(2, 'Bahasa Indonesia', 15),
(3, 'Bahasa Inggris', 15),
(4, 'IPA', 15),
(5, 'IPS', 15);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_siswa`
--

CREATE TABLE `tbl_siswa` (
  `no_induk` int(10) NOT NULL,
  `nama_siswa` varchar(100) NOT NULL,
  `kelahiran` varchar(100) NOT NULL,
  `alamat` varchar(200) NOT NULL,
  `password` varchar(50) NOT NULL,
  `foto` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_siswa`
--

INSERT INTO `tbl_siswa` (`no_induk`, `nama_siswa`, `kelahiran`, `alamat`, `password`, `foto`) VALUES
(1101, 'Samsudin Jadab', 'Denpasar, 04 Februari 1991', 'Denpasar, Bali', '1101', '1101.jpg'),
(1102, 'Habib Jindan', 'Banyuwangi, 21 Desember 1987', 'Rogojampi, Banyuwangi', '1102', '1102.jpg'),
(1103, 'Firdaus', 'Banyuwangi, 06 Juli 1991', 'Purwoharjo, Banyuwangi', '1103', ''),
(1104, 'Rizky Bilar', 'Banyuwangi, 18 Juli 1990', 'Rogojampi, Banyuwangi', '1104', ''),
(1105, 'Lesti', 'Padang, 07 Oktober 1989', 'Labuhan Ratu', '1105', ''),
(1106, 'Pesulap Merah', 'Situbondo, 27 Desember 1989', 'Jakarta', '1106', ''),
(1107, 'Aldi Taher', 'Tangerang, 12 Juli 1988', 'Bntaran kali ciliwung', '1107', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_soal`
--

CREATE TABLE `tbl_soal` (
  `id_soal` int(10) NOT NULL,
  `no_soal` int(10) NOT NULL,
  `id_pelajaran` int(10) NOT NULL,
  `id_kategori` int(10) NOT NULL,
  `pertanyaan` text COLLATE latin1_general_ci NOT NULL,
  `jwb_a` varchar(200) COLLATE latin1_general_ci NOT NULL,
  `jwb_b` varchar(200) COLLATE latin1_general_ci NOT NULL,
  `jwb_c` varchar(200) COLLATE latin1_general_ci NOT NULL,
  `jwb_d` varchar(200) COLLATE latin1_general_ci NOT NULL,
  `kunci` varchar(2) COLLATE latin1_general_ci NOT NULL,
  `penulis` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data untuk tabel `tbl_soal`
--

INSERT INTO `tbl_soal` (`id_soal`, `no_soal`, `id_pelajaran`, `id_kategori`, `pertanyaan`, `jwb_a`, `jwb_b`, `jwb_c`, `jwb_d`, `kunci`, `penulis`) VALUES
(1, 2, 1, 2, 'Manakah yang termasuk ke dalam periperal Input di dalam komputer...', 'Mouse', 'Printer', 'Scanner', 'Monitor', 'a', 1),
(2, 2, 1, 2, 'Kepanjangan dari RAM adalah...', 'Random Algorithm Management', 'Random Access Memory', 'Rational Access Management', '', 'b', 1),
(3, 2, 1, 2, 'Salah satu software pengolah gambar yang dikhususkan untuk gambar vektor ialah...', 'Photoshop', 'Gimp', 'Corel Draw', '', 'c', 1),
(4, 2, 1, 2, 'Komputer yang berfungsi untuk melayani komputer-komputer lainnya disebut...', 'Server', 'Repeater', 'Switch', '', 'a', 1),
(5, 2, 1, 2, 'Dibawah ini yang bukan merupakan jenis-jenis kabel jaringan ialah...', 'UTP', 'Coaxial', 'Power', 'Fibre Optik', 'c', 1),
(6, 2, 1, 2, 'Perangkat lunak yang bukan merupakan katagori kelompok sistem operasi adalah :', 'Ms Windows', 'Spreedsheet Calc', 'Linux', '', 'b', 1),
(8, 1, 1, 1, 'Secara garis besar sebuah sistem komputer dibagi kedalam tiga katagori yaitu input device, prosesing device dan output device. Yang tidak termasuk ke dalam katagori input device adalah...', 'Keyboard', 'Scanner', 'Monitor', 'Michrophone', 'C', 1),
(9, 1, 1, 1, 'Linux adalah sistem operasi yang menggunakan lisensi GPL, Kepanjangan dari GPL adalah...', 'General Public Linux', 'General Public License', 'General Private Linux', 'General Private License', 'b', 1),
(10, 1, 1, 1, 'Ada banyak media penyimpan data yang bisa digunakan saat ini. Diantara media-media penyimpan data yang disebutkan di bawah ini, mana yang memiliki kapasitas paling kecil...', 'Flashdisk', 'Disket', 'Harddisk', 'CD (Compact Disk)', 'b', 1),
(11, 1, 1, 1, 'Berdasarkan bentuknya, media penyimpan dapat dibagi kedalam 3 kelompok, yaitu magnetis, optis, Elektronis. Yang termasuk kedalam media penyimpan optic adalah...', 'CD', 'Memory', 'Disket', 'Hard Disk', 'a', 1),
(12, 3, 1, 1, 'Untuk melakukan penelusuran informasi di internet, diperlukan software browser. Yang bukan merupakan software browser di bawah ini adalah..', 'Netscape Navigator', 'Firefox', 'Internet Explorer', 'Ms. Power Point', 'd', 1),
(13, 3, 1, 1, 'Dalam perkembangannya isi (content) dari halaman web menjadi bervariasi, sehingga browser menjadi lebih menarik dan interaktif. Berikut yang tidak / belum tersedia sebuah halaman web...', 'Teks', 'Gambar', 'Audio', 'Aroma', 'd', 1),
(14, 3, 1, 1, 'Untuk membuka halaman web (website)tertentu, kita harus mengetahui alamat URL (Uniform Resource Locator) dan menuliskannya di...', 'Address', 'Password', 'ID', 'Favorite', 'a', 1),
(15, 3, 1, 1, 'Situs yang berisi fasilitas pencarian informasi disebut dengan situs ...', 'Web Mail', 'Portal', 'Search Engine', 'Berita', 'c', 1),
(16, 1, 1, 1, 'Yang bukan merupakan tipe data dalam pemrograman C# adalah...', 'Int', 'Char', 'Double', 'For', 'd', 1),
(17, 4, 2, 1, 'Salah satu fungsi perulangan yang sering dipakai dalam dunia pemrograman adalah...', 'While', 'If', 'Switch', 'Or', 'a', 1),
(18, 4, 2, 1, 'Kepanjangan dari CSS adalah...', 'Cascading Style Sheet', 'Component Social System', 'Configuration Style System', '', 'a', 1),
(19, 4, 2, 1, 'Sub-sub menu yang muncul ketika suatu link disentuh/on hover disebut...', 'Slide', 'Drop Down', 'Tab', 'Tree', 'b', 1),
(20, 4, 2, 1, 'Yang bukan merupakan attribut dari tag table ialah...', 'width', 'height', 'align', 'id', 'd', 1),
(21, 4, 2, 1, 'Fungsi dari tag br dalam penulisan kode HTML ialah....', 'Memberikan jarak ke bawah tanpa spasi', 'Memberikan jarak ke bawah dengan 1 spasi', 'Memberikan jarak ke bawah dengan 2 spasi', 'Memberikan jarak ke bawah dengan 3 spasi', 'a', 1),
(28, 1, 1, 1, 'Harga apel, jeruk, anggur secara berurutan ialah 2000,4000,5000. Jika Anto membeli 4 buah apel, 8 buah jeruk, dan 10 buah anggur, berapa total yang harus dibayarkan...', '90000', '80000', '10000', '85000', 'A', 1);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tbl_admin`
--
ALTER TABLE `tbl_admin`
  ADD PRIMARY KEY (`id_admin`);

--
-- Indeks untuk tabel `tbl_hasil`
--
ALTER TABLE `tbl_hasil`
  ADD PRIMARY KEY (`id_hasil`);

--
-- Indeks untuk tabel `tbl_hubungi`
--
ALTER TABLE `tbl_hubungi`
  ADD PRIMARY KEY (`id_hub`);

--
-- Indeks untuk tabel `tbl_jawab_soal`
--
ALTER TABLE `tbl_jawab_soal`
  ADD PRIMARY KEY (`id_jawaban`);

--
-- Indeks untuk tabel `tbl_kat_soal`
--
ALTER TABLE `tbl_kat_soal`
  ADD PRIMARY KEY (`id_kat`);

--
-- Indeks untuk tabel `tbl_pelajaran`
--
ALTER TABLE `tbl_pelajaran`
  ADD PRIMARY KEY (`id_pel`);

--
-- Indeks untuk tabel `tbl_siswa`
--
ALTER TABLE `tbl_siswa`
  ADD PRIMARY KEY (`no_induk`);

--
-- Indeks untuk tabel `tbl_soal`
--
ALTER TABLE `tbl_soal`
  ADD PRIMARY KEY (`id_soal`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tbl_admin`
--
ALTER TABLE `tbl_admin`
  MODIFY `id_admin` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `tbl_hasil`
--
ALTER TABLE `tbl_hasil`
  MODIFY `id_hasil` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `tbl_hubungi`
--
ALTER TABLE `tbl_hubungi`
  MODIFY `id_hub` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `tbl_jawab_soal`
--
ALTER TABLE `tbl_jawab_soal`
  MODIFY `id_jawaban` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=178;

--
-- AUTO_INCREMENT untuk tabel `tbl_kat_soal`
--
ALTER TABLE `tbl_kat_soal`
  MODIFY `id_kat` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tbl_pelajaran`
--
ALTER TABLE `tbl_pelajaran`
  MODIFY `id_pel` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `tbl_soal`
--
ALTER TABLE `tbl_soal`
  MODIFY `id_soal` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
