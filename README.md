#Meeting Room Booking

Meeting Room booking allow user to book a meeting room at a specific time, its a multi company room so you'll be able to see or booking your company's rooms.

## 1. Requirements:
    1.  Ruby 2.7.0
    2.  dotenv gem (manage multiple environments)
    3.  PostgreSQL (min version 10)

## 2. Setting project, follow next steps
  1. `gem install bundler -v 2.1.2` Installs bundler gem
  2. `gem install dotenv` Installs dotenv gem
  3. `bundle install`
  4. Set environment variables, creates .env file with next values:
  ```
      DATABASE_URL=postgres://localhost:5432/meeting_rooms_dev
      APP_ENV=dev
      DEFAULT_LOCALE=en
  ```
  5. Create database meeting_rooms_dev
     
     
## 3. Command execution
  Any command line sentence should include `dotenv -f .env`, for instance 
  - Run migrations: `dotenv -f .env rake db:migrate`
  - Run console: `dotenv -f .env rake console`
  - Run app: `dotenv -f .env shotgun`, (default port will be 9393)

## 4. Test environment
  Any command line sentence should include `dotenv -f .env.test`, and you can 
  - Create database meeting_rooms_test
  - Run test: `dotenv -f .env rspec spec/`
  
## 5. API endpoints
  1. Booked meeting room:
    - POST /v1/meeting_rooms_booking
    - Authorization: <<secret_key>> (It will be a nice to have, currently it's not checked but User table aws filled with this key)
    - Signature Request Payload:

  ```json
    {
      "user_id": 1,
      "meeting_room_id": 1,
      "booked_starts_at": "2021-09-29 10:00:00 +0200",
      "booked_ends_at": "2021-09-29 10:30:00 +0200"
    }
  ```
   - Fields information:

     | Field | Description | Data Type | Mandatory | Restrictions
     | ------------- | ------------- | ------------- | ------------- | ------------- |
     | user_id | User booking identifier | String | YES |  |
     | meeting_room_id | Meeting room identifier, this should be the room that is going to be book | String | YES |  |
     | booked_starts_at | Booked start period of time | String | YES | Datetime format with utc format |
     | booked_ends_at | Booked start period of time | String | YES |  Datetime format with utc format |

   - Signature Response:

  ```json
    {
      "data": {
          "id": "123-1234567890-12345",
          "user_id": 1,
          "meeting_room_id": 1,
          "booked_starts_at": "2021-09-29 10:00:00 +0200",
          "booked_ends_at": "2021-09-29 10:30:00 +0200",
          "status": "BOOKED"
       }
    }
  ```

  2. Booked meeting room:
    - GET /v1/meeting_rooms_booking/?company_id={company_id}
    - Authorization: <<secret_key>> (It will be a nice to have, currently it's not checked but User table aws filled with this key)
    - Expected Query Params:

   - Response

   ```json
      {
        "data": [
          {
            "id": 1,
            "max_capacity": 4,
            "status": "BOOKED",
            "created_at":  "2021-09-29 17:13:05 -0500"
          }, 
          {
            "id": 2,
            "max_capacity": 8,
            "status": "AVAILABLE",
            "created_at":  "2021-09-29 19:13:05 -0500"
          }
         ]
      }
   ```

## 6. Comments
 - Operation test was added by best practice should be create a end-to-end test on routes to ensure rigth behaviour in happy scenario and some fails response cases.
 - Also, unitary test on persistence clases enforce basic behaviour.
 - Despite at beginning, it's a single company it may be extend for more than one with the company model.
 - All messages error are set in English but I18n gem could be configured to support more than one language.
