-- Keep a log of any SQL queries you execute as you solve the mystery.

-- TO FIND OUT:
-- Who the thief is?
-- What city the thief escaped to?
-- Who the thief's accomplice is?

-- FACTS:
-- Theft: 28th July 2021
-- Place: Humphrey Street bakery
-- Time: 10:15am
-- Victim: The CS50 Duck has been stolen!

-- LEAD 1: Check crime scene report table, looking for a crime scene report that matches the date and the location of the crime.
/*
SELECT * FROM crime_scene_reports WHERE day = 28 AND month = 7 AND year = 2021 AND street = "Humphrey Street";

| 295 | 2021 | 7     | 28  | Humphrey Street | Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery. Interviews were
conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery. |
| 297 | 2021 | 7     | 28  | Humphrey Street | Littering took place at 16:36. No known witnesses.
*/

-- LEAD 2 (from crime scene report): Check witness statements of three witnesses
/*
SELECT * FROM interviews WHERE day = 28 AND month = 7 AND year = 2021 AND transcript LIKE "%bakery%";

| 161 | Ruth    | 2021 | 7     | 28  | Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery
parking lot and drive away.
If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.

| 162 | Eugene  | 2021 | 7     | 28  | I don't know the thief's name, but it was someone I recognized. Earlier this morning,
before I arrived at Emma's bakery,
I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.

| 163 | Raymond | 2021 | 7     | 28  | As the thief was leaving the bakery, they called someone
who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest
flight out of Fiftyville tomorrow.
The thief then asked the person on the other end of the phone to purchase the flight ticket. |
*/



