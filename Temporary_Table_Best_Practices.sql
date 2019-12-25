/**Script to Create Temporary Table to store Information -Method 1**/
CREATE TABLE #tempTable ([id] [int],[firstName] [varchar](10),[lastName] [varchar](10),[salary] [int]);
INSERT INTO #tempTable
SELECT id,firstName,lastName,salary FROM [dbo].[FirstTable];


/**Script to Create Temporary Table to store Information -Method 2**/
SELECT id,firstName,lastName,salary 
INTO #tempTable2 
FROM [dbo].[FirstTable];

/**Script to Create Temporary  Table using Cursor Example -Method3 **/
CREATE TABLE #tempTable3 ([id] [int],[firstName] [varchar](10),[lastName] [varchar](10),[salary] [int]);

DECLARE @id INT;
DECLARE @firstName VARCHAR(10);
DECLARE @lastName VARCHAR(10);
DECLARE @salary INT;

DECLARE cursor_tables CURSOR
FOR
SELECT id,firstName,lastName,salary 
      FROM [dbo].[FirstTable];
OPEN cursor_tables;
FETCH NEXT FROM cursor_tables INTO
      @id,
	  @firstName,
	  @lastName,
	  @salary
WHILE @@FETCH_STATUS = 0
     BEGIN
	 INSERT INTO #tempTable3(id,firstName,lastName,salary) VALUES (@id,@firstName,@lastName,@salary)
	 FETCH NEXT FROM cursor_tables INTO
	  @id,
	  @firstName,
	  @lastName,
	  @salary
	 END; 
CLOSE cursor_tables;

/**Script to Create Common Table Expression(CTE)-Method4 **/

WITH myCTE AS ( SELECT id FROM [dbo].[FirstTable])
SELECT ud.* FROM [dbo].[UserDetails] ud
         INNER JOIN myCTE ON ud.userId = myCTE.id