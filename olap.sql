
ALL ARE VIEWS INSIDE ADMINER, POSTGRES


### Query 1 - Show the number of instruments rented per month during a specified year.
It shall be possible to retrieve the total number of rented instruments (just one number)
and rented instruments of each kind (one number per kind, guitar, trumpet, etc).
The latter list shall be sorted by number of rentals. This query is expected to be
performed a few times per week. ###

CREATE VIEW query1 AS
WITH query_consts (query_year) as (VALUES (2020))

(SELECT DISTINCT RI.instrument_type AS type,
COALESCE(c_jan.month, 0) AS jan,
COALESCE(c_feb.month, 0) AS feb,
COALESCE(c_mar.month, 0) AS mar,
COALESCE(c_apr.month, 0) AS apr,
COALESCE(c_may.month, 0) AS may,
COALESCE(c_jun.month, 0) AS jun,
COALESCE(c_jul.month, 0) AS jul,
COALESCE(c_aug.month, 0) AS aug,
COALESCE(c_sep.month, 0) AS sep,
COALESCE(c_oct.month, 0) AS oct,
COALESCE(c_nov.month, 0) AS nov,
COALESCE(c_dec.month, 0) AS dec,
COALESCE(c_tot.total, 0) AS total

FROM rental_instrument AS RI
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=1
GROUP BY I.instrument_type) AS c_jan ON RI.instrument_type=c_jan.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=2
GROUP BY I.instrument_type) AS c_feb ON RI.instrument_type=c_feb.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=3
GROUP BY I.instrument_type) AS c_mar ON RI.instrument_type=c_mar.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=4
GROUP BY I.instrument_type) AS c_apr ON RI.instrument_type=c_apr.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=5
GROUP BY I.instrument_type) AS c_may ON RI.instrument_type=c_may.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=6
GROUP BY I.instrument_type) AS c_jun ON RI.instrument_type=c_jun.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=7
GROUP BY I.instrument_type) AS c_jul ON RI.instrument_type=c_jul.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=8
GROUP BY I.instrument_type) AS c_aug ON RI.instrument_type=c_aug.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=9
GROUP BY I.instrument_type) AS c_sep ON RI.instrument_type=c_sep.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=10
GROUP BY I.instrument_type) AS c_oct ON RI.instrument_type=c_oct.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=11
GROUP BY I.instrument_type) AS c_nov ON RI.instrument_type=c_nov.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=12
GROUP BY I.instrument_type) AS c_dec ON RI.instrument_type=c_dec.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) AS total
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
GROUP BY I.instrument_type) AS c_tot ON RI.instrument_type=c_tot.instrument_type
ORDER BY total)

UNION ALL

SELECT 'Total', total_jan.count, total_feb.count, total_mar.count, total_apr.count, total_may.count, total_jun.count, total_jul.count, total_aug.count, total_sep.count, total_oct.count, total_nov.count, total_dec.count, total_tot.count
FROM
(SELECT COUNT(*)
FROM query_consts, rentals AS R
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=1) AS total_jan,
(SELECT COUNT(*)
FROM query_consts, rentals AS R
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=2) AS total_feb,
(SELECT COUNT(*)
FROM query_consts, rentals AS R
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=3) AS total_mar,
(SELECT COUNT(*)
FROM query_consts, rentals AS R
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=4) AS total_apr,
(SELECT COUNT(*)
FROM query_consts, rentals AS R
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=5) AS total_may,
(SELECT COUNT(*)
FROM query_consts, rentals AS R
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=6) AS total_jun,
(SELECT COUNT(*)
FROM query_consts, rentals AS R
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=7) AS total_jul,
(SELECT COUNT(*)
FROM query_consts, rentals AS R
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=8) AS total_aug,
(SELECT COUNT(*)
FROM query_consts, rentals AS R
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=9) AS total_sep,
(SELECT COUNT(*)
FROM query_consts, rentals AS R
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=10) AS total_oct,
(SELECT COUNT(*)
FROM query_consts, rentals AS R
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=11) AS total_nov,
(SELECT COUNT(*)
FROM query_consts, rentals AS R
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=12) AS total_dec,
(SELECT COUNT(*)
FROM query_consts, rentals AS R
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year) AS total_tot



