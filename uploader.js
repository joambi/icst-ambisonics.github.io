const http = require('http');
const fs = require('fs');
const path = require('path');

const server = http.createServer((req, res) => {
  // Set CORS headers
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'OPTIONS, POST');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  // Handle preflight requests
  if (req.method === 'OPTIONS') {
    res.writeHead(204);
    res.end();
    return;
  }

  if (req.method === 'POST' && req.url === '/upload') {
    const contentType = req.headers['content-type'];
    const boundary = contentType.split('; ')[1].split('=')[1];
    let body = [];

    req.on('data', chunk => {
      body.push(chunk);
    });

    req.on('end', () => {
      body = Buffer.concat(body);
      const parts = multipartParser(body, boundary);
      let fileName, fileContent, uploadPath;

      parts.forEach(part => {
        if (part.filename) {
          fileName = part.filename;
          fileContent = part.data;
        } else if (part.name === 'path') {
          uploadPath = part.data.toString().trim();
        }
      });

      if (fileName && fileContent && uploadPath) {
        const fullPath = path.join(__dirname, 'static', uploadPath);
        fs.mkdirSync(fullPath, { recursive: true });
        const filePath = path.join(fullPath, fileName);

        fs.writeFile(filePath, fileContent, (err) => {
          if (err) {
            res.writeHead(500, { 'Content-Type': 'application/json' });
            res.end(JSON.stringify({ success: false, error: 'File write error' }));
          } else {
            res.writeHead(200, { 'Content-Type': 'application/json' });
            res.end(JSON.stringify({ success: true, path: path.join(uploadPath, fileName) }));
          }
        });
      } else {
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: false, error: 'Invalid upload data' }));
      }
    });
  } else {
    res.writeHead(404, { 'Content-Type': 'text/plain' });
    res.end('Not Found');
  }
});

function multipartParser(body, boundary) {
  const parts = [];
  const boundaryBytes = Buffer.from('--' + boundary);
  let start = body.indexOf(boundaryBytes) + boundaryBytes.length + 2;
  let end = body.indexOf(boundaryBytes, start);

  while (start < end) {
    const part = body.slice(start, end);
    const headerEnd = part.indexOf('\r\n\r\n');
    const header = part.slice(0, headerEnd).toString();
    const data = part.slice(headerEnd + 4);

    const filenameMatch = header.match(/filename="([^"]+)"/);
    const nameMatch = header.match(/name="([^"]+)"/);

    parts.push({
      filename: filenameMatch ? filenameMatch[1] : null,
      name: nameMatch ? nameMatch[1] : null,
      data: data
    });

    start = end + boundaryBytes.length + 2;
    end = body.indexOf(boundaryBytes, start);
  }

  return parts;
}

const PORT = 3001;
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});