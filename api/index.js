const http = require("http");

const PORT = 3000;

const server = http.createServer((req, res) => {
  res.writeHead(200, { "Content-Type": "application/json" });

  res.end(
    JSON.stringify({
      entorno: process.env.ENTORNO || "desconocido",
      mensaje: "API funciona",
    })
  );
});

server.listen(PORT, "0.0.0.0", () => {
  console.log(`API corriendo en el puerto ${PORT}`);
});