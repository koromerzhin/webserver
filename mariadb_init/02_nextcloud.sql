CREATE DATABASE IF NOT EXISTS `nextcloud_bdd`;
CREATE USER IF NOT EXISTS 'nextcloud'@localhost IDENTIFIED BY 'passwordbdd';
GRANT ALL PRIVILEGES ON `nextcloud_bdd`.* TO 'nextcloud'@localhost;