-- LEAD 3 (from crime scene report, from witness statement of Ruth): Check bakery security logs;
-- Look for a car that left the parking lot in the timeframe within 10 min of the theft
/*
SELECT * FROM bakery_security_logs WHERE day = 28 AND month = 7 AND year = 2021;

254 | 2021 | 7     | 28  | 9    | 14     | entrance | 4328GD8         |

| 255 | 2021 | 7     | 28  | 9    | 15     | entrance | 5P2BI95       |

| 256 | 2021 | 7     | 28  | 9    | 20     | entrance | 6P58WS2       |
| 257 | 2021 | 7     | 28  | 9    | 28     | entrance | G412CB7       |
| 258 | 2021 | 7     | 28  | 10   | 8      | entrance | R3G7486       |
| 259 | 2021 | 7     | 28  | 10   | 14     | entrance | 13FNH73       |
-----------------------------------------------------------------------


| 260 | 2021 | 7     | 28  | 10   | 16     | exit     | 5P2BI95       |

SELECT * FROM people WHERE license_plate = "5P2BI95";

+--------+---------+----------------+-----------------+---------------+
|   id   |  name   |  phone_number  | passport_number | license_plate |
+--------+---------+----------------+-----------------+---------------+
| 221103 | Vanessa | (725) 555-4692 | 2963008352      | 5P2BI95       |
+--------+---------+----------------+-----------------+---------------+

| 261 | 2021 | 7     | 28  | 10   | 18     | exit     | 94KL13X

SELECT * FROM people WHERE license_plate = "94KL13X";

+--------+-------+----------------+-----------------+---------------+
|   id   | name  |  phone_number  | passport_number | license_plate |
+--------+-------+----------------+-----------------+---------------+
| 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       | <<
+--------+-------+----------------+-----------------+---------------+


| 262 | 2021 | 7     | 28  | 10   | 18     | exit     | 6P58WS2     |

SELECT * FROM people WHERE license_plate = "6P58WS2";

+--------+-------+----------------+-----------------+---------------+
|   id   | name  |  phone_number  | passport_number | license_plate |
+--------+-------+----------------+-----------------+---------------+
| 243696 | Barry | (301) 555-4174 | 7526138472      | 6P58WS2       |
+--------+-------+----------------+-----------------+---------------+


| 263 | 2021 | 7     | 28  | 10   | 19     | exit     | 4328GD8     |

SELECT * FROM people WHERE license_plate = "4328GD8";

+--------+------+----------------+-----------------+---------------+
|   id   | name |  phone_number  | passport_number | license_plate |
+--------+------+----------------+-----------------+---------------+
| 467400 | Luca | (389) 555-5198 | 8496433585      | 4328GD8       | <<
+--------+------+----------------+-----------------+---------------+


| 264 | 2021 | 7     | 28  | 10   | 20     | exit     | G412CB7    |

SELECT * FROM people WHERE license_plate = "G412CB7";

+--------+-------+----------------+-----------------+---------------+
|   id   | name  |  phone_number  | passport_number | license_plate |
+--------+-------+----------------+-----------------+---------------+
| 398010 | Sofia | (130) 555-0289 | 1695452385      | G412CB7       |
+--------+-------+----------------+-----------------+---------------+

| 265 | 2021 | 7     | 28  | 10   | 21     | exit     | L93JTIZ     |

SELECT * FROM people WHERE license_plate = "L93JTIZ";

+--------+------+----------------+-----------------+---------------+
|   id   | name |  phone_number  | passport_number | license_plate |
+--------+------+----------------+-----------------+---------------+
| 396669 | Iman | (829) 555-5269 | 7049073643      | L93JTIZ       | <<
+--------+------+----------------+-----------------+---------------+

| 266 | 2021 | 7     | 28  | 10   | 23     | exit     | 322W7JE     |

SELECT * FROM people WHERE license_plate = "322W7JE";

+--------+-------+----------------+-----------------+---------------+
|   id   | name  |  phone_number  | passport_number | license_plate |
+--------+-------+----------------+-----------------+---------------+
| 514354 | Diana | (770) 555-1861 | 3592750733      | 322W7JE       | <<
+--------+-------+----------------+-----------------+---------------+


| 267 | 2021 | 7     | 28  | 10   | 23     | exit     | 0NTHK55     |

SELECT * FROM people WHERE license_plate = "0NTHK55";

+--------+--------+----------------+-----------------+---------------+
|   id   |  name  |  phone_number  | passport_number | license_plate |
+--------+--------+----------------+-----------------+---------------+
| 560886 | Kelsey | (499) 555-9472 | 8294398571      | 0NTHK55       |
+--------+--------+----------------+-----------------+---------------+

| 268 | 2021 | 7     | 28  | 10   | 35     | exit     | 1106N58

SELECT * FROM people WHERE license_plate = "1106N58";

+--------+--------+----------------+-----------------+---------------+
|   id   |  name  |  phone_number  | passport_number | license_plate |
+--------+--------+----------------+-----------------+---------------+
| 449774 | Taylor | (286) 555-6063 | 1988161715      | 1106N58       | <<
+--------+--------+----------------+-----------------+---------------+


*/



-- LEAD 5 (from witness statement of Eugene): Thief was known to Eugene (check EUGENE AS A SUSPECT);
-- Thief was withdrawing money from ATM on Leggett Street
/*
SELECT * FROM atm_transactions WHERE day = 28 AND month = 7 AND year = 2021 AND atm_location = "Leggett Street";

+-----+----------------+------+-------+-----+----------------+------------------+--------+
| id  | account_number | year | month | day |  atm_location  | transaction_type | amount |
+-----+----------------+------+-------+-----+----------------+------------------+--------+
| 246 | 28500762       | 2021 | 7     | 28  | Leggett Street | withdraw         | 48     | << Luca

| 264 | 28296815       | 2021 | 7     | 28  | Leggett Street | withdraw         | 20     |

| 266 | 76054385       | 2021 | 7     | 28  | Leggett Street | withdraw         | 60     | << Taylor
| 267 | 49610011       | 2021 | 7     | 28  | Leggett Street | withdraw         | 50     | << Bruce
| 269 | 16153065       | 2021 | 7     | 28  | Leggett Street | withdraw         | 80     |
| 275 | 86363979       | 2021 | 7     | 28  | Leggett Street | deposit          | 10     |
| 288 | 25506511       | 2021 | 7     | 28  | Leggett Street | withdraw         | 20     | << Iman
| 313 | 81061156       | 2021 | 7     | 28  | Leggett Street | withdraw         | 30     |
| 336 | 26013199       | 2021 | 7     | 28  | Leggett Street | withdraw         | 35     | << Diana
+-----+----------------+------+-------+-----+----------------+------------------+--------+


SELECT * FROM bank_accounts WHERE account_number = 28500762 OR account_number = 28296815 OR account_number = 76054385 OR account_number = 49610011 OR account_number = 16153065;
+----------------+-----------+---------------+
| account_number | person_id | creation_year |
+----------------+-----------+---------------+
| 49610011       | 686048    | 2010          | << Bruce
| 16153065       | 458378    | 2012          |

| 28296815       | 395717    | 2014          |

| 28500762       | 467400    | 2014          | << Luca
| 76054385       | 449774    | 2015          | << Taylor
+----------------+-----------+---------------+

SELECT * FROM bank_accounts WHERE account_number = 86363979 OR account_number = 25506511 OR account_number = 81061156 OR account_number = 26013199;
+----------------+-----------+---------------+
| account_number | person_id | creation_year |
+----------------+-----------+---------------+
| 86363979       | 948985    | 2010          |
| 26013199       | 514354    | 2012          | << Diana
| 25506511       | 396669    | 2014          | << Iman
| 81061156       | 438727    | 2018          |
+----------------+-----------+---------------+
*/


