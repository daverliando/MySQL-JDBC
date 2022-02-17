-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 17, 2022 at 03:11 AM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 7.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_hr`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `fc_get_new_salary` (`temp_salary` DECIMAL) RETURNS DECIMAL(10,0) NO SQL
BEGIN
	DECLARE
	result DECIMAL;

		IF(temp_salary BETWEEN 4000 AND 10000) THEN
			SET result:= temp_salary*1.15;
		ELSEIF(temp_salary BETWEEN 10000 AND 15000) THEN
			SET result:= temp_salary*1.12;
		ELSEIF(temp_salary BETWEEN 15000 AND 20000) THEN  
			SET result:= temp_salary*1.10;
		ELSE 
			SET result :=temp_salary*1.05;
		END IF;
	RETURN result;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `id` varchar(4) NOT NULL,
  `name` varchar(40) NOT NULL,
  `region` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`id`, `name`, `region`) VALUES
('AR', 'Argentina', 2),
('AU', 'Australia', 3),
('BE', 'Belgium', 1),
('BR', 'Brazil', 2),
('CA', 'Canada', 2),
('CH', 'Switzerland', 1),
('CN', 'China', 3),
('DE', 'Germany', 1),
('DK', 'Denmark', 1),
('EG', 'Egypt', 4),
('FR', 'France', 1),
('ID', 'Indonesia', 1),
('IL', 'Israel', 4),
('IN', 'India', 3),
('IT', 'Italy', 1),
('JP', 'Japan', 3),
('KW', 'Kuwait', 4),
('ML', 'Malaysia', 3),
('MX', 'Mexico', 2),
('NG', 'Nigeria', 4),
('NL', 'Netherlands', 1),
('SG', 'Singapore', 3),
('UK', 'United Kingdom', 1),
('US', 'United States of America', 2),
('ZM', 'Zambia', 4),
('ZW', 'Zimbabwe', 4);

--
-- Triggers `country`
--
DELIMITER $$
CREATE TRIGGER `tg_after_insert_country` AFTER INSERT ON `country` FOR EACH ROW BEGIN
UPDATE REGION
	SET count = (SELECT COUNT(*) FROM COUNTRY WHERE region= NEW.region)
WHERE id = NEW.region;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `id` int(4) NOT NULL,
  `name` varchar(30) NOT NULL,
  `manager` int(6) DEFAULT NULL,
  `location` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`id`, `name`, `manager`, `location`) VALUES
(10, 'Administration', 200, 1700),
(20, 'Marketing', 201, 1800),
(30, 'Purchasing', 114, 1700),
(40, 'Human Resources', 203, 2400),
(50, 'Shipping', 121, 1500),
(60, 'IT', 103, 1400),
(70, 'Public Relations', 204, 2700),
(80, 'Sales', 145, 2500),
(90, 'Executive', 100, 1700),
(100, 'Finance', 108, 1700),
(110, 'Accounting', 205, 1700),
(120, 'Treasury', NULL, 1700),
(130, 'Corporate Tax', NULL, 1700),
(140, 'Control And Credit', NULL, 1700),
(150, 'Shareholder Services', NULL, 1700),
(160, 'Benefits', NULL, 1700),
(170, 'Manufacturing', NULL, 1700),
(180, 'Construction', NULL, 1700),
(190, 'Contracting', NULL, 1700),
(200, 'Operations', NULL, 1700),
(210, 'IT Support', NULL, 1700),
(220, 'NOC', NULL, 1700),
(230, 'IT Helpdesk', NULL, 1700),
(240, 'Government Sales', NULL, 1700),
(250, 'Retail Sales', NULL, 1700),
(260, 'Recruiting', NULL, 1700),
(270, 'Payroll', NULL, 1700);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` int(6) NOT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(25) NOT NULL,
  `email` varchar(25) NOT NULL,
  `phone_number` varchar(13) DEFAULT NULL,
  `hire_date` date NOT NULL,
  `job` varchar(10) NOT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `comission_pct` decimal(10,2) DEFAULT NULL,
  `manager` int(6) DEFAULT NULL,
  `department` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_date`, `job`, `salary`, `comission_pct`, `manager`, `department`) VALUES
(100, 'Steven', 'King', 'SKING', '5151234567', '2003-06-17', 'AD_PRES', '9254.00', NULL, NULL, 90),
(101, 'Neena', 'Kochhar', 'NKOCHHAR', '5151234568', '2005-09-21', 'AD_VP', '17000.00', NULL, 100, 90),
(102, 'Lex', 'De Haan', 'LDEHAAN', '5151234569', '2001-01-13', 'AD_VP', '17000.00', NULL, 100, 90),
(103, 'Alexander', 'Hunold', 'AHUNOLD', '5904234567', '2006-01-03', 'IT_PROG', '9000.00', NULL, 102, 60),
(104, 'Bruce', 'Ernst', 'BERNST', '5904234568', '2007-07-21', 'IT_PROG', '6000.00', NULL, 103, 60),
(105, 'David', 'Austin', 'DAUSTIN', '5904234569', '2005-05-25', 'IT_PROG', '4800.00', NULL, 103, 60),
(106, 'Valli', 'Pataballa', 'VPATABAL', '5904234560', '2006-02-05', 'IT_PROG', '4800.00', NULL, 103, 60),
(107, 'Diana', 'Lorentz', 'DLORENTZ', '5904235567', '2007-02-07', 'IT_PROG', '4200.00', NULL, 103, 60),
(108, 'Nancy', 'Greenberg', 'NGREENBE', '5151244569', '2002-08-17', 'FI_MGR', '12008.00', NULL, 101, 100),
(109, 'Daniel', 'Faviet', 'DFAVIET', '5151244169', '2002-08-16', 'FI_ACCOUNT', '9000.00', NULL, 108, 100),
(110, 'John', 'Chen', 'JCHEN', '5151244269', '2005-09-28', 'FI_ACCOUNT', '8200.00', NULL, 108, 100),
(111, 'Ismael', 'Sciarra', 'ISCIARRA', '5151244369', '2005-09-30', 'FI_ACCOUNT', '7700.00', NULL, 108, 100),
(112, 'Jose Manuel', 'Urman', 'JMURMAN', '5151244469', '2006-03-07', 'FI_ACCOUNT', '7800.00', NULL, 108, 100),
(113, 'Luis', 'Popp', 'LPOPP', '5151244567', '2007-12-07', 'FI_ACCOUNT', '6900.00', NULL, 108, 100),
(114, 'Den', 'Raphaely', 'DRAPHEAL', '5151274561', '2002-12-07', 'PU_MAN', '11000.00', NULL, 100, 30),
(115, 'Alexander', 'Khoo', 'AKHOO', '5151274562', '2003-05-18', 'PU_CLERK', '3100.00', NULL, 114, 30),
(116, 'Shelli', 'Baida', 'SBAIDA', '5151274563', '2005-12-24', 'PU_CLERK', '2900.00', NULL, 114, 30),
(117, 'Sigal', 'Tobias', 'STOBIAS', '5151274564', '2005-07-24', 'PU_CLERK', '2800.00', NULL, 114, 30),
(118, 'Guy', 'Himuro', 'GHIMURO', '5151274565', '2006-11-15', 'PU_CLERK', '2600.00', NULL, 114, 30),
(119, 'Karen', 'Colmenares', 'KCOLMENA', '5151274566', '2007-08-10', 'PU_CLERK', '2500.00', NULL, 114, 30),
(120, 'Matthew', 'Weiss', 'MWEISS', '6501231234', '2004-07-18', 'ST_MAN', '8000.00', NULL, 100, 50),
(121, 'Adam', 'Fripp', 'AFRIPP', '6501232234', '2005-04-10', 'ST_MAN', '8200.00', NULL, 100, 50),
(122, 'Payam', 'Kaufling', 'PKAUFLIN', '6501233234', '2003-05-01', 'ST_MAN', '7900.00', NULL, 100, 50),
(123, 'Shanta', 'Vollman', 'SVOLLMAN', '6501234234', '2005-10-10', 'ST_MAN', '6500.00', NULL, 100, 50),
(124, 'Kevin', 'Mourgos', 'KMOURGOS', '6501235234', '2007-11-16', 'ST_MAN', '5800.00', NULL, 100, 50),
(125, 'Julia', 'Nayer', 'JNAYER', '6501241214', '2005-07-16', 'ST_CLERK', '3200.00', NULL, 120, 50),
(126, 'Irene', 'Mikkilineni', 'IMIKKILI', '6501241224', '2006-09-28', 'ST_CLERK', '2700.00', NULL, 120, 50),
(127, 'James', 'Landry', 'JLANDRY', '6501241334', '2007-01-14', 'ST_CLERK', '2400.00', NULL, 120, 50),
(128, 'Steven', 'Markle', 'SMARKLE', '6501241434', '2008-03-08', 'ST_CLERK', '2200.00', NULL, 120, 50),
(129, 'Laura', 'Bissot', 'LBISSOT', '6501245234', '2005-08-20', 'ST_CLERK', '3300.00', NULL, 121, 50),
(130, 'Mozhe', 'Atkinson', 'MATKINSO', '6501246234', '2005-10-30', 'ST_CLERK', '2800.00', NULL, 121, 50),
(131, 'James', 'Marlow', 'JAMRLOW', '6501247234', '2005-02-16', 'ST_CLERK', '2500.00', NULL, 121, 50),
(132, 'TJ', 'Olson', 'TJOLSON', '6501248234', '2007-04-10', 'ST_CLERK', '2100.00', NULL, 121, 50),
(133, 'Jason', 'Mallin', 'JMALLIN', '6501271934', '2004-06-14', 'ST_CLERK', '3300.00', NULL, 122, 50),
(134, 'Michael', 'Rogers', 'MROGERS', '6501271834', '2006-08-26', 'ST_CLERK', '2900.00', NULL, 122, 50),
(135, 'Ki', 'Gee', 'KGEE', '6501271734', '2007-12-12', 'ST_CLERK', '2400.00', NULL, 122, 50),
(136, 'Hazel', 'Philtanker', 'HPHILTAN', '6501271634', '2008-08-06', 'ST_CLERK', '2200.00', NULL, 122, 50),
(137, 'Renske', 'Ladwig', 'RLADWIG', '6501211234', '2003-07-14', 'ST_CLERK', '3600.00', NULL, 123, 50),
(138, 'Stephen', 'Stiles', 'SSTILES', '6501212034', '2005-10-26', 'ST_CLERK', '3200.00', NULL, 123, 50),
(139, 'John', 'Seo', 'JSEO', '6501212019', '2006-02-12', 'ST_CLERK', '2700.00', NULL, 123, 50),
(140, 'Joshua', 'Patel', 'JPATEL', '6501211834', '2006-04-06', 'ST_CLERK', '2500.00', NULL, 123, 50),
(141, 'Trenna', 'Rajs', 'TRAJS', '6501218009', '2003-10-17', 'ST_CLERK', '3500.00', NULL, 124, 50),
(142, 'Curtis', 'Davies', 'CDAVIES', '6501212994', '2005-01-29', 'ST_CLERK', '3100.00', NULL, 124, 50),
(143, 'Randall', 'Matos', 'RMATOS', '6501212874', '2006-03-15', 'ST_CLERK', '2600.00', NULL, 124, 50),
(144, 'Peter', 'Vargas', 'PVARGAS', '6501212004', '2006-07-09', 'ST_CLERK', '2500.00', NULL, 124, 50),
(145, 'John', 'Russell', 'JRUSSEL', '011.44.1344.4', '2004-10-01', 'SA_MAN', '14000.00', '0.40', 100, 80),
(146, 'Karen', 'Partners', 'KPARTNER', '011.44.1344.4', '2005-01-05', 'SA_MAN', '13500.00', '0.30', 100, 80),
(147, 'Alberto', 'Errazuriz', 'AERRAZUR', '011.44.1344.4', '2005-03-10', 'SA_MAN', '12000.00', '0.30', 100, 80),
(148, 'Gerald', 'Cambrault', 'GCAMBRAU', '011.44.1344.6', '2007-10-15', 'SA_MAN', '11000.00', '0.30', 100, 80),
(149, 'Eleni', 'Zlotkey', 'EZLOTKEY', '011.44.1344.4', '2008-01-29', 'SA_MAN', '10500.00', '0.20', 100, 80),
(150, 'Peter', 'Tucker', 'PTUCKER', '011.44.1344.1', '2005-01-30', 'SA_REP', '10000.00', '0.30', 145, 80),
(151, 'David', 'Bernstein', 'DBERNSTE', '011.44.1344.3', '2005-03-24', 'SA_REP', '9500.00', '0.25', 145, 80),
(152, 'Peter', 'Hall', 'PHALL', '011.44.1344.4', '2005-08-20', 'SA_REP', '9000.00', '0.25', 145, 80),
(153, 'Christopher', 'Olsen', 'COLSEN', '011.44.1344.4', '2006-03-30', 'SA_REP', '8000.00', '0.20', 145, 80),
(154, 'Nanette', 'Cambrault', 'NCAMBRAU', '011.44.1344.9', '2006-12-09', 'SA_REP', '7500.00', '0.20', 145, 80),
(155, 'Oliver', 'Tuvault', 'OTUVAULT', '011.44.1344.4', '2007-11-23', 'SA_REP', '7000.00', '0.15', 145, 80),
(156, 'Janette', 'King', 'JKING', '011.44.1345.4', '2004-01-30', 'SA_REP', '10000.00', '0.35', 146, 80),
(157, 'Patrick', 'Sully', 'PSULLY', '011.44.1345.9', '2004-03-04', 'SA_REP', '9500.00', '0.35', 146, 80),
(158, 'Allan', 'McEwen', 'AMCEWEN', '011.44.1345.8', '2004-08-01', 'SA_REP', '9000.00', '0.35', 146, 80),
(159, 'Lindsey', 'Smith', 'LSMITH', '011.44.1345.7', '2005-03-10', 'SA_REP', '8000.00', '0.30', 146, 80),
(160, 'Louise', 'Doran', 'LDORAN', '011.44.1345.6', '2005-12-15', 'SA_REP', '7500.00', '0.30', 146, 80),
(161, 'Sarath', 'Sewall', 'SSEWALL', '011.44.1345.5', '2006-11-03', 'SA_REP', '7000.00', '0.25', 146, 80),
(162, 'Clara', 'Vishney', 'CVISHNEY', '011.44.1346.1', '2005-11-11', 'SA_REP', '10500.00', '0.25', 147, 80),
(163, 'Danielle', 'Greene', 'DGREENE', '011.44.1346.2', '2007-03-19', 'SA_REP', '9500.00', '0.15', 147, 80),
(164, 'Mattea', 'Marvins', 'MMARVINS', '011.44.1346.3', '2008-01-24', 'SA_REP', '7200.00', '0.10', 147, 80),
(165, 'David', 'Lee', 'DLEE', '011.44.1346.5', '2008-02-23', 'SA_REP', '6800.00', '0.10', 147, 80),
(166, 'Sundar', 'Ande', 'SANDE', '011.44.1346.6', '2008-03-24', 'SA_REP', '6400.00', '0.10', 147, 80),
(167, 'Amit', 'Banda', 'ABANDA', '011.44.1346.7', '2008-04-21', 'SA_REP', '6200.00', '0.10', 147, 80),
(168, 'Lisa', 'Ozer', 'LOZER', '011.44.1343.9', '2005-03-11', 'SA_REP', '11500.00', '0.25', 148, 80),
(169, 'Harrison', 'Bloom', 'HBLOOM', '011.44.1343.8', '2006-03-23', 'SA_REP', '10000.00', '0.20', 148, 80),
(170, 'Tayler', 'Fox', 'TFOX', '011.44.1343.7', '2006-01-24', 'SA_REP', '9600.00', '0.20', 148, 80),
(171, 'William', 'Smith', 'WSMITH', '011.44.1343.6', '2007-02-23', 'SA_REP', '7400.00', '0.15', 148, 80),
(172, 'Elizabeth', 'Bates', 'EBATES', '011.44.1343.5', '2007-03-24', 'SA_REP', '7300.00', '0.15', 148, 80),
(173, 'Sundita', 'Kumar', 'SKUMAR', '011.44.1343.3', '2008-04-21', 'SA_REP', '6100.00', '0.10', 148, 80),
(174, 'Ellen', 'Abel', 'EABEL', '011.44.1644.4', '2004-05-11', 'SA_REP', '11000.00', '0.30', 149, 80),
(175, 'Alyssa', 'Hutton', 'AHUTTON', '011.44.1644.4', '2005-03-19', 'SA_REP', '8800.00', '0.25', 149, 80),
(176, 'Jonathon', 'Taylor', 'JTAYLOR', '011.44.1644.4', '2006-03-24', 'SA_REP', '8600.00', '0.20', 149, 80),
(177, 'Jack', 'Livingston', 'JLIVINGS', '011.44.1644.4', '2006-04-23', 'SA_REP', '8400.00', '0.20', 149, 80),
(178, 'Kimberely', 'Grant', 'KGRANT', '011.44.1644.4', '2007-05-24', 'SA_REP', '7000.00', '0.15', 149, NULL),
(179, 'Charles', 'Johnson', 'CJOHNSON', '011.44.1644.4', '2008-01-04', 'SA_REP', '6200.00', '0.10', 149, 80),
(180, 'Winston', 'Taylor', 'WTAYLOR', '6505079876', '2006-01-24', 'SH_CLERK', '3200.00', NULL, 120, 50),
(181, 'Jean', 'Fleaur', 'JFLEAUR', '6505079877', '2006-02-23', 'SH_CLERK', '3100.00', NULL, 120, 50),
(182, 'Martha', 'Sullivan', 'MSULLIVA', '6505079878', '2007-06-21', 'SH_CLERK', '2500.00', NULL, 120, 50),
(183, 'Girard', 'Geoni', 'GGEONI', '6505079879', '2008-02-03', 'SH_CLERK', '2800.00', NULL, 120, 50),
(184, 'Nandita', 'Sarchand', 'NSARCHAN', '6505091876', '2004-01-27', 'SH_CLERK', '4200.00', NULL, 121, 50),
(185, 'Alexis', 'Bull', 'ABULL', '6505092876', '2005-02-20', 'SH_CLERK', '4100.00', NULL, 121, 50),
(186, 'Julia', 'Dellinger', 'JDELLING', '6505093876', '2006-06-24', 'SH_CLERK', '3400.00', NULL, 121, 50),
(187, 'Anthony', 'Cabrio', 'ACABRIO', '6505094876', '2007-02-07', 'SH_CLERK', '3000.00', NULL, 121, 50),
(188, 'Kelly', 'Chung', 'KCHUNG', '6505051876', '2005-06-14', 'SH_CLERK', '3800.00', NULL, 122, 50),
(189, 'Jennifer', 'Dilly', 'JDILLY', '6505052876', '2005-08-13', 'SH_CLERK', '3600.00', NULL, 122, 50),
(190, 'Timothy', 'Gates', 'TGATES', '6505053876', '2006-07-11', 'SH_CLERK', '2900.00', NULL, 122, 50),
(191, 'Randall', 'Perkins', 'RPERKINS', '6505054876', '2007-12-19', 'SH_CLERK', '2500.00', NULL, 122, 50),
(192, 'Sarah', 'Bell', 'SBELL', '6505011876', '2004-02-04', 'SH_CLERK', '4000.00', NULL, 123, 50),
(193, 'Britney', 'Everett', 'BEVERETT', '6505012876', '2005-03-03', 'SH_CLERK', '3900.00', NULL, 123, 50),
(194, 'Samuel', 'McCain', 'SMCCAIN', '6505013876', '2006-07-01', 'SH_CLERK', '3200.00', NULL, 123, 50),
(195, 'Vance', 'Jones', 'VJONES', '6505014876', '2007-03-17', 'SH_CLERK', '2800.00', NULL, 123, 50),
(196, 'Alana', 'Walsh', 'AWALSH', '6505079811', '2006-04-24', 'SH_CLERK', '3100.00', NULL, 124, 50),
(197, 'Kevin', 'Feeney', 'KFEENEY', '6505079822', '2006-05-23', 'SH_CLERK', '3000.00', NULL, 124, 50),
(198, 'Donald', 'OConnell', 'DOCONNEL', '6505079833', '2007-06-21', 'SH_CLERK', '2600.00', NULL, 124, 50),
(199, 'Douglas', 'Grant', 'DGRANT', '6505079844', '2008-01-13', 'SH_CLERK', '2600.00', NULL, 124, 50),
(200, 'Jennifer', 'Whalen', 'JWHALEN', '5151234444', '2003-09-17', 'AD_ASST', '4400.00', NULL, 101, 10),
(201, 'Michael', 'Hartstein', 'MHARTSTE', '5151235555', '2004-04-17', 'MK_MAN', '13000.00', NULL, 100, 20),
(202, 'Pat', 'Fay', 'PFAY', '6031236666', '2005-08-17', 'MK_REP', '6000.00', NULL, 201, 20),
(203, 'Susan', 'Mavris', 'SMAVRIS', '5151237777', '2002-06-07', 'HR_REP', '6500.00', NULL, 101, 40),
(204, 'Hermann', 'Baer', 'HBAER', '5151238888', '2002-06-07', 'PR_REP', '10000.00', NULL, 101, 70),
(205, 'Shelley', 'Higgins', 'SHIGGINS', '5151238080', '2002-06-07', 'AC_MGR', '12008.00', NULL, 101, 110),
(206, 'William', 'Gietz', 'WGIETZ', '5151238181', '2002-06-07', 'AC_ACCOUNT', '8300.00', NULL, 205, 110);

-- --------------------------------------------------------

--
-- Table structure for table `job`
--

CREATE TABLE `job` (
  `id` varchar(10) NOT NULL,
  `title` varchar(35) NOT NULL,
  `min_salary` decimal(10,2) DEFAULT NULL,
  `max_salary` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `job`
--

INSERT INTO `job` (`id`, `title`, `min_salary`, `max_salary`) VALUES
('AC_ACCOUNT', 'Public Accountant', '4200.00', '9000.00'),
('AC_MGR', 'Accounting Manager', '8200.00', '16000.00'),
('AD_ASST', 'Administration Assistant', '3000.00', '6000.00'),
('AD_PRES', 'President', '20080.00', '40000.00'),
('AD_VP', 'Administration Vice President', '15000.00', '30000.00'),
('FI_ACCOUNT', 'Accountant', '4200.00', '9000.00'),
('FI_MGR', 'Finance Manager', '8200.00', '16000.00'),
('HR_REP', 'Human Resources Representative', '4000.00', '9000.00'),
('IT_PROG', 'Programmer', '4000.00', '10000.00'),
('MK_MAN', 'Marketing Manager', '9000.00', '15000.00'),
('MK_REP', 'Marketing Representative', '4000.00', '9000.00'),
('PR_REP', 'Public Relations Representative', '4500.00', '10500.00'),
('PU_CLERK', 'Purchasing Clerk', '2500.00', '5500.00'),
('PU_MAN', 'Purchasing Manager', '8000.00', '15000.00'),
('SA_MAN', 'Sales Manager', '10000.00', '20080.00'),
('SA_REP', 'Sales Representative', '6000.00', '12008.00'),
('SH_CLERK', 'Shipping Clerk', '2500.00', '5500.00'),
('ST_CLERK', 'Stock Clerk', '2008.00', '5000.00'),
('ST_MAN', 'Stock Manager', '5500.00', '8500.00');

-- --------------------------------------------------------

--
-- Table structure for table `job_history`
--

CREATE TABLE `job_history` (
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `employee` int(6) NOT NULL,
  `department` int(4) NOT NULL,
  `job` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `id` int(4) NOT NULL,
  `street_address` varchar(40) DEFAULT NULL,
  `postal_code` varchar(12) DEFAULT NULL,
  `city` varchar(30) NOT NULL,
  `state_province` varchar(25) DEFAULT NULL,
  `country` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`id`, `street_address`, `postal_code`, `city`, `state_province`, `country`) VALUES
(1000, '1297 Via Cola di Rie', '989', 'Roma', NULL, 'IT'),
(1100, '93091 Calle della Testa', '10934', 'Venice', NULL, 'IT'),
(1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP'),
(1300, '9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 'JP'),
(1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US'),
(1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US'),
(1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US'),
(1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US'),
(1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA'),
(1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA'),
(2000, '40-5-12 Laogianggen', '190518', 'Beijing', NULL, 'CN'),
(2100, '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN'),
(2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU'),
(2300, '198 Clementi North', '540198', 'Singapore', NULL, 'SG'),
(2400, '8204 Arthur St', NULL, 'London', NULL, 'UK'),
(2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK'),
(2600, '9702 Chester Road', '9629850293', 'Stretford', 'Manchester', 'UK'),
(2700, 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE'),
(2800, 'Rua Frei Caneca 1360', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR'),
(2900, '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH'),
(3000, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH'),
(3100, 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL'),
(3200, 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal,', 'MX');

-- --------------------------------------------------------

--
-- Table structure for table `region`
--

CREATE TABLE `region` (
  `id` int(5) NOT NULL,
  `name` varchar(25) NOT NULL,
  `count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `region`
