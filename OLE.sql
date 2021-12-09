-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : lun. 11 oct. 2021 à 17:13
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
  `machineID` int(11) NOT NULL,
  `other_machine` int(1) NOT NULL COMMENT '0 : No, 1 : Yes'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `machine_component`
--

INSERT INTO `machine_component` (`id`, `name`, `machineID`, `other_machine`) VALUES
(1, 'Saturation aval', 2, 1),
(2, 'Tourelle de dosage ', 2, 0),
(3, 'Bol bouchon', 2, 0),
(4, 'Tourelle de vissage', 2, 0),
(5, 'Manque bouteille', 2, 1),
(6, 'Autres', 2, 0);

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
(2, '2021-09-22 07:46:09', '0000-00-00 00:00:00', 'thotrb', 5, 'toto', 'A', 1);

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
(2, 'Changement de format', 'unplannedDowntime'),
(3, 'Changement de numero de lot', 'unplannedDowntime'),
(4, 'Arret non planifie', 'unplannedDowntime'),
(7, 'Pause', 'plannedDowntime'),
(8, 'Repas', 'plannedDowntime'),
(9, 'Urgence', 'plannedDowntime'),
(10, 'Reunion', 'plannedDowntime'),
(11, 'Pas de production prevue', 'plannedDowntime'),
(12, 'Maintenance', 'plannedDowntime'),
(13, 'Implementation de projet', 'plannedDowntime');

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
  `productionlineID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_formats`
--

INSERT INTO `ole_formats` (`id`, `format`, `shape`, `mat1`, `mat2`, `mat3`, `design_rate`, `productionlineID`) VALUES
(1, '1L', 'Rond', 'HDPE', 'FHDPE', 'PE/PA', 25, 1),
(2, '2L', 'Carre', 'HDPE', 'PET', 'None', 20, 1),
(3, '3L', 'Carre', 'HDPE', 'PET', 'None', 16, 1),
(4, '5L', 'Carre', 'HPDE', 'PET', 'None', 15, 1),
(5, '10L', 'Carre', 'HDPE', 'PET', 'None', 8, 1);

-- --------------------------------------------------------

--
-- Structure de la table `ole_formulations`
--