### Query 2 - The same as above, but retrieve the average number of rentals per month
during the entire year, instead of the total for each month. ###

CREATE VIEW query2 AS
WITH query_consts (query_year) as (VALUES (2020))

(SELECT DISTINCT RI.instrument_type AS type,
COALESCE(c_jan.month, 0) AS jan,
COALESCE(c_feb.month, 0) AS feb,
COALESCE(c_mar.month, 0) AS mar,
COALESCE(c_apr.month, 0) AS apr,
COALESCE(c_may.month, 0) AS may,
COALESCE(c_jun.month, 0) AS jun,
COALESCE(c_jul.month, 0) AS jul,
COALESCE(c_aug.month, 0) AS aug,
COALESCE(c_sep.month, 0) AS sep,
COALESCE(c_oct.month, 0) AS oct,
COALESCE(c_nov.month, 0) AS nov,
COALESCE(c_dec.month, 0) AS dec,
COALESCE(c_tot.total, 0) AS total

FROM rental_instrument AS RI
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=1
GROUP BY I.instrument_type) AS c_jan ON RI.instrument_type=c_jan.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=2
GROUP BY I.instrument_type) AS c_feb ON RI.instrument_type=c_feb.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=3
GROUP BY I.instrument_type) AS c_mar ON RI.instrument_type=c_mar.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=4
GROUP BY I.instrument_type) AS c_apr ON RI.instrument_type=c_apr.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=5
GROUP BY I.instrument_type) AS c_may ON RI.instrument_type=c_may.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=6
GROUP BY I.instrument_type) AS c_jun ON RI.instrument_type=c_jun.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=7
GROUP BY I.instrument_type) AS c_jul ON RI.instrument_type=c_jul.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=8
GROUP BY I.instrument_type) AS c_aug ON RI.instrument_type=c_aug.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=9
GROUP BY I.instrument_type) AS c_sep ON RI.instrument_type=c_sep.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=10
GROUP BY I.instrument_type) AS c_oct ON RI.instrument_type=c_oct.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=11
GROUP BY I.instrument_type) AS c_nov ON RI.instrument_type=c_nov.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) as month
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
AND EXTRACT(MONTH FROM R.rental_start)=12
GROUP BY I.instrument_type) AS c_dec ON RI.instrument_type=c_dec.instrument_type
LEFT JOIN
(SELECT I.instrument_type, COUNT(I.instrument_type) AS total
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
GROUP BY I.instrument_type) AS c_tot ON RI.instrument_type=c_tot.instrument_type
ORDER BY total)

UNION ALL

SELECT 'Average', round(AVG(avg_jan.count), 2), round(AVG(avg_feb.count), 2), round(AVG(avg_mar.count), 2), round(AVG(avg_apr.count), 2),
round(AVG(avg_may.count), 2), round(AVG(avg_jun.count), 2), round(AVG(avg_jul.count), 2), round(AVG(avg_aug.count), 2),
round(AVG(avg_sep.count), 2), round(AVG(avg_oct.count), 2), round(AVG(avg_nov.count), 2), round(AVG(avg_dec.count), 2), round(AVG(avg_tot.count), 2)

FROM
(SELECT DISTINCT RI.instrument_type, COALESCE(avg_january.count, 0) AS count
FROM rental_instrument AS RI
LEFT JOIN (SELECT I.instrument_type, COUNT(I.instrument_type)
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=1 GROUP BY I.instrument_type) AS avg_january ON RI.instrument_type=avg_january.instrument_type) AS avg_jan

INNER JOIN

