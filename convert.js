const showdown  = require('showdown');
const fs = require('fs');
const converter = new showdown.Converter();
const text = fs.readFileSync('resume.md', 'utf8');
const html = converter.makeHtml(text);

const htmlWithStyles = `
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    ${html}
</body>
</html>
`;

fs.writeFileSync('index.html', htmlWithStyles);
