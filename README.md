# webserver 🛠️

[![Version](https://img.shields.io/github/package-json/v/koromerzhin/webserver)](CHANGELOG.md)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/koromerzhin/webserver/graphs/commit-activity)
[![Continuous Integration](https://github.com/koromerzhin/webserver/actions/workflows/ci.yml/badge.svg?branch=develop)](https://github.com/koromerzhin/webserver/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

> Stack web générique sur Docker Swarm : Redmine, Nextcloud, Jenkins,
> Mercure, Redis, MariaDB, Mailpit, phpMyAdmin, Portainer et Traefik,
> pilotée par [Task](https://taskfile.dev/).

## Services

| Service | Image | Accès |
| ------- | ----- | ----- |
| traefik | traefik:v3.7.14 | proxy.traefik.me (dashboard) |
| redmine | redmine:6.1.5 | redmine.traefik.me |
| nextcloud | nextcloud:32.0.15-apache | nextcloud.traefik.me |
| jenkins | jenkins/jenkins:2.586 | jenkins.traefik.me |
| mercure | dunglas/mercure:v1.1.2 | interne (/.well-known/mercure) |
| redis | redis:8.10.2 | interne |
| mariadb | mariadb:13.0.2 | interne (pas de port publié) |
| mailtest | axllent/mailpit:v1.31.5 | mailtest.traefik.me |
| phpmyadmin | phpmyadmin/phpmyadmin:5.2.3 | phpmyadmin.traefik.me |
| portainer | portainer/portainer-ce:2.45.2 | portainer.traefik.me |
| reverse | alpine:3.23 | certificats traefik.me (one-shot) |

Les frontaux sont sur le réseau `proxywebserver`, les backends sur
`serverwebserver` (gérés par la stack, voir `docker-compose.yml`).

## Prérequis

- [task](https://taskfile.dev/) et [Docker](https://docs.docker.com/) (mode Swarm)
- [Node.js](https://nodejs.org/) (version dans `.nvmrc`, `nvm use`) pour le lint
- `openssl` pour (re)générer le mot de passe du dashboard

## Installation

```sh
git clone --recursive https://github.com/koromerzhin/webserver.git webserver
cd webserver
npm ci
```

## Configuration

```sh
task env:init
```

Crée `.env` depuis `.env.example` (sans écraser l'existant), puis
éditez `.env` (jamais committé) : mots de passe, clés JWT Mercure
(`openssl rand -hex 32`) et surtout `ADVERTISEADDR`, qui **doit** être une
IP locale existante (`ip -4 addr show`) — sinon `docker swarm init`
échoue avec « must specify a listening address ».

Changez le mot de passe du dashboard Traefik (`admin` / `changeme` par défaut) :

```sh
task webserver:dashboard-password
```

Puis validez la configuration :

```sh
task env:validate
docker compose config --quiet
```

## Déploiement

```sh
task webserver:exec
```

Cela enchaîne : `.env` garanti → init Swarm → pull des images →
`docker stack deploy` → attente des 7 services → liste. Suivi au quotidien :

```sh
task webserver:ls
task webserver:waiting
task bash:mariadb   # shell dans un service (mariadb, redis, …)
```

## ⚠️ Usage local uniquement

Cette stack est calibrée pour un poste de développement : hub Mercure
ouvert (`ALLOW_ANONYMOUS`, CORS `*`), certificats `traefik.me` récupérés en
HTTP, dashboard Traefik protégé par un simple basic-auth. Ne l'exposez pas
telle quelle sur un réseau non maîtrisé.

## Aide

```sh
task --list
task help
task env:show
```

## Intégration continue

- `lint` : `npm ci` + `task lint:all`.
- `launch` : recrée `.env` depuis l'exemple et déploie la stack complète
  sur le runner — premier endroit où un secret vide ou une image cassée
  se voient (timeout `webserver:waiting`).

## 🤝 Contribution

Contributions, issues et demandes de fonctionnalités bienvenues :
[issues](https://github.com/koromerzhin/webserver/issues).

## 📝 Licence

Copyright © 2019 [koromerzhin](https://github.com/koromerzhin).
Projet sous licence [MIT](https://github.com/koromerzhin/webserver/blob/develop/LICENSE).

## ✨ Contributeurs

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/koromerzhin"><img src="https://avatars0.githubusercontent.com/u/308012?v=4" width="100px;" alt=""/><br /><sub><b>Le TOULLEC Martial</b></sub></a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/apps/mend-bolt-for-github"><img src="https://avatars.githubusercontent.com/in/16809?v=4" width="100px;" alt=""/><br /><sub><b>mend-bolt-for-github[bot]</b></sub></a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/apps/renovate"><img src="https://avatars.githubusercontent.com/in/2740?v=4" width="100px;" alt=""/><br /><sub><b>renovate[bot]</b></sub></a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/apps/dependabot"><img src="https://avatars.githubusercontent.com/in/29110?v=4" width="100px;" alt=""/><br /><sub><b>dependabot[bot]</b></sub></a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://www.mend.io/free-developer-tools/renovate/"><img src="https://avatars.githubusercontent.com/u/25180681?v=4" width="100px;" alt=""/><br /><sub><b>Mend Renovate</b></sub></a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
