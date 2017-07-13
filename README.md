# Rollout-Service
**A Grape service that expose rollout gem via RESTful endpoints**

This service expose RESTfull endpoints that allows you to perform CRUD operation on [rollout](https://github.com/fetlife/rollout) gem.

This service works great with [Rollout-Dashboard](https://github.com/fiverr/rollout_dashboard) - a beautiful user interface for rollout gem) 

## End-Points Documentation:

| Description   | END POINT     |
| ------------- | ------------- |
| Get all features  | GET /api/v1/features  |
| Get specific feature by name  | GET /api/v1/features/:feature_name  |
| Get specific feature by name  | GET /api/v1/features/:feature_name  |
| Check if feature is active  | GET /api/v1/features/:feature_name/:user_id/active  |
| Create a new feature  | POST /api/v1/features/:feature_name  |
| Partially update existing feature  | PATCH /api/v1/features/:feature_name  |
| Delete a feature  | DELETE /api/v1/features/:feature_name  |


# FAQ

# How to set redis configuration?
Edit `./config/redis.yml`

## How to start the service? 
Run 
```
REDIS_URL="redis://localhost:6379" ALLOWED_EMAILS="user1@gmail.com,user2@gmail.com" OAUTH_ALLOWED_DOMAIN="my.domain.com" bundle exec rackup -p 4000
```
Specify proper REDIS_URL, ALLOWED_EMAILS and service port. In this example the service will listen on port 4000.
If OAUTH_ALLOWED_DOMAIN is specified only users authorized with that domain are allowed.