BEGIN TRY
	DROP TABLE [dbo].[DimDate]
END TRY

BEGIN CATCH
	/*No Action*/
END CATCH

/**********************************************************************************/

CREATE TABLE	[dbo].[DimDate]
	(	[date_key] INT primary key, 
		[date] DATETIME,
		[full_date] CHAR(10), -- Date in dd-MM-yyyy format
		[day_of_month] VARCHAR(2), -- Field will hold day number of month
		[day_name] VARCHAR(9), -- Contains name of the day, Sunday, Monday 
		[day_of_week_usa] CHAR(1),-- First Day Sunday=1 and Saturday=7
		[day_of_week_cr] CHAR(1),-- First Day Monday=1 and Sunday=7
		[day_of_week_in_month] VARCHAR(2), --1st Monday or 2nd Monday in month
		[day_of_week_in_year] VARCHAR(2),
		[day_of_quarter] VARCHAR(3),
		[day_of_year] VARCHAR(3),
		[week_of_month] VARCHAR(1),-- Week Number of month 
		[week_of_quarter] VARCHAR(2), --Week Number of the quarter
		[week_of_year] VARCHAR(2),--Week Number of the year
		[month] VARCHAR(2), --Number of the month 1 to 12
		[month_name] VARCHAR(9),--January, February etc
		[month_of_quarter] VARCHAR(2),-- month Number belongs to quarter
		[quarter] CHAR(1),
		[quarter_name] VARCHAR(9),--First,Second..
		[year] CHAR(4),-- year value of Date stored in Row
		[year_name] CHAR(7), --CY 2012,CY 2013
		[month_year] CHAR(10), --Jan-2013,Feb-2013
		[mmyyyy] CHAR(6),
		[first_day_of_month] DATE,
		[last_day_of_month] DATE,
		[first_day_of_quarter] DATE,
		[last_day_of_quarter] DATE,
		[first_day_of_year] DATE,
		[last_day_of_year] DATE,
		[IsWeekday] BIT,-- 0=Week End ,1=Week Day
		[IsHoliday] BIT Null,-- Flag 1=National Holiday, 0-No National Holiday
		[Holiday] VARCHAR(75) Null --Name of Holiday in UK
	)
GO

