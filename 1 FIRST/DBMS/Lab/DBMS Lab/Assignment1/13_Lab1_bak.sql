-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: kaushal_13_kk
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `dependents`
--

DROP TABLE IF EXISTS `dependents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dependents` (
  `Did` int NOT NULL,
  `Dname` varchar(255) DEFAULT NULL,
  `Dage` int DEFAULT NULL,
  `SSN` int DEFAULT NULL,
  `Drelation` char(50) DEFAULT NULL,
  PRIMARY KEY (`Did`),
  KEY `SSN` (`SSN`),
  CONSTRAINT `dependents_ibfk_1` FOREIGN KEY (`SSN`) REFERENCES `employee` (`SSN`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `age_constraint` CHECK ((`Dage` < 16))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dependents`
--

LOCK TABLES `dependents` WRITE;
/*!40000 ALTER TABLE `dependents` DISABLE KEYS */;
INSERT INTO `dependents` VALUES (1,'Ram Khatiwada',15,13,'Brother'),(2,'Sharmila Parajuli',11,NULL,'Sister'),(3,'Ryan Shrestha',9,2,'Brother'),(4,'Gopal Khatri',3,5,'Son');
/*!40000 ALTER TABLE `dependents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `SSN` int NOT NULL AUTO_INCREMENT,
  `Ename` varchar(255) NOT NULL,
  `Gender` char(1) DEFAULT NULL,
  `Bdate` date DEFAULT NULL,
  `Address` varchar(355) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT '0.00',
  `Ono` int DEFAULT NULL,
  `Years_of_experience` int DEFAULT NULL,
  PRIMARY KEY (`SSN`),
  KEY `Ono` (`Ono`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`Ono`) REFERENCES `office` (`Onumber`),
  CONSTRAINT `employee_chk_1` CHECK ((`Gender` in (_utf8mb4'M',_utf8mb4'F')))
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (2,'Raju Shrestha','M','1995-01-01','Kalimati',50000.00,2,5),(3,'Bipin Maharjan','M','1994-08-12','Kirtipur',40000.00,5,2),(4,'Rishi Pradhananga','M','1990-10-21','Anamnagar',60000.00,4,8),(5,'Dipen Khatri','M','1993-02-07','Pepsicola',58000.00,3,10),(13,'Kaushal Khatiwada','M','1996-10-28','Kaushaltar',30000.00,6,6);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office`
--

DROP TABLE IF EXISTS `office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `office` (
  `Onumber` int NOT NULL,
  `Oname` varchar(255) NOT NULL,
  `Country` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Onumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `office`
--

LOCK TABLES `office` WRITE;
/*!40000 ALTER TABLE `office` DISABLE KEYS */;
INSERT INTO `office` VALUES (1,'C8I','Nepal'),(2,'Cypher Technology','Nepal'),(3,'Visec Technology','India'),(4,'Dell Technology','USA'),(5,'Info Developer','Nepal'),(6,'Kaushal_Office_13','Nepal'),(13,'Kaushal_Ncell_13','Nepal');
/*!40000 ALTER TABLE `office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `Pnumber` int NOT NULL,
  `Pname` varchar(40) NOT NULL,
  `Proj_location` varchar(40) DEFAULT NULL,
  `Onumber` int DEFAULT NULL,
  PRIMARY KEY (`Pnumber`),
  UNIQUE KEY `Pname` (`Pname`),
  KEY `fk_pro` (`Onumber`),
  CONSTRAINT `fk_pro` FOREIGN KEY (`Onumber`) REFERENCES `office` (`Onumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES (1,'SaaS Product Deployment','Satdobato',1),(2,'HCI Deployment','Kupondole',2),(3,'Sever Protection','Bangalore',3),(4,'Dell R740 Resouce Upgradation','New York',4),(5,'Payment Feature Addition','Sanepa',5),(13,'Kaushal_ProjMDS','Kaushaltar',6);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `works_on`
--

DROP TABLE IF EXISTS `works_on`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `works_on` (
  `ESSN` int DEFAULT NULL,
  `Pno` int DEFAULT NULL,
  KEY `ESSN` (`ESSN`),
  KEY `Pno` (`Pno`),
  CONSTRAINT `works_on_ibfk_1` FOREIGN KEY (`ESSN`) REFERENCES `employee` (`SSN`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `works_on_ibfk_2` FOREIGN KEY (`Pno`) REFERENCES `project` (`Pnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `works_on`
--

LOCK TABLES `works_on` WRITE;
/*!40000 ALTER TABLE `works_on` DISABLE KEYS */;
INSERT INTO `works_on` VALUES (2,2),(3,5),(4,4),(5,3),(13,13);
/*!40000 ALTER TABLE `works_on` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-30 20:03:14
