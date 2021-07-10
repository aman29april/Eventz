
# Eventz - Clock In/Out

This README contains steps for local setup and more information about the application

## Introduction
Eventz is Ruby on Rails based application for clock in and out events. This is a MVP product with minimum functionalities that can be used by employees for logging IN and Out timings.

## Tech Stack
* Ruby (2.4.3)
* Rails (5.2.6)
* PostgreSQL (Versions 9.1 and up)

## Running Locally
Make sure above requirements are fulfilled before running this application.
Navigate to project directory and follow following commands

```bash
bundle install
```
Above command will install all the required gems.

```bash
bin/rails db:setup
```
Above command will install all the required gems.

```bash
bin/rails server
```
Rails Server will start and you can visit `localhost:3000` in your web browser.

## Live Version
Live version can be found at

## Running Tests

Run below command from project folder.
```bash
bin/rails test test/*
```
### Assumptions
* Every clock event has a username field, which should be unique for the users.
* Username will have length between 3 and 40.
* While displaying username on home page, it's trimmed if length is more than 10.