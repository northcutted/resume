const fs = require('fs');

const jsonPath = process.argv[2];
const mdPath = process.argv[3];

if (!jsonPath || !mdPath) {
    console.error('Usage: node json-to-md.js <json-path> <md-path>');
    process.exit(1);
}

try {
    const resume = JSON.parse(fs.readFileSync(jsonPath, 'utf8'));
    let md = '';

    const formatDate = (value) => {
        if (!value || /present/i.test(value)) return value;

        const monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        const isoMonthMatch = /^(\d{4})-(\d{2})$/.exec(value);
        if (isoMonthMatch) {
            const year = isoMonthMatch[1];
            const monthIndex = Number(isoMonthMatch[2]) - 1;
            if (monthIndex >= 0 && monthIndex < 12) {
                return `${monthNames[monthIndex]} ${year}`;
            }
        }

        const isoDateMatch = /^(\d{4})-(\d{2})-(\d{2})$/.exec(value);
        if (isoDateMatch) {
            const year = isoDateMatch[1];
            const monthIndex = Number(isoDateMatch[2]) - 1;
            if (monthIndex >= 0 && monthIndex < 12) {
                return `${monthNames[monthIndex]} ${year}`;
            }
        }

        return value;
    };

    // Add Frontmatter
    // Extract keywords from skills for meta tags
    const metaKeywords = [];
    if (resume.skills) {
        resume.skills.forEach(skill => {
            if (skill.keywords) metaKeywords.push(...skill.keywords);
        });
    }
    // Fallback defaults if no skills
    if (metaKeywords.length === 0) {
        metaKeywords.push('resume', 'software engineer', 'developer');
    }

    md += `---
margin-left: 2cm
margin-right: 2cm
margin-top: 1cm
margin-bottom: 2cm
title: ${resume.basics.name}
description-meta: '${resume.basics.summary ? resume.basics.summary.replace(/'/g, "''").substring(0, 160) : 'Resume'}'
keywords:
${metaKeywords.map(k => `  - '${k.replace(/'/g, "''")}'`).join('\n')}
subject: 'Resume of ${resume.basics.name}'
header-includes:
  - <meta property="og:title" content="${resume.basics.name} - Resume" />
  - <meta property="og:type" content="website" />
  - <meta property="og:description" content="${resume.basics.summary ? resume.basics.summary.replace(/"/g, '&quot;').substring(0, 160) : 'Resume'}" />
