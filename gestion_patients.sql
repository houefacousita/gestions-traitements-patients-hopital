-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  lun. 16 mai 2022 à 19:40
-- Version du serveur :  5.7.24
-- Version de PHP :  7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `gestion_patients`
--

-- --------------------------------------------------------

--
-- Structure de la table `allergie`
--

DROP TABLE IF EXISTS `allergie`;
CREATE TABLE IF NOT EXISTS `allergie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numdossier` int(11) NOT NULL,
  `nummed` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `numdossier` (`numdossier`),
  KEY `nummed` (`nummed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `dose`
--

DROP TABLE IF EXISTS `dose`;
CREATE TABLE IF NOT EXISTS `dose` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numord` int(11) NOT NULL,
  `nummed` int(11) NOT NULL,
  `posologie` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `numord` (`numord`),
  KEY `nummed` (`nummed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `maladie`
--

DROP TABLE IF EXISTS `maladie`;
CREATE TABLE IF NOT EXISTS `maladie` (
  `nummal` int(11) NOT NULL AUTO_INCREMENT,
  `nommal` varchar(255) NOT NULL,
  PRIMARY KEY (`nummal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `maladie_diagnostique`
--

DROP TABLE IF EXISTS `maladie_diagnostique`;
CREATE TABLE IF NOT EXISTS `maladie_diagnostique` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numtrait` int(11) NOT NULL,
  `nummal` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `numtrait` (`numtrait`),
  KEY `nummal` (`nummal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `maladie_traite`
--

DROP TABLE IF EXISTS `maladie_traite`;
CREATE TABLE IF NOT EXISTS `maladie_traite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numtrait` int(11) NOT NULL,
  `matmed` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `numtrait` (`numtrait`),
  KEY `matmed` (`matmed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `medecin`
--

DROP TABLE IF EXISTS `medecin`;
CREATE TABLE IF NOT EXISTS `medecin` (
  `matmed` int(11) NOT NULL AUTO_INCREMENT,
  `nommedecin` varchar(255) NOT NULL,
  PRIMARY KEY (`matmed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `medicament`
--

DROP TABLE IF EXISTS `medicament`;
CREATE TABLE IF NOT EXISTS `medicament` (
  `nummed` int(11) NOT NULL AUTO_INCREMENT,
  `nommed` varchar(255) NOT NULL,
  PRIMARY KEY (`nummed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `ordonnance`
--

DROP TABLE IF EXISTS `ordonnance`;
CREATE TABLE IF NOT EXISTS `ordonnance` (
  `numord` int(11) NOT NULL AUTO_INCREMENT,
  `numdossier` int(11) NOT NULL,
  `numrdv` int(11) NOT NULL,
  `matmed` int(11) NOT NULL,
  `numtrait` int(11) NOT NULL,
  `datord` timestamp NOT NULL,
  PRIMARY KEY (`numord`),
  KEY `numdossier` (`numdossier`),
  KEY `numrdv` (`numrdv`),
  KEY `matmed` (`matmed`),
  KEY `numtrait` (`numtrait`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `patient`
--

DROP TABLE IF EXISTS `patient`;
CREATE TABLE IF NOT EXISTS `patient` (
  `numdossier` int(11) NOT NULL AUTO_INCREMENT,
  `nompatient` varchar(255) NOT NULL,
  `sexepatient` char(1) NOT NULL,
  PRIMARY KEY (`numdossier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `rdv`
--

DROP TABLE IF EXISTS `rdv`;
CREATE TABLE IF NOT EXISTS `rdv` (
  `numrdv` int(11) NOT NULL AUTO_INCREMENT,
  `datrdv` timestamp NOT NULL,
  `numtrait` int(11) NOT NULL,
  PRIMARY KEY (`numrdv`),
  KEY `numtrait` (`numtrait`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `soin`
--

DROP TABLE IF EXISTS `soin`;
CREATE TABLE IF NOT EXISTS `soin` (
  `codsoin` int(11) NOT NULL AUTO_INCREMENT,
  `libsoin` varchar(255) NOT NULL,
  `coutsoin` decimal(10,0) NOT NULL,
  PRIMARY KEY (`codsoin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `soin_programme`
--

DROP TABLE IF EXISTS `soin_programme`;
CREATE TABLE IF NOT EXISTS `soin_programme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numrdv` int(11) NOT NULL,
  `codsoin` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `numrdv` (`numrdv`),
  KEY `codsoin` (`codsoin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `traitement`
--

DROP TABLE IF EXISTS `traitement`;
CREATE TABLE IF NOT EXISTS `traitement` (
  `numtrait` int(11) NOT NULL AUTO_INCREMENT,
  `dattrait` timestamp NOT NULL,
  `numdossier` int(11) NOT NULL,
  PRIMARY KEY (`numtrait`),
  KEY `numdossier` (`numdossier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `allergie`
--
ALTER TABLE `allergie`
  ADD CONSTRAINT `allergie_medicament_nummed` FOREIGN KEY (`nummed`) REFERENCES `medicament` (`nummed`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `allergie_patient_numdossier` FOREIGN KEY (`numdossier`) REFERENCES `patient` (`numdossier`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dose`
--
ALTER TABLE `dose`
  ADD CONSTRAINT `dose_medicament_nummed` FOREIGN KEY (`nummed`) REFERENCES `medicament` (`nummed`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dose_ordonnance_numord` FOREIGN KEY (`numord`) REFERENCES `ordonnance` (`numord`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `maladie_diagnostique`
--
ALTER TABLE `maladie_diagnostique`
  ADD CONSTRAINT `maladie_diagnostique_maladie_nummal` FOREIGN KEY (`nummal`) REFERENCES `maladie` (`nummal`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `maladie_diagnostique_traitement_numtrait` FOREIGN KEY (`numtrait`) REFERENCES `traitement` (`numtrait`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `maladie_traite`
--
ALTER TABLE `maladie_traite`
  ADD CONSTRAINT `maladie_traite_medecin_matmed` FOREIGN KEY (`matmed`) REFERENCES `medecin` (`matmed`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `maladie_traite_traitement_numtrait` FOREIGN KEY (`numtrait`) REFERENCES `traitement` (`numtrait`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `ordonnance`
--
ALTER TABLE `ordonnance`
  ADD CONSTRAINT `ordonnance_medecin_matmed` FOREIGN KEY (`matmed`) REFERENCES `medecin` (`matmed`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ordonnance_patient_numdossier` FOREIGN KEY (`numdossier`) REFERENCES `patient` (`numdossier`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ordonnance_rdv_numrdv` FOREIGN KEY (`numrdv`) REFERENCES `rdv` (`numrdv`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ordonnance_traitement_numtrait` FOREIGN KEY (`numtrait`) REFERENCES `traitement` (`numtrait`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rdv`
--
ALTER TABLE `rdv`
  ADD CONSTRAINT `rdv_traitement_numtrait` FOREIGN KEY (`numtrait`) REFERENCES `traitement` (`numtrait`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `soin_programme`
--
ALTER TABLE `soin_programme`
  ADD CONSTRAINT `soin_programme_rdv_numrdv` FOREIGN KEY (`numrdv`) REFERENCES `rdv` (`numrdv`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `soin_programme_soin_codsoin` FOREIGN KEY (`codsoin`) REFERENCES `soin` (`codsoin`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `traitement`
--
ALTER TABLE `traitement`
  ADD CONSTRAINT `traitement_patient_numdossier` FOREIGN KEY (`numdossier`) REFERENCES `patient` (`numdossier`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
