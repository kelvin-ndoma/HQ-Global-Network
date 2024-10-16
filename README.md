# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
Log In:

Request Type: POST
URL: http://localhost:3000/sessions
Body (JSON):
json
Copy code
{
  "user": {
    "email": "john.doe@example.com",
    "password": "securepassword"
  }
}
<!-- Check Login Status:

Request Type: GET
URL: http://localhost:3000/sessions/logged_in
Log Out:

Request Type: DELETE (or POST based on your route configuration)
URL: http://localhost:3000/sessions/logout
Update User Information:

Request Type: PATCH
URL: http://localhost:3000/sessions
Body (JSON):
json
Copy code
{
  "user": {
    "first_name": "John",
    "last_name": "Doe",
    "photo": "https://example.com/new_photo.jpg",
    "bio": "An updated bio."
  }
} -->