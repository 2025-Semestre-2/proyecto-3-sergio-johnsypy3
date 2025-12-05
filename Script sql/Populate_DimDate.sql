
/********************************************************************************************/
--Specify Start Date and End date here
--Value of Start Date Must be Less than Your End Date 

DECLARE @StartDate DATETIME = '01/01/1900' --Starting value of Date Range
DECLARE @EndDate DATETIME = '01/02/1900' --End Value of Date Range

--Temporary Variables To Hold the Values During Processing of Each Date of year
DECLARE
	@day_of_week_in_month INT,
	@day_of_week_in_year INT,
	@day_of_quarter INT,
	@week_of_month INT,
	@Currentyear INT,
	@Currentmonth INT,
	@Currentquarter INT

/*Table Data type to store the day of week count for the month and year*/
DECLARE @day_of_week TABLE (DOW INT, monthCount INT, quarterCount INT, yearCount INT)

INSERT INTO @day_of_week VALUES (1, 0, 0, 0)
INSERT INTO @day_of_week VALUES (2, 0, 0, 0)
INSERT INTO @day_of_week VALUES (3, 0, 0, 0)
INSERT INTO @day_of_week VALUES (4, 0, 0, 0)
INSERT INTO @day_of_week VALUES (5, 0, 0, 0)
INSERT INTO @day_of_week VALUES (6, 0, 0, 0)
INSERT INTO @day_of_week VALUES (7, 0, 0, 0)

--Extract and assign various parts of Values from Current Date to Variable

DECLARE @CurrentDate AS DATETIME = @StartDate
SET @Currentmonth = DATEPART(MM, @CurrentDate)
SET @Currentyear = DATEPART(YY, @CurrentDate)
SET @Currentquarter = DATEPART(QQ, @CurrentDate)

/********************************************************************************************/
--Proceed only if Start Date(Current date ) is less than End date you specified above

WHILE @CurrentDate < @EndDate
BEGIN
 
/*Begin day of week logic*/

         /*Check for Change in month of the Current date if month changed then 
          Change variable value*/
	IF @Currentmonth != DATEPART(MM, @CurrentDate) 
	BEGIN
		UPDATE @day_of_week
		SET monthCount = 0
		SET @Currentmonth = DATEPART(MM, @CurrentDate)
	END

        /* Check for Change in quarter of the Current date if quarter changed then change 
         Variable value*/

	IF @Currentquarter != DATEPART(QQ, @CurrentDate)
	BEGIN
		UPDATE @day_of_week
		SET quarterCount = 0
		SET @Currentquarter = DATEPART(QQ, @CurrentDate)
	END
       
        /* Check for Change in year of the Current date if year changed then change 
         Variable value*/
	

	IF @Currentyear != DATEPART(YY, @CurrentDate)
	BEGIN
		UPDATE @day_of_week
		SET yearCount = 0
		SET @Currentyear = DATEPART(YY, @CurrentDate)
	END
	
        -- Set values in table data type created above from variables 

	UPDATE @day_of_week
	SET 
		monthCount = monthCount + 1,
		quarterCount = quarterCount + 1,
		yearCount = yearCount + 1
	WHERE DOW = DATEPART(DW, @CurrentDate)

	SELECT
		@day_of_week_in_month = monthCount,
		@day_of_quarter = quarterCount,
		@day_of_week_in_year = yearCount
	FROM @day_of_week
	WHERE DOW = DATEPART(DW, @CurrentDate)
	
/*End day of week logic*/


