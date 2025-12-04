---
margin-left: 2cm
margin-right: 2cm
margin-top: 1cm
margin-bottom: 2cm
title: Edward Northcutt
description-meta: 'Experienced Software Engineer specializing in DevOps, Platform Engineering, and Cloud Infrastructure. Proven track record in building scalable systems and developer tooling.'
keywords:
  - 'devops'
  - 'platform engineering'
  - 'cloud infrastructure'
  - 'kubernetes'
  - 'aws'
  - 'software engineer'
  - 'go'
  - 'python'
  - 'java'
  - 'ci/cd'
  - 'docker'
  - 'terraform'
subject: 'Resume of Edward Northcutt'
header-includes:
  - <meta property="og:title" content="Edward Northcutt - Resume" />
  - <meta property="og:type" content="website" />
  - <meta property="og:description" content="Experienced Software Engineer specializing in DevOps, Platform Engineering, and Cloud Infrastructure." />
---
###### [northcutted@gmail.com](mailto:northcutted@gmail.com) • [LinkedIn](https://www.linkedin.com/in/edward-northcutt-b06386101/)

Experienced Software Engineer with a strong focus on platform engineering, DevOps, and secure, scalable cloud infrastructure. Specializes in building shared systems—including enterprise container images, CI/CD platforms, and developer tooling that simplify workflows, reduce duplication, and drive efficiency at scale. Proven track record of delivering solutions used by thousands of engineers, leading complex migrations, and embedding automation and security into core development platforms.

## Skills
- **Programming/Scripting:** Go, Python, Java, JavaScript/TypeScript, Ruby, HTML, CSS, Bash  
- **Containerization & Orchestration:** Docker, Kubernetes, Red Hat OpenShift (ROSA), Multi-Arch Builds (ARM64/AMD64), Helm, Sysbox.
- **Cloud & Infrastructure:**  AWS (EC2, ECR, S3, IAM, CloudWatch), Fargate, VPC Networking, Red Hat Openshift, Terraform/OpenTofu, Ansible, Puppet  
- **CI/CD & DevOps:** GitLab CI/CD, GitHub Actions, Jenkins, Automated Vulnerability Remediation, Supply Chain Security.
- **Observability:** Grafana, ELK Stack (Elasticsearch, Logstash, Kibana), Prometheus, CloudWatch  
- **System Design:** JVM Tuning/Profiling, Linux System Administration, Distributed Systems, API Design, LLM workflow integration.

## Publications

* **[DevSecFinOps: The Challenge of Implementing a Secure and Cost-Effective Container-Based CI/CD System](https://engineering.statefarm.com/devsecfinops-the-challenge-of-implementing-a-secure-and-cost-effective-container-based-ci-cd-c2257eac8eb4)** – *State Farm Engineering Blog (July 2025)*
  * Co-authored a technical deep dive detailing the architecture and implementation of a secure, cost-effective container-based CI/CD system, highlighting solutions to key engineering challenges.

## Experience

### Lead Software Engineer II, State Farm (_Bloomington, IL/Hybrid-Remote_)

_April 2024 - Present_

Sole engineer responsible for transforming enterprise container image management from ad-hoc community efforts into a governed, multi-architecture product. Architected and delivered a standardized base image ecosystem that now powers the majority of production kubernetes workloads, reducing operational variance and accelerating delivery across the enterprise.

*Achievements:*

* **Enterprise Scale & Adoption:** Scaled adoption from zero to over **730 unique applications** leveraging official enterprise base images in 2025, used in over **108,000 image builds**.
* **Multi-Architecture & Optimization:** Architected a modular image suite supporting both **Linux/arm64 and Linux/amd64**, enabling runtime cost savings. Implemented layered inheritance to maximize caching, minimize storage footprint and transfer costs.
* **JVM Middleware Innovation:** Delivered a tool integrated into base image designed to optimize heap sizing and garbage collection for JVM applications on Kubernetes, significantly improving stability and reducing cognitive load for teams migrating from legacy platforms.
* **Security Automation:** Slashed vulnerability remediation time to **under 24 hours** (down from days) by implementing automated patching pipelines and integrating State Farm Certificate Authority trust directly into base images.
* **Observability:** Built comprehensive OpenSearch/Kibana dashboards to visualize adoption trends and track legacy registry usage, enabling data-driven governance decisions.
* **Developer Enablement:** Created searchable, RAG-optimized documentation to facilitate LLM-powered knowledge retrieval for engineering teams.


### Lead Software Engineer, State Farm (_Bloomington, IL/Hybrid-Remote_)

_August 2020 - April 2024_

Directed and enhanced Source Control Management (SCM) and CI/CD capabilities, supporting over 10,000 engineers. Focused on pipeline architecture, service resiliency, and development best practices.

_Achievements:_

* **Shared CI/CD Service:** Engineered a shared CI/CD service using GitLab Runners, enabling users to leverage isolated, secure container builds via Sysbox. By 2022, this system managed over half of all pipelines at State Farm.
* **Cloud Migration:** Successfully migrated the CI/CD infrastructure from on-premises to AWS in 2023, implementing robust autoscaling to handle peak loads.
* **Inner-Source Leadership:** Launched Terraform modules and container images for pipeline usage to accelerate development velocity.
* **Metrics & Observability:** Developed a cloud-based solution to collect CI/CD metrics, using Grafana to visualize usage data for consumer-facing dashboards.
* **Platform Migration:** Transitioned users from legacy Jenkins services to the shared GitLab CI/CD platform, providing custom solutions for complex migration challenges.

### Software Developer, State Farm (_Bloomington, IL_)

_June 2018 - August 2020_

Collaborated with a team of seven engineers to maintain and enhance proprietary tools for insurance product design, managing complex backend validations and database integrations.

_Achievements:_

* **Security Tooling:** Developed an internal tool to scan projects for vulnerable dependencies and provide automated upgrade suggestions. This tool was adopted by the application security team.
* **Legacy Modernization:** Maintained REST endpoints and Java IMS services interacting with IBM MQ. Played a pivotal role in migrating applications from a legacy WAS platform to Pivotal Cloud Foundry (Postgres, RabbitMQ, Spring Boot).

### IT/Systems Intern, State Farm (_Champaign, IL_)

_Summer 2017 - Spring 2018_

* Developed a solution to assist with PCI DSS compliance audits as a full-stack developer.
* Assisted business partners in writing recovery plans for business continuity.

## Education

### B.S. in Agricultural and Consumer Economics
**University of Illinois at Urbana-Champaign**
*Fall 2014 - Spring 2018*
* Concentration in Finance in Agribusiness
* Relevant Course Work: Data Structures (CS 225)
