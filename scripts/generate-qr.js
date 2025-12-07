const QRCode = require('qrcode');
const fs = require('fs');
const path = require('path');

const url = process.argv[2];
const outputPath = process.argv[3];

if (!url || !outputPath) {
    console.error('Usage: node generate-qr.js <url> <output-path>');
    process.exit(1);
}

// Ensure directory exists
const dir = path.dirname(outputPath);
if (!fs.existsSync(dir)){
    fs.mkdirSync(dir, { recursive: true });
}

QRCode.toFile(outputPath, url, {
    color: {
        dark: '#000000',
        light: '#00000000' // Transparent background
    }
}, function (err) {
    if (err) {
        console.error('Error generating QR code:', err);
        process.exit(1);
    }
    console.log(`QR code generated at ${outputPath}`);
});
