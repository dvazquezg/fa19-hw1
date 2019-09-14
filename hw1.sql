DROP VIEW IF EXISTS q0, q1i, q1ii, q1iii, q1iv, q2i, q2ii, q2iii, q3i, q3ii, q3iii, q4i, q4ii, q4iii, q4iv, q4v;

-- Question 0
CREATE VIEW q0(era) AS
  SELECT MAX(era)
  FROM pitching
;

-- Question 1i
CREATE VIEW q1i(namefirst, namelast, birthyear)
AS
  SELECT namefirst, namelast, birthyear
  FROM people
  WHERE weight > 300
;

-- Question 1ii
CREATE VIEW q1ii(namefirst, namelast, birthyear)
AS
  SELECT namefirst, namelast, birthyear
  FROM people
  WHERE namefirst LIKE '% %'
  --WHERE namefirst ~ '/^\s+$/'
;

-- Question 1iii
CREATE VIEW q1iii(birthyear, avgheight, count)
AS
  SELECT birthyear, AVG(height), COUNT(*)
  FROM people
  GROUP BY birthyear
  ORDER BY birthyear ASC
;

-- Question 1iv
CREATE VIEW q1iv(birthyear, avgheight, count)
AS
  SELECT birthyear, AVG(height), COUNT(*)
  FROM people
  GROUP BY birthyear
  HAVING AVG(height) > 70
  ORDER BY birthyear ASC
;

-- Question 2i
CREATE VIEW q2i(namefirst, namelast, playerid, yearid)
AS
  SELECT P.namefirst, P.namelast, P.playerid, H.yearid
  FROM people AS P, halloffame AS H
  WHERE P.playerid = H.playerid AND H.inducted = 'Y'
  ORDER BY H.yearid DESC
;

-- Question 2ii
CREATE VIEW q2ii(namefirst, namelast, playerid, schoolid, yearid)
AS
  SELECT P.namefirst, P.namelast, P.playerid, C.schoolid, H.yearid
  FROM people AS P, halloffame AS H, CollegePlaying AS C,
       Schools AS S
  WHERE P.playerid = H.playerid AND H.inducted = 'Y' 
    AND P.playerid = C.playerid AND C.schoolid = S.schoolid
    AND S.schoolstate = 'CA'
  ORDER BY H.yearid DESC, C.schoolid ASC, P.playerid ASC

;

-- Question 2iii
CREATE VIEW q2iii(playerid, namefirst, namelast, schoolid)
AS
  SELECT P.playerid, P.namefirst, P.namelast, C.schoolid
  FROM people AS P LEFT OUTER JOIN CollegePlaying AS C 
  ON P.playerid = C.playerid, halloffame AS H
  WHERE P.playerid = H.playerid AND H.inducted = 'Y' 
  ORDER BY P.playerid DESC, C.schoolid ASC

;

-- Question 3i
CREATE VIEW q3i(playerid, namefirst, namelast, yearid, slg)
AS
  SELECT P.playerid, P.namefirst, P.namelast, B.yearid, ((B.h + B.h2b + 2*B.h3b + 3*B.hr) / CAST(B.ab as float)) AS slg
  FROM people AS P NATURAL JOIN batting AS B
  WHERE B.ab > 50
  ORDER BY slg DESC, B.yearid ASC, P.playerid ASC
  LIMIT(10)

;

-- Question 3ii
CREATE VIEW q3ii(playerid, namefirst, namelast, lslg)
AS
  SELECT P.playerid, P.namefirst, P.namelast, (SUM(B.h + B.h2b + 2*B.h3b + 3*B.hr) / CAST(SUM(B.ab) as float)) AS lslg
  FROM people AS P NATURAL JOIN batting AS B
  GROUP BY P.playerid
  HAVING SUM(B.ab) > 50
  ORDER BY lslg DESC, P.playerid ASC
  LIMIT(10)
;

-- Question 3iii
CREATE VIEW q3iii(namefirst, namelast, lslg)
AS
  SELECT namefirst, namelast, lslg
  FROM (
    SELECT P1.playerid, P1.namefirst, P1.namelast, (SUM(B1.h + B1.h2b + 2*B1.h3b + 3*B1.hr) / CAST(SUM(B1.ab) as float)) AS lslg
    FROM people AS P1 NATURAL JOIN batting AS B1
    GROUP BY P1.playerid
    HAVING SUM(B1.ab) > 50
    ) as SubTable
  WHERE lslg > ANY (
    SELECT (SUM(B2.h + B2.h2b + 2*B2.h3b + 3*B2.hr) / CAST(SUM(B2.ab) as float))
    FROM people AS P2 NATURAL JOIN batting AS B2
    WHERE P2.playerid = 'mayswi01'
    GROUP BY P2.playerid
    HAVING SUM(B2.ab) > 50
    LIMIT(1)
    )
  ORDER BY namefirst ASC
;

-- Question 4i
CREATE VIEW q4i(yearid, min, max, avg, stddev)
AS
  SELECT 1, 1, 1, 1, 1 -- replace this line
;

-- Question 4ii
CREATE VIEW q4ii(binid, low, high, count)
AS
  SELECT 1, 1, 1, 1 -- replace this line
;

-- Question 4iii
CREATE VIEW q4iii(yearid, mindiff, maxdiff, avgdiff)
AS
  SELECT 1, 1, 1, 1 -- replace this line
;

-- Question 4iv
CREATE VIEW q4iv(playerid, namefirst, namelast, salary, yearid)
AS
  SELECT 1, 1, 1, 1, 1 -- replace this line
;
-- Question 4v
CREATE VIEW q4v(team, diffAvg) AS
  SELECT 1, 1 -- replace this line
;

