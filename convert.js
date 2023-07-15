const showdown  = require('showdown');
const fs = require('fs');
const converter = new showdown.Converter();
const text = fs.readFileSync('resume.md', 'utf8');
const html = converter.makeHtml(text);
fs.writeFileSync('index.html', html);