CREATE TABLE `ole_formulations` (
  `id` int(11) NOT NULL,
  `formulation` varchar(150) NOT NULL,
  `productionlineID` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_formulations`
--

INSERT INTO `ole_formulations` (`id`, `formulation`, `productionlineID`) VALUES
(1, 'Formulation1', 1),
(2, 'Formulation2', 1);

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
  `productionlineID` int(10) NOT NULL,
  `denomination_ordre` varchar(75) NOT NULL,
  `ordre` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_machines`
--

INSERT INTO `ole_machines` (`id`, `name`, `operation`, `fabricant`, `modele`, `productionlineID`, `denomination_ordre`, `ordre`) VALUES
(1, 'Depalettiseur', 'Manual', 'NA', 'NA', 1, 'M1', 1),
(2, 'Remplisseuse', 'Automated', 'SERAC', 'R1V1', 1, 'Filler/Caper', 2),
(3, 'Laser bouteille', '', '', '', 0, '0', 0),
(4, 'Etiqueteuse bouteille', 'Automated', 'PE Labeler', 'XXX', 1, 'M2', 3),
(5, 'Encaisseuse', 'Manual', 'NA', 'NA', 1, 'M4', 5),
(6, 'Palettiseur', 'Manual', 'NA', 'NA', 1, 'M8', 9),
(7, 'Peseur de caisse', 'Automated', 'METTLER TOLEDO', 'MT-20', 1, 'M7', 8),
(8, 'Scelleur de caisse', 'Automated', 'LANTECH', 'CS-300', 1, 'M6', 7),
(9, 'Formeur de caisse', 'Semi-Auto', 'LANTECH', 'C-300', 1, 'M5', 6),
(10, 'Applicateur bouteille', 'Automated', 'SERAC', 'RX20', 1, 'M3', 4);

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
  `comment` text NOT NULL DEFAULT ' ',
  `kind` int(1) NOT NULL DEFAULT 0 COMMENT '0 : planned, 1 : unplanned'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_planned_events`
--

INSERT INTO `ole_planned_events` (`id`, `created_at`, `updated_at`, `OLE`, `productionline`, `reason`, `duration`, `comment`, `kind`) VALUES
(1, '2021-09-02 10:38:32', '2021-09-02 10:38:32', 'titi', 'F52', 'Reunion', 15, 'lala', 0),
(3, '2021-09-04 14:23:15', '2021-09-04 14:23:15', 'titi', 'F53', 'Pause', 1, 'lunch', 0),
(7, '2021-09-06 13:40:47', '2021-09-06 13:40:47', 'titi', 'F52', 'Pause', 30, 'Pause déjeuner', 0),
(8, '2021-09-06 13:41:21', '2021-09-06 13:41:21', 'titi', 'F52', 'Reunion', 45, 'lala', 0);

-- --------------------------------------------------------

--
-- Structure de la table `ole_pos`
--

CREATE TABLE `ole_pos` (
  `id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `number` varchar(50) NOT NULL,
  `GMID-Code` varchar(50) NOT NULL,
  `productionline_name` varchar(50) NOT NULL,
  `state` int(1) NOT NULL DEFAULT 1 COMMENT '0:a l''arret, 1:en cours',
  `totalOperatingTime` int(10) NOT NULL,
  `totalNetOperatingTime` int(10) NOT NULL,
  `Availability` float(5,2) NOT NULL,
  `Performance` float(5,2) NOT NULL,
  `Quality` float(5,2) NOT NULL,
  `OLE` float(5,2) NOT NULL,
  `qtyProduced` int(11) NOT NULL,
  `workingDuration` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_pos`
--

INSERT INTO `ole_pos` (`id`, `created_at`, `updated_at`, `number`, `GMID-Code`, `productionline_name`, `state`, `totalOperatingTime`, `totalNetOperatingTime`, `Availability`, `Performance`, `Quality`, `OLE`, `qtyProduced`, `workingDuration`) VALUES
(1, '2021-10-10 15:24:18', '0000-00-00 00:00:00', 'titi', '87507', 'F52', 0, 0, 0, 72.00, 64.00, 98.00, 78.00, 200, 0),
(2, '2021-10-10 15:24:27', '0000-00-00 00:00:00', 'toto', '87507', 'F52', 0, 0, 0, 1.00, 0.67, 1.00, 0.67, 100, 0),
(3, '2021-10-10 15:12:56', '2021-09-16 06:37:25', 't1', '335871', 'F53', 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0, 0),
(4, '2021-10-10 15:12:57', '2021-09-16 06:37:25', 't2', '335871', 'F53', 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0, 0),
(24, '2021-10-10 15:24:36', '2021-09-20 11:02:38', 'lala', '335871', 'F52', 1, 0, 0, 0.00, 0.00, 0.00, 0.00, 50, 0);

-- --------------------------------------------------------

--
-- Structure de la table `ole_productionline`
--

CREATE TABLE `ole_productionline` (
  `id` int(11) NOT NULL,
  `productionline_name` varchar(50) NOT NULL,
  `worksiteID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_productionline`
--

INSERT INTO `ole_productionline` (`id`, `productionline_name`, `worksiteID`) VALUES
(1, 'F52', 1),
(5, 'F53', 1);

-- --------------------------------------------------------

--
-- Structure de la table `ole_products`
--

CREATE TABLE `ole_products` (
  `id` int(11) NOT NULL,
  `product` varchar(150) NOT NULL,
  `GMID` varchar(50) NOT NULL,
  `size` varchar(20) NOT NULL,
  `idealRate` float(7,2) NOT NULL,
  `bottlesPerCase` int(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_products`
--

INSERT INTO `ole_products` (`id`, `product`, `GMID`, `size`, `idealRate`, `bottlesPerCase`) VALUES
(3, 'SUCCESSNATURALY BTLPE1X1GL USA', '87507', '4L', 20.00, 4),
(4, 'SUCCESSNATURALY BTLHPE4X1QT EN', '101223', '1L', 40.00, 12),
(5, 'CONSERVESC BTLHPE4X4X1QT USA', '124042', '1L', 40.00, 12),
(6, 'SUCCESS BTLHPE4X4X1L CAN', '138087', '1L', 40.00, 12),
(7, 'GF120NFBAIT BTLHPE4X1GL USA GF1111', '225830', '4L', 20.00, 4),
(8, 'GF120FFBAIT BTLHPE4X3.78L CAN GF1111', '275681', '4L', 20.00, 4),
(9, 'RADIANTSC BTLHPE4X1GL USA', '295528', '4L', 20.00, 4),
(10, 'RADIANTSC BTLHPE4X4X1QT USA', '295529', '1L', 40.00, 12),
(11, 'CONSERVESC BTLHPE4X4X1QT PRI', '335871', '1L', 40.00, 12),
(12, 'GF120NFNATURALYTEFFB BTLFPE4X4L PAK', '336953', '4L', 20.00, 4),
(13, 'ENTRUST BTLHPE12X1L CAN', '11039846', '1L', 40.00, 12),
(14, 'NATURALUREFLYBAIT BTLHPE2X10L AUS', '11045177', '10L', 10.00, 2),
(15, 'INTREPIDEDGE BTLHPE4X1GL USA', '11045655', '4L', 20.00, 4),
(16, 'SUCCESSNATURALYTE BTLHPE12X1QT USA', '97018444', '1L', 40.00, 12),
(17, 'ENTRUSTSC BTLHPE12X1QT USA', '97018807', '1L', 40.00, 12),
(18, 'RADIANTSC BTLHPE12X1QT USA', '97018841', '1L', 40.00, 12),
(19, 'RADIANTSC BTLHPE12X1QT PRI', '97019730', '1L', 40.00, 12),
(20, 'ENTRUSTSC BTLHPE12X1QT PRI', '97019823', '1L', 40.00, 12),
(21, 'MOZKILL120SC BTLHPE4X5L NGA', '99056786', '5L', 17.00, 4),
(22, 'ENTRUSTSC BTLHPE4X4X1QT PRI', '99059298', '1L', 40.00, 12),
(23, 'RADIANTSC BTLHPE4X4X1QT PRI', '99059340', '1L', 40.00, 12);

-- --------------------------------------------------------

--
-- Structure de la table `ole_rejection_counters`
--

CREATE TABLE `ole_rejection_counters` (
  `id` int(11) NOT NULL,
  `po` varchar(50) NOT NULL,
  `fillerCounter` int(11) NOT NULL,
  `caperCounter` int(11) NOT NULL,
  `labelerCounter` int(11) NOT NULL,
  `weightBoxCounter` int(11) NOT NULL,
  `fillerRejection` int(11) NOT NULL,
  `caperRejection` int(11) NOT NULL,
  `labelerRejection` int(11) NOT NULL,
  `weightBoxRejection` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_rejection_counters`
--

INSERT INTO `ole_rejection_counters` (`id`, `po`, `fillerCounter`, `caperCounter`, `labelerCounter`, `weightBoxCounter`, `fillerRejection`, `caperRejection`, `labelerRejection`, `weightBoxRejection`) VALUES
(1, 'titi', 0, 0, 0, 0, 0, 0, 0, 0),
(2, 'lala', 0, 0, 0, 0, 0, 0, 0, 0),
(3, 'toto', 0, 0, 0, 0, 0, 0, 0, 0);

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
  `comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_speed_losses`
--

INSERT INTO `ole_speed_losses` (`id`, `created_at`, `updated_at`, `OLE`, `productionline`, `duration`, `reason`, `comment`) VALUES
(3, '2021-09-15 15:07:04', '2021-09-15 15:07:04', 'titi', 'F53', 0, 'Reduced Rate At Filler', 'zizihz'),
(4, '2021-09-20 11:16:07', '2021-09-20 11:16:07', 'lala', 'F53', 0, 'Reduce Rate At An Other Machine', 'Commentaire'),
(5, '2021-10-02 13:50:50', '2021-10-02 13:50:50', 'titi', 'F52', 0, 'Filler Own Stoppage', 'lalalalala');

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
  `comment` text NOT NULL DEFAULT ' ',
  `type` varchar(255) NOT NULL DEFAULT 'Changement de lot',
  `kind` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ole_unplanned_event_changing_clients`
--

INSERT INTO `ole_unplanned_event_changing_clients` (`id`, `created_at`, `updated_at`, `OLE`, `productionline`, `predicted_duration`, `total_duration`, `lot_number`, `comment`, `type`, `kind`) VALUES
(1, '2021-09-21 19:04:36', '2021-09-02 09:20:42', 'toto', 'F52', 5, 25, 'ABC123', 'tata', 'Lot changing', 1);

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
  `comment` text NOT NULL DEFAULT ' ',
  `type` varchar(255) NOT NULL DEFAULT 'Changement de format',
  `kind` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `comment` text NOT NULL DEFAULT ' ',
  `productionline` varchar(50) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'CIP',
  `kind` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `comment` text CHARACTER SET utf8mb4 NOT NULL DEFAULT '\' \'',
  `type` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT 'Arret non planifie',
  `kind` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `teamInfo`
--

CREATE TABLE `teamInfo` (
  `id` int(11) NOT NULL,
  `workingDebut` varchar(10) NOT NULL,
  `workingEnd` varchar(10) NOT NULL,
  `type` varchar(4) NOT NULL,
  `worksite` int(11) NOT NULL,
  `state` int(1) NOT NULL DEFAULT 0 COMMENT '0: a l''arret, 1:en cours'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `teamInfo`
--

INSERT INTO `teamInfo` (`id`, `workingDebut`, `workingEnd`, `type`, `worksite`, `state`) VALUES
(1, '10', '18', 'A', 1, 0),
(2, '18', '02', 'B', 1, 0);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `login` varchar(25) NOT NULL,
  `password` varchar(25) NOT NULL,
  `assignement` int(11) NOT NULL COMMENT 'worksite assignment',
  `lastname` varchar(50) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `status` int(11) NOT NULL COMMENT '0 : opérateur\r\n1 : crew leader\r\n2 : admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `login`, `password`, `assignement`, `lastname`, `firstname`, `status`) VALUES
(1, 'thotrb', '1234', 1, 'Trubert', 'Thomas', 0),
(2, 'pieria', '', 1, 'Riant', 'Pierre', 1),
(3, 'minpas', '', 2, 'Minault', 'Pascal', 1);

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
(1, 'Cernay');

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
-- Index pour la table `ole_formulations`
--
ALTER TABLE `ole_formulations`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

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
-- AUTO_INCREMENT pour la table `ole_formulations`
--
ALTER TABLE `ole_formulations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `ole_machines`
--
ALTER TABLE `ole_machines`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `ole_planned_events`
--
ALTER TABLE `ole_planned_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `ole_pos`
--
ALTER TABLE `ole_pos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pour la table `ole_productionline`
--
ALTER TABLE `ole_productionline`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `ole_products`
--
ALTER TABLE `ole_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pour la table `ole_rejection_counters`
--
ALTER TABLE `ole_rejection_counters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `ole_speed_losses`
--
ALTER TABLE `ole_speed_losses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `ole_unplanned_event_changing_clients`
--
ALTER TABLE `ole_unplanned_event_changing_clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `ole_unplanned_event_changing_formats`
--
ALTER TABLE `ole_unplanned_event_changing_formats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `ole_unplanned_event_cips`
--
ALTER TABLE `ole_unplanned_event_cips`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `ole_unplanned_event_unplanned_downtimes`
--
ALTER TABLE `ole_unplanned_event_unplanned_downtimes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `teamInfo`
--
ALTER TABLE `teamInfo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `worksite`
--
ALTER TABLE `worksite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
