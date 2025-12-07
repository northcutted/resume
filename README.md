# JSON Resume Generator



[![License](https://img.shields.io/github/license/northcutted/resume?style=for-the-badge)](LICENSE)

[![Security: Dependabot](https://img.shields.io/badge/Securtiy-dependabot-0077c2?style=for-the-badge&logo=dependabot&logoColor=white)](https://github.com/dependabot)
[![Security: Trivy](https://img.shields.io/badge/Security-Trivy-0077c2?style=for-the-badge&logo=trivy&logoColor=white)](https://github.com/northcutted/resume/actions/workflows/ci.yml)

![GitHub Release](https://img.shields.io/github/v/release/northcutted/resume?style=for-the-badge)
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/northcutted/resume/ci.yml?style=for-the-badge)


[![View Resume](https://img.shields.io/badge/View_Resume-4DAAFC?style=for-the-badge&logo=github&logoColor=white)](https://northcutted.github.io/resume/)
[![Download PDF](https://img.shields.io/badge/Download_PDF-EC1C24?style=for-the-badge&logo=&logoColor=white)](https://northcutted.github.io/resume/resume.pdf)

This repository generates a professional resume in HTML, PDF, and DOCX formats from a single `resume.json` file. It follows the [JSON Resume](https://jsonresume.org/) schema standard.

There are two ways to use this project: the **Cloud Method** (recommended for most users) and the **Local Method** (for developers who want to build locally).

---

## ☁️ Cloud Method (GitHub Actions)

This is the easiest way to get started. You don't need to install anything on your computer. GitHub Actions will build your resume and host it for you.

### 1. Fork & Setup

1.  **Fork this Repository**: Click the "Fork" button in the top right of GitHub to create your own copy.
2.  **Enable GitHub Actions**:
    -   Go to your repository's **Settings** > **Pages**.
    -   Under **Build and deployment**, select **GitHub Actions** as the source.

### 2. Edit your Resume

1.  Edit `resume.json` with your actual data.
2.  Commit and push your changes to the `main` branch.
3.  The GitHub Action will automatically build your resume and deploy it to `https://<your-username>.github.io/resume/`.

### 3. Linting & Validation

To ensure high quality, the CI pipeline runs several checks:

-   **JSON Validation**: Ensures your `resume.json` follows the schema.
-   **Markdown Linting**: Checks the generated markdown for style issues using `markdownlint`.
-   **Spell Checking**: Checks for spelling errors using `cspell`.

#### Customizing Linting

If the default rules are too strict, you can customize them:

-   **Markdown Rules**: Edit `.markdownlint.json` to enable/disable specific rules.
-   **Spelling**: Edit `cspell.json` to add words to the dictionary (e.g., your name, company names) or ignore specific paths.

---

## 💻 Local Method (Docker/Podman)

If you prefer to build locally, you can use the provided script. This method requires **Docker** or **Podman** installed on your machine.

### 1. Clone the Repository

```bash
git clone https://github.com/northcutted/resume.git
cd resume
```

### 2. Build & Generate

Run the build script. It will automatically detect if you have Docker or Podman installed.

```bash
./build_local.sh
```

Your generated files will appear in the `output/` directory:

-   `index.html` (Web version)
-   `resume.pdf` (PDF version)
-   `resume.docx` (Word version)

---

## 🎨 Customization

-   **Themes**: The `output/` folder contains several CSS themes (`theme-modern.css`, `theme-classic.css`, etc.). You can switch themes by editing `build.sh` or modifying the HTML output.
-   **Styles**: Edit `styles/resume-stylesheet.css` or any of the `styles/theme-*.css` files to change the look and feel.

## 📝 Workflow & Schema

**Important:** This project uses a **JSON-first** workflow.

1.  **Source of Truth**: `resume.json` is the master file.
2.  **Generation**: The build script converts `resume.json` into a temporary `resume.md` file using `scripts/json-to-md.js`.
3.  **Rendering**: Pandoc then converts that Markdown file into the final HTML, PDF, and DOCX outputs.

### Supported Sections

The generator supports the full JSON Resume schema, including:

-   Basics (Contact, Summary, Profiles)
-   Work Experience
-   Education
-   Skills
-   Projects
-   Volunteer
-   Awards & Certificates
-   Publications
-   Languages
-   Interests
-   References

### Credits

Inspired by: <https://github.com/vidluther/markdown-resume>

## 📦 Stack / SBOM

The following table outlines the core components and dependencies used in this project (Software Bill of Materials).

| Component | Version | Type | Description |
|-----------|---------|------|-------------|
| **Node.js** | 25 (Bookworm Slim) | Runtime | Base container image |
| **Pandoc** | 3.6.3 | Binary | Document converter (MD to PDF/Docx) |
| **Chromium** | Latest (apt) | Binary | Headless browser for PDF generation |
| **Puppeteer** | ^24.32.0 | npm | Chrome control library |
| **dumb-init** | Latest (apt) | Binary | Init system for container |
| **markdownlint-cli** | ^0.46.0 | npm (dev) | Markdown linter |
| **cspell** | ^9.4.0 | npm (dev) | Spell checker |
| **live-server** | ^1.2.0 | npm (dev) | Local development server |
| **nodemon** | ^3.1.11 | npm (dev) | File watcher |
