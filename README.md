# BusyBiz API

BusyBiz - An API for querying, filtering, sorting, and searching business details from all around the world. 

## Usage

### Authentication
Register as a user to get a JWT Bearer token.
Set the token in your header when making requests to the businesses and searches endpoint\
``` "Authorization": "Bearer BEARER_TOKEN"```\
If you lost your token, no worries, call the /refresh-token endpoint to get new one.

### API Endpoints

[Documentation](https://busybiz.herokuapp.com/api-docs)

[Postman Collection](https://www.getpostman.com/collections/2c13bd4affdda315b2b5)


## Features
- JWT Authentication
- [Yelp Fusion API](https://www.yelp.com/fusion)
- [Geocoder](https://github.com/alexreisner/geocoder)
- RSpec Testing Suite
- Docker

## Testing
![alt test](https://p63.f2.n0.cdn.getcloudapp.com/items/OAuqqNR9/Image%202020-08-13%20at%2011.20.10%20PM.png)

## Hosting
BusyBiz is hosted on Heroku
`https://busybiz.herokuapp.com/`