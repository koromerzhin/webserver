CREATE DATABASE IF NOT EXISTS `redmine_bdd`;
CREATE USER IF NOT EXISTS 'redmine'@localhost IDENTIFIED BY 'passwordbdd';
GRANT ALL PRIVILEGES ON `redmine_bdd`.* TO 'redmine'@localhost;