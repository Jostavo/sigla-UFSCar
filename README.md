# Sistema de Gerenciamento de Laboratórios (SiGLa)

[![CircleCI](https://circleci.com/gh/Darkkgreen/sigla-UFSCar/tree/master.svg?style=svg)](https://circleci.com/gh/Darkkgreen/sigla-UFSCar/tree/master)
---
Projeto realizado na Universidade Federal de São Carlos - Sorocaba, nas matérias de `Projeto de Desenvolvimento de Software (PDS)` e `Interface Humano Computador (IHC)`.

O sistema consiste no gerenciamento dos laboratórios de informática, verificando a disponibilidade do mesmo e das máquinas a partir de um mapa do laboratório, o status do laboratório (a disponibilidade, se atualmente está ocorrendo aula ou monitoria), report de máquinas danificadas e requisição de instalação de software para utilização.

O serviço está disponível no `Heroku`, você pode acessar através deste link:
https://siglaufscar.herokuapp.com

### Como rodar?
> $ docker-compose build

> $ docker-compose run --service-ports db

> $ docker-compose run rails db:create db:seed

> $ docker-compose up --build

### Colaboradores do Projeto:
- [@automagically](https://github.com/automagically)
- [@byandreee](https://github.com/byandreee)
- [@eiguike](https://github.com/eiguike)
- [@Darkkgreen](https://github.com/Darkkgreen)