(SELECT DISTINCT RI.instrument_type, COALESCE(avg_february.count, 0) AS count
FROM rental_instrument AS RI
LEFT JOIN (SELECT I.instrument_type, COUNT(I.instrument_type)
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=2 GROUP BY I.instrument_type) AS avg_february ON RI.instrument_type=avg_february.instrument_type) AS avg_feb

ON avg_jan.instrument_type=avg_feb.instrument_type
INNER JOIN

(SELECT DISTINCT RI.instrument_type, COALESCE(avg_march.count, 0) AS count
FROM rental_instrument AS RI
LEFT JOIN (SELECT I.instrument_type, COUNT(I.instrument_type)
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=3 GROUP BY I.instrument_type) AS avg_march ON RI.instrument_type=avg_march.instrument_type) AS avg_mar

ON avg_feb.instrument_type=avg_mar.instrument_type
INNER JOIN

(SELECT DISTINCT RI.instrument_type, COALESCE(avg_april.count, 0) AS count
FROM rental_instrument AS RI
LEFT JOIN (SELECT I.instrument_type, COUNT(I.instrument_type)
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=4 GROUP BY I.instrument_type) AS avg_april ON RI.instrument_type=avg_april.instrument_type) AS avg_apr

ON avg_mar.instrument_type=avg_apr.instrument_type
INNER JOIN

(SELECT DISTINCT RI.instrument_type, COALESCE(avg_may.count, 0) AS count
FROM rental_instrument AS RI
LEFT JOIN (SELECT I.instrument_type, COUNT(I.instrument_type)
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=5 GROUP BY I.instrument_type) AS avg_may ON RI.instrument_type=avg_may.instrument_type) AS avg_may

ON avg_apr.instrument_type=avg_may.instrument_type
INNER JOIN

(SELECT DISTINCT RI.instrument_type, COALESCE(avg_june.count, 0) AS count
FROM rental_instrument AS RI
LEFT JOIN (SELECT I.instrument_type, COUNT(I.instrument_type)
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=6 GROUP BY I.instrument_type) AS avg_june ON RI.instrument_type=avg_june.instrument_type) AS avg_jun

ON avg_may.instrument_type=avg_jun.instrument_type
INNER JOIN

(SELECT DISTINCT RI.instrument_type, COALESCE(avg_july.count, 0) AS count
FROM rental_instrument AS RI
LEFT JOIN (SELECT I.instrument_type, COUNT(I.instrument_type)
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=7 GROUP BY I.instrument_type) AS avg_july ON RI.instrument_type=avg_july.instrument_type) AS avg_jul

ON avg_jun.instrument_type=avg_jul.instrument_type
INNER JOIN

(SELECT DISTINCT RI.instrument_type, COALESCE(avg_august.count, 0) AS count
FROM rental_instrument AS RI
LEFT JOIN (SELECT I.instrument_type, COUNT(I.instrument_type)
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=8 GROUP BY I.instrument_type) AS avg_august ON RI.instrument_type=avg_august.instrument_type) AS avg_aug

ON avg_jul.instrument_type=avg_aug.instrument_type
INNER JOIN

(SELECT DISTINCT RI.instrument_type, COALESCE(avg_september.count, 0) AS count
FROM rental_instrument AS RI
LEFT JOIN (SELECT I.instrument_type, COUNT(I.instrument_type)
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=9 GROUP BY I.instrument_type) AS avg_september ON RI.instrument_type=avg_september.instrument_type) AS avg_sep

ON avg_aug.instrument_type=avg_sep.instrument_type
INNER JOIN

(SELECT DISTINCT RI.instrument_type, COALESCE(avg_october.count, 0) AS count
FROM rental_instrument AS RI
LEFT JOIN (SELECT I.instrument_type, COUNT(I.instrument_type)
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=10 GROUP BY I.instrument_type) AS avg_october ON RI.instrument_type=avg_october.instrument_type) AS avg_oct

ON avg_sep.instrument_type=avg_oct.instrument_type
INNER JOIN

