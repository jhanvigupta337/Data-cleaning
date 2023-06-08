select * from cleaning.dbo.employee

--Replacing rows which has null values

SELECT COUNT(*) AS MissingCount
FROM Employee
WHERE middlename IS NULL;

UPDATE Employee
SET MiddleName = ''
WHERE MiddleName IS NULL;

--Droping the column ParentEmployeeNationalIDAlternateKey and END Date since it contains all null values

ALTER TABLE Employee
DROP COLUMN ParentEmployeeNationalIDAlternateKey;

ALTER TABLE Employee
DROP COLUMN EndDate;

--Removing Duplicate Values From Parent Employee Key

SELECT ParentEmployeeKey, COUNT(*) AS DuplicateCount
FROM Employee
WHERE ParentEmployeeKey IS NOT NULL
GROUP BY ParentEmployeeKey
HAVING COUNT(*) > 1;


With RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER (						--This is a Windows Function
	PARTITION BY Parentemployeekey,
				 employeenationalidalternatekey,
				 firstname,
				 lastname,
				 title
				 ORDER BY
				 employeekey
				  )row_num
From cleaning.dbo.employee
--order by
)
DElete
From RownumCTE
Where row_num >1



--Removing Hyphens From phone numbers

UPDATE Employee
SET Phone = REPLACE(Phone, '-', '')
WHERE Phone LIKE '%-%';


UPDATE Employee
SET EmergencyContactPhone = REPLACE(EmergencyContactPhone, '-', '')
WHERE EmergencyContactPhone LIKE '%-%';


