# README

This project is an API for the a Ruby Backend Code Challenge.

This API can:
- Provide to users a stateless integer incrementation API:
   - Get a integer (That is stored in the server)
   - Increment that number by one
   - Reset that number to 0 or a positive number
- Grant the ability to users to register their email/password to get a JWT token
- Enable those users to edit/get their own users


## Requirements
To run this API, you need to install in your system:
- SQLITE 3
- Ruby 2.6
- Rails 5.2

I recommend installing those dependencies with `rvm`.

After that, you need to do those steps:
1. Run `bundle` to install other dependencies
2. Run `bin/rails db:migrate` to start the database
3. Copy the **config/jwt.yml.default** file and name it **config/jwt.yml**. Open that file and give a the `api_key` a secret hash (at least for Development and Test environments)
4. Run `bin/rails server` to start the server

## How to use this API:

First, you need to create a user. You need to do a `POST` request to the **users** route with those parameters:

```
   {
       "users": {
           "email": "",
           "password": ""
       }
   }
```

Using the **login** route, you can send the same parameters to receive a **JWT TOKEN**. Send it as a header using `Authorization: Bearer TOKEN` so you can able to access other routes in the API.

### Users

#### POST

Create a new user.

##### Params:

```
   {
       "users": {
           "email": "",
           "password": ""
       }
   }
```

#### GET

Get token bearer user information from the database

#### PUT/PATCH

Update the token bearer user information. **Only one of the parameter is obligatory**

```
   {
       "users": {
           "email": "",
           "password": ""
       }
   }
```

### Integer

Those are the routes that store and advance the integer that the users use.

#### integer/current - GET

GET the token bearer’s current integer. If nothing is set, returns 0

#### integer/current/{number} - PUT

Set the token bearer’s integer in the database to **{number}**. **{number}** can't be negative

#### integer/next - PUT

Increment the token bearer’s integer by one.

## Test

To run the tests, use the command "bin/rails test"


## Challenge Notes

I had some time constraints while doing this challenge (I had to work during the weekend) limiting my time with it. I only half-made some of the suggestions of the challenge to show you that I know how some of those concepts must be applied and how they work.

More specifically:
- Only some routes in **users_controller** has the JSON.API format.
- Only the models and the **users_controllers** have tests.

Other than that I have some observations about some of my decisions:
- For the **Integers Increment part**, I opted to insert every action the user makes so we can have a log of when those numbers were incremented and in what order. This is a very important to do right now, because it can be something the user might need.
- I opted to only allow the show/update route to work only for the **token bearer’s user** for security reasons. I also found important to include those routes to give the user power over their registered password and email. I'm also aware of some security problems that this implementation can open, but in a production situation I would ask my Product Owner/Project Manager if we should enable that.
- Disabled some **middlewares** in the **config/application.rb** to slim the whole API, because those middlewares (Related to file upload/download) are not useful right now to the API
- I made the **JWT HASH KEY** in a config file because this key MUST be different to each system/environment and I think it should be a separated token from the main application’s to avoid having too much dependencies in a same token, thus, making the API more insecure.
- The only external dependencies gem that I have included in the project is the **JWT gem**.
- For the production environment to work, I required the requests to be made with HTTPS to increase security (Protecting against network sniffing). This can be changed in the production environment configuration file