(SELECT DISTINCT RI.instrument_type, COALESCE(avg_november.count, 0) AS count
FROM rental_instrument AS RI
LEFT JOIN (SELECT I.instrument_type, COUNT(I.instrument_type)
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=11 GROUP BY I.instrument_type) AS avg_november ON RI.instrument_type=avg_november.instrument_type) AS avg_nov

ON avg_oct.instrument_type=avg_nov.instrument_type
INNER JOIN

(SELECT DISTINCT RI.instrument_type, COALESCE(avg_december.count, 0) AS count
FROM rental_instrument AS RI
LEFT JOIN (SELECT I.instrument_type, COUNT(I.instrument_type)
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year AND EXTRACT(MONTH FROM R.rental_start)=12 GROUP BY I.instrument_type) AS avg_december ON RI.instrument_type=avg_december.instrument_type) AS avg_dec

ON avg_nov.instrument_type=avg_dec.instrument_type,

(SELECT DISTINCT RI.instrument_type, COALESCE(avg_year.count, 0) AS count
FROM rental_instrument AS RI
LEFT JOIN
(SELECT DISTINCT I.instrument_type, COUNT(*)
FROM query_consts, rentals AS R
INNER JOIN rental_instrument AS I ON R.rental_instrument_id=I.id
WHERE EXTRACT(YEAR FROM R.rental_start)=query_year
GROUP BY I.instrument_type) AS avg_year ON RI.instrument_type=avg_year.instrument_type) as avg_tot



### Query 3 - Show the number of lessons given per month during a specified year.
It shall be possible to retrieve the total number of lessons (just one number)
and the specific number of individual lessons, group lessons and ensembles.
This query is expected to be performed a few times per week. ###

CREATE VIEW query3 AS
WITH query_consts (query_year) as (VALUES (2020))

(SELECT DISTINCT LE.lesson_type,
COALESCE(c_jan.count, 0) AS jan,
COALESCE(c_feb.count, 0) AS feb,
COALESCE(c_mar.count, 0) AS mar,
COALESCE(c_apr.count, 0) AS apr,
COALESCE(c_may.count, 0) AS may,
COALESCE(c_jun.count, 0) AS jun,
COALESCE(c_jul.count, 0) AS jul,
COALESCE(c_aug.count, 0) AS aug,
COALESCE(c_sep.count, 0) AS sep,
COALESCE(c_oct.count, 0) AS oct,
COALESCE(c_nov.count, 0) AS nov,
COALESCE(c_dec.count, 0) AS dec,
COALESCE(c_tot.count, 0) AS total

FROM lesson AS LE
LEFT JOIN
(SELECT L.lesson_type, COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=1
GROUP BY L.lesson_type) AS c_jan ON c_jan.lesson_type=LE.lesson_type
LEFT JOIN
(SELECT L.lesson_type, COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=2
GROUP BY L.lesson_type) AS c_feb ON c_feb.lesson_type=LE.lesson_type
LEFT JOIN
(SELECT L.lesson_type, COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=3
GROUP BY L.lesson_type) AS c_mar ON c_mar.lesson_type=LE.lesson_type
LEFT JOIN
(SELECT L.lesson_type, COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=4
GROUP BY L.lesson_type) AS c_apr ON c_apr.lesson_type=LE.lesson_type
LEFT JOIN
(SELECT L.lesson_type, COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=5
GROUP BY L.lesson_type) AS c_may ON c_may.lesson_type=LE.lesson_type
LEFT JOIN
(SELECT L.lesson_type, COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=6
GROUP BY L.lesson_type) AS c_jun ON c_jun.lesson_type=LE.lesson_type
LEFT JOIN
(SELECT L.lesson_type, COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=7
GROUP BY L.lesson_type) AS c_jul ON c_jul.lesson_type=LE.lesson_type
LEFT JOIN
(SELECT L.lesson_type, COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=8
GROUP BY L.lesson_type) AS c_aug ON c_aug.lesson_type=LE.lesson_type
LEFT JOIN
(SELECT L.lesson_type, COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=9
GROUP BY L.lesson_type) AS c_sep ON c_sep.lesson_type=LE.lesson_type
LEFT JOIN
(SELECT L.lesson_type, COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=10
GROUP BY L.lesson_type) AS c_oct ON c_oct.lesson_type=LE.lesson_type
LEFT JOIN
(SELECT L.lesson_type, COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=11
GROUP BY L.lesson_type) AS c_nov ON c_nov.lesson_type=LE.lesson_type
LEFT JOIN
(SELECT L.lesson_type, COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=12
GROUP BY L.lesson_type) AS c_dec ON c_dec.lesson_type=LE.lesson_type
LEFT JOIN
(SELECT L.lesson_type, COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year
GROUP BY L.lesson_type) AS c_tot ON c_tot.lesson_type=LE.lesson_type
ORDER BY total)

