# JSON Resume Generator

This repository generates a professional resume in HTML, PDF, and DOCX formats from a single `resume.json` file. It follows the [JSON Resume](https://jsonresume.org/) schema standard.

## 🚀 Quick Start

The easiest way to build your resume is using Docker. You don't need to install Node.js, Pandoc, or anything else on your machine besides Docker.

### 1. Edit your Resume
Open `resume.json` and update it with your details. 
*   **DO NOT** edit `resume.md` directly. It is auto-generated and will be overwritten.
*   This project follows the [JSON Resume Schema](https://jsonresume.org/schema/).

### 2. Build with Docker
Run the following command in your terminal to build the image and generate your resume:

```bash
# 1. Build the Docker image (only needs to be done once or when you change dependencies)
docker build -t resume-builder .

# 2. Run the builder
# This mounts your current directory to the container and runs the build script
docker run --rm -v "$(pwd):/data" resume-builder ./build.sh
```

Your generated files will appear in the `output/` directory:
*   `index.html` (Web version)
*   `resume.pdf` (PDF version)
*   `resume.docx` (Word version)

### 🐳 Podman Support

If you prefer **Podman**, the commands are nearly identical. Just replace `docker` with `podman`. 

**Note:** On systems with SELinux enabled (like Fedora or RHEL), you may need to append `:Z` to the volume mount to allow the container to write to the directory.

```bash
podman build -t resume-builder .
podman run --rm -v "$(pwd):/data:Z" resume-builder ./build.sh
```

---

## 🛠️ Local Development (Advanced)

If you prefer to run tools locally without Docker, you will need:
*   **Node.js** (v20+)
*   **Pandoc**
*   **wkhtmltopdf**

### Setup
```bash
npm install
```

### Available Commands

| Command | Description |
|---------|-------------|
| `npm run build` | Runs the full build process (JSON -> MD -> HTML/PDF/DOCX). |
| `npm run watch` | Watches `resume.json` and CSS files, rebuilding automatically on change. |
| `npm run validate` | Validates your `resume.json` against the schema requirements. |
| `npm run convert-json` | Manually converts `resume.json` to `resume.md` (useful for debugging). |

## 📝 Workflow & Schema

**Important:** This project has moved to a **JSON-first** workflow. 

1.  **Source of Truth**: `resume.json` is the master file.
2.  **Generation**: The build script converts `resume.json` into a temporary `resume.md` file using `scripts/json-to-md.js`.
3.  **Rendering**: Pandoc then converts that Markdown file into the final HTML, PDF, and DOCX outputs.

### Supported Sections
The generator supports the full JSON Resume schema, including:
*   Basics (Contact, Summary, Profiles)
*   Work Experience
*   Education
*   Skills
*   Projects
*   Volunteer
*   Awards & Certificates
*   Publications
*   Languages
*   Interests
*   References

## 🎨 Customization

*   **Themes**: The `output/` folder contains several CSS themes (`theme-modern.css`, `theme-classic.css`, etc.). You can switch themes by editing `build.sh` or modifying the HTML output.
*   **Styles**: Edit `styles/resume-stylesheet.css` or any of the `styles/theme-*.css` files to change the look and feel.

## 🍴 Forking & Setup

Want to make this your own? Follow these steps to get your resume hosted on GitHub Pages:

1.  **Fork this Repository**: Click the "Fork" button in the top right of GitHub to create your own copy.
2.  **Enable GitHub Actions**:
    *   Go to your repository's **Settings** > **Pages**.
    *   Under **Build and deployment**, select **GitHub Actions** as the source.
3.  **Update Personal Info**:
    *   Edit `resume.json` with your actual data.
    *   (Optional) Edit `.github/workflows/build-and-deploy.yml` if you want to change the PDF filename or other build settings.
4.  **Push Changes**: Commit and push your changes to the `main` branch. The GitHub Action will automatically build your resume and deploy it to GitHub Pages.

## ☁️ GitHub Pages Deployment

This repo is configured to deploy to GitHub Pages automatically using GitHub Actions.
1.  Push your changes to `main`.
2.  The workflow will build your resume and deploy it to `https://<your-username>.github.io/resume/`.

### Credits
Inspired by: https://github.com/vidluther/markdown-resume
