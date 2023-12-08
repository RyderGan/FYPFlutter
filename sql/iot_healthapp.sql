-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 08, 2023 at 09:18 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `iot_healthapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `about_us`
--

CREATE TABLE `about_us` (
  `about_us_id` int(11) NOT NULL,
  `about_us_title` text NOT NULL,
  `about_us_who` text NOT NULL,
  `about_us_who_details` text NOT NULL,
  `about_us_aim` text NOT NULL,
  `about_us_aim_details` text NOT NULL,
  `about_us_website_name` text NOT NULL,
  `about_us_website_link` text NOT NULL,
  `about_us_facebook_link` text NOT NULL,
  `about_us_instagram_link` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `about_us`
--

INSERT INTO `about_us` (`about_us_id`, `about_us_title`, `about_us_who`, `about_us_who_details`, `about_us_aim`, `about_us_aim_details`, `about_us_website_name`, `about_us_website_link`, `about_us_facebook_link`, `about_us_instagram_link`) VALUES
(1, 'About IOT FSKTM', 'Students of Software Enginnering Deparment', 'We are 2 students from FSKTM.', 'To motivate users to run', 'We aim to promote a health lifestyle among FSKTM residents. How? Well, by motivating them of course. Through challenges and special rewards, we would like to get more and more people to join in.', 'IOT FSKTM Website', 'https://www.google.com/', 'https://www.facebook.com/', 'https://www.instagram.com/');

-- --------------------------------------------------------

--
-- Table structure for table `blood_pressures`
--

CREATE TABLE `blood_pressures` (
  `bp_id` int(255) NOT NULL,
  `user_id` int(100) NOT NULL,
  `systolic_pressure` int(10) NOT NULL,
  `diastolic_pressure` int(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `blood_pressures`
--

INSERT INTO `blood_pressures` (`bp_id`, `user_id`, `systolic_pressure`, `diastolic_pressure`, `created_at`) VALUES
(1, 3, 120, 75, '2023-11-19 13:37:16'),
(3, 3, 110, 70, '2023-11-19 13:51:32'),
(4, 3, 105, 75, '2023-11-19 14:55:50');

-- --------------------------------------------------------

--
-- Table structure for table `bmis`
--

CREATE TABLE `bmis` (
  `bmi_id` int(255) NOT NULL,
  `user_id` int(100) NOT NULL,
  `user_weight` int(10) NOT NULL,
  `user_height` int(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bmis`
--

INSERT INTO `bmis` (`bmi_id`, `user_id`, `user_weight`, `user_height`, `created_at`) VALUES
(3, 3, 58, 165, '2023-11-18 16:22:53'),
(4, 3, 55, 170, '2023-11-19 13:46:31'),
(5, 3, 57, 170, '2023-11-19 13:46:48');

-- --------------------------------------------------------

--
-- Table structure for table `checkpoints`
--

