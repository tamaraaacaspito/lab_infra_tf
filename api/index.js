const http = require("http");
const { Client } = require("pg");

const PORT = 3000;

const db = new Client({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
});

const server = http.createServer(async (req, res) => {
  res.setHeader("Content-Type", "application/json");

  if (req.url === "/") {
    res.writeHead(200);

    res.end(
      JSON.stringify({
        entorno: process.env.ENTORNO || "desconocido",
        mensaje: "API funciona",
      })
    );

    return;
  }

  if (req.url === "/db") {
    try {
      const result = await db.query("SELECT NOW() AS fecha");

      res.writeHead(200);

      res.end(
        JSON.stringify({
          entorno: process.env.ENTORNO || "desconocido",
          mensaje: "Conexión exitosa con PostgreSQL",
          base_de_datos: process.env.DB_NAME,
          fecha_servidor: result.rows[0].fecha,
        })
      );
    } catch (error) {
      res.writeHead(500);

      res.end(
        JSON.stringify({
          mensaje: "Error al conectar con PostgreSQL",
          error: error.message,
        })
      );
    }

    return;
  }

  res.writeHead(404);

  res.end(
    JSON.stringify({
      mensaje: "Ruta no encontrada",
    })
  );
});

async function conectarBaseDeDatos() {
  try {
    await db.connect();

    console.log("Conectado a PostgreSQL");

    server.listen(PORT, "0.0.0.0", () => {
      console.log(`API ejecutándose en el puerto ${PORT}`);
    });
  } catch (error) {
    console.error(
      "No fue posible conectar con PostgreSQL:",
      error.message
    );

    process.exit(1);
  }
}

conectarBaseDeDatos();