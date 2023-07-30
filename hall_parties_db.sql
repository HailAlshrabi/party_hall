-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 13, 2023 at 06:50 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hall_parties_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phonenumber` varchar(20) DEFAULT NULL,
  `time_stamp` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `full_name`, `password`, `email`, `phonenumber`, `time_stamp`) VALUES
(1, 'admin', 'admin', NULL, '777', '2023-05-07 17:09:20');

-- --------------------------------------------------------

--
-- Table structure for table `booking_hall`
--

CREATE TABLE `booking_hall` (
  `id` int(11) NOT NULL,
  `hall_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_booking` varchar(20) DEFAULT NULL,
  `status` enum('Booking','Cancel') NOT NULL DEFAULT 'Booking',
  `time_stamp` datetime NOT NULL DEFAULT current_timestamp(),
  `name` varchar(1000) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `period` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `booking_hall`
--

INSERT INTO `booking_hall` (`id`, `hall_id`, `user_id`, `date_booking`, `status`, `time_stamp`, `name`, `phone`, `period`) VALUES
(1, 1, 1, '2023-05-08', 'Cancel', '2023-05-08 23:14:15', NULL, NULL, NULL),
(2, 1, 1, '2023-05-09', 'Booking', '2023-05-08 23:14:19', NULL, NULL, NULL),
(3, 2, 1, '2023-05-10', 'Booking', '2023-05-09 00:25:50', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `hall_table`
--

CREATE TABLE `hall_table` (
  `hall_Id` int(11) NOT NULL,
  `hall_name` varchar(100) NOT NULL,
  `price` varchar(10) NOT NULL,
  `address` varchar(50) DEFAULT NULL,
  `address_details` varchar(500) DEFAULT NULL,
  `latitude` varchar(20) DEFAULT NULL,
  `longitude` varchar(20) DEFAULT NULL,
  `image_displaying` varchar(500) DEFAULT NULL,
  `image1` varchar(500) DEFAULT NULL,
  `image2` varchar(500) DEFAULT NULL,
  `image3` varchar(500) DEFAULT NULL,
  `phoneNumbers` varchar(200) NOT NULL,
  `info_hall` varchar(1000) NOT NULL,
  `city` varchar(20) DEFAULT NULL,
  `time_stamp` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `hall_table`
--

INSERT INTO `hall_table` (`hall_Id`, `hall_name`, `price`, `address`, `address_details`, `latitude`, `longitude`, `image_displaying`, `image1`, `image2`, `image3`, `phoneNumbers`, `info_hall`, `city`, `time_stamp`) VALUES
(1, 'قاعة سباء', '200000', 'صنعاء - الحصبه', 'جوار الغرفة التجارية', '15.36861755787545', '44.18886546045542', 'img16835321140374596.png', 'img16835321148889618.png', 'img16835321148899730.png', 'img16835321148919908.png', '223567  -  7888854743 - 733333333', 'قاعة المناسبات والافراح', 'صنعاء', '2023-05-07 23:48:34'),
(2, 'قاعة الملوك', '100000', 'صنعاء - الحصبه', 'جوار الغرفة التجارية', '15.36861691130166', '44.18948102742433', 'img16835321734858986.png', 'img16835321746379164.png', 'img16835321746393750.png', 'img16835321746409077.png', '223567  -  7888854743 - 733333333', 'قاعة المناسبات والافراح', 'صنعاء', '2023-05-07 23:49:34'),
(3, 'قاعة الملوك', '200000', 'صنعاء - الحصبه', 'جوار الغرفة التجارية', '15.36861691130166', '44.18948102742433', 'img16835321768407112.png', 'img16835321768934468.png', 'img16835321768943420.png', 'img16835321768956154.png', '223567  -  7888854743 - 733333333', 'قاعة المناسبات والافراح', 'صنعاء', '2023-05-07 23:49:36'),
(4, 'قاعة الامراء', '200000', 'صنعاء - الحصبه', 'جوار الغرفة التجارية', '15.36861691130166', '44.18948102742433', 'img16835322091319973.png', 'img16835322091514584.png', 'img16835322091537730.png', 'img16835322091551794.png', '223567  -  7888854743 - 733333333', 'قاعة المناسبات والافراح', 'عدن', '2023-05-07 23:50:09');

-- --------------------------------------------------------

--
-- Table structure for table `star_rating_hall`
--

CREATE TABLE `star_rating_hall` (
  `id` int(11) NOT NULL,
  `hall_id` int(11) NOT NULL,
  `rating_star` enum('1','2','3','4','5') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `star_rating_hall`
--

INSERT INTO `star_rating_hall` (`id`, `hall_id`, `rating_star`) VALUES
(1, 3, '3'),
(2, 2, '5'),
(3, 1, '3'),
(4, 2, '3');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `admin_id` int(11) NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phonenumber` varchar(20) DEFAULT NULL,
  `address` varchar(20) DEFAULT NULL,
  `time_stamp` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`admin_id`, `full_name`, `password`, `email`, `phonenumber`, `address`, `time_stamp`) VALUES
(1, 'محمد محمد محمد', '777', 'm@gmail.com', '777', 'صنعاء', '2023-05-08 01:19:16'),
(2, 'محمد محمد محمد', '777', 'm@gmail.com', '77777', 'صنعاء', '2023-05-08 01:20:55'),
(3, 'محمد محمد محمد', '777', 'm@gmail.com', '779999777', 'صنعاء', '2023-05-08 01:22:09'),
(4, 'محمد محمد محمد', '777', 'm@gmail.com', '779222777', 'صنعاء', '2023-05-08 01:23:19'),
(5, 'محمد محمد محمد', '777', 'm@gmail.com', '779221777', 'صنعاء', '2023-05-08 01:24:01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `booking_hall`
--
ALTER TABLE `booking_hall`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hall_table`
--
ALTER TABLE `hall_table`
  ADD PRIMARY KEY (`hall_Id`);

--
-- Indexes for table `star_rating_hall`
--
ALTER TABLE `star_rating_hall`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`admin_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `booking_hall`
--
ALTER TABLE `booking_hall`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `hall_table`
--
ALTER TABLE `hall_table`
  MODIFY `hall_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `star_rating_hall`
--
ALTER TABLE `star_rating_hall`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
