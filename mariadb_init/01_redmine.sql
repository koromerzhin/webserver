CREATE DATABASE IF NOT EXISTS `redmine_bdd`;
CREATE USER IF NOT EXISTS 'redmine'@'%' IDENTIFIED BY 'passwordbdd';
GRANT ALL PRIVILEGES ON `redmine_bdd`.* TO 'redmine'@'%';