--

INSERT INTO `region` (`id`, `name`, `count`) VALUES
(1, 'Europe', 9),
(2, 'Americas', 8),
(3, 'Asia', 0),
(4, 'Middle East and Africa', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`id`),
  ADD KEY `region` (`region`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`id`),
  ADD KEY `location` (`location`),
  ADD KEY `manager` (`manager`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `manager` (`manager`),
  ADD KEY `department` (`department`),
  ADD KEY `job` (`job`);

--
-- Indexes for table `job`
--
ALTER TABLE `job`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `job_history`
--
ALTER TABLE `job_history`
  ADD KEY `employee` (`employee`),
  ADD KEY `job_history_ibfk_2` (`department`),
  ADD KEY `job_history_ibfk_3` (`job`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`id`),
  ADD KEY `country` (`country`);

--
-- Indexes for table `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `region`
--
ALTER TABLE `region`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `country`
--
ALTER TABLE `country`
  ADD CONSTRAINT `country_ibfk_1` FOREIGN KEY (`region`) REFERENCES `region` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `department_ibfk_1` FOREIGN KEY (`location`) REFERENCES `location` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `department_ibfk_2` FOREIGN KEY (`manager`) REFERENCES `employee` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`manager`) REFERENCES `employee` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`department`) REFERENCES `department` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_ibfk_3` FOREIGN KEY (`job`) REFERENCES `job` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `job_history`
--
ALTER TABLE `job_history`
  ADD CONSTRAINT `job_history_ibfk_1` FOREIGN KEY (`employee`) REFERENCES `employee` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `job_history_ibfk_2` FOREIGN KEY (`department`) REFERENCES `department` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `job_history_ibfk_3` FOREIGN KEY (`job`) REFERENCES `job` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `location`
--
ALTER TABLE `location`
  ADD CONSTRAINT `location_ibfk_1` FOREIGN KEY (`country`) REFERENCES `country` (`id`) ON UPDATE CASCADE;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `update_salary` ON SCHEDULE EVERY '0:10' MINUTE_SECOND STARTS '2021-09-07 00:00:00' ENDS '2021-09-09 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
	UPDATE EMPLOYEE
	SET SALARY = fc_get_new_salary(SALARY)
	WHERE id = 100;
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