-- LEAD 6 (from witness statement of Raymond): Thief was talking on the phone and planning to take a flight
-- out Fiftyville on 29th July 2021. The thief asked to purchase a flight ticket.

/*
SELECT * FROM airports WHERE city = "Fiftyville";
+----+--------------+-----------------------------+------------+
| id | abbreviation |          full_name          |    city    |
+----+--------------+-----------------------------+------------+
| 8  | CSF          | Fiftyville Regional Airport | Fiftyville |
+----+--------------+-----------------------------+------------+
*/

-- LEAD 7: Check flights from Fyftyville on the 29th July 2021
/*
SELECT * FROM flights WHERE day = 29 AND month = 7 AND year = 2021 AND origin_airport_id = 8 ;

+----+-------------------+------------------------+------+-------+-----+------+--------+
| id | origin_airport_id | destination_airport_id | year | month | day | hour | minute |
+----+-------------------+------------------------+------+-------+-----+------+--------+
| 18 | 8                 | 6                      | 2021 | 7     | 29  | 16   | 0      | << Diana
| 23 | 8                 | 11                     | 2021 | 7     | 29  | 12   | 15     |
| 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     | << Bruce
| 43 | 8                 | 1                      | 2021 | 7     | 29  | 9    | 30     |
| 53 | 8                 | 9                      | 2021 | 7     | 29  | 15   | 20     |
+----+-------------------+------------------------+------+-------+-----+------+--------+
*/

-- LEAD 8: Check passengers
/*
SELECT * FROM passengers WHERE passport_number = 5773159633 OR passport_number = 8496433585 OR passport_number = 1988161715 OR passport_number = 7049073643 OR passport_number = 3592750733;
+-----------+-----------------+------+
| flight_id | passport_number | seat |
+-----------+-----------------+------+
| 11        | 8496433585      | 5D   |
| 18        | 3592750733      | 4C   |<< Diana
| 24        | 3592750733      | 2C   |
| 26        | 7049073643      | 2C   |
| 36        | 5773159633      | 4A   |<< Bruce
| 36        | 1988161715      | 6D   |<< Taylor
| 36        | 8496433585      | 7B   |<< Luca
| 48        | 8496433585      | 7C   |
| 54        | 3592750733      | 6C   |
+-----------+-----------------+------+

Checking Diana and Philip passport numbers in the passengers list
SELECT * FROM passengers WHERE passport_number =  3391710505; -- FOR Philip
+-----------+-----------------+------+
| flight_id | passport_number | seat |
+-----------+-----------------+------+
| 10        | 3391710505      | 2A   |
| 28        | 3391710505      | 2A   |
| 47        | 3391710505      | 4D   |
*/


