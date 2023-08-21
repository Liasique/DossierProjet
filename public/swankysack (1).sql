-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: localhost:8889
-- Время создания: Авг 21 2023 г., 08:40
-- Версия сервера: 5.7.39
-- Версия PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `swankysack`
--

-- --------------------------------------------------------

--
-- Структура таблицы `address`
--

CREATE TABLE `address` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postal` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `address`
--

INSERT INTO `address` (`id`, `user_id`, `name`, `firstname`, `lastname`, `company`, `address`, `postal`, `city`, `country`, `phone`) VALUES
(1, 1, 'Home', 'Olga', 'Lukianets', 'Olga Lukianets', '19 Rue Charles Baudelaire', '93330', 'Neuilly-sur-Marne', 'FR', '0761722489'),
(2, 2, 'Home', 'Olga', 'Lukianets', 'Olga Lukianets', '19 Rue Charles Baudelaire', '93330', 'Neuilly-sur-Marne', 'FR', '0761722489'),
(3, 3, '4 rue Yvonne', 'Zackary', 'Sim', NULL, '19 Rue Charles Baudelaire', '93140', 'Bondy', 'UA', '0761722489'),
(4, 3, '19 Rue Charles Baudelaire', 'Olga', 'Lukianets', NULL, '19 Rue Charles Baudelaire', '93140', 'Bondy', 'UA', '0761722489');

-- --------------------------------------------------------

--
-- Структура таблицы `carousel`
--

CREATE TABLE `carousel` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `illustration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_activated` tinyint(1) DEFAULT NULL,
  `btn_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bnt_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `carrier`
--

CREATE TABLE `carrier` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `carrier`
--

INSERT INTO `carrier` (`id`, `name`, `description`, `price`) VALUES
(1, 'DHL', '<div>lorem</div>', 1000),
(2, 'UPS', '<div>lorem</div>', 1000);

-- --------------------------------------------------------

--
-- Структура таблицы `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `category`
--

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'LONGCHAMP'),
(2, 'L\'ALINGI'),
(3, 'BALENCIAGA');

-- --------------------------------------------------------

--
-- Структура таблицы `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20230314090659', '2023-03-14 09:07:03', 100);

-- --------------------------------------------------------

--
-- Структура таблицы `invoice`
--

