
# Eventz - Clock In/Out

## Introduction
**Eventz** is Ruby on Rails based application for clock in and out events. This is a MVP product with minimum functionalities that can be used by employees for logging IN and Out timings.

### Live Demo
Live demo can be found at https://eventz-io.herokuapp.com

### Tech Stack
* Ruby (2.4.3)
* Rails (5.2.6)
* PostgreSQL (13.3.1)

### Running Locally
Make sure above requirements are fulfilled before running this application.
Navigate to project directory and follow following commands

`bundle install` will install all the required gems.

`rails db:setup` command will install all the required gems.

 `rails server` Rails Server will start and you can visit `localhost:3000` in your web browser.

### Running Tests
Run `rails test test/*` command from project folder.
## Assumptions
* Every clock event has a `username` field, which should be `unique` for the users.
  * As of now, there is no uniqueness validation on username.
  * Username will have length between 3 and 40.
  * Username should start with alphabet. Currently there is not validation on username.
  * While displaying username on home page, it's trimmed if length is more than 10.
* At time of event creation, current datetime is used event time and user can change later by editing the entry.
* Validations on Clock IN/OUT:
  * Clock OUT should be greater than clock IN
  * Max difference between clock OUT and Clock IN should be 8 hours
  

## Features
* Clock In/Out entries can be created with username.
* Entries can be modified and destroyed.
* User will get error message if criteria is not fulfilled.
* User can see Total Clocked Time for the day on user page

###Screens
* **Home Screen**
  + Lists all the events by all users
  + Events can be created by adding username, type
  + Events can be deleted
* **User Screen**
  + User can see own events
  + Easy Mechanism to add IN and OUT events
  + User can see total time spent for the day
* **Edit clock Event Screen**
  + Update clock event details like username, Clock IN/OUT time
## Development process and planning
* Initially, I was creating _separate entries_ for Clock IN and clock OUT events. Soon I realized that it would be problematic as If the user deletes an entry, data will become falsy. Also If we have to calculate total working hours, we have to compute time difference in different records and IN and OUT should in sequence.
* So I changed my approach and started to record IN and OUT in a single record. Every IN entry should have an OUT and having it in the same table makes sense.

## Design
* This application is using Ruby on Rails only. It’s not a single page application and I am using rails views to render response. The application is simple and easy to use.
* For persistence, **Postgres** is being used. We have structured data and later on, we may want to perform complex queries to generate timesheet and reports. So I choose SQL based database.
* There is no authentication as of now. For an MVP, I wanted to build a working application with important functionalities.
* The application is hosted on Heroku free instance and we can use some `elastic server` in case our app becomes popular and attract thousands or millions of users. Also generally we can predict peak hours as general check-in and checkout time would be at start and end of the day.

## Database Schema
Table Name: `clock_events`

|             | username      | event_type | clock_in_at | clock_out_at | hours_clocked |
|-------------|---------------|------------|-------------|--------------|---------------|
| type        | string        | boolean    | datetime    | datetime     | float         |
| constraints | 3 to 40 chars | not null   | not null    |              | default: 0    |
| index       | yes           |            | yes         |              |               |

* When `clock_out_at` is getting saved, I am computing `hours_clocked`, which would make our calculations easy.
* As I am searching records on username and clock_in_at, these columns are getting `indexed` as well.
* Having both IN/OUT timings in same table give following benefits
  * If we store IN, OUT separately, any event could be deleted, but now we can delete matching events
  * Easier Computation of timesheet
  
## Other Alternatives I considered
* Instead of using rails for the whole application, I could have used rails as a backed and some frontend framework like ember.js or react.js for rendering HTML.
* If we need to have a mobile app, then we would need APIs. In that case, hybrid applications using PhoneGap or writing native mobile apps or using a framework like Flutter and consuming APIs could be considered.

## If I were given another day to work on this
* I would add some **authentication** and only current login user could enter and see their hours.
* Giving ability to users to **filter** data for a week, month or date range.

## If I were given a month to work on this
* I would add **roles** to users and admin roles can see all users and their respective hours.
* Admin can perform **filtration** based on criteria like users who have not completed threshold hours for the week or month, users who are overworking, etc.
* Prohibit a user to log overlapping time slots.
* Add Multilingual support
* Execute some policy if Clock OUT is not done for the day.
