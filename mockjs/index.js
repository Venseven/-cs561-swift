const express = require('express');
const app = express();
// Constants
const PORT = 8080;
const HOST = '0.0.0.0';
app.get('/data/2.5/weather', (request, response) => {
    response.json({
        "coord": {
          "lon": 123.26,
          "lat": 44.56
        },
        "weather": [
          {
            "id": 801,
            "main": "Clouds",
            "description": "few clouds",
            "icon": "02d"
          }
        ],
        "base": "stations",
        "main": {
          "temp": 295.29,
          "feels_like": 294.47,
          "temp_min": 295.29,
          "temp_max": 295.29,
          "pressure": 1009,
          "humidity": 35,
          "sea_level": 1009,
          "grnd_level": 992
        },
        "visibility": 10000,
        "wind": {
          "speed": 5.48,
          "deg": 32,
          "gust": 5.65
        },
        "clouds": {
          "all": 17
        },
        "dt": 1664343405,
        "sys": {
          "country": "CN",
          "sunrise": 1664314826,
          "sunset": 1664357704
        },
        "timezone": 28800,
        "id": 2036338,
        "name": "Kaitong"
      });
  });

app.listen(PORT, HOST, () => {});