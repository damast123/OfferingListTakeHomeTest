const request = require('supertest')
const app = require('../app')

describe("Offers", () => {
  describe("GET /", () => {
    it("should get all offers", async () => {
      const rest = await request(app).get('/api/v1/offers');
      expect(rest.statusCode).toEqual(200);
      expect(Array.isArray(rest.body)).toBe(true);

      rest.body.forEach((offer) => {
        expect(offer).toHaveProperty('_id');
        expect(offer).toHaveProperty('title');
        expect(offer).toHaveProperty('description');
        expect(offer).toHaveProperty('discountPercentage');
        expect(offer).toHaveProperty('originalPrice');
        expect(offer).toHaveProperty('discountedPrice');
      });
    });

    it("should get a single offers", async () => {
      const rest = await request(app).get('/api/v1/offers/66d976ff9b155f53b25f4e24');
      expect(rest.statusCode).toEqual(200);

      expect(rest.body['data']['offer']).toHaveProperty('_id');
      expect(rest.body['data']['offer']).toHaveProperty('title');
      expect(rest.body['data']['offer']).toHaveProperty('description');
      expect(rest.body['data']['offer']).toHaveProperty('discountPercentage');
      expect(rest.body['data']['offer']).toHaveProperty('originalPrice');
      expect(rest.body['data']['offer']).toHaveProperty('discountedPrice');
    });

    it("should not get a single offers", async () => {
      const rest = await request(app).get('/api/v1/offers/2');
      expect(rest.statusCode).toEqual(500);

      expect(rest.body).toHaveProperty('message');
      expect(rest.body).toHaveProperty('error');
    });
  });
  
  describe("POST /", () => {
    it('should POST a new offer', async () => {
      let offer = {
        title: 'New Offer 3',
        description: 'Great Offer 3',
        discountPercentage: 15.0,
        originalPrice: 400000,
        discountedPrice: 360000,
      };
      const rest = await request(app).post('/api/v1/offers').send(offer);
      expect(rest.statusCode).toEqual(201);

      expect(rest.body).toEqual(offer);
    });
  });

  describe("PUT /", () => {
    it('should PUT an existing offer', async () => {
      let offer = {
        title: 'Offer List Baru',
        description: 'Ini offer list baru dari saya',
        discountPercentage: 5.0,
        originalPrice: 600000,
        discountedPrice: 540000,
      };
      const rest = await request(app).put('/api/v1/offers/66da9e1277dc130d2833773c').send(offer);
      expect(rest.statusCode).toEqual(202);
    });
    
    it('should not PUT an existing offer', async () => {
      let offer = {
        title: 'Offer List Baru',
        description: 'Ini offer list baru dari saya',
        discountPercentage: 5.0,
        originalPrice: 600000,
        discountedPrice: 540000,
      };
      const rest = await request(app).put('/api/v1/offers/3').send(offer);
      expect(rest.statusCode).toEqual(500);
    });
  });

  describe("Delete /", () => {
    it('should Delete an existing offer', async () => {
      const rest = await request(app).delete('/api/v1/offers/66da9e1277dc130d2833773c');
      expect(rest.statusCode).toEqual(204);
    });

    it('should not Delete an existing offer', async () => {
      const rest = await request(app).delete('/api/v1/offers/3');
      expect(rest.statusCode).toEqual(500);
    });
  });
});