CREATE TABLE `checkpoints` (
  `cp_id` int(11) NOT NULL,
  `check_point` int(11) NOT NULL,
  `road_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `checkpoints`
--

INSERT INTO `checkpoints` (`cp_id`, `check_point`, `road_id`, `created_at`) VALUES
(1, 1, 1, '2023-11-30 04:36:38'),
(2, 2, 1, '2023-11-30 04:36:50'),
(3, 1, 2, '2023-11-30 04:36:56');

-- --------------------------------------------------------

--
-- Table structure for table `checkpoint_history`
--

CREATE TABLE `checkpoint_history` (
  `checkpoint_history_id` int(11) NOT NULL,
  `rfid_checkpoint_id` int(11) NOT NULL,
  `rfid_band_id` int(11) NOT NULL,
  `checkpoint_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `checkpoint_history`
--

INSERT INTO `checkpoint_history` (`checkpoint_history_id`, `rfid_checkpoint_id`, `rfid_band_id`, `checkpoint_time`) VALUES
(1, 1, 1, '2023-12-07 04:31:50'),
(2, 1, 1, '2023-12-07 04:34:26'),
(3, 1, 1, '2023-12-07 04:53:10'),
(4, 1, 1, '2023-12-07 04:53:16'),
(5, 1, 1, '2023-12-07 08:52:39'),
(6, 1, 1, '2023-12-07 08:52:42'),
(7, 1, 1, '2023-12-07 09:16:17'),
(8, 2, 1, '2023-12-07 09:17:27'),
(9, 1, 1, '2023-12-07 18:17:34'),
(10, 1, 1, '2023-12-07 18:35:50'),
(11, 2, 1, '2023-12-07 18:36:33'),
(12, 2, 1, '2023-12-08 01:09:10'),
(13, 1, 1, '2023-12-08 03:00:06'),
(14, 1, 1, '2023-12-08 02:59:11');

-- --------------------------------------------------------

--
-- Table structure for table `feedbacks`
--

CREATE TABLE `feedbacks` (
  `feedback_id` int(255) NOT NULL,
  `user_id` int(100) NOT NULL,
  `title` varchar(255) NOT NULL,
  `fb_description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedbacks`
--

INSERT INTO `feedbacks` (`feedback_id`, `user_id`, `title`, `fb_description`) VALUES
(1, 3, '1st feedback', 'Testing');

-- --------------------------------------------------------

--
-- Table structure for table `paths`
--

CREATE TABLE `paths` (
  `path_id` int(255) NOT NULL,
  `path_name` varchar(255) NOT NULL,
  `path_from_cp_id` int(255) NOT NULL,
  `path_to_cp_id` int(255) NOT NULL,
  `path_distance` int(255) DEFAULT NULL,
  `path_elevation` int(255) DEFAULT NULL,
  `path_difficulty` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `paths`
--

INSERT INTO `paths` (`path_id`, `path_name`, `path_from_cp_id`, `path_to_cp_id`, `path_distance`, `path_elevation`, `path_difficulty`) VALUES
(1, 'Path from BK2 to BK1', 1, 2, 100, 2, 4),
(2, 'Path from BK2 to BK1', 2, 1, 100, -2, 2),
(3, 'Path from DK1 to DK2', 2, 3, 100, 2, -2);

-- --------------------------------------------------------

--
-- Table structure for table `rewards`
--

CREATE TABLE `rewards` (
  `reward_id` int(255) NOT NULL,
  `reward_title` varchar(255) NOT NULL,
  `reward_description` text NOT NULL,
  `required_pt` int(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rewards`
--

INSERT INTO `rewards` (`reward_id`, `reward_title`, `reward_description`, `required_pt`, `created_at`) VALUES
(1, 'TnG RM1 reload', 'Reload RM1 into TnG eWallet balance', 100, '2023-11-28 07:53:39');

-- --------------------------------------------------------

--
-- Table structure for table `reward_points`
--

CREATE TABLE `reward_points` (
  `reward_pt_id` int(255) NOT NULL,
  `reward_pt` int(50) NOT NULL,
  `user_id` int(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reward_points`
--

INSERT INTO `reward_points` (`reward_pt_id`, `reward_pt`, `user_id`, `created_at`) VALUES
(1, 100, 3, '2023-12-07 12:08:28'),
(2, 100, 3, '2023-12-07 12:08:33'),
(3, 100, 3, '2023-12-07 17:10:23'),
(4, 100, 3, '2023-12-07 17:10:31'),
(5, 100, 3, '2023-12-07 18:35:50'),
(6, 100, 3, '2023-12-07 18:36:33'),
(7, 100, 3, '2023-12-08 02:15:41'),
(8, 100, 3, '2023-12-08 02:29:17'),
(9, 100, 3, '2023-12-08 02:29:32'),
(10, 100, 3, '2023-12-08 02:34:34'),
(11, 100, 3, '2023-12-08 02:36:40'),
(12, 100, 3, '2023-12-08 02:37:11'),
(13, 100, 3, '2023-12-08 02:59:46'),
(14, 100, 3, '2023-12-08 03:00:28'),
(15, 100, 3, '2023-12-08 03:01:28'),
(16, 100, 3, '2023-12-08 03:01:45');

-- --------------------------------------------------------

--
-- Table structure for table `rfid_bands`
--

CREATE TABLE `rfid_bands` (
  `rfid_band_id` int(100) NOT NULL,
  `rfid_band_uid` varchar(255) NOT NULL,
  `rfid_band_name` varchar(255) NOT NULL,
  `user_id` int(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rfid_bands`
--

INSERT INTO `rfid_bands` (`rfid_band_id`, `rfid_band_uid`, `rfid_band_name`, `user_id`, `created_at`) VALUES
(1, 'A9 73 40 59', 'RFID Band 1', 3, '2023-12-07 12:53:47');

-- --------------------------------------------------------

--
-- Table structure for table `rfid_checkpoint`
--

CREATE TABLE `rfid_checkpoint` (
  `rfid_checkpoint_id` int(255) NOT NULL,
  `rfid_checkpoint_name` varchar(255) NOT NULL,
  `rfid_checkpoint_description` text NOT NULL,
  `rfid_checkpoint_location` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rfid_checkpoint`
--

INSERT INTO `rfid_checkpoint` (`rfid_checkpoint_id`, `rfid_checkpoint_name`, `rfid_checkpoint_description`, `rfid_checkpoint_location`, `created_at`) VALUES
(1, 'Checkpoint 1', 'RFID Checkpoint at BK2', 'BK2', '2023-12-06 00:45:29'),
(2, 'Checkpoint 2', 'RFID Checkpoint at BK1', 'BK1', '2023-12-06 00:45:29'),
(3, 'Checkpoint 3', 'RFID Checkpoint at BK3', 'BK3', '2023-12-06 00:45:29');

-- --------------------------------------------------------

--
-- Table structure for table `roads`
--

CREATE TABLE `roads` (
  `road_id` int(11) NOT NULL,
  `road` int(11) NOT NULL,
  `reward_pt` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roads`
--

INSERT INTO `roads` (`road_id`, `road`, `reward_pt`, `created_at`) VALUES
(1, 1, 200, '2023-11-30 04:45:46'),
(2, 2, 100, '2023-11-30 04:45:46');

-- --------------------------------------------------------

--
-- Table structure for table `stepcounts`
--

CREATE TABLE `stepcounts` (
  `stepCount_id` int(255) NOT NULL,
  `user_id` int(100) NOT NULL,
  `stepCount` int(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stepcounts`
--

INSERT INTO `stepcounts` (`stepCount_id`, `user_id`, `stepCount`, `created_at`) VALUES
(6, 3, 358, '2023-11-27 08:14:39'),
(8, 3, 380, '2023-11-29 03:44:34'),
(10, 3, 380, '2023-11-30 03:52:04'),
(14, 3, 461, '2023-12-07 10:00:47'),
(15, 0, 0, '2023-12-08 06:33:19'),
(16, 3, 461, '2023-12-08 06:43:27');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `user_type` varchar(50) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `reward_point` int(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `user_password`, `full_name`, `user_type`, `gender`, `dateOfBirth`, `reward_point`, `created_at`) VALUES
(3, 'ganwan2@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 'Ryder Gan', 'Student', 'Male', '2000-07-08', 10099, '2023-11-18 09:59:39'),
(4, 'ganwan1@gmail.com', 'f1887d3f9e6ee7a32fe5e76f4ab80d63', 'Gan', 'Student', 'Male', '2023-11-18', 0, '2023-11-18 10:06:06');

-- --------------------------------------------------------

--
-- Table structure for table `user_checkpoints`
--

CREATE TABLE `user_checkpoints` (
  `record_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `check_point` int(11) NOT NULL,
  `road_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_checkpoints`
--

INSERT INTO `user_checkpoints` (`record_id`, `user_id`, `check_point`, `road_id`, `created_at`) VALUES
(10, 3, 1, 1, '2023-11-30 07:12:25'),
(11, 3, 1, 2, '2023-11-30 07:12:48'),
(12, 3, 1, 2, '2023-11-30 07:13:09'),
(13, 0, 0, 0, '2023-11-30 07:14:12');

-- --------------------------------------------------------

--
-- Table structure for table `visceral_fats`
--

CREATE TABLE `visceral_fats` (
  `vf_id` int(255) NOT NULL,
  `user_id` int(100) NOT NULL,
  `rating` int(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `visceral_fats`
--

INSERT INTO `visceral_fats` (`vf_id`, `user_id`, `rating`, `created_at`) VALUES
(1, 3, 2, '2023-11-19 14:58:13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `about_us`
--
ALTER TABLE `about_us`
  ADD PRIMARY KEY (`about_us_id`);

--
-- Indexes for table `blood_pressures`
--
ALTER TABLE `blood_pressures`
  ADD PRIMARY KEY (`bp_id`);

--
-- Indexes for table `bmis`
--
ALTER TABLE `bmis`
  ADD PRIMARY KEY (`bmi_id`);

--
-- Indexes for table `checkpoints`
--
ALTER TABLE `checkpoints`
  ADD PRIMARY KEY (`cp_id`);

--
-- Indexes for table `checkpoint_history`
--
ALTER TABLE `checkpoint_history`
  ADD PRIMARY KEY (`checkpoint_history_id`);

--
-- Indexes for table `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD PRIMARY KEY (`feedback_id`);

--
-- Indexes for table `paths`
--
ALTER TABLE `paths`
  ADD PRIMARY KEY (`path_id`);

--
-- Indexes for table `rewards`
--
ALTER TABLE `rewards`
  ADD PRIMARY KEY (`reward_id`);

--
-- Indexes for table `reward_points`
--
ALTER TABLE `reward_points`
  ADD PRIMARY KEY (`reward_pt_id`);

--
-- Indexes for table `rfid_bands`
--
ALTER TABLE `rfid_bands`
  ADD PRIMARY KEY (`rfid_band_id`);

--
-- Indexes for table `rfid_checkpoint`
--
ALTER TABLE `rfid_checkpoint`
  ADD PRIMARY KEY (`rfid_checkpoint_id`);

--
-- Indexes for table `roads`
--
ALTER TABLE `roads`
  ADD PRIMARY KEY (`road_id`);

--
-- Indexes for table `stepcounts`
--
ALTER TABLE `stepcounts`
  ADD PRIMARY KEY (`stepCount_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_checkpoints`
--
ALTER TABLE `user_checkpoints`
  ADD PRIMARY KEY (`record_id`);

--
-- Indexes for table `visceral_fats`
--
ALTER TABLE `visceral_fats`
  ADD PRIMARY KEY (`vf_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blood_pressures`
--
ALTER TABLE `blood_pressures`
  MODIFY `bp_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `bmis`
--
ALTER TABLE `bmis`
  MODIFY `bmi_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `checkpoints`
--
ALTER TABLE `checkpoints`
  MODIFY `cp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `feedbacks`
--
ALTER TABLE `feedbacks`
  MODIFY `feedback_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rewards`
--
ALTER TABLE `rewards`
  MODIFY `reward_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `roads`
--
ALTER TABLE `roads`
  MODIFY `road_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `stepcounts`
--
ALTER TABLE `stepcounts`
  MODIFY `stepCount_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_checkpoints`
--
ALTER TABLE `user_checkpoints`
  MODIFY `record_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `visceral_fats`
--
ALTER TABLE `visceral_fats`
  MODIFY `vf_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
