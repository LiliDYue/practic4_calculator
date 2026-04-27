const request = require('supertest');
const app = require('../src/app');

describe('API Calculadora', () => {

  test('suma', async () => {
    const res = await request(app).get('/suma?a=2&b=3');
    expect(res.body.resultado).toBe(5);
  });

  test('resta', async () => {
    const res = await request(app).get('/resta?a=5&b=3');
    expect(res.body.resultado).toBe(2);
  });

});