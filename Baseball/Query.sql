.echo off
.headers off
SELECT '' ;
SELECT '' ;
SELECT '**** Standard questions ****' ;
SELECT '10 at 5 points each for 50 points' ;
SELECT '' ;
SELECT '' ; SELECT 'Query 1';
.headers on

-- Query 1
-- Print the player name, player number, and player team
-- for all catchers (position 2)

SELECT name,number,team from Player
Where position=2;

.headers off
SELECT '' ; SELECT 'Query 2' ;
.headers on

-- Query 2
-- Print the coach name and team name for all the managers (a type of coach).

SELECT Coach.name,Team.name from Coach
Inner join Team on Coach.team=Team.name
WHERE Coach.title="Manager";


.headers off
SELECT '' ; SELECT 'Query 3' ;
.headers on

-- Query 3
-- Print the player name, number, and position (as a title) for all
-- outfielders (positions 7-9) whose home field is 'Fenway Park'.

SELECT Player.name,Player.number,Position.title from Player
Inner join Position on Player.position=Position.posnum
Inner join Team on Player.team=Team.name
where team.ballpark="Fenway Park"
and Position.posnum Between 7 and 9;

.headers off
SELECT '' ; SELECT 'Query 4' ;
.headers on

-- Query 4
-- Print the names and numbers of the hitting coaches for 'Hanley Ramirez'.
-- There may be more than one; any coach with a title containing 'Hitting'
-- anywhere within it is a hitting coach.

SELECT Coach.name,Coach.number from Coach
Inner join Team on Coach.team=Team.name
Inner join Player on Player.team=Coach.team
Where Coach.title Like '%Hitting%'
and Player.name="Hanley Ramirez";

.headers off
SELECT '' ; SELECT 'Query 5' ;
.headers on

-- Query 5
-- Print the player name, pitching coach name, and team name for
-- all pitchers (position 1) who are over 30 years old.
-- Pitching coaches have 'Pitching' somewhere in their title.

SELECT Player.name,Coach.name,Team.name from Player
Inner join Coach on Coach.team=Player.team
Inner join Team on Team.name=Player.team
Where Coach.title Like '%Pitching%'
and Player.position=1
and Player.age>30;

.headers off
SELECT '' ; SELECT 'Query 6' ;
.headers on

-- Query 6
-- Print the names, numbers, and ages of all infielders (positions 3-6)
-- whose home field is 'Camden Yards'.

SELECT Player.name,Player.number,Player.age from Player
Inner join Team on Team.name=Player.team
Where Team.ballpark="Camden Yards"
and Player.position Between 3 and 6;

.headers off
SELECT '' ; SELECT 'Query 7' ;
.headers on

-- Query 7
-- Print the names, numbers, and team of all outfielders (positions 7-9)
-- whose manager's first name is 'John'

SELECT Player.name,Player.number,Player.team from Player
Inner join Coach on Coach.team=Player.team
Where Coach.title="Manager"
and Coach.name Like '%John%'
and Player.position Between 7 and 9;

.headers off
SELECT '' ; SELECT 'Query 8' ;
.headers on

-- Query 8
-- Print the names of the bullpen coaches for teams on the Eastern Seaboard
-- (Boston, Baltimore, and New York).
-- HINT: search for "bullpen coach"

SELECT Coach.name from Coach
Inner join Team on Coach.team=Team.name
where Coach.title="Bullpen Coach"
and (Team.city="New York"
or Team.city="Boston"
or Team.city="Baltimore");

.headers off
SELECT '' ; SELECT 'Query 9' ;
.headers on

-- Query 9
-- Print the name, position, number, and team of all players whose
-- position is greater than their (jersey) number.

SELECT name,position,number,team from Player
Where position>number;

.headers off
SELECT '' ; SELECT 'Query 10' ;
.headers on

-- Query 10
-- Print the name and position title for all players whose (first) name
-- begins with 'D'

SELECT Player.name, Position.title from Player
Inner Join Position on Player.position=Position.posnum
Where SUBSTR(Player.name,1,1)="D";

.headers off
SELECT '' ;
SELECT '' ;
SELECT '**** Extra credit ****'  ;
SELECT '5 at 2 points each for 10 bonus points max.' ;
SELECT '' ;
SELECT '' ; SELECT 'Extra Credit 1' ;
.headers on

-- Query EC1
-- Create a listing of all player names and numbers for players on the 'Rays'
-- sorted by ascending name.
-- See ORDER BY

SELECT Player.name,Player.number from Player
Inner Join Team on Player.team=Team.name
Where Team.name="Rays"
Order By Player.name ASC;

.headers off
SELECT '' ; SELECT 'Extra Credit 2' ;

-- Query EC2
-- How many infielders (positions 3-6) are in the database?
-- See the count() function.

SELECT Count(position)
from Player
Where position between 3 and 6;

SELECT '' ; SELECT 'Extra Credit 3' ;

-- Query EC3
-- What is the average age of all pitchers (position 1) in the database (rounded to
-- two fractional digit)?
-- See the avg() and round() functions.

SELECT ROUND(AVG(Player.age),2) AS RoundValue
from Player
Inner Join Position on Player.position=Position.posnum
Where Player.position=1;

SELECT '' ; SELECT 'Extra Credit 4' ;

-- Query EC4
-- How many infielders (positions 3-6) are there in the database *by team*?
-- Each output line has a count and a team name.
-- See GROUP BY

SELECT COUNT(position), Team.name
from Player
Inner join Team on Player.team=Team.name 
Where position Between 3 and 6
Group by Player.team;

SELECT '' ; SELECT 'Extra Credit 5' ;

-- Query EC5
-- What is the average age of all pitchers (position 1) in the database *by team*?
-- Each output line has an average age rounded to two fractional digits and a team name.
-- The lines should be ordered by increasing average age.
-- See GROUP BY

SELECT ROUND(AVG(Player.age),2) AS RoundValue, Player.team
from Player
Inner join Position on Player.position=Position.posnum
Where Player.position=1
Group by Player.team
Order By AVG(Player.age) ASC;
