const express = require('express');
const app = express();

app.use(express.json());

// SUMA
app.get('/suma', (req, res) => {
  const { a, b } = req.query;
  res.json({ resultado: Number(a) + Number(b) });
});

// RESTA
app.get('/resta', (req, res) => {
  const { a, b } = req.query;
  res.json({ resultado: Number(a) - Number(b) });
});

module.exports = app;