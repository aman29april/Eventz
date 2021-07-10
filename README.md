
# Eventz - Clock In/Out

This README contains steps for local setup and more information about the application

## Introduction
Eventz is Ruby on Rails based application for clock in and out events. This is a MVP product with minimum functionalities that can be used by employees for logging IN and Out timings.

### Live Demo
Live demo can be found at https://eventz-io.herokuapp.com

## Tech Stack
* Ruby (2.4.3)
* Rails (5.2.6)
* PostgreSQL (13.3.1)

## Running Locally
Make sure above requirements are fulfilled before running this application.
Navigate to project directory and follow following commands

`bundle install` will install all the required gems.

`rails db:setup` command will install all the required gems.

 `rails server` Rails Server will start and you can visit `localhost:3000` in your web browser.

## Running Tests

Run `rails test test/*` command from project folder.
## Assumptions
* Every clock event has a `username` field, which should be `unique` for the users.
  * As of now, there is no uniqueness validation on username.
* Username will have length between 3 and 40.
* While displaying username on home page, it's trimmed if length is more than 10.
* At time of event creation, current datetime is used event time and user can change later by editing the entry. 

## Features
* Clock In/Out entries can be created with username.
* Entries can be modified and destroyed.
* User will get error message if criteria is not fulfilled.

## Schema Design
* This application is using Ruby on Rails only. It’s not a single page application and I am using rails views to render response. The application is simple and easy to use.
* For persistence, Postgres is being used. We have structured data and later on, we may want to perform complex queries to generate timesheets and reports. So I choose SQL based database.
* There is no authentication as of now. For an MVP, I wanted to build a working application with important functionalities.
* The application is hosted on Heroku free instance and we can use some elastic server in case our app becomes popular and attract thousands or millions of users. Also generally we can predict peak hours as general check-in and checkout time would be at stand and end of the day.

## Other Alternatives I considered
* Instead of using rails for the whole application, I could have used rails as a backed and some frontend framework like ember.js or react.js for rendering HTML.
* If we need to have a mobile app, then we would need APIs. In that case, hybrid applications using PhoneGap or writing native mobile apps or using a framework like Flutter and consuming APIs could be considered.

## If I were given another day to work on this
* I would add some authentication and only current login user could enter and see their hours.
* Prohibit a user to log similar consecutive events. Like after log In, the user can enter only log out.
* Also for the current day, I would like to show the number of hours the user has worked.

## If I were given a month to work on this
* I would add roles to users and admin roles can see all users and their respective hours.
* Users can apply date range filters to the data
* Pagination on pages.
* Admin can perform filtration based on criteria like users who have not completed threshold hours for the week or month, users who are overworking, etc.

