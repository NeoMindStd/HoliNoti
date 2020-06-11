CREATE TABLE `facility` (
  `code` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(255),
  `phone_number` char(30),
  `site_url` VARCHAR(255),
  `comment` VARCHAR(255),
  `opening_info` VARCHAR(255),
  `coordinates` POINT NOT NULL,
  FULLTEXT FULLTEXT_ADDRESS(`address`),
  FULLTEXT FULLTEXT_NAME(`name`),
  SPATIAL SPATIAL_COORD(`coordinates`)
);

CREATE TABLE `facility_image` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `file_name` varchar(255) NOT NULL,
  `facility_code` int NOT NULL
);

CREATE TABLE `user` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `account` varchar(20)	NOT NULL UNIQUE,
  `password` blob(20) NOT NULL,
  `name` varchar(255),
  `authority` SET('admin', 'normal') NOT NULL,
  `email` varchar(255),
  `phone_number` char(30)
);

CREATE TABLE `relation_af` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `facility_code` int NOT NULL,
  `role` SET('supervisor', 'manager', 'customer') NOT NULL
);