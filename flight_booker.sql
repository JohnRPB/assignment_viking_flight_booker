---- VIKING FLIGHT BOOKER WARMUP ----

-- AIRLINES
  id | origin_id | destination_id | departure_time | arrival_time | price | created_at | updated_at | airline_id | distance
-- USERS
id  | city_id | state_id | username | first_name | last_name |               email                |         created_at         |         updated_at
-- AIRPORTS
 id | city_id | state_id | code |                   long_name                    |         created_at         |         updated_at
-- CITIES
 id  |       name       |         created_at         |         updated_at
--itineraries
 id  | user_id | payment_method |         created_at         |         updated_at
 --flights
 id   | origin_id | destination_id |       departure_time       |        arrival_time        | price  |         created_at         |         updated_at         | airline_id | distance
--tickets
id  | itinerary_id | flight_id |         created_at         |         updated_at

Find the top 5 most expensive flights that end in California.

SELECT long_name
  FROM flights JOIN airports ON flights.destination_id = airports.id
    JOIN states ON states.id = airports.state_id 
  WHERE states.name = 'California'
  ORDER BY price
  LIMIT 5;

Find the shortest flight that username 'emelia' took.

SELECT *
  FROM users JOIN tickets ON users.id = tickets.id 
    JOIN flights ON flights.id = tickets.flight_id
  WHERE users.username = 'emelia'
  ORDER BY arrival_time - departure_time
  

Find the average flight distance for every city in California

SELECT AVG(distance)
  FROM flights JOIN airports ON flights.origin_id = airports.id
  WHERE state_id = (SELECT states.id FROM states WHERE states.name = 'California')
  GROUP BY distance, city_id;

Find the 3 users who spent the most money on flights in 2013

SELECT username
  FROM users JOIN tickets ON users.id = tickets.id
    JOIN flights ON tickets.flight_id = flights.id
  WHERE TO_CHAR(flights.departure_time, 'YYYY') LIKE '%2013%' 
  ORDER BY price DESC
  LIMIT 3;

Count all flights to OR from the city of Smithhaven that did not land in Delaware

SELECT COUNT(*)
  FROM airports JOIN cities ON airports.city_id = cities.id
    JOIN states ON airports.state_id = states.id
      JOIN flights ON airports.id = flights.origin_id
  WHERE cities.name = 'Smithhaven' AND NOT states.name = 'Delaware';

Find the most popular travel destination for users who live in California.

SELECT COUNT(*)
  FROM users JOIN tickets ON users.id = tickets.id
    JOIN flights ON tickets.flight_id = flights.id
      JOIN states ON users.state_id = states.id
  WHERE states.name = 'California'
  GROUP BY flights.destination_id;

How many flights have round trips possible? In other words, we want the count of all airports where there exists a flight FROM that airport and a later flight TO that airport.

Find the cheapest flight that was taken by a user who only had one itinerary.

Find the average cost of a flight itinerary for users in each state in 2012.

Bonus: You're a tourist. It's May 6, 2013. Book the cheapest set of flights over the next six weeks that connect Oregon, Pennsylvania and Arkansas, but do not take any flights over 400 miles in distance. Note: This can be ~50 lines long but doesn't require any subqueries.





