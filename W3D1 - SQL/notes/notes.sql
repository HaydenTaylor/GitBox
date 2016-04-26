-- RDBMS




-- SELECT, FROM, WHERE

SELECT
  fname
FROM
  characters
WHERE
  lname = 'Baratheon'

-- ORDER, LIMIT

SELECT
  *
FROM
  characters
WHERE
  lname = 'Baratheon'
ORDER BY
  fname
LIMIT
  3

-- LIKE, IN, NULL

SELECT
  *
FROM
  characters
WHERE
  lname LIKE 'S%'

SELECT
  *
FROM
  characters
WHERE
  lname IN ('Stark', 'Snow')

SELECT
  *
FROM
  pets
WHERE
  owner_id IS NULL

-- DISTINCT

SELECT
  DISTINCT lname
FROM
  characters

-- GROUP BY, HAVING, AGGREGATE FUNCTIONS

SELECT
  lname, COUNT(id) AS family_size
FROM
  characters
GROUP BY
  lname
HAVING
  COUNT(id) > 2

-- SUBQUERIES

-- don't actually need a subquery here, but we did it!
SELECT
  robs.lname
FROM (
  SELECT
    *
  FROM
    characters
  WHERE
    fname LIKE 'Rob%'
) AS robs

-- JOIN

-- inner join
SELECT
  *
FROM
  characters
JOIN
  pets ON pets.owner_id = characters.id

-- left outer join
SELECT
  *
FROM
  characters
LEFT OUTER JOIN
  pets ON characters.id = pets.owner_id

-- full outer join -> you probably shouldn't be using this...
SELECT
  *
FROM
  characters
FULL OUTER JOIN
  pets ON pets.owner_id = characters.id

-- house_memberships is a "join table" - used for many-to-many relationships
SELECT
  COUNT(characters.id), houses.name
FROM
  characters
JOIN
  house_memberships
ON
  characters.id = house_memberships.character_id
JOIN
  houses
ON
  house_memberships.house_id = houses.id
GROUP BY
  houses.id

-- COALESCE, CASE, CAST

-- default (this is a silly example)
SELECT
  name, COALESCE(owner_id, 25)
FROM
  pets

SELECT
  fname,
  CASE lname
    WHEN 'Stark'
      THEN 'Good'
    ELSE 'Bad'
  END AS goodness
FROM
  characters
