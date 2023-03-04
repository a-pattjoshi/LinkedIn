-------------------------------------
-- LinkedIn Learning ----------------
-- Advanced SQL - Query Processing --
-- Ami Levin 2020 -------------------
-- .\Chapter4\Video5.sql ------------
-------------------------------------

-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=688dee398b12e9646515be8ceada7468&hide=3

USE Animal_Shelter; -- For SQL Server

SELECT	AN.Name,
		AN.Species,
		MAX(AN.Primary_Color) AS Primary_Color, -- Dummy aggregate, functionally dependent.
		MAX(AN.Breed) AS Breed, -- Dummy aggregate, functionally dependent.
		COUNT(V.Vaccine) AS Number_Of_Vaccines
FROM	Animals AS AN
		LEFT OUTER JOIN 
		Vaccinations AS V
			ON	V.Name = AN.Name 
				AND 
				V.Species = AN.Species
WHERE	AN.Species <> 'Rabbit'
		AND
		(V.Vaccine <> 'Rabies' OR V.Vaccine IS NULL)
GROUP BY	AN.Species,
			AN.Name
HAVING	MAX(V.Vaccination_Time) < '20191001' 
		OR
		MAX(V.Vaccination_Time) IS NULL
ORDER BY	AN.Species,
			AN.Name;



-- Alternate solution : Using where clause for Vaccination_Time condition check instead of having.
SELECT
	A.NAME,
		A.SPECIES,
		A.BREED,
		A.PRIMARY_COLOR,
	COUNT(V.VACCINE) AS NO_OF_VACC
FROM
	ANIMALS AS A
LEFT OUTER JOIN
		VACCINATIONS AS V
		ON
	A.NAME = V.NAME
	AND
			A.SPECIES = V.SPECIES
WHERE
	A.SPECIES <> 'RABBIT'
	AND (V.VACCINE <> 'RABIES'
		OR V.VACCINE IS NULL)
	AND
(V.VACCINATION_TIME::DATE < '2019-10-01'
		OR V.VACCINATION_TIME IS NULL)
GROUP BY
	A.NAME,
	A.SPECIES,
	A.BREED,
	A.PRIMARY_COLOR
ORDER BY
	A.NAME,
	A.SPECIES,
	A.BREED,
	A.PRIMARY_COLOR
