const puppeteer = require('puppeteer');
const path = require('path');
const fs = require('fs');

(async () => {
    // Check for batch mode
    if (process.argv[2] === '--batch') {
        const batchFile = process.argv[3];
        if (!batchFile) {
            console.error('Usage: node html-to-pdf.js --batch <batch-json-file>');
            process.exit(1);
        }
        
        try {
            const jobs = JSON.parse(fs.readFileSync(batchFile, 'utf8'));
            await processJobs(jobs);
        } catch (err) {
            console.error('Error processing batch file:', err);
            process.exit(1);
        }
    } else {
        // Single file mode
        const inputPath = process.argv[2];
        const outputPath = process.argv[3];

        if (!inputPath || !outputPath) {
            console.error('Usage: node html-to-pdf.js <input-html> <output-pdf>');
            process.exit(1);
        }

        await processJobs([{ input: inputPath, output: outputPath }]);
    }
})();

async function processJobs(jobs) {
    let browser;
    try {
        browser = await puppeteer.launch({
            args: [
                '--no-sandbox', 
                '--disable-setuid-sandbox',
                '--disable-dev-shm-usage', // Important for Docker
                '--font-render-hinting=none' // Improves font rendering consistency
            ],
            headless: true
        });

        const page = await browser.newPage();

        for (const job of jobs) {
            const absoluteInputPath = path.resolve(job.input);
            console.log(`Processing: ${job.input} -> ${job.output}`);
            
            await page.goto(`file://${absoluteInputPath}`, { 
                waitUntil: 'networkidle0' 
            });

            await page.pdf({
                path: job.output,
                format: 'Letter',
                printBackground: true,
                scale: 0.9,
                margin: {
                    top: '0mm',
                    bottom: '0mm',
                    left: '0mm',
                    right: '0mm'
                },
                preferCSSPageSize: true
            });
        }

        console.log(`Successfully generated ${jobs.length} PDFs`);
    } catch (err) {
        console.error('Error generating PDF:', err);
        process.exit(1);
    } finally {
        if (browser) {
            await browser.close();
        }
    }
}
