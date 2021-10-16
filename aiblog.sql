-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 16, 2021 at 07:05 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aiblog`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `srno` int(50) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_number` varchar(50) NOT NULL,
  `mssg` text NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`srno`, `name`, `email`, `phone_number`, `mssg`, `date`) VALUES
(1, 'first_post_person', 'firstpost@gmail.com', '9100000031', 'This is my first post.', '2021-09-18 18:06:14'),
(3, 'Dhyey Sherasia', 'myemail@gmail.com', '1122334455', 'Message sent from Website\'s contact page.', '2021-09-18 18:40:04'),
(4, 'Dhyey_2002', 'dhyey@gmail.com', '3141431234', 'Sending mail', '2021-09-18 19:45:39'),
(5, 'Dhyey_2002', 'dhyey@gmail.com', '3141431234', 'Sending mail', '2021-09-18 19:45:41'),
(6, 'Dhyey_2002', 'drpls1973@gmail.com', '9911223344', 'Check messages received in email.', '2021-09-18 19:51:15'),
(7, 'Dhyey Sherasia', '1976jagruti@gmail.com', '1122334455', 'Test mail from jagruti account', '2021-09-18 22:05:22'),
(8, 'Dhyey Sherasia', '1976jagruti@gmail.com', '1122334455', 'Mail sent from jagruti account.', '2021-09-18 22:07:18'),
(9, 'Dhyey Sherasia v2', 'dhyeysherasia2002@gmail.com', '1122334455', 'Mail sent from dhyey\'s id', '2021-09-18 22:12:28'),
(10, 'Dhyey sherasia v2', 'dhyeysherasia2002@gmail.com', '1122334455', 'Mail sent from Dhyey\'s id.', '2021-09-18 22:13:37'),
(11, 'Dhyey v3', '', '', '', '2021-09-18 22:14:40'),
(12, 'Dhyey v3', '1976jagruti@gmail.com', '1122334455', 'Mail sent from jagruti\'s mail id', '2021-09-18 22:15:26'),
(13, 'Dhyey Sherasia`', 'dhyeysherasia2002@gmail.com', '99998909`', 'I have a question....how was your maths exam ?', '2021-09-24 18:38:14'),
(14, 'Dhyey Sherasia`', 'dhyeysherasia2002@gmail.com', '99998909`', 'I have a question....how was your maths exam ?', '2021-09-24 18:38:15'),
(15, 'Dhvani Sherasia', 'dhvani3926@anandalaya.ac.in', '827387283', 'Helllloooooooo!!!!!!', '2021-09-24 18:40:09'),
(16, 'Elon Musk', 'elon@gmail.com', '9999999999', 'Hey Dhyey,\r\nSpaceX wants to hire you as a senior product development manager. Please accept our request.\r\n\r\nElon Musk', '2021-10-10 08:57:09'),
(17, 'DHyey', 'mail@gmail.com', '2321432123', 'New Message', '2021-10-10 09:14:39'),
(18, 'Elon Musk', 'elon@gmail.com', '1234567890', 'Hey Dhyey,\r\nSpaceX wants to hire you !!\r\n\r\nElon Musk', '2021-10-10 09:18:58'),
(19, 'Elon Musk', 'email@gmail.com', '1234567890', 'Have some problem accessing you recent project', '2021-10-10 23:12:28');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `srno` int(50) NOT NULL,
  `title` text NOT NULL,
  `tagline` text NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `image` varchar(30) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`srno`, `title`, `tagline`, `slug`, `content`, `image`, `date`) VALUES
(1, 'FirstPostTitle', 'Potential of AI', 'first-post', 'This is my first post. I am very excited about learning flask and hosting my first website.', 'new_updated_post_jpg', '2021-10-12 12:54:41'),
(2, 'My Second Post', 'You didn\'t know this about AI', 'second-post', 'It’s important to know that the outer double-curly braces are not part of the variable, but the print statement. If you access variables inside tags don’t put the braces around them.\r\n\r\nIf a variable or attribute does not exist, you will get back an undefined value. What you can do with that kind of value depends on the application configuration: the default behavior is to evaluate to an empty string if printed or iterated over, and to fail for every other operation.', '', '2021-09-19 17:22:30'),
(3, 'Next Post', 'Coolest post ever', 'third-post', 'Beside filters, there are also so-called “tests” available. Tests can be used to test a variable against a common expression. To test a variable or expression, you add is plus the name of the test after the variable. For example, to find out if a variable is defined, you can do name is defined, which will then return true or false depending on whether name is defined in the current template context.\r\n\r\nTests can accept arguments, too. If the test only takes one argument, you can leave out the parentheses. For example, the following two expressions do the same thing:', '', '2021-09-19 17:40:33'),
(4, 'Fourth Post Title', 'Mast wali tagline', 'fourth-post', 'Template Inheritance\r\nThe most powerful part of Jinja is template inheritance. Template inheritance allows you to build a base “skeleton” template that contains all the common elements of your site and defines blocks that child templates can override.\r\n\r\nSounds complicated but is very basic. It’s easiest to understand it by starting with an example.\r\n\r\nBase Template\r\nThis template, which we’ll call base.html, defines a simple HTML skeleton document that you might use for a simple two-column page. It’s the job of “child” templates to fill the empty blocks with content:', '', '2021-09-19 17:41:53'),
(5, 'Brand New Post', 'Fifth post tagline', 'fifth-post', 'This example would output empty <li> items because item is unavailable inside the block. The reason for this is that if the block is replaced by a child template, a variable would appear that was not defined in the block or passed to the context.\r\n\r\nStarting with Jinja 2.2, you can explicitly specify that variables are available in a block by setting the block to “scoped” by adding the scoped modifier to a block declaration:', '', '2021-09-19 17:44:11'),
(9, 'Post - 7', 'New post added', 'post-7', 'Content - 7', 'img.png', '2021-10-12 11:44:58'),
(10, 'title-new', 'tag-new', 'slug-new', 'content-new', 'img.png', '2021-10-12 12:25:22'),
(11, 'newww', 'newww', 'newww', 'newww', 'dewkm,f', '2021-10-12 12:39:02'),
(12, 'latest', 'latest', 'latest', 'latest', '.,emflwe', '2021-10-12 12:40:58'),
(13, 'brand new', 'brand new', 'brand new', 'brand new', 'emfefwe', '2021-10-12 12:42:28'),
(14, '14', '14', '14', '14', '14.png', '2021-10-12 12:55:13'),
(15, 'Title-20', 'Tag-20', 'post-20', 'Contefnekmlfeklrnf;efmer\r\nrgvergvern gvjerngvremkvndfnvnermkvmernfknelkmvlnlm', 'img_20.png', '2021-10-16 08:33:54'),
(17, 'some_new_things', 'new_ai_things_present_here', 'post-ai', 'nefjwenjfnerf\r\nwenfjkerjfnregfekr glkermgfmre', 'ai.jpg', '2021-10-16 19:19:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`srno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`srno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `srno` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `srno` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
