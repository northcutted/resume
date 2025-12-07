const fs = require('fs');
const path = require('path');

const schemaUrl = 'https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json';
const resumePath = process.argv[2] || 'resume.json';

if (!fs.existsSync(resumePath)) {
    console.error(`File not found: ${resumePath}`);
    process.exit(1);
}

// Simple validation: Check if it parses and has required top-level fields
try {
    const resume = JSON.parse(fs.readFileSync(resumePath, 'utf8'));
    
    const required = ['basics'];
    const missing = required.filter(field => !resume[field]);
    
    if (missing.length > 0) {
        console.error(`Validation Error: Missing required fields: ${missing.join(', ')}`);
        process.exit(1);
    }

    if (resume.basics && !resume.basics.name) {
        console.error('Validation Error: basics.name is required');
        process.exit(1);
    }

    console.log('Resume JSON is valid (basic check).');
    
    // Suggestion: Use a real schema validator like 'ajv' for full validation
    // console.log('To perform full schema validation, install "ajv" and fetch the schema.');

} catch (err) {
    console.error('Error parsing JSON:', err.message);
    process.exit(1);
}
