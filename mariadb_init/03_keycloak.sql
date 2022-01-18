CREATE DATABASE IF NOT EXISTS `keycloak_bdd`;
CREATE USER IF NOT EXISTS 'keycloak'@localhost IDENTIFIED BY 'passwordbdd';
GRANT ALL PRIVILEGES ON `keycloak_bdd`.* TO 'keycloak'@localhost;