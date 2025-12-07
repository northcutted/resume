const fs = require('fs');
const path = require('path');

const mdPath = process.argv[2] || 'resume.md';
const jsonPath = process.argv[3] || 'resume.json';

if (!fs.existsSync(mdPath)) {
    console.error(`File not found: ${mdPath}`);
    process.exit(1);
}

const content = fs.readFileSync(mdPath, 'utf8');

// Helper to extract section content
function extractSection(text, header) {
    const regex = new RegExp(`## ${header}\\s+([\\s\\S]*?)(?=\\n## |$)`, 'i');
    const match = text.match(regex);
    return match ? match[1].trim() : null;
}

// Helper to parse frontmatter
function parseFrontmatter(text) {
    const match = text.match(/^---\n([\s\S]*?)\n---/);
    if (!match) return {};
    const fm = {};
    match[1].split('\n').forEach(line => {
        const parts = line.split(':');
        if (parts.length >= 2) {
            const key = parts[0].trim();
            const value = parts.slice(1).join(':').trim().replace(/^['"]|['"]$/g, '');
            if (key && value) fm[key] = value;
        }
    });
    return fm;
}

const frontmatter = parseFrontmatter(content);
const body = content.replace(/^---\n[\s\S]*?\n---/, '').trim();

// Initialize JSON Resume structure
const resume = {
    basics: {
        name: frontmatter.title || "Edward Northcutt",
        label: "Software Engineer",
        email: "",
        phone: "",
        url: "",
        summary: "",
        location: {},
        profiles: []
    },
    work: [],
    education: [],
    skills: [],
    publications: []
};

// Parse Header (Email, Phone, Links)
// Format: ###### [email](mailto:...) • [LinkedIn](...)
const headerLines = body.split('\n').slice(0, 10);
const headerLine = headerLines.find(l => l.includes('mailto:') || l.includes('http'));

if (headerLine) {
    // Extract Email
    const emailMatch = headerLine.match(/\[(.*?)\]\(mailto:(.*?)\)/);
    if (emailMatch) {
        resume.basics.email = emailMatch[2];
    }

    // Extract Profiles (LinkedIn, etc.)
    // We look for links that are NOT mailto
    // Fix: Use [^\[\]]*? to avoid matching across multiple links
    const linkRegex = /\[([^\[\]]*?)\]\((http.*?)\)/g;
    let match;
    while ((match = linkRegex.exec(headerLine)) !== null) {
        if (!match[2].includes('mailto')) {
            resume.basics.profiles.push({
                network: match[1],
                url: match[2]
            });
        }
    }
}

// Parse Summary
const summaryMatch = body.match(/^(?:######.*?\n)?([\s\S]*?)(?=\n## )/);
if (summaryMatch) {
    // Remove the header line if it was captured
    let summary = summaryMatch[1].trim();
    if (summary.startsWith('######')) {
        summary = summary.split('\n').slice(1).join('\n').trim();
    }
    resume.basics.summary = summary;
}

// Parse Skills
const skillsText = extractSection(body, 'Skills');
if (skillsText) {
    skillsText.split('\n').forEach(line => {
        const match = line.match(/-\s*\*\*(.*?):\*\*\s*(.*)/);
        if (match) {
            resume.skills.push({
                name: match[1].trim(),
                keywords: match[2].split(',').map(s => s.trim())
            });
        }
    });
}

// Parse Experience
const experienceText = extractSection(body, 'Experience');
if (experienceText) {
    // Split by ### (Job entries)
    // We use a lookahead to split but keep the delimiter, or just split and reconstruct
    // Easier: Split by \n### and handle the first element
    const rawJobs = experienceText.split(/\n### /);
    
    // If the text starts with ###, the first element might be empty or contain the first job title if we split by `\n### `
    // Let's normalize: ensure it starts with `### ` so we can split cleanly
    let normalizedExp = experienceText;
    if (!normalizedExp.startsWith('### ')) {
        normalizedExp = '### ' + normalizedExp; // Should not happen based on structure but good for safety
    }
    
    // Actually, if it starts with `### Title`, `split('\n### ')` will NOT split the first one if it's at the very beginning of the string (no newline before it).
    // So we should split by `### ` (with optional newline)
    const jobs = normalizedExp.split(/(?:^|\n)### /).filter(j => j.trim().length > 0);

    jobs.forEach(jobBlock => {
        const lines = jobBlock.split('\n');
        const titleLine = lines[0].trim();
        
        // Format: Title, Company (_Location_)
        const titleMatch = titleLine.match(/(.*?), (.*?) \((.*?)\)/) || titleLine.match(/(.*?), (.*)/);
        
        const job = {
            position: titleMatch ? titleMatch[1] : titleLine,
            name: titleMatch ? titleMatch[2] : "",
            summary: "",
            highlights: []
        };

        // Find date line: _Date - Date_
        const dateLineIndex = lines.findIndex(l => l.trim().startsWith('_') && l.trim().endsWith('_'));
        if (dateLineIndex !== -1) {
            const dateText = lines[dateLineIndex].replace(/_/g, '').trim();
            const dates = dateText.split('-');
            job.startDate = dates[0] ? dates[0].trim() : "";
            job.endDate = dates[1] ? dates[1].trim() : "";
        }

        // Summary and Highlights
        let inHighlights = false;
        for (let i = dateLineIndex + 1; i < lines.length; i++) {
            const line = lines[i].trim();
            if (!line) continue;
            
            if (line.startsWith('*') || line.startsWith('-')) {
                const content = line.replace(/^[\*\-]\s*/, '').trim();
                // Filter out "Achievements" header if it appears as a bullet
                if (content.toLowerCase().includes('achievements') && content.length < 20) continue;
                
                inHighlights = true;
                job.highlights.push(content);
            } else if (!inHighlights) {
                // Check if it's "Achievements:" header
                if (line.toLowerCase().includes('achievements:')) continue;
                job.summary += line + " ";
            }
        }
        job.summary = job.summary.trim();
        resume.work.push(job);
    });
}

// Parse Education
const educationText = extractSection(body, 'Education');
if (educationText) {
    const eduBlocks = educationText.split(/(?:^|\n)### /).filter(e => e.trim().length > 0);
    eduBlocks.forEach(block => {
        const lines = block.split('\n');
        const institutionLine = lines[0].trim();
        
        const edu = {
            institution: institutionLine,
            area: "",
            studyType: "",
            startDate: "",
            endDate: ""
        };

        // Try to extract degree and institution
        // Format: B.S. in X (University)
        const titleMatch = institutionLine.match(/(.*?) \((.*?)\)/);
        if (titleMatch) {
            edu.studyType = titleMatch[1]; // B.S. in ...
            edu.institution = titleMatch[2];
        }

        // Find date line
        const dateLine = lines.find(l => l.trim().startsWith('_') && l.trim().endsWith('_'));
        if (dateLine) {
            const dateText = dateLine.replace(/_/g, '').trim();
            const dates = dateText.split('-');
            edu.startDate = dates[0] ? dates[0].trim() : "";
            edu.endDate = dates[1] ? dates[1].trim() : "";
        }
        
        resume.education.push(edu);
    });
}

// Parse Publications
const publicationsText = extractSection(body, 'Publications');
if (publicationsText) {
    publicationsText.split('\n').forEach(line => {
        if (line.startsWith('*') || line.startsWith('-')) {
            // Check if it's a main bullet point with a link
            const match = line.match(/\[(.*?)\]\((.*?)\)/);
            if (match) {
                resume.publications.push({
                    name: match[1],
                    url: match[2],
                    summary: line.replace(/\[.*?\]\(.*?\)/, '').replace(/^[\*\-]\s*/, '').replace(/\*\*/g, '').trim()
                });
            } else if (resume.publications.length > 0) {
                // Append sub-bullets to the last publication's summary
                const lastPub = resume.publications[resume.publications.length - 1];
                lastPub.summary += " " + line.replace(/^[\*\-]\s*/, '').trim();
            }
        }
    });
}

fs.writeFileSync(jsonPath, JSON.stringify(resume, null, 2));
console.log(`Generated ${jsonPath} from ${mdPath}`);