CREATE TABLE `invoice` (
  `id` int(11) NOT NULL,
  `order_invoice_id` int(11) DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `carrier_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `carrier_price` double NOT NULL,
  `delivery` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `ref` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_session_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `order`
--

INSERT INTO `order` (`id`, `user_id`, `created_at`, `carrier_name`, `carrier_price`, `delivery`, `ref`, `stripe_session_id`, `state`) VALUES
(1, 1, '2023-03-13 14:23:30', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '13032023-640f31e26f32b', 'cs_test_b11WeNLzJaFPzCQX5x9VCiR9ejDM1JzIyyoiI56V8RdfABpVD9FaUxJwqq', 2),
(2, 1, '2023-03-13 14:45:43', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '13032023-640f371777041', 'cs_test_b1waL20wzvOa3q3lv8vmg5Y9hNwnNELRr2AlQTPvJNA8IlrnZItpPzFAhT', 0),
(3, 1, '2023-03-13 14:55:09', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '13032023-640f394d4dbfd', 'cs_test_b1GrJ0InzDnr6CSxo8j0dZgx4xgMlJapnfD0m0sdxxdXyy2bVeozQKltV8', 0),
(4, 1, '2023-03-13 15:21:22', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '13032023-640f3f729308d', 'cs_test_b1Od2J0YXj0rq0zKC2XjNQy2jlBWiune8h3hgqCwuzaXryHuqSDin7drgK', 1),
(5, 2, '2023-03-13 15:24:44', 'UPS', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '13032023-640f403cd69a8', 'cs_test_b1IOmfNhJYNf2MSrLnIYU7R4MM6UYJ3eH0IoBfXD6LPzhiDjMNFyP6Ndne', 3),
(6, 1, '2023-03-14 08:30:14', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '14032023-641030966b8d6', 'cs_test_b11yj5MiJXXYtFCtiFi9zcto9Bt68Pu1N9EGBzq6jrfwqYvf6gqDrReMmP', 1),
(7, 1, '2023-03-14 08:32:44', 'UPS', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '14032023-6410312ccb7a2', 'cs_test_b1ix6ANOJDlaXOcHwBoQJ2MtXwCyvGumezNmO4UMsmNPFQg6lVL6sMgSWM', 0),
(8, 1, '2023-03-14 08:37:44', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '14032023-64103258844c0', 'cs_test_b1oy9wDytq13O8XB2h1o9Ainb0WvF5ZVdJodsKEuIyhAa4fAkhL1ftKOET', 1),
(9, 1, '2023-03-14 12:56:48', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '14032023-64106f102bce2', 'cs_test_b1Su1nGMqrYZ9KEHMlukXFC96ptxbgFkBHUObyZKzdEBBykTc40SRbf0J0', 0),
(10, 1, '2023-03-15 10:28:41', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '15032023-64119dd9dba73', 'cs_test_b1wHRVyh54XUmAaKLyCNhdF1oxNG0gZcO0D7KlkS55vpJOMGUmaJe1IfFL', 1),
(11, 1, '2023-03-15 10:48:39', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '15032023-6411a287c2f15', 'cs_test_b1dlz0alO37KS5kYzmS0QJDagHuBeTvpAD0Fz3KRkr0HEoYPi8IIV7uozh', 1),
(12, 1, '2023-03-15 10:58:21', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '15032023-6411a4cd8763c', 'cs_test_b1sI6sNDaz4Rt8Q6hRQz1lSeO7tf6bi1xfTDssFjuwpCzRo3MkuEzkSEyG', 1),
(13, 1, '2023-03-15 11:10:52', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '15032023-6411a7bc51f80', 'cs_test_b16xKVjD5DZoSiysM9SlXadylO6uzDnI4CoLCm0yo3gPOrHgKpu4evkGDZ', 1),
(14, 1, '2023-03-15 11:16:13', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '15032023-6411a8fdac952', 'cs_test_b1TS3qKRsxNP8L3pYU8yQ4aHrSDSBJ0B0JPrquZhAFP6UJXeASWFxCD6cy', 1),
(15, 1, '2023-03-15 11:20:13', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '15032023-6411a9ed2778e', 'cs_test_b1MDmd3WeT6ShIth42gqelGEQjxxSGGIcciMREZR1ZyXnjjRe2GbBQSbGi', 1),
(16, 1, '2023-03-15 11:22:52', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '15032023-6411aa8ca5d1b', 'cs_test_b1FIuhJSb0YW5bVjRUYaRgwbROEdvPLSdCVUA3H3eH5ezbgp8TiwtBJ8cT', 1),
(17, 1, '2023-03-15 11:32:44', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '15032023-6411acdce96b3', 'cs_test_b1CJiAnF0VRGsCegkIkcgtIoZxBIPWCR8wVDGH9T4IwMdag6UQGhGPGBcw', 1),
(18, 1, '2023-03-15 11:40:04', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '15032023-6411ae948e003', 'cs_test_b1oaKBkodRk4MKJ70utFbNiTyUxabBIKgyabrn8QioJxVtdxpacbLGjVjj', 1),
(19, 1, '2023-03-15 11:42:20', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '15032023-6411af1c0c471', 'cs_test_b1mCI5jt9P4XPXWnIqAizz5JcV3yxvtgaOFf3wrGcPWgbCiNLzTtMK2sQt', 1),
(20, 1, '2023-03-15 11:50:21', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '15032023-6411b0fd6e61d', 'cs_test_b1Gaf1qyBuEYb8DjjBOUtrbCWmVEA1vK0d0dtoj84JUaO0EepVL5DO3z5f', 1),
(21, 1, '2023-03-15 12:16:28', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '15032023-6411b71cdc1f9', 'cs_test_b1lXHiW5YdvxhigytXrEhDkMguFmzqBInAmm457AVVUq64WqGPa1s82Zfp', 1),
(22, 1, '2023-03-15 12:19:41', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '15032023-6411b7dd54955', 'cs_test_b17YFDwrM3aSuMH5pNGrVjuyWS2PrWGKCGxv9oATYN2FEXmGLQmWI7jMPY', 1),
(23, 1, '2023-03-15 12:31:12', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '15032023-6411ba908576e', 'cs_test_b1IWFUxcEdeoM5dwTtLDgSnLq7H5CuQJ9NXnzgI9mAi89GeyOvDBxIHvXl', 1),
(24, 1, '2023-03-15 12:54:40', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '15032023-6411c010b088d', 'cs_test_b1GUwkYo3EHbB3xdSBVLHmyke8OqaHX2yI7Jdc9upapEKkM66hkwIQdHWz', 1),
(25, 1, '2023-03-15 12:58:28', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '15032023-6411c0f447618', 'cs_test_b1gGrC7b5IU52OUxZKXpEA2nVUECHkGZZJ8QPhCC9gPvEOpXVHxpdB5std', 1),
(26, 1, '2023-03-15 13:05:37', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '15032023-6411c2a10f1b0', 'cs_test_b1c3UI2DOB44jmWWpD0kf1UqLF0CySigl2xC9ixAhYoZtzZtACvQXHxyC1', 1),
(27, 1, '2023-03-15 13:10:33', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '15032023-6411c3c9d086b', 'cs_test_b1fVhoYAnmwIk4cohD12xflbr56YbJeGkvKRGJLxpjntRngcWa1WmXCr5s', 1),
(28, 1, '2023-03-17 10:54:39', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '17032023-641446ef2d9b8', 'cs_test_b1mzJ6kDFox5DYJpYqiXze8SX4xEpnwtRKO2N59n2i5Ox9OPi0biPepXyE', 1),
(29, 1, '2023-04-12 09:30:38', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>Olga Lukianets<br>19 Rue Charles Baudelaire<br>93330 Neuilly-sur-Marne<br>FR<br>', '12042023-64367a3e7f5fc', 'cs_test_b12H0ud5P2AABGuT8PR6IiVhE2Pf9T8xH1OyfZUKssFjniRqekkD8Z49cP', 3),
(30, 3, '2023-06-30 13:52:05', 'DHL', 1000, 'Zackary Sim<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '30062023-649ede0500bb6', 'cs_test_b1uCjEA9i1BZYdiuEXGqe6fyr3ho5UuLVBAdd40I0abSetq9Gt5Ve2c0Nq', 0),
(31, 3, '2023-07-11 09:42:50', 'UPS', 1000, 'Zackary Sim<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '11072023-64ad241ab44bb', 'cs_test_b1z0eb2bHjOAyOEGMUmY3I14Rb3h9J9IfrYIZyIMyGWoYqykhcrmLv84VK', 0),
(32, 3, '2023-08-08 09:38:34', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '08082023-64d20d1acaaf0', NULL, 0),
(33, 3, '2023-08-08 09:53:27', 'DHL', 1000, 'Zackary Sim<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '08082023-64d21097e4f61', NULL, 0),
(34, 3, '2023-08-08 09:54:21', 'DHL', 1000, 'Zackary Sim<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '08082023-64d210cdf05f7', NULL, 0),
(35, 3, '2023-08-08 09:54:47', 'DHL', 1000, 'Zackary Sim<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '08082023-64d210e7e9c4a', NULL, 0),
(36, 3, '2023-08-08 09:55:10', 'DHL', 1000, 'Zackary Sim<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '08082023-64d210fe4a5d6', NULL, 0),
(37, 3, '2023-08-08 09:55:57', 'DHL', 1000, 'Zackary Sim<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '08082023-64d2112def42d', NULL, 0),
(38, 3, '2023-08-08 09:56:18', 'DHL', 1000, 'Zackary Sim<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '08082023-64d211424c531', NULL, 0),
(39, 3, '2023-08-08 09:57:08', 'DHL', 1000, 'Zackary Sim<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '08082023-64d21174ea9ca', NULL, 0),
(40, 3, '2023-08-08 09:57:37', 'DHL', 1000, 'Zackary Sim<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '08082023-64d21191471db', NULL, 0),
(41, 3, '2023-08-08 09:57:54', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '08082023-64d211a24fefc', NULL, 0),
(42, 3, '2023-08-08 09:59:40', 'UPS', 1000, 'Olga Lukianets<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '08082023-64d2120ca7c9a', NULL, 0),
(43, 3, '2023-08-08 10:00:12', 'UPS', 1000, 'Olga Lukianets<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '08082023-64d2122c5dc5d', NULL, 0),
(44, 3, '2023-08-08 10:03:00', 'UPS', 1000, 'Olga Lukianets<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '08082023-64d212d4edc66', NULL, 0),
(45, 3, '2023-08-08 10:06:45', 'DHL', 1000, 'Zackary Sim<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '08082023-64d213b562630', NULL, 0),
(46, 3, '2023-08-08 10:07:02', 'DHL', 1000, 'Zackary Sim<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '08082023-64d213c64a69e', NULL, 0),
(47, 3, '2023-08-08 10:17:59', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '08082023-64d2165797fda', NULL, 0),
(48, 3, '2023-08-08 10:21:38', 'UPS', 1000, 'Olga Lukianets<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '08082023-64d217329308f', NULL, 0),
(49, 3, '2023-08-08 10:52:58', 'UPS', 1000, 'Olga Lukianets<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '08082023-64d21e8aaa364', NULL, 0),
(50, 3, '2023-08-16 13:48:29', 'UPS', 1000, 'Olga Lukianets<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '16082023-64dcd3ad1bc6c', NULL, 0),
(51, 3, '2023-08-16 20:04:35', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '16082023-64dd2bd3462f0', NULL, 0),
(52, 3, '2023-08-17 14:36:24', 'UPS', 1000, 'Olga Lukianets<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '17082023-64de306809452', NULL, 0),
(53, 3, '2023-08-17 14:37:08', 'DHL', 1000, 'Olga Lukianets<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '17082023-64de30943e78e', NULL, 0),
(54, 3, '2023-08-17 14:42:57', 'UPS', 1000, 'Olga Lukianets<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '17082023-64de31f1003a1', NULL, 0),
(55, 3, '2023-08-21 07:54:36', 'UPS', 1000, 'Olga Lukianets<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '21082023-64e3183c4c194', NULL, 0),
(56, 3, '2023-08-21 08:08:44', 'UPS', 1000, 'Zackary Sim<br>0761722489<br>19 Rue Charles Baudelaire<br>93140 Bondy<br>UA<br>', '21082023-64e31b8c8700f', NULL, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `order_details`
--

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL,
  `my_order_id` int(11) NOT NULL,
  `product` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` double NOT NULL,
  `total` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `order_details`
--

INSERT INTO `order_details` (`id`, `my_order_id`, `product`, `quantity`, `price`, `total`) VALUES
(1, 1, 'L\'ALINGI', 2, 74000, 148000),
(2, 1, 'BALENCIAGA', 1, 118000, 118000),
(3, 1, 'LONGCHAMP', 1, 6400, 6400),
(4, 2, 'L\'ALINGI', 2, 74000, 148000),
(5, 2, 'BALENCIAGA', 1, 118000, 118000),
(6, 2, 'LONGCHAMP', 1, 6400, 6400),
(7, 3, 'L\'ALINGI', 2, 74000, 148000),
(8, 3, 'BALENCIAGA', 1, 118000, 118000),
(9, 3, 'LONGCHAMP', 1, 6400, 6400),
(10, 4, 'LONGCHAMP', 1, 6400, 6400),
(11, 4, 'L\'ALINGI', 1, 115500, 115500),
(12, 5, 'BALENCIAGA', 2, 118000, 236000),
(13, 5, 'L\'ALINGI', 1, 74000, 74000),
(14, 6, 'LONGCHAMP', 1, 6400, 6400),
(15, 7, 'L\'ALINGI', 1, 74000, 74000),
(16, 8, 'L\'ALINGI', 1, 74000, 74000),
(17, 8, 'BALENCIAGA', 1, 118000, 118000),
(18, 9, 'LONGCHAMP', 1, 6400, 6400),
(19, 10, 'L\'ALINGI', 1, 74000, 74000),
(20, 11, 'LONGCHAMP', 2, 6400, 12800),
(21, 12, 'LONGCHAMP', 1, 6400, 6400),
(22, 12, 'L\'ALINGI', 1, 74000, 74000),
(23, 13, 'L\'ALINGI', 2, 74000, 148000),
(24, 14, 'L\'ALINGI', 2, 74000, 148000),
(25, 15, 'L\'ALINGI', 1, 74000, 74000),
(26, 16, 'L\'ALINGI', 1, 74000, 74000),
(27, 17, 'L\'ALINGI', 2, 74000, 148000),
(28, 18, 'L\'ALINGI', 1, 74000, 74000),
(29, 19, 'L\'ALINGI', 2, 74000, 148000),
(30, 20, 'LONGCHAMP', 1, 6400, 6400),
(31, 21, 'LONGCHAMP', 1, 6400, 6400),
(32, 22, 'LONGCHAMP', 1, 6400, 6400),
(33, 22, 'L\'ALINGI', 1, 74000, 74000),
(34, 23, 'LONGCHAMP', 1, 6400, 6400),
(35, 24, 'L\'ALINGI', 1, 74000, 74000),
(36, 25, 'LONGCHAMP', 1, 6400, 6400),
(37, 26, 'L\'ALINGI', 2, 74000, 148000),
(38, 27, 'LONGCHAMP', 1, 6400, 6400),
(39, 27, 'L\'ALINGI', 1, 115500, 115500),
(40, 28, 'BALENCIAGA', 1, 118000, 118000),
(41, 29, 'LONGCHAMP', 3, 6400, 19200),
(42, 29, 'L\'ALINGI', 1, 74000, 74000),
(43, 30, 'LONGCHAMP', 1, 6400, 6400),
(44, 31, 'LONGCHAMP', 3, 6400, 19200),
(45, 32, 'LONGCHAMP', 1, 6400, 6400),
(46, 33, 'L\'ALINGI', 1, 74000, 74000),
(47, 34, 'L\'ALINGI', 1, 74000, 74000),
(48, 35, 'L\'ALINGI', 1, 74000, 74000),
(49, 36, 'L\'ALINGI', 1, 74000, 74000),
(50, 37, 'L\'ALINGI', 1, 74000, 74000),
(51, 38, 'L\'ALINGI', 1, 74000, 74000),
(52, 39, 'L\'ALINGI', 1, 74000, 74000),
(53, 40, 'L\'ALINGI', 1, 74000, 74000),
(54, 41, 'L\'ALINGI', 1, 74000, 74000),
(55, 42, 'L\'ALINGI', 1, 74000, 74000),
(56, 43, 'L\'ALINGI', 1, 74000, 74000),
(57, 44, 'L\'ALINGI', 1, 74000, 74000),
(58, 45, 'L\'ALINGI', 1, 74000, 74000),
(59, 46, 'L\'ALINGI', 1, 74000, 74000),
(60, 47, 'L\'ALINGI', 1, 74000, 74000),
(61, 47, 'LONGCHAMP', 1, 6400, 6400),
(62, 48, 'L\'ALINGI', 1, 74000, 74000),
(63, 48, 'LONGCHAMP', 1, 6400, 6400),
(64, 49, 'L\'ALINGI', 1, 74000, 74000),
(65, 49, 'LONGCHAMP', 1, 6400, 6400),
(66, 50, 'L\'ALINGI', 1, 115500, 115500),
(67, 51, 'L\'ALINGI', 1, 74000, 74000),
(68, 52, 'L\'ALINGI', 2, 74000, 148000),
(69, 53, 'L\'ALINGI', 2, 74000, 148000),
(70, 54, 'L\'ALINGI', 2, 74000, 148000),
(71, 54, 'L\'ALINGI', 2, 115500, 231000),
(72, 55, 'L\'ALINGI', 2, 115500, 231000),
(73, 56, 'L\'ALINGI', 2, 115500, 231000);

-- --------------------------------------------------------

--
-- Структура таблицы `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtitle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double NOT NULL,
  `illustration` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_best` tinyint(1) DEFAULT NULL,
  `is_stock` tinyint(1) DEFAULT NULL,
  `quota` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `product`
--

INSERT INTO `product` (`id`, `category_id`, `name`, `slug`, `subtitle`, `description`, `price`, `illustration`, `is_best`, `is_stock`, `quota`) VALUES
(1, 1, 'LONGCHAMP', 'longchamp-le-pliage-filet-extra-small-cotton-top-handle-ba', 'Le Pliage Filet extra-small cotton top-handle bag', '<div>Sac bandoulière en coton <strong>Longchamp </strong>100% coton ;&nbsp;bordures en cuir de vachette à 100%<br><br>Fermeture à bouton-pression<br><br>Poignée supérieure, bandoulière, motif filet de pêche sur l\'ensemble, bordures contrastantes en cuir, quincaillerie dorée, un compartiment principal<br><br>Hauteur 17 cm, largeur 20 cm, profondeur 1 cm, hauteur de la poignée 5 cm, longueur de la bandoulière 99 cm, hauteur de la bandoulière 46 cm<br><br>Nettoyer avec un chiffon propre et sec<br><br></div>', 6400, '401b710fa68db6c501fba6b79ca742e0a8f0b76c.jpg', 0, 1, '<div>\"Le sac Longchamps Le Pliage Filet extra-small cotton top-handle bag est un peu comme un petit miracle en toile de coton. Il est assez petit pour ne pas vous alourdir, mais assez grand pour contenir tous vos indispensables : votre téléphone, vos clés, votre portefeuille et même quelques bonbons pour les coups de mou. Sa poignée supérieure en cuir vous donne une allure sophistiquée, tandis que la fermeture à glissière garde vos affaires en sécurité . Avec son design simple mais élégant, ce sac est parfait pour les journées décontractées, les sorties rapides ou les rendez-vous galants où vous voulez juste emporter l\'essentiel. En fin de compte, ce sac est tout simplement parfait pour tous ceux qui apprécient la qualité, le style et le confort - ou pour ceux qui aiment simplement dire \"c\'est un sac Longchamps, chéri\".</div>'),
(2, 2, 'L\'ALINGI', 'lalingi-eternity-embellished-satin-clutch-bag', 'Eternity embellished satin clutch bag', '<div>textile ; ornements en cristaux à 100%<br><br>Fermeture à glissière<br><br>Forme courbe, poignée structurée sur le dessus, cristaux multicolores incrustés sur les poignées et les bords, texture satinée sur l\'ensemble, quincaillerie argentée, un compartiment principal, poche intérieure plaquée et plaque de marque, entièrement doublée<br><br>Hauteur 10,5 cm, largeur 20 cm, hauteur de la poignée 8,5 cm<br><br>Nettoyer avec un chiffon propre et sec<br><br>Livré avec un sac de rangement, présenté dans une boîte.</div>', 74000, '2de5fee0c722631cb2f667bafc2648fd08a8b1a9.jpg', 0, 1, '<div>\"Un sac à main sophistiqué, élégant et pratique pour toutes les occasions spéciales. Avec sa toile satinée douce et chatoyante et ses embellissements sophistiqués, ce sac à main est un véritable joyau de la mode. Assez grand pour ranger tous vos essentiels, il est le choix parfait pour les soirées chics où vous voulez impressionner ou pour vous sentir comme une star hollywoodienne. Alors ne cherchez plus, laissez-vous séduire par l\'élégance de l\'Alingi et faites tourner les têtes avec notre Eternity embellished satin clutch bag !\"</div>'),
(3, 2, 'L\'ALINGI', 'lalingi-pearl-acrylic-clutch-bag', 'Pearl acrylic clutch bag', '<ul><li>Sac pochette en acrylique <strong>L’alingi</strong></li><li>100% acrylique</li><li>Fermeture magnétique</li><li>Forme sphérique, poignée supérieure en chaîne, incrustation de strass sur le panneau latéral, effet perle sur l\'ensemble, quincaillerie dorée, un compartiment principal, fait à la main</li><li>Hauteur 26 cm, largeur 21 cm, hauteur de la poignée supérieure 14 cm</li><li>Nettoyer avec un chiffon propre et sec</li><li>Livré avec un sac de rangement.</li></ul>', 115500, '4cc5d74a52ba712452b7746efc6746143de1136d.jpg', 1, 1, NULL),
(4, 3, 'BALENCIAGA', 'balenciaga-mini-leather-shoulder-bag', 'Le Cagole Heart mini leather shoulder bag', '<div>Sac à bandoulière en cuir <strong>Balenciaga</strong><br><br></div><div>100% cuir d\'agneau<br><br></div><div>Fermeture éclair</div><div><br>Forme de coeur, bandoulière chaîne, clous et coutures exposées à l\'avant, trois boucles à l\'avant, poche zippée à l\'avant extérieure, matériel argenté, un compartiment principal, deux emplacements pour cartes et branding doré à l\'intérieur, entièrement doublé<br><br></div><div>Hauteur 14 cm, largeur 16 cm, profondeur 4,5 cm, longueur de la sangle 45 cm<br><br></div><div>Nettoyage spécialisé du cuir<br><br></div><div>Livré avec un sac de rangement</div>', 118000, '0da2e043ac7afc905a381a0ddc7ffa7ef2397916.jpg', 1, 1, NULL),
(5, 3, 'BALENCIAGA', 'balenciaga-le-cagole-heart-mini-leather-shoulder-bag', 'Le Cagole Heart mini leather shoulder bag', '<ul><li>Sac à bandoulière en cuir Balenciaga</li><li>100% cuir d\'agneau</li><li>Fermeture éclair</li><li>Forme de coeur, bandoulière chaîne, clous et coutures exposées à l\'avant, trois boucles à l\'avant, poche zippée à l\'avant extérieure, matériel argenté, un compartiment principal, deux emplacements pour cartes et branding doré à l\'intérieur, entièrement doublé</li><li>Hauteur 14 cm, largeur 16 cm, profondeur 4,5 cm, longueur de la sangle 45 cm</li><li>Nettoyage spécialisé du cuir</li><li>Livré avec un sac de rangement</li></ul>', 118000, '0bee72b1e0c459732941dc72939d64f9b154b23d.jpg', 1, 1, '<div>\"Nous ne savons pas pour vous, mais un seul coup d\'œil sur le sac Le Cagole de Balenciaga et nous semblons avoir été frappés par la flèche de l\'amour de Cupidon. Réinventant l\'un des styles les plus rêveurs de la maison parisienne pour la collection printemps-été 2023, ce design attachant est cousu à partir de panneaux de cuir froissé et sculpté pour refléter les lignes sinueuses d\'un cœur. Puis, en s\'inspirant des motos imposantes de la ville, il est couronné d\'une multitude de clous, de boucles et de sangles tressées.\"</div>');

-- --------------------------------------------------------

--
-- Структура таблицы `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_activated` tinyint(1) DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `firstname`, `lastname`, `is_activated`, `avatar`) VALUES
(1, 'olgalukianets7@gmail.com', '[\"ROLE_USER\", \"ROLE_ADMIN\"]', '$2y$13$j223aR/oBD/MivX2SDgM1.Y9qgmdjjkMBvYRYOtyx9jApNhU4mp7C', 'Olga', 'Lukianets', 0, '87a89bd5388e7d10a93c9c9aa67d2bc7630d6d33.jpg'),
(2, 'admin@ss.com', '[\"ROLE_USER\", \"ROLE_ADMIN\"]', '$2y$13$66/zT9Sc8Vkl5V3myF/Gku6j/YCNO17rfMBGXy2JeLF5qre.wU3oS', 'Olga', 'Lukianets', 0, NULL),
(3, 'doe@gmail.com', '[\"ROLE_USER\", \"ROLE_ADMIN\"]', '$2y$13$Rubr6txaTjFfZ72tXhJMw.Gyi9CcRXaMOlijsZ6mm1GcrAHcIfxEu', 'Doe', 'John', 0, NULL),
(4, 'olgalukianets8@gmail.com', '[]', '$2y$13$MRVk/fYUKgQOu6cRVA4HoucJD4cA94d.0YGUTHzX3J9zaAuBuzSzO', 'Olga', 'Lukianets', NULL, NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D4E6F81A76ED395` (`user_id`);

--
-- Индексы таблицы `carousel`
--
ALTER TABLE `carousel`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `carrier`
--
ALTER TABLE `carrier`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Индексы таблицы `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_906517449A530CA8` (`order_invoice_id`);

--
-- Индексы таблицы `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Индексы таблицы `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_F5299398A76ED395` (`user_id`);

--
-- Индексы таблицы `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_845CA2C1BFCDF877` (`my_order_id`);

--
-- Индексы таблицы `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D34A04AD12469DE2` (`category_id`);

--
-- Индексы таблицы `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `address`
--
ALTER TABLE `address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `carousel`
--
ALTER TABLE `carousel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `carrier`
--
ALTER TABLE `carrier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `invoice`
--
ALTER TABLE `invoice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT для таблицы `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT для таблицы `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `FK_D4E6F81A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Ограничения внешнего ключа таблицы `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `FK_906517449A530CA8` FOREIGN KEY (`order_invoice_id`) REFERENCES `order` (`id`);

--
-- Ограничения внешнего ключа таблицы `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `FK_F5299398A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Ограничения внешнего ключа таблицы `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `FK_845CA2C1BFCDF877` FOREIGN KEY (`my_order_id`) REFERENCES `order` (`id`);

--
-- Ограничения внешнего ключа таблицы `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FK_D34A04AD12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
