---
margin-left: 2cm
margin-right: 2cm
margin-top: 1cm
margin-bottom: 2cm
title: Edward Northcutt
description-meta: 'Platform engineering lead with 8+ years of experience building secure container, CI/CD, and developer infrastructure at enterprise scale. Founding technical own'
keywords:
  - 'Docker'
  - 'Docker Buildx'
  - 'Kubernetes'
  - 'OpenShift'
  - 'Distroless Images'
  - 'Multi-Arch Builds'
  - 'Helm'
  - 'Sysbox'
  - 'crane'
  - 'skopeo'
  - 'Cloud Native Buildpacks'
  - 'SLSA'
  - 'Sigstore'
  - 'Cosign'
  - 'SBOMs'
  - 'Syft'
  - 'Grype'
  - 'Docker Buildx Provenance'
  - 'JFrog Artifactory'
  - 'JFrog Evidence'
  - 'Vulnerability Remediation'
  - 'GitLab CI/CD'
  - 'GitLab Runners'
  - 'GitHub Actions'
  - 'Jenkins'
  - 'Release Automation'
  - 'Artifact Promotion'
  - 'Container Registry Workflows'
  - 'AWS'
  - 'ECR'
  - 'IAM'
  - 'S3'
  - 'CloudWatch'
  - 'Fargate'
  - 'Terraform'
  - 'OpenTofu'
  - 'Ansible'
  - 'VPC Networking'
  - 'Go'
  - 'Python'
  - 'Bash'
  - 'Java'
  - 'JavaScript'
  - 'TypeScript'
  - 'Grafana'
  - 'OpenSearch'
  - 'Kibana'
  - 'Prometheus'
  - 'CloudWatch'
  - 'Linux'
  - 'JVM Tuning'
  - 'API Design'
subject: 'Resume of Edward Northcutt'
header-includes:
  - <meta property="og:title" content="Edward Northcutt - Resume" />
  - <meta property="og:type" content="website" />
  - <meta property="og:description" content="Platform engineering lead with 8+ years of experience building secure container, CI/CD, and developer infrastructure at enterprise scale. Founding technical own" />
---
###### [northcutted@gmail.com](mailto:northcutted@gmail.com) | +1 (618) 541-8770 | [https://resume.northcutt.dev](https://resume.northcutt.dev) | Charleston, Illinois, US | [LinkedIn](https://www.linkedin.com/in/edward-northcutt-b06386101/) | [GitHub](https://github.com/northcutted)

##### Lead Platform Engineer | Software Engineering | Secure Container Infrastructure | CI/CD

Platform engineering lead with 8+ years of experience building secure container, CI/CD, and developer infrastructure at enterprise scale. Founding technical owner of a multi-architecture container image platform adopted by 700+ applications and used in 100,000+ image builds. Specialized in distroless images, software supply chain security, SLSA provenance, SBOM and vulnerability automation, GitLab CI/CD, AWS, OpenShift, and Go-based platform tooling.

## Skills

- **Platform / Containers:** Docker, Docker Buildx, Kubernetes, OpenShift, Distroless Images, Multi-Arch Builds, Helm, Sysbox, crane, skopeo, Cloud Native Buildpacks
- **Software Supply Chain Security:** SLSA, Sigstore, Cosign, SBOMs, Syft, Grype, Docker Buildx Provenance, JFrog Artifactory, JFrog Evidence, Vulnerability Remediation
- **CI/CD:** GitLab CI/CD, GitLab Runners, GitHub Actions, Jenkins, Release Automation, Artifact Promotion, Container Registry Workflows
- **Cloud / Infrastructure as Code:** AWS, ECR, IAM, S3, CloudWatch, Fargate, Terraform, OpenTofu, Ansible, VPC Networking
- **Programming:** Go, Python, Bash, Java, JavaScript, TypeScript
- **Observability / Systems:** Grafana, OpenSearch, Kibana, Prometheus, CloudWatch, Linux, JVM Tuning, API Design

## Experience

### Lead Software Engineer II, State Farm (_Bloomington, IL / Hybrid-Remote_)

_Apr 2025 - Present_

Founding engineer and technical owner of the enterprise container image platform, delivering hardened, production-ready base images and secure CI/CD patterns for containerized workloads.

- Built and launched an enterprise container image platform adopted by 700+ applications and used in 100,000+ image builds within the first year.
- Designed and maintain a secure-by-default base image ecosystem built on Amazon Linux 2023, supporting Java/JVM, JavaScript/TypeScript, Python, Go, and .NET across distroless and development variants.
- Architected a modular Docker Buildx image build system supporting Linux/amd64 and Linux/arm64 across all runtime families, improving reuse through layered inheritance and cache-efficient build patterns.
- Implemented Cosign-based image signing, Docker Buildx provenance, and JFrog Artifactory Evidence integration, raising enterprise base-image supply chain posture to SLSA Level 2.
- Automated nightly SBOM generation and vulnerability scanning with Syft and Grype, reducing remediation time for fixable CVEs to under 24 hours after upstream patch availability.
- Managed Artifactory container registry lifecycle, access control, cleanup automation, image mirroring, and promotion workflows using crane, skopeo, and Docker Buildx.
- Developed Go middleware embedded in JVM base images to auto-configure heap sizing, CPU share mapping, and garbage collection behavior for Kubernetes workloads.
- Implemented a companion Go telemetry proxy with HMAC request signing, timestamp validation, replay protection, and Entra-authenticated forwarding to emit JVM metrics without embedding credentials in container images.
- Owned platform roadmap, adoption metrics, user support, and feedback loops as a solo engineer.

