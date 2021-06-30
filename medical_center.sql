-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 30, 2021 at 09:14 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `medical_center`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_client` (IN `fio` VARCHAR(255), IN `date_birsday` DATE, IN `phone` VARCHAR(255), IN `email` VARCHAR(255), IN `pass` VARCHAR(255))  BEGIN
    SET @mykeystr = 'This is security key for my encryption procedure! Ha!';
    SET @shahex = SHA2(@mykeystr, 512);
    SET @key = UNHEX(@shahex);

    SET @crypt_pass = AES_ENCRYPT(pass, @key);
    
	INSERT INTO client(client.fio, client.date_birsday, client.phone, client.email, client.pass)
    VALUES(fio, date_birsday, phone, email, @crypt_pass);
    
    SELECT * FROM client WHERE client.id = LAST_INSERT_ID();
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `doctorreferrals`
--

CREATE TABLE `doctorreferrals` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `doctor_id` int(10) UNSIGNED NOT NULL,
  `receipt_date` datetime NOT NULL,
  `conclusion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pacients`
--

CREATE TABLE `pacients` (
  `id` int(10) UNSIGNED NOT NULL,
  `fio` varchar(255) NOT NULL,
  `date_birsday` date NOT NULL,
  `date_reg` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `pass` varbinary(255) NOT NULL,
  `doctor_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pacients`
--

INSERT INTO `pacients` (`id`, `fio`, `date_birsday`, `date_reg`, `phone`, `email`, `pass`, `doctor_id`) VALUES
(3, 'Яркін О.О.', '0000-00-00', '2021-06-01 09:48:02', '+38 098 372 11 15', 'фвіфв@gmail.com', 0x3132333435, 1),
(4, 'dsfds', '0000-00-00', '2021-06-01 13:50:06', '+38048444444', 'asd@aa.com', 0xc4b2581d3f027d3f1341313f3f240f06, NULL),
(5, 'Вася', '0000-00-00', '2021-06-01 13:53:13', '+38058444444', 'addfsd@aa.com', 0xc4b2581d91027d99134131ec81240f06, NULL);

--
-- Triggers `pacients`
--
DELIMITER $$
CREATE TRIGGER `trigger_insert_client` BEFORE INSERT ON `pacients` FOR EACH ROW SET NEW.fio = TRIM(NEW.fio),
NEW.phone = TRIM(NEW.phone),
NEW.email = TRIM(NEW.email)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `personal`
--

CREATE TABLE `personal` (
  `id` int(10) UNSIGNED NOT NULL,
  `fio` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `specialty_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `personal`
--

INSERT INTO `personal` (`id`, `fio`, `phone`, `email`, `pass`, `specialty_id`) VALUES
(1, 'Иванов И.И.', '+380 67 8888888', 'dsfd@gmail.com', '1234', 1);

-- --------------------------------------------------------

--
-- Table structure for table `procedurereferrals`
--

CREATE TABLE `procedurereferrals` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `doctor_id` int(10) UNSIGNED NOT NULL,
  `procedure_id` int(10) UNSIGNED NOT NULL,
  `reciept_date` datetime NOT NULL,
  `conclusion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `procedures`
--

CREATE TABLE `procedures` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `specialty_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `specialty`
--

CREATE TABLE `specialty` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `specialty`
--

INSERT INTO `specialty` (`id`, `name`) VALUES
(1, 'doctor');

-- --------------------------------------------------------

--
-- Table structure for table `survey`
--

CREATE TABLE `survey` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `surveyreferrals`
--

CREATE TABLE `surveyreferrals` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `survey_id` int(10) UNSIGNED NOT NULL,
  `receipt_date` date NOT NULL,
  `doctor_id` int(10) UNSIGNED NOT NULL,
  `conclusion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `doctorreferrals`
--
ALTER TABLE `doctorreferrals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_id` (`doctor_id`),
  ADD KEY `client_id` (`client_id`,`doctor_id`) USING BTREE;

--
-- Indexes for table `pacients`
--
ALTER TABLE `pacients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `personal`
--
ALTER TABLE `personal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `specialty_id` (`specialty_id`);

--
-- Indexes for table `procedurereferrals`
--
ALTER TABLE `procedurereferrals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_id` (`doctor_id`),
  ADD KEY `procedure_id` (`procedure_id`),
  ADD KEY `client_id` (`client_id`,`doctor_id`,`procedure_id`) USING BTREE;

--
-- Indexes for table `procedures`
--
ALTER TABLE `procedures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `specialty_id` (`specialty_id`);

--
-- Indexes for table `specialty`
--
ALTER TABLE `specialty`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `survey`
--
ALTER TABLE `survey`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `surveyreferrals`
--
ALTER TABLE `surveyreferrals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_id` (`doctor_id`),
  ADD KEY `survey_id` (`survey_id`),
  ADD KEY `client_id` (`client_id`,`survey_id`,`doctor_id`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `doctorreferrals`
--
ALTER TABLE `doctorreferrals`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pacients`
--
ALTER TABLE `pacients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `personal`
--
ALTER TABLE `personal`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `procedurereferrals`
--
ALTER TABLE `procedurereferrals`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `procedures`
--
ALTER TABLE `procedures`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `specialty`
--
ALTER TABLE `specialty`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `survey`
--
ALTER TABLE `survey`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `surveyreferrals`
--
ALTER TABLE `surveyreferrals`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `doctorreferrals`
--
ALTER TABLE `doctorreferrals`
  ADD CONSTRAINT `doctorreferrals_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `pacients` (`id`),
  ADD CONSTRAINT `doctorreferrals_ibfk_3` FOREIGN KEY (`doctor_id`) REFERENCES `personal` (`id`);

--
-- Constraints for table `pacients`
--
ALTER TABLE `pacients`
  ADD CONSTRAINT `pacients_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `personal` (`id`);

--
-- Constraints for table `personal`
--
ALTER TABLE `personal`
  ADD CONSTRAINT `personal_ibfk_1` FOREIGN KEY (`specialty_id`) REFERENCES `specialty` (`id`);

--
-- Constraints for table `procedurereferrals`
--
ALTER TABLE `procedurereferrals`
  ADD CONSTRAINT `procedurereferrals_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `pacients` (`id`),
  ADD CONSTRAINT `procedurereferrals_ibfk_3` FOREIGN KEY (`doctor_id`) REFERENCES `personal` (`id`),
  ADD CONSTRAINT `procedurereferrals_ibfk_4` FOREIGN KEY (`procedure_id`) REFERENCES `procedures` (`id`);

--
-- Constraints for table `procedures`
--
ALTER TABLE `procedures`
  ADD CONSTRAINT `procedures_ibfk_1` FOREIGN KEY (`specialty_id`) REFERENCES `specialty` (`id`);

--
-- Constraints for table `survey`
--
ALTER TABLE `survey`
  ADD CONSTRAINT `survey_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `specialty` (`id`);

--
-- Constraints for table `surveyreferrals`
--
ALTER TABLE `surveyreferrals`
  ADD CONSTRAINT `surveyreferrals_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `pacients` (`id`),
  ADD CONSTRAINT `surveyreferrals_ibfk_3` FOREIGN KEY (`doctor_id`) REFERENCES `personal` (`id`),
  ADD CONSTRAINT `surveyreferrals_ibfk_4` FOREIGN KEY (`survey_id`) REFERENCES `survey` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
