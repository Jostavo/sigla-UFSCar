# Sistema de Gerenciamento de Laboratórios (SiGLa)

[![CircleCI](https://circleci.com/gh/Darkkgreen/sigla-UFSCar/tree/master.svg?style=svg)](https://circleci.com/gh/Darkkgreen/sigla-UFSCar/tree/master)
---
Project installed at Federal University of São Carlos - Sorocaba, for the following courses `Interface Humano Computador (IHC)` and `Projeto de Desenvolvimento de Software (PDS)`.

The system manages computer labs checking its availability and the current status (if it's occurring a class or if it is closed) displaying all computers' status in a laboratory's map. It is possible to report damage computers and create requests to install new software.

---

### Technologies
<details>
    <summary>
    HTTP Server
    </summary>
    
> Application responsible to serve the main's page and the dashboard which shows all the information related to laboratories and user's access (using biometric fingerprint). 

- Ruby 2.6.3;
- Rails 5.0;
    - Bootstrap;
    - Fullpage.js;
- PostgreSQL;

</details>

<details>
    <summary>
Fingerprint Client/Server (/tools/digital_matcher)
    </summary>
    
> Application to enroll fingerprint registration and access. Using with libfprint for Microsoft Fingerprint 1033. Only tested with Ubuntu distribution, but it should works in others Linux environments. [[video](https://youtu.be/69XO-Iv9SG0)]

- C++;
- Libfprint;
- JsonCpp;
</details>

---

### How to run the HTTP Server?
```sh
docker-compose run rails db:create db:seed
docker-compose up --build
```
---

### Contribuitors:
- [@automagically](https://github.com/automagically)
- [@byandreee](https://github.com/byandreee)
- [@eiguike](https://github.com/eiguike)
- [@Darkkgreen](https://github.com/Darkkgreen)