### Lead Software Engineer, State Farm (_Bloomington, IL / Hybrid-Remote_)

_Aug 2020 - Apr 2025_

Technical lead for source control management and CI/CD platform capabilities supporting 10,000+ engineers, with focus on pipeline architecture, service resiliency, infrastructure as code, and developer platform quality.

- Engineered shared GitLab Runner infrastructure with Sysbox-isolated container builds; by 2022, the platform handled over half of State Farm's CI/CD pipelines.
- Authored reusable Terraform modules for GitLab Runner fleet deployment on AWS, including cross-account IAM credential patterns for workloads running across isolated AWS accounts.
- Migrated CI/CD infrastructure from on-premises systems to AWS in 2023, adding autoscaling capacity for peak build loads.
- Developed a telemetry pipeline for CI/CD job metrics and surfaced consumer-facing reporting through Grafana dashboards.
- Led migrations from legacy Jenkins infrastructure to shared GitLab CI/CD patterns, including custom solutions for teams with complex pipeline requirements.

### Software Developer, State Farm (_Bloomington, IL_)

_Jun 2018 - Aug 2020_

Full-stack developer maintaining proprietary insurance product design tools, backend security tooling, and platform modernization efforts.

- Built an internal dependency-scanning tool that surfaced vulnerable packages and automated upgrade suggestions; the tool was adopted by the application security team.
- Migrated applications from legacy WebSphere Application Server infrastructure to Pivotal Cloud Foundry/Tanzu using Spring Boot, PostgreSQL, RabbitMQ, REST APIs, Java IMS services, and IBM MQ.

### Software Developer Intern, State Farm (_Champaign, IL_)

_May 2017 - May 2018_

- Developed a full-stack solution to support PCI DSS compliance audit workflows.
- Assisted business partners with recovery-plan documentation for business continuity.

## Publications

- **[DevSecFinOps: The Challenge of Implementing a Secure and Cost-Effective Container-Based CI/CD System](https://engineering.statefarm.com/devsecfinops-the-challenge-of-implementing-a-secure-and-cost-effective-container-based-ci-cd-c2257eac8eb4)** - _State Farm Engineering Blog (June 2025)_
  - Co-authored a technical deep dive on secure, cost-effective container-based CI/CD architecture, including engineering tradeoffs across isolation, security, cost, and developer experience.

## Projects

### [dock-docs](https://github.com/northcutted/dock-docs)

Go CLI tool that generates Dockerfile and container image documentation for platform teams, security reviews, and CI pipelines. Parses Dockerfiles and optionally integrates Syft, Grype, and Dive for SBOM generation, vulnerability scanning, and layer analysis.

_Go | Docker | Podman | Syft | Grype | Dive | SBOM | Container Security | CLI | GitHub Actions_

### [ClearCutt](https://github.com/northcutted/clearcutt)

Work-in-progress declarative framework ([project site](https://northcutted.github.io/clearcutt/)) for building hardened, minimal container base images using Nix flakes and a Go governance CLI, compiling language runtimes into reproducible, hermetically sealed closures across dev, slim, and distroless tiers. Layers keyless Sigstore/Cosign signing, SLSA Level 3 provenance, SBOMs, and Kyverno admission policies to enforce signed images from source through Kubernetes and OpenShift deployment.

_Nix | Go | Distroless | Kubernetes | OpenShift | Kyverno | Cosign | SLSA Level 3 | SBOM | FIPS 140-3 | Supply Chain Security_

### [PicStrip](https://github.com/northcutted/picstrip)

Published iOS app ([App Store](https://apps.apple.com/us/app/picstrip/id6765989071)) that strips metadata and redacts PII from photos entirely on-device — no network calls, analytics, or third-party SDKs — using a two-pass ImageIO pipeline plus Vision OCR and face detection that flags 30 categories of sensitive data across four risk tiers. Built in Swift/SwiftUI and shipped through an automated GitHub Actions and Fastlane release pipeline with SLSA Level 3 build provenance attestation.

_Swift | SwiftUI | iOS | Vision | ImageIO | Privacy Engineering | OCR | Fastlane | GitHub Actions | SLSA Level 3_

### [JSON Resume Generator](https://github.com/northcutted/resume)

Containerized resume-as-code pipeline that generates HTML, PDF, and DOCX artifacts from a single JSON Resume source. Demonstrates artifact-agnostic supply chain controls including keyless Sigstore/Cosign signing, SLSA provenance attestations, SBOM publishing, and minimal Wolfi-based builder images.

_SLSA Level 3 | Sigstore | Cosign | SBOM | Chainguard Wolfi | GitHub Actions | Provenance | Docker | Supply Chain Security_

### [Gitleaks Open Source Contribution](https://github.com/gitleaks/gitleaks/pull/487)

Contributed to gitleaks, a widely used open source secrets-detection tool. Added support for appending repository-specific and user-supplied configuration behavior via a merged pull request.

_Go | Security | Secrets Detection | Open Source_

## Education

### B.S. in Agricultural and Consumer Economics - Finance in Agribusiness (University of Illinois at Urbana-Champaign)

_Aug 2014 - May 2018_

- CS 225 - Data Structures
