-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : mar. 23 nov. 2021 à 18:02
-- Version du serveur :  10.4.17-MariaDB
-- Version de PHP : 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `OLE`
--

-- --------------------------------------------------------

--
-- Structure de la table `machine_component`
--

CREATE TABLE `machine_component` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `machineName` varchar(100) NOT NULL,
  `other_machine` int(1) NOT NULL COMMENT '0 : No, 1 : Yes'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `machine_component`
--

INSERT INTO `machine_component` (`id`, `name`, `machineName`, `other_machine`) VALUES
(1, 'downstreamSaturation', 'filler', 1),
(2, 'dosingTurret', 'filler', 0),
(3, 'bowlStopper', 'filler', 0),
(4, 'screwingTurret', 'filler', 0),
(5, 'missingBottle', 'filler', 1),
(6, 'other', 'filler', 0);

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2021_08_24_110847_create_ole_unplanned_event_unplanned_downtimes_table', 2);

-- --------------------------------------------------------

--
-- Structure de la table `ole_assignement_team_pos`
--

CREATE TABLE `ole_assignement_team_pos` (
  `id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `username` varchar(25) NOT NULL,
  `productionline` int(50) NOT NULL,
  `po` varchar(50) NOT NULL,
  `shift` varchar(50) NOT NULL,
  `worksite` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_assignement_team_pos`
--

INSERT INTO `ole_assignement_team_pos` (`id`, `created_at`, `updated_at`, `username`, `productionline`, `po`, `shift`, `worksite`) VALUES
(1, '2021-09-22 07:46:09', '0000-00-00 00:00:00', 'thotrb', 1, 'titi', 'A', 1),
(2, '2021-09-22 07:46:09', '0000-00-00 00:00:00', 'thotrb', 5, 'toto', 'A', 1),
(34, '2021-10-26 11:49:50', '2021-10-26 11:49:50', 'userMedan', 6, 'testPOMedan1', 'First', 2),
(35, '2021-10-26 11:50:11', '2021-10-26 11:50:11', 'userMedan', 7, 'testPOMedan2', 'First', 2),
(36, '2021-10-26 12:58:13', '2021-10-26 12:58:13', 'userMedan', 6, 'testPOMedan2', 'First', 2),
(37, '2021-10-26 13:00:54', '2021-10-26 13:00:54', 'userMedan', 6, 'testPOMedan3', 'Second', 2),
(38, '2021-10-26 13:00:57', '2021-10-26 13:00:57', 'userMedan', 7, 'testPOMedan4', 'Second', 2),
(39, '2021-10-26 13:37:21', '2021-10-26 13:37:21', 'userMedan', 6, 'testPOMedan4', 'Third', 2),
(40, '2021-10-26 13:37:25', '2021-10-26 13:37:25', 'userMedan', 7, 'testPOMedan2', 'Third', 2),
(41, '2021-10-26 13:38:02', '2021-10-26 13:38:02', 'userMedan', 7, 'testPOMedan3', 'Second', 2),
(42, '2021-10-26 13:38:51', '2021-10-26 13:38:51', 'userMedan', 7, 'testPOMedan1', 'First', 2),
(43, '2021-10-28 12:31:44', '2021-10-28 12:31:44', 'userMedan', 7, 'testPOMedan5', 'Third', 2),
(44, '2021-10-28 12:58:34', '2021-10-28 12:58:34', 'userMedan', 6, 'testPOMedan5', 'Third', 2),
(45, '2021-10-28 12:58:37', '2021-10-28 12:58:37', 'userMedan', 7, 'testPOMedan1', 'Third', 2),
(46, '2021-11-03 15:05:03', '2021-11-03 15:05:03', 'userMedan', 6, 'testMedanLigne1', 'Third', 2),
(47, '2021-11-03 15:05:06', '2021-11-03 15:05:06', 'userMedan', 7, 'testMedanLigne2', 'Third', 2),
(48, '2021-11-04 12:06:15', '2021-11-04 12:06:15', 'thotrb', 5, 'titi', 'A', 1),
(49, '2021-11-20 09:48:47', '2021-11-20 09:48:47', 'userMedan', 6, 'nouveauPODETest', 'Third', 2),
(50, '2021-11-20 09:48:49', '2021-11-20 09:48:49', 'userMedan', 7, 'PO1', 'Third', 2);

-- --------------------------------------------------------

--
-- Structure de la table `ole_downtimeReason`
--

CREATE TABLE `ole_downtimeReason` (
  `id` int(11) NOT NULL,
  `reason` varchar(50) CHARACTER SET utf8 NOT NULL,
  `downtimeType` varchar(50) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_downtimeReason`
--

INSERT INTO `ole_downtimeReason` (`id`, `reason`, `downtimeType`) VALUES
(1, 'CIP', 'unplannedDowntime'),
(2, 'formatChanging', 'unplannedDowntime'),
(3, 'packNumberChanging', 'unplannedDowntime'),
(4, 'unplannedDowntime', 'unplannedDowntime'),
(7, 'break', 'plannedDowntime'),
(8, 'lunch', 'plannedDowntime'),
(9, 'emergency', 'plannedDowntime'),
(10, 'meeting', 'plannedDowntime'),
(11, 'noProductionPlanned', 'plannedDowntime'),
(12, 'maintenance', 'plannedDowntime'),
(13, 'projectImplementation', 'plannedDowntime');

-- --------------------------------------------------------

--
-- Structure de la table `ole_formats`
--

CREATE TABLE `ole_formats` (
  `id` int(11) NOT NULL,
  `format` varchar(15) NOT NULL,
  `shape` varchar(40) NOT NULL,
  `mat1` varchar(15) NOT NULL,
  `mat2` varchar(15) NOT NULL,
  `mat3` varchar(15) NOT NULL,
  `design_rate` int(5) NOT NULL,
  `productionlineName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_formats`
--

INSERT INTO `ole_formats` (`id`, `format`, `shape`, `mat1`, `mat2`, `mat3`, `design_rate`, `productionlineName`) VALUES
(1, '1L', 'round', 'HDPE', 'FHDPE', 'PE/PA', 25, 'F52'),
(2, '2L', 'square', 'HDPE', 'PET', 'None', 20, 'F52'),
(3, '3L', 'square', 'HDPE', 'PET', 'None', 16, 'F52'),
(4, '5L', 'square', 'HPDE', 'PET', 'None', 15, 'F52'),
(5, '10L', 'square', 'HDPE', 'PET', 'None', 8, 'F52');

-- --------------------------------------------------------

--
-- Structure de la table `ole_machines`
--

CREATE TABLE `ole_machines` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `operation` varchar(50) NOT NULL,
  `fabricant` varchar(100) NOT NULL,
  `modele` varchar(100) NOT NULL,
  `productionline_name` varchar(100) NOT NULL,
  `denomination_ordre` varchar(75) NOT NULL,
  `ordre` int(11) NOT NULL,
  `rejection` int(1) NOT NULL DEFAULT 0 COMMENT '0 = No rejection, 1 = Rejection'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_machines`
--

INSERT INTO `ole_machines` (`id`, `name`, `operation`, `fabricant`, `modele`, `productionline_name`, `denomination_ordre`, `ordre`, `rejection`) VALUES
(1, 'Depalettiseur', 'Manual', 'NA', 'NA', 'F52', 'M1', 1, 0),
(2, 'filler', 'Automated', 'SERAC', 'R1V1', 'F52', 'Filler/Caper', 2, 1),
(4, 'EtiqueteuseBouteille', 'Automated', 'PE Labeler', 'XXX', 'F52', 'M2', 3, 1),
(5, 'Encaisseuse', 'Manual', 'NA', 'NA', 'F52', 'M4', 5, 0),
(6, 'Palettiseur', 'Manual', 'NA', 'NA', 'F52', 'M8', 9, 0),
(7, 'PeseurDeCaisse', 'Automated', 'METTLER TOLEDO', 'MT-20', 'F52', 'M7', 8, 1),
(8, 'ScelleurDeCaisse', 'Automated', 'LANTECH', 'CS-300', 'F52', 'M6', 7, 0),
(9, 'FormeurDeCaisse', 'Semi-Auto', 'LANTECH', 'C-300', 'F52', 'M5', 6, 0),
(10, 'ApplicateurBouteille', 'Automated', 'SERAC', 'RX20', 'F52', 'M3', 4, 0);

-- --------------------------------------------------------

--
-- Structure de la table `ole_planned_events`
--

CREATE TABLE `ole_planned_events` (
  `id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `OLE` varchar(50) NOT NULL,
  `productionline` varchar(50) NOT NULL,
  `reason` varchar(100) NOT NULL,
  `duration` int(11) NOT NULL,
  `comment` text DEFAULT '\' \'',
  `kind` int(1) NOT NULL DEFAULT 0 COMMENT '0 : planned, 1 : unplanned'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_planned_events`
--

INSERT INTO `ole_planned_events` (`id`, `created_at`, `updated_at`, `OLE`, `productionline`, `reason`, `duration`, `comment`, `kind`) VALUES
(1, '2021-11-04 13:23:47', '2021-09-02 10:38:32', 'titi', 'F52', 'meeting', 15, 'lala', 0),
(3, '2021-11-04 13:23:45', '2021-09-04 14:23:15', 'titi', 'F53', 'break', 1, 'lunch', 0),
(7, '2021-11-04 13:23:43', '2021-09-06 13:40:47', 'titi', 'F52', 'break', 30, 'Pause déjeuner', 0),
(8, '2021-11-04 13:23:40', '2021-09-06 13:41:21', 'titi', 'F52', 'meeting', 45, 'lala', 0),
(9, '2021-11-04 13:23:37', '2021-10-26 12:27:39', 'testPOMedan1', 'Medan1', 'break', 120, 'Break', 0),
(10, '2021-11-04 13:23:34', '2021-10-26 13:01:12', 'testPOMedan3', 'Medan1', 'break', 30, 'Break', 0),
(11, '2021-11-04 13:23:32', '2021-10-26 14:10:32', 'testPOMedan2', 'Medan1', 'break', 30, 'Breaks', 0),
(12, '2021-11-04 13:23:28', '2021-10-26 14:10:46', 'testPOMedan2', 'Medan1', 'break', 30, 'Breaks', 0),
(13, '2021-11-04 13:23:25', '2021-10-28 12:29:32', 'testPOMedan4', 'Medan1', 'break', 30, 'Breaks', 0),
(14, '2021-11-04 13:23:22', '2021-10-28 12:59:34', 'testPOMedan5', 'Medan1', 'break', 30, 'Breaks', 0),
(15, '2021-11-03 16:39:09', '2021-11-03 15:21:12', 'testMedanLigne1', 'Medan1', 'break', 45, 'Lunch', 0),
(16, '2021-11-03 15:44:51', '2021-11-03 15:44:51', 'testMedanLigne2', 'Medan2', 'break', 50, 'BREAK MEDAN2', 0),
(17, '2021-11-03 15:46:33', '2021-11-03 15:46:33', 'testMedanLigne2', 'Medan2', 'projectImplementation', 30, 'No comments', 0),
(18, '2021-11-20 09:49:12', '2021-11-20 09:49:12', 'nouveauPODETest', 'Medan1', 'Pause', 30, 'LUNCH', 0);

-- --------------------------------------------------------

--
-- Structure de la table `ole_pos`
--

CREATE TABLE `ole_pos` (
  `id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `number` varchar(50) NOT NULL,
  `GMIDCode` varchar(50) NOT NULL,
  `productionline_name` varchar(50) NOT NULL,
  `state` int(1) NOT NULL DEFAULT 1 COMMENT '0:a l''arret, 1:en cours',
  `totalOperatingTime` int(10) NOT NULL DEFAULT 0,
  `totalNetOperatingTime` int(10) NOT NULL DEFAULT 0,
  `Availability` float(5,2) NOT NULL DEFAULT 0.00,
  `Performance` float(5,2) NOT NULL DEFAULT 0.00,
  `Quality` float(5,2) NOT NULL DEFAULT 0.00,
  `OLE` float(5,2) NOT NULL DEFAULT 0.00,
  `qtyProduced` int(11) NOT NULL DEFAULT 0,
  `workingDuration` int(8) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_pos`
--

INSERT INTO `ole_pos` (`id`, `created_at`, `updated_at`, `number`, `GMIDCode`, `productionline_name`, `state`, `totalOperatingTime`, `totalNetOperatingTime`, `Availability`, `Performance`, `Quality`, `OLE`, `qtyProduced`, `workingDuration`) VALUES
(1, '2021-11-15 16:24:12', '0000-00-00 00:00:00', 'titi', '87507', 'F52', 0, 0, 0, 72.00, 64.00, 98.00, 78.00, 200, 160),
(2, '2021-11-15 16:24:17', '0000-00-00 00:00:00', 'toto', '87507', 'F52', 0, 0, 0, 1.00, 0.67, 1.00, 0.67, 100, 20),
(3, '2021-10-10 15:12:56', '2021-09-16 06:37:25', 't1', '335871', 'F53', 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0, 0),
(4, '2021-10-10 15:12:57', '2021-09-16 06:37:25', 't2', '335871', 'F53', 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0, 0),
(24, '2021-11-15 16:24:23', '2021-09-20 11:02:38', 'lala', '335871', 'F52', 1, 0, 0, 0.00, 0.00, 0.00, 0.00, 50, 50),
(30, '2021-10-26 16:01:15', '2021-10-26 12:22:39', 'testPOMedan1', '11111', 'Medan1', 0, 0, 0, 0.50, 1.00, 1.00, 0.50, 180, 210),
(31, '2021-11-20 09:58:45', '2021-10-26 12:22:39', 'testPOMedan2', '11111', 'Medan1', 0, 0, 0, 0.81, 1.00, -1.11, -0.90, 120, 240),
(32, '2021-10-26 16:55:21', '2021-10-26 13:00:58', 'testPOMedan3', '11111', 'Medan1', 0, 0, 0, 0.68, 0.51, 1.00, 0.34, 618, 480),
(34, '2021-10-27 14:58:42', '2021-10-28 12:44:22', 'testPOMedan4', '11113', 'Medan1', 0, 0, 0, 0.64, 0.34, 1.00, 0.22, 226, 480),
(35, '2021-10-27 15:01:50', '2021-10-28 12:58:38', 'testPOMedan5', '11114', 'Medan1', 0, 0, 0, 0.73, 0.34, 1.00, 0.25, 448, 480),
(36, '2021-11-03 18:26:03', '2021-11-03 15:05:07', 'testMedanLigne1', '138087', 'Medan1', 0, 0, 0, 0.86, 0.00, 1.00, 0.00, 0, 720),
(37, '2021-11-20 10:31:25', '2021-11-03 15:05:07', 'testMedanLigne2', '225830', 'Medan2', 0, 0, 0, 1.00, 1.00, 9.23, 9.23, 120, 240);

-- --------------------------------------------------------

--
-- Structure de la table `ole_productionline`
--

CREATE TABLE `ole_productionline` (
  `id` int(11) NOT NULL,
  `productionline_name` varchar(50) NOT NULL,
  `worksite_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_productionline`
--

INSERT INTO `ole_productionline` (`id`, `productionline_name`, `worksite_name`) VALUES
(1, 'F52', 'Cernay'),
(5, 'F53', 'Cernay'),
(6, 'Medan1', 'Medan'),
(7, 'Medan2', 'Medan');

-- --------------------------------------------------------

--
-- Structure de la table `ole_products`
--

CREATE TABLE `ole_products` (
  `id` int(11) NOT NULL,
  `product` varchar(150) NOT NULL,
  `GMID` varchar(50) NOT NULL,
  `BULK` varchar(50) NOT NULL,
  `family` varchar(150) NOT NULL,
  `GIFAP` varchar(50) NOT NULL,
  `description` varchar(150) NOT NULL,
  `formulationType` varchar(150) NOT NULL,
  `size` varchar(20) NOT NULL COMMENT 'Taille des bouteilles',
  `idealRate` float(7,2) NOT NULL,
  `bottlesPerCase` int(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_products`
--

INSERT INTO `ole_products` (`id`, `product`, `GMID`, `BULK`, `family`, `GIFAP`, `description`, `formulationType`, `size`, `idealRate`, `bottlesPerCase`) VALUES
(3, 'SUCCESSNATURALY BTLPE1X1GL USA', '87507', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '4', 20.00, 4),
(4, 'SUCCESSNATURALY BTLHPE4X1QT EN', '101223', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '1', 40.00, 12),
(5, 'CONSERVESC BTLHPE4X4X1QT USA', '124042', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '1', 40.00, 12),
(6, 'SUCCESS BTLHPE4X4X1L CAN', '138087', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '1', 40.00, 12),
(7, 'GF120NFBAIT BTLHPE4X1GL USA GF1111', '225830', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '4', 20.00, 4),
(8, 'GF120FFBAIT BTLHPE4X3.78L CAN GF1111', '275681', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '4', 20.00, 4),
(9, 'RADIANTSC BTLHPE4X1GL USA', '295528', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '4', 20.00, 4),
(10, 'RADIANTSC BTLHPE4X4X1QT USA', '295529', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '1', 40.00, 12),
(11, 'CONSERVESC BTLHPE4X4X1QT PRI', '335871', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Liquid', '1', 40.00, 12),
(12, 'GF120NFNATURALYTEFFB BTLFPE4X4L PAK', '336953', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '4', 20.00, 4),
(13, 'ENTRUST BTLHPE12X1L CAN', '11039846', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '1', 40.00, 12),
(14, 'NATURALUREFLYBAIT BTLHPE2X10L AUS', '11045177', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '10', 10.00, 2),
(15, 'INTREPIDEDGE BTLHPE4X1GL USA', '11045655', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '4', 20.00, 4),
(16, 'SUCCESSNATURALYTE BTLHPE12X1QT USA', '97018444', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '1', 40.00, 12),
(17, 'ENTRUSTSC BTLHPE12X1QT USA', '97018807', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '1', 40.00, 12),
(18, 'RADIANTSC BTLHPE12X1QT USA', '97018841', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '1', 40.00, 12),
(19, 'RADIANTSC BTLHPE12X1QT PRI', '97019730', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '1', 40.00, 12),
(20, 'ENTRUSTSC BTLHPE12X1QT PRI', '97019823', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '1', 40.00, 12),
(21, 'MOZKILL120SC BTLHPE4X5L NGA', '99056786', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '5', 17.00, 4),
(22, 'ENTRUSTSC BTLHPE4X4X1QT PRI', '99059298', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '1', 40.00, 12),
(23, 'RADIANTSC BTLHPE4X4X1QT PRI', '99059340', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '1', 40.00, 12),
(24, 'EXALT60SC BTLPET24x0.25L PHL', '11111', 'BT100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '0.25', 100.00, 24),
(25, 'EXALT BTLPET24x0.2 5L THA', '11112', 'EX100', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Solid', '0.25', 100.00, 24),
(26, 'TENANO360SC BTLPET50x0.1L IDN', '11113', 'BULKTENANO', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Sparkling', '0.1', 115.00, 50),
(27, 'ENDURE60SC BTLPET20X0.5L MYS', '11114', 'ENDURE', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Sparkling', '0.5', 80.00, 20),
(28, 'TENANO360SC BTLPET24x0.2L IDN', '22222', 'BULKTENANO', 'Herbicide', 'WG', 'Water Dispersible Granule', 'Sparkling', '0.2', 100.00, 24);

-- --------------------------------------------------------

--
-- Structure de la table `ole_rejection_counters`
--

CREATE TABLE `ole_rejection_counters` (
  `id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `po` varchar(50) DEFAULT NULL,
  `fillerCounter` int(11) NOT NULL,
  `caperCounter` int(11) NOT NULL,
  `labelerCounter` int(11) NOT NULL,
  `weightBoxCounter` int(11) NOT NULL COMMENT 'Number of bottles',
  `qualityControlCounter` int(5) NOT NULL,
  `fillerRejection` int(11) NOT NULL,
  `caperRejection` int(11) NOT NULL,
  `labelerRejection` int(11) NOT NULL,
  `weightBoxRejection` int(11) NOT NULL COMMENT 'Number of bottles',
  `qualityControlRejection` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_rejection_counters`
--

INSERT INTO `ole_rejection_counters` (`id`, `created_at`, `updated_at`, `po`, `fillerCounter`, `caperCounter`, `labelerCounter`, `weightBoxCounter`, `qualityControlCounter`, `fillerRejection`, `caperRejection`, `labelerRejection`, `weightBoxRejection`, `qualityControlRejection`) VALUES
(1, '2021-11-17 19:13:35', '0000-00-00 00:00:00', 'titi', 30, 1, 3, 4, 0, 20, 5, 15, 3, 0),
(2, '2021-11-17 19:13:56', '0000-00-00 00:00:00', 'lala', 10, 0, 20, 1, 0, 3, 5, 15, 3, 0),
(3, '2021-11-17 19:14:10', '0000-00-00 00:00:00', 'toto', 0, 1, 2, 1, 0, 4, 10, 5, 5, 0),
(4, '2021-11-14 23:11:10', '0000-00-00 00:00:00', 'testPOMedan1', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, '2021-11-14 23:11:10', '0000-00-00 00:00:00', 'testPOMedan3', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, '2021-11-14 23:11:10', '0000-00-00 00:00:00', 'testPOMedan4', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(8, '2021-11-14 23:11:10', '0000-00-00 00:00:00', 'testPOMedan5', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11, '2021-11-20 09:35:02', '2021-11-20 09:35:02', 'testMedanLigne2', 0, 0, 0, 288, 0, 0, 0, 0, 24, 0);

-- --------------------------------------------------------

--
-- Structure de la table `ole_speed_losses`
--

CREATE TABLE `ole_speed_losses` (
  `id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `OLE` varchar(50) NOT NULL,
  `productionline` varchar(50) NOT NULL,
  `duration` int(50) NOT NULL,
  `reason` varchar(150) NOT NULL,
  `comment` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_speed_losses`
--

INSERT INTO `ole_speed_losses` (`id`, `created_at`, `updated_at`, `OLE`, `productionline`, `duration`, `reason`, `comment`) VALUES
(3, '2021-11-15 15:34:23', '2021-09-15 15:07:04', 'titi', 'F53', 20, 'Reduced Rate At Filler', 'zizihz'),
(4, '2021-11-15 15:34:21', '2021-09-20 11:16:07', 'lala', 'F53', 15, 'Reduce Rate At An Other Machine', 'Commentaire'),
(5, '2021-11-14 15:34:19', '2021-10-02 13:50:50', 'titi', 'F52', 10, 'Filler Own Stoppage', 'lalalalala');

-- --------------------------------------------------------

--
-- Structure de la table `ole_unplanned_event_changing_clients`
--

CREATE TABLE `ole_unplanned_event_changing_clients` (
  `id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `OLE` varchar(50) NOT NULL,
  `productionline` varchar(50) NOT NULL,
  `predicted_duration` int(11) NOT NULL,
  `total_duration` int(11) NOT NULL,
  `lot_number` varchar(50) NOT NULL,
  `comment` text DEFAULT '\' \'',
  `type` varchar(255) NOT NULL DEFAULT 'Changement de lot',
  `kind` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_unplanned_event_changing_clients`
--

INSERT INTO `ole_unplanned_event_changing_clients` (`id`, `created_at`, `updated_at`, `OLE`, `productionline`, `predicted_duration`, `total_duration`, `lot_number`, `comment`, `type`, `kind`) VALUES
(2, '2021-11-03 16:26:21', '2021-11-03 16:26:21', 'testMedanLigne1', 'Medan1', 5, 10, 'ABCD', NULL, 'Changement de lot', 1);

-- --------------------------------------------------------

--
-- Structure de la table `ole_unplanned_event_changing_formats`
--

CREATE TABLE `ole_unplanned_event_changing_formats` (
  `id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `OLE` varchar(50) NOT NULL,
  `productionline` varchar(50) NOT NULL,
  `predicted_duration` int(11) NOT NULL,
  `total_duration` int(11) NOT NULL,
  `comment` text DEFAULT '\' \'',
  `type` varchar(255) NOT NULL DEFAULT 'Changement de format',
  `kind` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_unplanned_event_changing_formats`
--

INSERT INTO `ole_unplanned_event_changing_formats` (`id`, `created_at`, `updated_at`, `OLE`, `productionline`, `predicted_duration`, `total_duration`, `comment`, `type`, `kind`) VALUES
(6, '2021-11-03 16:38:10', '2021-11-03 16:38:10', 'testMedanLigne1', 'Medan1', 60, 10, NULL, 'Changement de format', 1);

-- --------------------------------------------------------

--
-- Structure de la table `ole_unplanned_event_cips`
--

CREATE TABLE `ole_unplanned_event_cips` (
  `id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `OLE` varchar(50) NOT NULL,
  `previous_bulk` varchar(255) NOT NULL,
  `predicted_duration` int(11) NOT NULL,
  `total_duration` int(11) NOT NULL,
  `comment` text DEFAULT '\' \'',
  `productionline` varchar(50) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'CIP',
  `kind` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_unplanned_event_cips`
--

INSERT INTO `ole_unplanned_event_cips` (`id`, `created_at`, `updated_at`, `OLE`, `previous_bulk`, `predicted_duration`, `total_duration`, `comment`, `productionline`, `type`, `kind`) VALUES
(3, '2021-11-03 15:47:20', '2021-11-03 15:47:20', 'testMedanLigne1', 'prevBulk', 5, 35, 'CIP', 'Medan1', 'CIP', 1),
(4, '2021-11-03 16:12:48', '2021-11-03 16:12:48', 'testMedanLigne1', 'PREV', 5, 10, NULL, 'Medan1', 'CIP', 1),
(5, '2021-11-03 16:21:41', '2021-11-03 16:21:41', 'testMedanLigne1', 'PREVIOUSBULK', 5, 30, NULL, 'Medan1', 'CIP', 1),
(6, '2021-11-17 14:58:47', '2021-11-17 14:58:47', 'titi', 'PreviousBULKTEST', 5, 30, 'J\'ai été lent.', 'F52', 'CIP', 1);

-- --------------------------------------------------------

--
-- Structure de la table `ole_unplanned_event_unplanned_downtimes`
--

CREATE TABLE `ole_unplanned_event_unplanned_downtimes` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `OLE` varchar(50) CHARACTER SET utf8mb4 NOT NULL,
  `productionline` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `implicated_machine` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `component` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `total_duration` int(11) NOT NULL,
  `comment` text CHARACTER SET utf8mb4 DEFAULT '\'\'',
  `type` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT 'unplannedDowntime',
  `kind` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `ole_unplanned_event_unplanned_downtimes`
--

INSERT INTO `ole_unplanned_event_unplanned_downtimes` (`id`, `created_at`, `updated_at`, `OLE`, `productionline`, `implicated_machine`, `component`, `total_duration`, `comment`, `type`, `kind`) VALUES
(5, '2021-11-19 15:54:29', '2021-10-26 12:28:35', 'testPOMedan1', 'Medan1', 'Autres', 'Autres', 20, 'Labelling Box Manual', 'unplannedDowntime', 1),
(6, '2021-11-19 15:54:35', '2021-10-26 12:29:04', 'testPOMedan1', 'Medan1', 'Autres', 'Autres', 25, 'Weighing error', 'unplannedDowntime', 1),
(7, '2021-11-19 15:54:43', '2021-10-26 13:02:11', 'testPOMedan3', 'Medan1', 'Etiqueteuse bouteille', 'Saturation aval', 70, 'Label Stuck in the Servo 3 time', 'unplannedDowntime', 1),
(8, '2021-11-19 15:54:49', '2021-10-26 13:02:48', 'testPOMedan3', 'Medan1', 'Etiqueteuse bouteille', 'Saturation aval', 75, 'Change roll label and setting 5 time', 'unplannedDowntime', 1),
(9, '2021-11-19 15:54:51', '2021-10-26 14:11:23', 'testPOMedan2', 'Medan1', 'Etiqueteuse bouteille', 'Saturation aval', 20, 'Label broken', 'unplannedDowntime', 1),
(10, '2021-11-19 15:54:54', '2021-10-26 14:11:46', 'testPOMedan2', 'Medan1', 'Etiqueteuse bouteille', 'Saturation aval', 15, 'Label Zigzag', 'unplannedDowntime', 1),
(12, '2021-11-19 15:54:41', '2021-10-28 12:30:42', 'testPOMedan4', 'Medan1', 'Bol bouchon', 'Bol bouchon', 90, 'Sensor bottle reject Failure', 'unplannedDowntime', 1),
(13, '2021-11-19 15:55:01', '2021-10-28 12:31:35', 'testPOMedan4', 'Medan1', 'Etiqueteuse bouteille', 'Saturation aval', 72, 'Change Roll Label 12 time', 'unplannedDowntime', 1),
(14, '2021-11-19 15:55:08', '2021-10-28 13:00:26', 'testPOMedan5', 'Medan1', 'Tourelle de vissage', 'Tourelle de vissage', 95, 'Manual failing and check capping process', 'unplannedDowntime', 1),
(15, '2021-11-19 15:54:38', '2021-10-28 13:01:11', 'testPOMedan5', 'Medan1', 'Autres', 'Autres', 25, 'Setting capper filling machine and tooling', 'unplannedDowntime', 1),
(16, '2021-11-19 15:55:03', '2021-11-03 17:40:16', 'testMedanLigne1', 'Medan1', 'other', 'other', 120, NULL, 'unplannedDowntime', 1),
(17, '2021-11-19 15:55:06', '2021-11-03 17:49:16', 'testMedanLigne1', 'Medan1', 'screwingTurret', 'screwingTurret', 120, NULL, 'unplannedDowntime', 1),
(19, '2021-11-20 09:49:58', '2021-11-20 09:49:58', 'nouveauPODETest', 'Medan1', 'other', 'other', 95, 'Manual Filling and Check Capping Process', 'unplannedDowntime', 1),
(20, '2021-11-20 09:50:24', '2021-11-20 09:50:24', 'nouveauPODETest', 'Medan1', 'other', 'other', 25, 'Setting Capper', 'unplannedDowntime', 1),
(21, '2021-11-20 09:50:52', '2021-11-20 09:50:52', 'nouveauPODETest', 'Medan1', 'other', 'other', 20, 'Batchnumber', 'unplannedDowntime', 1),
(22, '2021-11-20 09:51:26', '2021-11-20 09:51:26', 'nouveauPODETest', 'Medan1', 'other', 'other', 30, 'Slip Servo', 'unplannedDowntime', 1);

-- --------------------------------------------------------

--
-- Structure de la table `teamInfo`
--

CREATE TABLE `teamInfo` (
  `id` int(11) NOT NULL,
  `workingDebut` varchar(10) NOT NULL,
  `workingEnd` varchar(10) NOT NULL,
  `type` varchar(50) NOT NULL,
  `worksite_name` varchar(100) NOT NULL,
  `state` int(1) NOT NULL DEFAULT 0 COMMENT '0: a l''arret, 1:en cours'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `teamInfo`
--

INSERT INTO `teamInfo` (`id`, `workingDebut`, `workingEnd`, `type`, `worksite_name`, `state`) VALUES
(1, '10', '18', 'A', 'Cernay', 0),
(2, '18', '02', 'B', 'Cernay', 0),
(3, '8', '13', 'First', 'Medan', 0),
(4, '13', '18', 'Second', 'Medan', 0),
(5, '18', '00', 'Third', 'Medan', 0);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `login` varchar(25) NOT NULL,
  `password` varchar(25) NOT NULL,
  `worksite_name` varchar(100) NOT NULL COMMENT 'worksite assignment',
  `lastname` varchar(50) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `status` int(11) NOT NULL COMMENT '0 : opérateur\r\n1 : crew leader\r\n2 : admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `login`, `password`, `worksite_name`, `lastname`, `firstname`, `status`) VALUES
(1, 'thotrb', '1234', 'Cernay', 'Trubert', 'Thomas', 0),
(2, 'pieria', '', 'Cernay', 'Riant', 'Pierre', 1),
(3, 'minpas', '', 'Medan', 'Minault', 'Pascal', 1),
(4, 'userMedan', '1234', 'Medan', 'lastname', 'first name', 0),
(5, 'leaderMedan', '1234', 'Medan', 'Junaidi', 'Albert', 1);

-- --------------------------------------------------------

--
-- Structure de la table `worksite`
--

CREATE TABLE `worksite` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `worksite`
--

INSERT INTO `worksite` (`id`, `name`) VALUES
(1, 'Cernay'),
(2, 'Medan');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `machine_component`
--
ALTER TABLE `machine_component`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ole_assignement_team_pos`
--
ALTER TABLE `ole_assignement_team_pos`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ole_downtimeReason`
--
ALTER TABLE `ole_downtimeReason`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ole_formats`
--
ALTER TABLE `ole_formats`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ole_machines`
--
ALTER TABLE `ole_machines`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ole_planned_events`
--
ALTER TABLE `ole_planned_events`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ole_pos`
--
ALTER TABLE `ole_pos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `number` (`number`);

--
-- Index pour la table `ole_productionline`
--
ALTER TABLE `ole_productionline`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ole_products`
--
ALTER TABLE `ole_products`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ole_rejection_counters`
--
ALTER TABLE `ole_rejection_counters`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ole_speed_losses`
--
ALTER TABLE `ole_speed_losses`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ole_unplanned_event_changing_clients`
--
ALTER TABLE `ole_unplanned_event_changing_clients`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ole_unplanned_event_changing_formats`
--
ALTER TABLE `ole_unplanned_event_changing_formats`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ole_unplanned_event_cips`
--
ALTER TABLE `ole_unplanned_event_cips`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ole_unplanned_event_unplanned_downtimes`
--
ALTER TABLE `ole_unplanned_event_unplanned_downtimes`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `teamInfo`
--
ALTER TABLE `teamInfo`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`);

--
-- Index pour la table `worksite`
--
ALTER TABLE `worksite`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `machine_component`
--
ALTER TABLE `machine_component`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `ole_assignement_team_pos`
--
ALTER TABLE `ole_assignement_team_pos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT pour la table `ole_downtimeReason`
--
ALTER TABLE `ole_downtimeReason`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `ole_formats`
--
ALTER TABLE `ole_formats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `ole_machines`
--
ALTER TABLE `ole_machines`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `ole_planned_events`
--
ALTER TABLE `ole_planned_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pour la table `ole_pos`
--
ALTER TABLE `ole_pos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT pour la table `ole_productionline`
--
ALTER TABLE `ole_productionline`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `ole_products`
--
ALTER TABLE `ole_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pour la table `ole_rejection_counters`
--
ALTER TABLE `ole_rejection_counters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `ole_speed_losses`
--
ALTER TABLE `ole_speed_losses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `ole_unplanned_event_changing_clients`
--
ALTER TABLE `ole_unplanned_event_changing_clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `ole_unplanned_event_changing_formats`
--
ALTER TABLE `ole_unplanned_event_changing_formats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `ole_unplanned_event_cips`
--
ALTER TABLE `ole_unplanned_event_cips`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `ole_unplanned_event_unplanned_downtimes`
--
ALTER TABLE `ole_unplanned_event_unplanned_downtimes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT pour la table `teamInfo`
--
ALTER TABLE `teamInfo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `worksite`
--
ALTER TABLE `worksite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