UNION ALL

SELECT 'Total', total_jan.count, total_feb.count, total_mar.count, total_apr.count, total_may.count, total_jun.count, total_jul.count, total_aug.count, total_sep.count, total_oct.count, total_nov.count, total_dec.count, total_tot.count
FROM
(SELECT COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=1) AS total_jan,
(SELECT COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=2) AS total_feb,
(SELECT COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=3) AS total_mar,
(SELECT COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=4) AS total_apr,
(SELECT COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=5) AS total_may,
(SELECT COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=6) AS total_jun,
(SELECT COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=7) AS total_jul,
(SELECT COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=8) AS total_aug,
(SELECT COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=9) AS total_sep,
(SELECT COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=10) AS total_oct,
(SELECT COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=11) AS total_nov,
(SELECT COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year AND EXTRACT(MONTH FROM L.time)=12) AS total_dec,
(SELECT COUNT(*)
FROM query_consts, lesson AS L
WHERE EXTRACT(YEAR FROM L.time)=query_year) AS total_tot


### Query 4 - The same as above, but retrieve the average number of lessons per month during
the entire year, instead of the total for each month. ###

CREATE VIEW query4 AS
WITH query_consts (query_year) AS (VALUES (2020))

SELECT 'Individual' AS lesson_type, round(AVG(c_m.count), 2) AS avg_per_month
FROM (SELECT COUNT(*)
FROM query_consts, lesson AS L
WHERE date_part('year', L.time)=query_year AND L.lesson_type='Individual'
GROUP BY date_part('month', L.time)) AS c_m
UNION ALL
SELECT 'Group' AS lesson_type, round(AVG(c_m.count), 2) AS avg_per_month
FROM (SELECT COUNT(*)
FROM query_consts, lesson AS L
WHERE date_part('year', L.time)=query_year AND L.lesson_type='Group'
GROUP BY date_part('month', L.time)) AS c_m
UNION ALL
SELECT 'Ensemble' AS lesson_type, round(AVG(c_m.count), 2) AS avg_per_month
FROM (SELECT COUNT(*)
FROM query_consts, lesson AS L
WHERE date_part('year', L.time)=query_year AND L.lesson_type='Ensemble'
GROUP BY date_part('month', L.time)) AS c_m
UNION ALL
SELECT 'All' AS lesson_type, round(AVG(c_t.count), 2) AS avg_per_year
FROM (SELECT COUNT(*)
FROM query_consts, lesson AS L
WHERE date_part('year', L.time)=query_year
GROUP BY date_part('month', L.time)) AS c_t


### Query 5 - List all instructors who has given more than a specific number of lessons
during the current month. Sum all lessons, independent of type.
Also list the three instructors having given most lessons (independent of lesson type)
during the last month, sorted by number of given lessons.
This query will be used to find instructors risking to work too much, and will be executed daily. ###

