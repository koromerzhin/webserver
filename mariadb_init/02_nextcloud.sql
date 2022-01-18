CREATE DATABASE IF NOT EXISTS `nextcloud_bdd`;
CREATE USER IF NOT EXISTS 'nextcloud'@'%' IDENTIFIED BY 'passwordbdd';
GRANT ALL PRIVILEGES ON `nextcloud_bdd`.* TO 'nextcloud'@'%';