/* Populate Your Dimension Table with values*/
	
	INSERT INTO [dbo].[DimDate]
	SELECT
		
		CONVERT (char(8),@CurrentDate,112) as date_key,
		@CurrentDate AS date,
		CONVERT (char(10),@CurrentDate,103) as full_date,
		DATEPART(DD, @CurrentDate) AS day_of_month,
		--Apply Suffix values like 1st, 2nd 3rd etc..
		/*
		CASE 
			WHEN DATEPART(DD,@CurrentDate) IN (11,12,13) 
			THEN CAST(DATEPART(DD,@CurrentDate) AS VARCHAR) + 'th'
			WHEN RIGHT(DATEPART(DD,@CurrentDate),1) = 1 
			THEN CAST(DATEPART(DD,@CurrentDate) AS VARCHAR) + 'ero'
			WHEN RIGHT(DATEPART(DD,@CurrentDate),1) = 2 
			THEN CAST(DATEPART(DD,@CurrentDate) AS VARCHAR) + 'do'
			WHEN RIGHT(DATEPART(DD,@CurrentDate),1) = 3 
			THEN CAST(DATEPART(DD,@CurrentDate) AS VARCHAR) + 'rd'
			ELSE CAST(DATEPART(DD,@CurrentDate) AS VARCHAR) + 'th' 
			END AS day_suffix,
		*/
		
		DATENAME(DW, @CurrentDate) AS day_name,
		DATEPART(DW, @CurrentDate) AS day_of_week_usa,

		-- check for day of week as Per US and change it as per UK format 
		CASE DATEPART(DW, @CurrentDate)
			WHEN 1 THEN 7
			WHEN 2 THEN 1
			WHEN 3 THEN 2
			WHEN 4 THEN 3
			WHEN 5 THEN 4
			WHEN 6 THEN 5
			WHEN 7 THEN 6
			END 
			AS day_of_week_cr,
		
		@day_of_week_in_month AS day_of_week_in_month,
		@day_of_week_in_year AS day_of_week_in_year,
		@day_of_quarter AS day_of_quarter,
		DATEPART(DY, @CurrentDate) AS day_of_year,
		DATEPART(WW, @CurrentDate) + 1 - DATEPART(WW, CONVERT(VARCHAR, 
		DATEPART(MM, @CurrentDate)) + '/1/' + CONVERT(VARCHAR, 
		DATEPART(YY, @CurrentDate))) AS week_of_month,
		(DATEDIFF(DD, DATEADD(QQ, DATEDIFF(QQ, 0, @CurrentDate), 0), 
		@CurrentDate) / 7) + 1 AS week_of_quarter,
		DATEPART(WW, @CurrentDate) AS week_of_year,
		DATEPART(MM, @CurrentDate) AS month,
		DATENAME(MM, @CurrentDate) AS month_name,
		CASE
			WHEN DATEPART(MM, @CurrentDate) IN (1, 4, 7, 10) THEN 1
			WHEN DATEPART(MM, @CurrentDate) IN (2, 5, 8, 11) THEN 2
			WHEN DATEPART(MM, @CurrentDate) IN (3, 6, 9, 12) THEN 3
			END AS month_of_quarter,
		DATEPART(QQ, @CurrentDate) AS quarter,
		CASE DATEPART(QQ, @CurrentDate)
			WHEN 1 THEN 'Primero'
			WHEN 2 THEN 'Segundo'
			WHEN 3 THEN 'Tercero'
			WHEN 4 THEN 'Cuarto'
			END AS quarter_name,
		DATEPART(YEAR, @CurrentDate) AS year,
		'CY ' + CONVERT(VARCHAR, DATEPART(YEAR, @CurrentDate)) AS year_name,
		LEFT(DATENAME(MM, @CurrentDate), 3) + '-' + CONVERT(VARCHAR, 
		DATEPART(YY, @CurrentDate)) AS month_year,
		RIGHT('0' + CONVERT(VARCHAR, DATEPART(MM, @CurrentDate)),2) + 
		CONVERT(VARCHAR, DATEPART(YY, @CurrentDate)) AS mmyyyy,
		CONVERT(DATETIME, CONVERT(DATE, DATEADD(DD, - (DATEPART(DD, 
		@CurrentDate) - 1), @CurrentDate))) AS first_day_of_month,
		CONVERT(DATETIME, CONVERT(DATE, DATEADD(DD, - (DATEPART(DD, 
		(DATEADD(MM, 1, @CurrentDate)))), DATEADD(MM, 1, 
		@CurrentDate)))) AS last_day_of_month,
		DATEADD(QQ, DATEDIFF(QQ, 0, @CurrentDate), 0) AS first_day_of_quarter,
		DATEADD(QQ, DATEDIFF(QQ, -1, @CurrentDate), -1) AS last_day_of_quarter,
		CONVERT(DATETIME, '01/01/' + CONVERT(VARCHAR, DATEPART(YY, 
		@CurrentDate))) AS first_day_of_year,
		CONVERT(DATETIME, '12/31/' + CONVERT(VARCHAR, DATEPART(YY, 
		@CurrentDate))) AS last_day_of_year,
		CASE DATEPART(DW, @CurrentDate)
			WHEN 1 THEN 0
			WHEN 2 THEN 1
			WHEN 3 THEN 1
			WHEN 4 THEN 1
			WHEN 5 THEN 1
			WHEN 6 THEN 1
			WHEN 7 THEN 0
			END AS IsWeekday,
		NULL AS IsHoliday,
		NULL AS Holiday

	SET @CurrentDate = DATEADD(DD, 1, @CurrentDate)