---
`;

    // Basics
    if (resume.basics) {
        // Header line with email and profiles
        const contact = [];
        if (resume.basics.email) contact.push(`[${resume.basics.email}](mailto:${resume.basics.email})`);
        if (resume.basics.phone) contact.push(resume.basics.phone);
        if (resume.basics.url) contact.push(`[${resume.basics.url}](${resume.basics.url})`);
        if (resume.basics.location) {
             const loc = [];
             if (resume.basics.location.city) loc.push(resume.basics.location.city);
             if (resume.basics.location.region) loc.push(resume.basics.location.region);
             if (resume.basics.location.countryCode) loc.push(resume.basics.location.countryCode);
             if (loc.length > 0) contact.push(loc.join(', '));
        }
        if (resume.basics.profiles) {
            resume.basics.profiles.forEach(profile => {
                contact.push(`[${profile.network}](${profile.url})`);
            });
        }
        
        if (contact.length > 0) {
            md += `###### ${contact.join(' | ')}\n\n`;
        }

        if (resume.basics.label) {
            md += `##### ${resume.basics.label}\n\n`;
        }

        if (resume.basics.summary) {
            md += `${resume.basics.summary}\n\n`;
        }
    }

    // Skills
    if (resume.skills && resume.skills.length > 0) {
        md += `## Skills\n\n`;
        resume.skills.forEach(skill => {
            md += `- **${skill.name}:** `;
            if (skill.keywords && skill.keywords.length > 0) {
                md += skill.keywords.join(', ');
            }
            md += `\n`;
        });
        md += `\n`;
    }

    // Work
    if (resume.work && resume.work.length > 0) {
        md += `## Experience\n\n`;
        resume.work.forEach(job => {
            md += `### ${job.position}, ${job.name}`;
            if (job.location) {
                md += ` (_${job.location}_)`;
            }
            md += `\n\n`;
            
            if (job.startDate) {
                md += `_${formatDate(job.startDate)} - ${formatDate(job.endDate || 'Present')}_\n\n`;
            }
            
            if (job.summary) md += `${job.summary}\n\n`;
            
            if (job.highlights && job.highlights.length > 0) {
                job.highlights.forEach(highlight => {
                    md += `- ${highlight}\n`;
                });
                md += '\n';
            }
        });
    }

    // Publications
    if (resume.publications && resume.publications.length > 0) {
        md += `## Publications\n\n`;
        resume.publications.forEach(pub => {
            let pubLine = `- **[${pub.name}](${pub.url})**`;
            if (pub.publisher) {
                pubLine += ` - _${pub.publisher}`;
                if (pub.releaseDate) {
                    const date = new Date(pub.releaseDate);
                    const dateStr = isNaN(date.getTime()) ? pub.releaseDate : date.toLocaleDateString('en-US', { month: 'long', year: 'numeric' });
                    pubLine += ` (${dateStr})`;
                }
                pubLine += `_`;
            }
            md += `${pubLine}\n`;
            
            if (pub.summary) {
                md += `  - ${pub.summary}\n`;
            }
        });
        md += `\n`;
    }

    // Projects
    if (resume.projects && resume.projects.length > 0) {
        md += `## Projects\n\n`;
        resume.projects.forEach(proj => {
            const title = proj.url ? `[${proj.name}](${proj.url})` : proj.name;
            md += `### ${title}\n\n`;
            if (proj.startDate) {
                md += `_${formatDate(proj.startDate)} - ${formatDate(proj.endDate || 'Present')}_\n\n`;
            }
            if (proj.description) md += `${proj.description}\n\n`;
            if (proj.highlights && proj.highlights.length > 0) {
                proj.highlights.forEach(highlight => {
                    md += `- ${highlight}\n`;
                });
                md += '\n';
            }
            if (proj.keywords && proj.keywords.length > 0) {
                md += `_${proj.keywords.join(' | ')}_\n\n`;
            }
        });
    }

    // Education
    if (resume.education && resume.education.length > 0) {
        md += `## Education\n\n`;
        resume.education.forEach(edu => {
            let title = edu.institution;
            if (edu.studyType) {
                title = `${edu.studyType}`;
                if (edu.area) title += ` in ${edu.area}`;
                title += ` (${edu.institution})`;
            }
            md += `### ${title}\n\n`;
            
            if (edu.startDate) {
                md += `_${formatDate(edu.startDate)} - ${formatDate(edu.endDate || 'Present')}_\n\n`;
            }

            if (edu.score) {
                md += `- GPA: ${edu.score}\n`;
            }
            
            if (edu.courses && edu.courses.length > 0) {
                edu.courses.forEach(course => {
                    md += `- ${course}\n`;
                });
                md += '\n';
            }
        });
    }

    // Awards
    if (resume.awards && resume.awards.length > 0) {
        md += `## Awards\n\n`;
        resume.awards.forEach(award => {
            md += `### ${award.title} (${award.awarder})\n\n`;
            if (award.date) md += `_${formatDate(award.date)}_\n\n`;
            if (award.summary) md += `${award.summary}\n\n`;
        });
    }

    // Volunteer
    if (resume.volunteer && resume.volunteer.length > 0) {
        md += `## Volunteer\n\n`;
        resume.volunteer.forEach(vol => {
            md += `### ${vol.position}, ${vol.organization}\n\n`;
            if (vol.startDate) {
                md += `_${formatDate(vol.startDate)} - ${formatDate(vol.endDate || 'Present')}_\n\n`;
            }
            if (vol.summary) md += `${vol.summary}\n\n`;
            if (vol.highlights && vol.highlights.length > 0) {
                vol.highlights.forEach(highlight => {
                    md += `- ${highlight}\n`;
                });
                md += '\n';
            }
        });
    }

    // Certificates
    if (resume.certificates && resume.certificates.length > 0) {
        md += `## Certificates\n\n`;
        resume.certificates.forEach(cert => {
            md += `### ${cert.name}\n\n`;
            if (cert.issuer) md += `_${cert.issuer}_\n`;
            if (cert.date) md += `_${formatDate(cert.date)}_\n`;
            if (cert.url) md += `[Link](${cert.url})\n`;
            md += `\n`;
        });
    }

    // Languages
    if (resume.languages && resume.languages.length > 0) {
        md += `## Languages\n\n`;
        resume.languages.forEach(lang => {
            md += `- **${lang.language}**: ${lang.fluency}\n`;
        });
        md += `\n`;
    }

    // Interests
    if (resume.interests && resume.interests.length > 0) {
        md += `## Interests\n\n`;
        resume.interests.forEach(interest => {
            md += `- **${interest.name}**: `;
            if (interest.keywords && interest.keywords.length > 0) {
                md += interest.keywords.join(', ');
            }
            md += `\n`;
        });
        md += `\n`;
    }

    // References
    if (resume.references && resume.references.length > 0) {
        md += `## References\n\n`;
        resume.references.forEach(ref => {
            md += `> ${ref.reference}\n> \n> — **${ref.name}**\n\n`;
        });
    }

    fs.writeFileSync(mdPath, md.trim() + '\n');
    console.log(`Generated ${mdPath} from ${jsonPath}`);

} catch (err) {
    console.error('Error converting JSON to Markdown:', err);
    process.exit(1);
}
