const http = require('http');
const request = require('request');
const port = process.env.PORT || 3000

http.createServer(function (req, res) {
        // change URI to your liking
    if (req.url.startsWith('/mypayload')) {
        // Replace with your favorite ipfs proxy and your ipfs site or file CID. https://ipfs.github.io/public-gateway-checker/
        const imageUrl = 'https://cloudflare-ipfs.com/ipfs/QmVe6wtvqYUBHVLXzUkDCffHN41SJJMqoooCi5WPuPyA8w';
        req.pipe(request(imageUrl)).pipe(res);
    } else {
      res.writeHead(302, {
        'Location': 'https://google.com'
      });
      res.end();
    }
}).listen(port);