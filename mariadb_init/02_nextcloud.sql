-- Seed versionné : doit correspondre à MYSQL_PASSWORD du `.env`
-- au premier démarrage (changez les deux ensemble).
CREATE DATABASE IF NOT EXISTS `nextcloud_bdd`;
CREATE USER IF NOT EXISTS 'nextcloud'@'%' IDENTIFIED BY 'change_me_nextcloud';
GRANT ALL PRIVILEGES ON `nextcloud_bdd`.* TO 'nextcloud'@'%';