-- LEAD 9: Check phone records - who did the thief talk to for less than a minute between 10:00 and 10:30?
/*
SELECT * FROM phone_calls WHERE day = 28 AND month = 7 AND year = 2021 AND duration <= 60;

+-----+----------------+----------------+------+-------+-----+----------+
| id  |     caller     |    receiver    | year | month | day | duration |
+-----+----------------+----------------+------+-------+-----+----------+
| 221 | (130) 555-0289 | (996) 555-8899 | 2021 | 7     | 28  | 51       |
| 224 | (499) 555-9472 | (892) 555-8872 | 2021 | 7     | 28  | 36       |
| 233 | (367) 555-5533 BRUCE | (375) 555-8161 | 2021 | 7     | 28  | 45       |
| 234 | (609) 555-5876 | (389) 555-5198 | 2021 | 7     | 28  | 60       |
| 251 | (499) 555-9472 | (717) 555-1342 | 2021 | 7     | 28  | 50       |
| 254 | (286) 555-6063 | (676) 555-6554 | 2021 | 7     | 28  | 43       |
| 255 | (770) 555-1861 DIANA | (725) 555-3243 PHILIPP | 2021 | 7     | 28  | 49       |
| 261 | (031) 555-6622 | (910) 555-3251 | 2021 | 7     | 28  | 38       |
| 279 | (826) 555-1652 | (066) 555-9701 | 2021 | 7     | 28  | 55       |
| 281 | (338) 555-6650 | (704) 555-2131 | 2021 | 7     | 28  | 54       |
+-----+----------------+----------------+------+-------+-----+----------+

Checking receiver numbers from Bruce and Diana's calls:
SELECT * FROM people WHERE phone_number = "(375) 555-8161" OR phone_number = "(725) 555-3243";

+--------+--------+----------------+-----------------+---------------+
|   id   |  name  |  phone_number  | passport_number | license_plate |
+--------+--------+----------------+-----------------+---------------+
| 847116 | Philip | (725) 555-3243 | 3391710505      | GW362R6       |
| 864400 | Robin  | (375) 555-8161 |                 | 4V16VO0       |
*/

-- SUSPECTS:

/*
+--------+-------+----------------+-----------------+---------------+
|   id   | name  |  phone_number  | passport_number | license_plate |
+--------+-------+----------------+-----------------+---------------+
| 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       | <<
+--------+-------+----------------+-----------------+---------------+

+--------+------+----------------+-----------------+---------------+
|   id   | name |  phone_number  | passport_number | license_plate |
+--------+------+----------------+-----------------+---------------+
| 467400 | Luca | (389) 555-5198 | 8496433585      | 4328GD8       | << eliminated as thief as no phone record
+--------+------+----------------+-----------------+---------------+

+--------+--------+----------------+-----------------+---------------+
|   id   |  name  |  phone_number  | passport_number | license_plate |
+--------+--------+----------------+-----------------+---------------+
| 449774 | Taylor | (286) 555-6063 | 1988161715      | 1106N58       | << eliminated as thief as no phone record
+--------+--------+----------------+-----------------+---------------+

+--------+------+----------------+-----------------+---------------+
|   id   | name |  phone_number  | passport_number | license_plate |
+--------+------+----------------+-----------------+---------------+
| 396669 | Iman | (829) 555-5269 | 7049073643      | L93JTIZ       | << **eliminated as thief on the flight / eliminated as thief as no phone record
+--------+------+----------------+-----------------+---------------+

+--------+-------+----------------+-----------------+---------------+
|   id   | name  |  phone_number  | passport_number | license_plate |
+--------+-------+----------------+-----------------+---------------+
| 514354 | Diana | (770) 555-1861 | 3592750733      | 322W7JE       | <<
+--------+-------+----------------+-----------------+---------------+

*/

-- Check the city Diana escaped to:
-- SELECT * FROM airports WHERE id = 6;
/*
+----+--------------+-----------------------------+--------+
| id | abbreviation |          full_name          |  city  |
+----+--------------+-----------------------------+--------+
| 6  | BOS          | Logan International Airport | Boston |
+----+--------------+-----------------------------+--------+

-- Check the city Bruce escaped to:
-- SELECT * FROM airports WHERE id = 4;
+----+--------------+-------------------+---------------+
| id | abbreviation |     full_name     |     city      |
+----+--------------+-------------------+---------------+
| 4  | LGA          | LaGuardia Airport | New York City |
+----+--------------+-------------------+---------------+

*/