END

/********************************************************************************************/
 
--Step 3.
-- FERIADOS OFICIALES DE COSTA RICA
	
-- Año nuevo, 01 de enero
	UPDATE [dbo].[DimDate]
		SET Holiday = 'Año nuevo'
	WHERE [month] = 1 AND [day_of_month]  = 1

-- Batalla de Rivas, 11 de Abril
	UPDATE [dbo].[DimDate]
		SET Holiday = 'Batalla de Rivas'
	WHERE [month] = 4 AND [day_of_month]  = 11

-- Jueves Santo de la Semana Santa, 17 de Abril
   UPDATE [dbo].[DimDate]
		SET Holiday = 'Jueves Santo - Semana Santa'
	WHERE [month] = 4 AND [day_of_month]  = 17

-- Viernes Santo de la Semana Santa, 18 de Abril
   UPDATE [dbo].[DimDate]
		SET Holiday = 'Viernes Santo - Semana Santa'
	WHERE [month] = 4 AND [day_of_month]  = 18

-- Día del Trabajador, 1 de mayo 
    UPDATE [dbo].[DimDate]
		SET Holiday = 'Día del Trabajador'
	WHERE [month] = 5 AND [day_of_month]  = 1

-- Anexión de Nicoya, 25 de julio 
    UPDATE [dbo].[DimDate]
		SET Holiday = 'Anexión de Nicoya'
	WHERE [month] = 7 AND [day_of_month]  = 25

-- Día de la Virgen de los Ángeles, 02 de agosto 
    UPDATE [dbo].[DimDate]
		SET Holiday = 'Día de la Virgen de los Ángeles'
	WHERE [month] = 8 AND [day_of_month]  = 2

-- Día de la madre, 15 de agosto 
    UPDATE [dbo].[DimDate]
		SET Holiday = 'Día de la madre'
	WHERE [month] = 8 AND [day_of_month]  = 15

-- Día de la persona negra y la cultura afrodescendiente, 31 de agosto 
    UPDATE [dbo].[DimDate]
		SET Holiday = 'Día de la persona negra y la cultura afrodescendiente'
	WHERE [month] = 8 AND [day_of_month]  = 31

-- Día de la Independencia, 15 de setiembre 
    UPDATE [dbo].[DimDate]
		SET Holiday = 'Día de la Independencia'
	WHERE [month] = 9 AND [day_of_month]  = 15

-- Día de la abolición del ejercito
	UPDATE [dbo].[DimDate]
		SET Holiday = 'Día de la abolición del ejercito'
	WHERE [month] = 12 AND [day_of_month]  = 1

-- Navidad
	UPDATE [dbo].[DimDate]
		SET Holiday = 'Navidad'
	WHERE [month] = 12 AND [day_of_month]  = 25

--Update flag for Holidays 1= Holiday, 0=No Holiday
	UPDATE [dbo].[DimDate]
		SET IsHoliday  = CASE WHEN Holiday   IS NULL 
		THEN 0 WHEN Holiday   IS NOT NULL THEN 1 END
		
 
SELECT * FROM [dbo].[DimDate]