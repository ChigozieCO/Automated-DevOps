const express = require("express");
const path = require("path");
const client = require("prom-client");

const app = express();
const PORT = process.env.PORT || 3000;

// Prometheus Metrics Setup
const register = new client.Registry();
client.collectDefaultMetrics({ register });

const requestCounter = new client.Counter({
  name: "password_check_requests_total",
  help: "Total number of password strength check requests",
  registers: [register]
});

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static("public"));

// Serve Homepage
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "public", "index.html"));
});

// API Route
app.get("/api", (req, res) => {
  res.json({ message: "Hello from Express API!", status: "success" });
});

// Password Strength Checker
app.post("/check-password", (req, res) => {
  const { password } = req.body;
  if (!password) return res.status(400).send("Password is required");

  requestCounter.inc(); // Increment request counter

  const result = checkPasswordStrength(password);
  res.send(result);
});

// Prometheus Metrics Endpoint
app.get("/metrics", async (req, res) => {
  res.set("Content-Type", register.contentType);
  res.end(await register.metrics());
});

// 404 Handler (for unknown routes)
app.use((req, res) => {
  res.status(404).send("404 - Not Found");
});

// Password Strength Checker Logic
function checkPasswordStrength(password) {
  let score = 0;
  if (password.length >= 12) score++;
  if (/[A-Z]/.test(password)) score++;
  if (/[a-z]/.test(password)) score++;
  if (/[0-9]/.test(password)) score++;
  if (/[^A-Za-z0-9]/.test(password)) score++;

  if (score === 5) return `Strong`;
  if (score >= 3) return `Moderate ⚠️`;

  return `Weak ❌ - Try: ${generateStrongerPassword(password)}`;
}

// Strong Password Generator
function generateStrongerPassword(weakPassword) {
  const randomChars = "!@#$%^&*()_-+=<>?";
  const randomNumbers = Math.random().toString().slice(2, 6);
  const shuffled = weakPassword.split("").sort(() => Math.random() - 0.5).join("");

  let strongerPassword = "";
  for (let char of shuffled) {
    strongerPassword += Math.random() > 0.5 ? char.toUpperCase() : char;
    if (Math.random() > 0.7) strongerPassword += randomChars[Math.floor(Math.random() * randomChars.length)];
  }

  return strongerPassword + randomNumbers;
}

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});