CREATE VIEW query5 AS
SELECT * FROM
(SELECT date_part('year', L.time)::text || '-' || lpad(date_part('month', L.time)::text, 2, '0') AS month,
        L.instructor_id AS id, I.first_name, I.last_name, COUNT(L.instructor_id) AS lessons
FROM lesson AS L
INNER JOIN instructor AS I ON L.instructor_id=I.id
WHERE date_part('year', L.time)=date_part('year', CURRENT_DATE)
AND date_part('month', L.time)=date_part('month', CURRENT_DATE)
GROUP BY date_part('year', L.time)::text || '-' || lpad(date_part('month', L.time)::text, 2, '0'), L.instructor_id,
         I.first_name, I.last_name
ORDER BY lessons DESC) AS t
WHERE t.lessons > 2
UNION ALL
(SELECT date_part('year', L.time)::text || '-' || lpad(date_part('month', L.time)::text, 2, '0') AS month,
       L.instructor_id AS id, I.first_name, I.last_name, COUNT(L.instructor_id) AS lessons
FROM lesson AS L
INNER JOIN instructor AS I ON L.instructor_id=I.id
WHERE date_part('year', L.time)=date_part('year', CURRENT_DATE - interval '1' month)
AND date_part('month', L.time)=date_part('month', CURRENT_DATE - interval '1' month)
GROUP BY date_part('year', L.time)::text || '-' || lpad(date_part('month', L.time)::text, 2, '0'), L.instructor_id,
         I.first_name, I.last_name
ORDER BY lessons DESC
LIMIT 3)


### Query 6 - List all ensembles held during the next week, sorted by music genre and
weekday. For each ensemble tell whether it is full booked, has 1-2 seats
left or has more seats left. ###

CREATE VIEW query6 AS
SELECT to_char(lesson_count.time, 'Day') AS day, E.genre,
       CASE
         WHEN (E.max_nr_of_students-lesson_count.count)<=0 THEN 'FULL'
         WHEN (E.max_nr_of_students-lesson_count.count)>2 THEN '2+'
         ELSE '1-2'
       END AS spots
FROM ensemble_lesson AS E
INNER JOIN
(SELECT A.lesson_id, L.time, COUNT(A.lesson_id), EXTRACT(isodow FROM L.time) AS day_number
FROM lesson AS L
INNER JOIN application AS A ON A.lesson_id=L.id
WHERE DATE_PART('year', L.time)=DATE_PART('year', CURRENT_DATE + '1 week'::interval)
AND DATE_PART('week', L.time)=DATE_PART('week', CURRENT_DATE + '1 week'::interval)
GROUP BY A.lesson_id, L.time) AS lesson_count ON lesson_count.lesson_id=E.lesson_id
ORDER BY E.genre, lesson_count.day_number


### Query 7 - List the three instruments with the lowest monthly rental fee.
For each instrument tell whether it is rented or available to rent. Also tell
when the next group lesson for each listed instrument is scheduled. ###

CREATE VIEW query7 AS
SELECT R.id, R.instrument_type, R.brand, R.monthly_fee AS fee,
       CASE
         WHEN (R.rented=TRUE) THEN 'YES'
         ELSE 'NO'
       END AS rented,
       next_lessons.next_lesson
FROM rental_instrument AS R
LEFT JOIN
(SELECT future_group.instrument, MIN(future_group.time) AS next_lesson
FROM
(SELECT L.id, L.time, L.duration, L.skill_level, L.lesson_type, G.instrument
FROM lesson AS L
INNER JOIN group_lesson AS G ON G.lesson_id=L.id
WHERE L.lesson_type='Group' AND L.time < CURRENT_DATE
AND DATE_PART('day', L.time) <> DATE_PART('day', CURRENT_DATE)) AS future_group
GROUP BY future_group.instrument) AS next_lessons ON R.instrument_type=next_lessons.instrument
ORDER BY R.monthly_fee
LIMIT 3;
