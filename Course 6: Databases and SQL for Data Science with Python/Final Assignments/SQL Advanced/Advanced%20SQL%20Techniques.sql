-- Exercise 1

-- Question 1
select NAME_OF_SCHOOL, CPS.COMMUNITY_AREA_NAME, AVERAGE_STUDENT_ATTENDANCE
from CHICAGO_PUBLIC_SCHOOLS CPS
LEFT OUTER JOIN CENSUS_DATA CD
ON CPS.COMMUNITY_AREA_NUMBER = CD.COMMUNITY_AREA_NUMBER
where HARDSHIP_INDEX = 98

-- Question 2
select CASE_NUMBER, PRIMARY_TYPE, COMMUNITY_AREA_NAME
from CHICAGO_CRIME_DATA CCD
LEFT OUTER JOIN CENSUS_DATA CD
ON CCD.COMMUNITY_AREA_NUMBER = CD.COMMUNITY_AREA_NUMBER
where LOCATION_DESCRIPTION like '%SCHOOL%'


-- Exercise 2

-- Question 1
CREATE VIEW CHICAGO_SCHOOLS (School_Name, Safety_Rating, Family_Rating, Environment_Rating,
Instruction_Rating, Leaders_Rating, Teachers_Rating)
AS select NAME_OF_SCHOOL, Safety_Icon, Family_Involvement_Icon, 
Environment_Icon, Instruction_Icon, Leaders_Icon, Teachers_Icon
from CHICAGO_PUBLIC_SCHOOLS

select * from CHICAGO_SCHOOLS

select School_Name, Leaders_Rating from CHICAGO_SCHOOLS


-- Exercise 3

-- Question 1
DROP PROCEDURE UPDATE_LEADERS_SCORE;
ALTER TABLE CHICAGO_PUBLIC_SCHOOLS ALTER COLUMN LEADERS_ICON SET DATA TYPE VARCHAR(10);
--#SET TERMINATOR @
CREATE PROCEDURE UPDATE_LEADERS_SCORE (IN in_School_ID INT, IN in_Leader_score INT)

LANGUAGE SQL 
MODIFIES SQL DATA 

BEGIN 
	
	-- Question 2
	UPDATE CHICAGO_PUBLIC_SCHOOLS
	set LEADERS_SCORE = in_Leader_score
	where SCHOOL_ID = in_School_ID;

	-- Question 3	
	if in_Leader_score >= 80 AND in_Leader_score <= 99 then 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		set LEADERS_ICON = 'Very Strong'
		where SCHOOL_ID = in_School_ID;
		
	elseif in_Leader_score >= 60 AND in_Leader_score <= 79 then 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		set LEADERS_ICON = 'Strong'
		where SCHOOL_ID = in_School_ID;
		
	elseif in_Leader_score >= 40 AND in_Leader_score <= 59 then 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		set LEADERS_ICON = 'Average'
		where SCHOOL_ID = in_School_ID;
		
	elseif in_Leader_score >= 20 AND in_Leader_score <= 39 then 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		set LEADERS_ICON = 'Weak'
		where SCHOOL_ID = in_School_ID;
		
	elseif in_Leader_score >= 0 AND in_Leader_score <= 19 then 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		set LEADERS_ICON = 'Very Weak'
		where SCHOOL_ID = in_School_ID;
	
	
	-- Exercise 4

	-- Question 1
	else 
		ROLLBACK WORK;
		
	-- Question 2 
	COMMIT WORK;
	
	end if;
END 
@

CALL UPDATE_LEADERS_SCORE(610038, 50);
CALL UPDATE_LEADERS_SCORE(610281, 101);

select SCHOOL_ID, LEADERS_SCORE, LEADERS_ICON 
from CHICAGO_PUBLIC_SCHOOLS limit 2










