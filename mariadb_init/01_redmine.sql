-- Seed versionné : doit correspondre à REDMINE_DB_PASSWORD du `.env`
-- au premier démarrage (changez les deux ensemble, jamais de vrai
-- secret ici autre qu'un placeholder).
CREATE DATABASE IF NOT EXISTS `redmine_bdd`;
CREATE USER IF NOT EXISTS 'redmine'@'%' IDENTIFIED BY 'change_me_redmine';
GRANT ALL PRIVILEGES ON `redmine_bdd`.* TO 'redmine'@'%';