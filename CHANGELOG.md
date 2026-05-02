## [2.7.1](https://github.com/northcutted/resume/compare/v2.7.0...v2.7.1) (2026-05-02)


### Bug Fixes

* accept linkedin 999 status code in link checker ([ce86106](https://github.com/northcutted/resume/commit/ce86106cde85655dfda74eb3079d7c3d3999546c))

# [2.7.0](https://github.com/northcutted/resume/compare/v2.6.2...v2.7.0) (2026-05-02)


### Features

* replace attest-build-provenance with slsa-framework/slsa-github-generator for true SLSA L3 artifact provenance ([8702d89](https://github.com/northcutted/resume/commit/8702d8954af8445cc7c12b65a50862cf9cf19522))

## [2.6.2](https://github.com/northcutted/resume/compare/v2.6.1...v2.6.2) (2026-05-02)


### Bug Fixes

* prevent deploy/release skip when build-image is skipped ([52ac2a1](https://github.com/northcutted/resume/commit/52ac2a1503f2abb7467d5cc0affc55e7347a56dd))
* update resume ([d8dfec9](https://github.com/northcutted/resume/commit/d8dfec9ca367073bb17bc93f31eb10f12345013f))
* wording fixes ([94e753e](https://github.com/northcutted/resume/commit/94e753e4bbef6b35bbbb35e8a9953b1f75a114f1))

## [2.6.1](https://github.com/northcutted/resume/compare/v2.6.0...v2.6.1) (2026-04-05)


### Bug Fixes

* update Dockerfile base image and resume URL ([577aca4](https://github.com/northcutted/resume/commit/577aca47a4393ad5ef353fa6b9ddb437a81a2ef6))

# [2.6.0](https://github.com/northcutted/resume/compare/v2.5.1...v2.6.0) (2026-04-05)


### Bug Fixes

* add missing permissions for id-token in CI workflow ([08c5e51](https://github.com/northcutted/resume/commit/08c5e51babcdfb398a7ae1f53160e9917ce5d1ba))
* add zip package to Dockerfile dependencies ([5bf52c1](https://github.com/northcutted/resume/commit/5bf52c1c69dbb4315b2dc4fd682888555e00371f))
* Q2 2026 Updates ([d3abf9f](https://github.com/northcutted/resume/commit/d3abf9fc8e50066df872cc6b4ad8f93956146ccf))
* update builder image to alpine and streamline dependencies in Dockerfile ([9318435](https://github.com/northcutted/resume/commit/9318435d1dbb54e4cbe1ae519e884faa7ca35a9f))


### Features

* enhance CI/CD workflows with SLSA v3 support and artifact signing ([b94f5d6](https://github.com/northcutted/resume/commit/b94f5d644b185bfdea5cf68b8d7eb9d891de1fc4))

## [2.5.1](https://github.com/northcutted/resume/compare/v2.5.0...v2.5.1) (2026-01-02)


### Bug Fixes

* wording ([29bfd07](https://github.com/northcutted/resume/commit/29bfd07d5f894f13f61f995beffa40027fe57c98))

# [2.5.0](https://github.com/northcutted/resume/compare/v2.4.4...v2.5.0) (2025-12-08)


### Bug Fixes

* add error handling for container engine detection and improve build script output ([61ba9b8](https://github.com/northcutted/resume/commit/61ba9b8c9b80051344850352b67773ac2ffc7916))
* add SBOM generation steps and update README with SBOM badge ([75035d9](https://github.com/northcutted/resume/commit/75035d979c2c868a697006bec27f32ac6eae6d76))
* correct argument formatting in link checker configuration ([cdfd4bb](https://github.com/northcutted/resume/commit/cdfd4bbe0b09daad68e4450b013a611b708dd044))
* correct argument formatting in link checker configuration ([3ad10b3](https://github.com/northcutted/resume/commit/3ad10b316df6bff79cd8348bf4e01a4dd5c27bcc))
* enhance CI/CD workflow with image existence check and dynamic Docker tagging ([5aca457](https://github.com/northcutted/resume/commit/5aca4575e5a0a4ee4fa1cfa061fc07a9d78a39a0))
* remove mail exclusion from link checker arguments ([92de675](https://github.com/northcutted/resume/commit/92de675192947bb454ec5451798f4ae198d9d56f))
* update CI/CD workflow to support dynamic Docker tagging and improve image build dependencies ([534a711](https://github.com/northcutted/resume/commit/534a711eebc9712458920cb2dabd2911a9626488))
* update Docker change detection logic in CI workflow ([4adcc7a](https://github.com/northcutted/resume/commit/4adcc7a1e8af68e9a65f1641b62efa6f395b4cf3))
* update link checker arguments to include specific status codes ([bad63ea](https://github.com/northcutted/resume/commit/bad63eaddfb67bf952082b9dd4dcd8b0c333853c))
* update markdown linting rules, enhance README formatting, and improve resume generation script output ([92ac09c](https://github.com/northcutted/resume/commit/92ac09c19c2522aed34db5236bb571e6dad82c8a))
* update paths-filter configuration to improve Dockerfile detection ([958a068](https://github.com/northcutted/resume/commit/958a068eec70473592bdc1488cd9ea08ccc63711))
* update workflow actions and improve theme styles for better print layout ([3b431da](https://github.com/northcutted/resume/commit/3b431dabc85275fdc2da8f5786780afa9cd8cb67))


### Features

* :boom: JSON Resume Schema overhaul ([627a11d](https://github.com/northcutted/resume/commit/627a11d17db409114c3a2dacddb34139ae275fe3))
* add cleanup workflow for closed pull requests and remove redundant footer in build script ([3f55401](https://github.com/northcutted/resume/commit/3f55401a468a2832f2ef488765fa6134abd7296a))
* enhance GitHub Actions workflows for PR previews and builds ([4979c9f](https://github.com/northcutted/resume/commit/4979c9fa68a875f001a7142f675cf66f0a37597f))
* update dependencies and add HTML to PDF conversion script ([30a9e6f](https://github.com/northcutted/resume/commit/30a9e6f3805e5b7310bef7b22cc3988879f0868a))

## [2.4.4](https://github.com/northcutted/resume/compare/v2.4.3...v2.4.4) (2025-12-07)

### Bug Fixes

- update GitHub Actions and dependencies; enhance footer styles across themes ([515882c](https://github.com/northcutted/resume/commit/515882c4481e4d9873b41a94058c6dcc3fc0c080))

## [2.4.3](https://github.com/northcutted/resume/compare/v2.4.2...v2.4.3) (2025-12-04)

### Bug Fixes

- typ0 ([2113bcb](https://github.com/northcutted/resume/commit/2113bcba08659304e71e6d6f699c5e623ff8cb60))

## [2.4.2](https://github.com/northcutted/resume/compare/v2.4.1...v2.4.2) (2025-12-04)

### Bug Fixes

- typ0 ([1021365](https://github.com/northcutted/resume/commit/10213659d6c31788c588d0bfed4689b0592a3b0b))

## [2.4.1](https://github.com/northcutted/resume/compare/v2.4.0...v2.4.1) (2025-12-04)

### Bug Fixes

- clarify achievements and responsibilities in resume ([37fba24](https://github.com/northcutted/resume/commit/37fba2475390248bffbb743a5577fc0aaa90f03b))

# [2.4.0](https://github.com/northcutted/resume/compare/v2.3.0...v2.4.0) (2025-12-04)

### Features

- winter updates and add theme support ([10be228](https://github.com/northcutted/resume/commit/10be228e731ad3fd71b6eed02e10e8d3f24438f1))

# [2.3.0](https://github.com/northcutted/resume/compare/v2.2.2...v2.3.0) (2025-07-03)

### Features

- add new role to resume and update skills ([3ef119d](https://github.com/northcutted/resume/commit/3ef119d61678864d5161c65cf22fb06a941079b2))

## [2.2.2](https://github.com/northcutted/resume/compare/v2.2.1...v2.2.2) (2023-07-16)

### Bug Fixes

- hardcode url so that it goes back to original repo ([ae394fc](https://github.com/northcutted/resume/commit/ae394fc123adc7bd309502f68098e91898e0de8f))

## [2.2.1](https://github.com/northcutted/resume/compare/v2.2.0...v2.2.1) (2023-07-16)

### Bug Fixes

- add blurb about seeing how the resume was built with a link to the repo ([7966415](https://github.com/northcutted/resume/commit/7966415f7be92e1fe83e983cfb6a786d05e0b08c))

# [2.2.0](https://github.com/northcutted/resume/compare/v2.1.1...v2.2.0) (2023-07-16)

### Bug Fixes

- update deployment workflow to use ci image instead of installing dependencies each time ([165f22b](https://github.com/northcutted/resume/commit/165f22b69b4d52b08c741adac5fd118c379aaedd))

### Features

- add ci image to speed up pipeline ([bf00aa8](https://github.com/northcutted/resume/commit/bf00aa8a4f8cb193067386af1727aa861fbe5cd8))

## [2.1.1](https://github.com/northcutted/resume/compare/v2.1.0...v2.1.1) (2023-07-16)

### Bug Fixes

- remove duplicate information ([e9ac8c4](https://github.com/northcutted/resume/commit/e9ac8c48fd1c5a33111b6566d4504d1d8dd22f9e))

# [2.1.0](https://github.com/northcutted/resume/compare/v2.0.3...v2.1.0) (2023-07-16)

### Features

- remove need to maintain two resume files ([2268d6d](https://github.com/northcutted/resume/commit/2268d6d3c206ced87bf457386e443dac476ba647))

## [2.0.3](https://github.com/northcutted/resume/compare/v2.0.2...v2.0.3) (2023-07-16)

### Bug Fixes

- formatting ([c538380](https://github.com/northcutted/resume/commit/c538380e986607a06c31dfcadad63f8555df59b6))

## [2.0.2](https://github.com/northcutted/resume/compare/v2.0.1...v2.0.2) (2023-07-16)

### Bug Fixes

- update headers ([6043011](https://github.com/northcutted/resume/commit/604301134eda81a666e39c8ad0e8e0f984f27b20))

## [2.0.1](https://github.com/northcutted/resume/compare/v2.0.0...v2.0.1) (2023-07-16)

### Bug Fixes

- update formatting ([ec4d936](https://github.com/northcutted/resume/commit/ec4d936bb7a8c8d8b24c8550f79a5c2b5ac59126))

# [2.0.0](https://github.com/northcutted/resume/compare/v1.2.0...v2.0.0) (2023-07-16)

### Bug Fixes

- fix link to generated pdf ([d7f531a](https://github.com/northcutted/resume/commit/d7f531a2b351ab0497840a4164d4375b67a5ebb9))

### Features

- Render pdf documents ([0c3e1a7](https://github.com/northcutted/resume/commit/0c3e1a7096e6a350479017886d065eb3106aac1b))

### BREAKING CHANGES

- Entire impl change

# [1.2.0](https://github.com/northcutted/resume/compare/v1.1.0...v1.2.0) (2023-07-15)

### Features

- resume updates ([576dc88](https://github.com/northcutted/resume/commit/576dc883aebd8ee596b188ce3e0c918d651d09cd))

# [1.1.0](https://github.com/northcutted/resume/compare/v1.0.1...v1.1.0) (2023-07-15)

### Features

- update resume text ([fd141e5](https://github.com/northcutted/resume/commit/fd141e5dc034de1eb88bdc7a1a6380dd9e4e7d90))

## [1.0.1](https://github.com/northcutted/resume/compare/v1.0.0...v1.0.1) (2023-07-15)

### Bug Fixes

- update styling ([a38d484](https://github.com/northcutted/resume/commit/a38d484a0eba4a7ddf8744275bb12fe1bb016d8a))

# 1.0.0 (2023-07-15)

### Bug Fixes

- add styling ([cda8205](https://github.com/northcutted/resume/commit/cda82058b05280576c13f9f2def1956b57de7946))
- update html template to use styling ([40f9555](https://github.com/northcutted/resume/commit/40f95555a9e34f9fa6911f1a771667ec3c996c0b))
- update styling ([149c1cb](https://github.com/northcutted/resume/commit/149c1cb0b1865efb83a4cc370e050f6167c966fb))
