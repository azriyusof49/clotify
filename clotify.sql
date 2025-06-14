-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 12, 2025 at 10:11 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `clotify`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cartId` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `productId` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cartId`, `userId`, `productId`, `quantity`) VALUES
(1, 1, 10, 1),
(6, 12, 1, 1),
(7, 12, 10, 1),
(9, 11, 9, 1),
(10, 11, 2, 2),
(13, 12, 2, 1),
(14, 12, 9, 2);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `productId` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(100) NOT NULL,
  `category` varchar(50) NOT NULL,
  `imgURL` varchar(200) NOT NULL,
  `size` varchar(50) NOT NULL,
  `stock` int(11) NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`productId`, `name`, `description`, `category`, `imgURL`, `size`, `stock`, `price`) VALUES
(1, 'asdasd', 'asdasd', 'Tshirt', 'https://www.mtmp.com.my/wp-content/uploads/2021/05/NHB-2200-1-683x1024.jpg', 'S', 12312, 21),
(2, 'asdasd', 'asdasd', 'Tshirt', 'https://www.mtmp.com.my/wp-content/uploads/2021/05/NHB-2101-Gold-Navy-683x1024.jpg', 'S', 12312, 41),
(3, 'Tshirt', 'Shirt any bla bla bla', 'Tshirt', 'https://www.mtmp.com.my/wp-content/uploads/2021/06/76000L-51C-Royal-683x1024.jpg', 'XXL', 123, 50),
(9, 'Jacket', 'ajndnajsfkadb', 'Tshirt', 'https://www.net-a-porter.com/variants/images/1647597336388911/in/w920_q60.jpg', 'M', 120, 50),
(10, 'Pants', 'asdasdas', 'Pants', 'https://www.net-a-porter.com/variants/images/1647597332737653/in/w920_q60.jpg', 'M', 12, 45);

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `reviewId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `ratting` int(11) NOT NULL,
  `comment` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`reviewId`, `userId`, `ratting`, `comment`) VALUES
(7, 12, 5, 'asdas'),
(8, 12, 3, 'Biasa-Biasa ajaa nii'),
(9, 12, 3, 'Biasa-Biasa ajaa nii'),
(10, 12, 2, 'Consequatur rem max'),
(11, 12, 2, 'Consequatur rem max'),
(12, 12, 4, 'asdasd');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `role` varchar(50) NOT NULL,
  `birthdate` date NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `birthdate`, `timestamp`) VALUES
(1, 'AzuriY', 'azriyusof49@gmail.com', 'asd', 'user', '2025-05-01', '2025-06-09 15:22:12'),
(9, 'asd', 'azriyusof49@gmail.com', 'asd', 'user', '2025-05-01', '2025-05-24 08:24:10'),
(10, 'danial', 'danial@gmail.com', 'asd', 'user', '2025-05-01', '2025-05-24 15:27:45'),
(11, 'admin', 'admin@gmail.com', 'admin', 'admin', '2025-04-30', '2025-05-24 15:06:16'),
(12, 'user', 'azriyusof49@gmail.com', 'user', 'user', '2025-05-04', '2025-06-10 15:31:23');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cartId`),
  ADD KEY `userId` (`userId`),
  ADD KEY `productId` (`productId`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`productId`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`reviewId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cartId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `productId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `reviewId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
