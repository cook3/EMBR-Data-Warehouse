

CREATE PROCEDURE [dbo].[load_dim_date]

	@StartDate  date
	, @EndDate  date

AS 


-- =============================================
-- Author:		Scott Cooke
-- Create date: 26/01/2018
-- Description:	perform load of date dimension
-- =============================================

BEGIN

SET DATEFIRST 1;

SET NOCOUNT ON; 


SET IDENTITY_INSERT [dbo].[dim_date] ON


;WITH

       E00(N) AS (SELECT 1 UNION ALL SELECT 1),

       E02(N) AS (SELECT 1 FROM E00 a, E00 b),

       E04(N) AS (SELECT 1 FROM E02 a, E02 b),

       E08(N) AS (SELECT 1 FROM E04 a, E04 b),

       E16(N) AS (SELECT 1 FROM E08 a, E08 b),

       E32(N) AS (SELECT 1 FROM E16 a, E16 b),

       cteTally(N) AS (SELECT ROW_NUMBER() OVER (ORDER BY N) FROM E32)

,

CalendarBase as (

SELECT

       CalendarDate = DATEADD(day, n - 1, @StartDate )

       FROM cteTally

       WHERE N <= DATEDIFF(day, @StartDate , @EndDate) + 1

)

-- Use the list of calendar dates to fill the date dimension

INSERT [dbo].[dim_date] (

       date_key, actual_date, iso_date, is_weekday, is_weekend, day_short_name, day_long_name, day_of_week, day_of_month, day_of_year

       , week_of_year_key, week_of_year, week_of_year_name, week_of_month

       , [week_start_date_monday], [week_end_date_sunday],  [week_start_name_monday], [week_end_name_sunday]

       , month_key, month_of_year, month_long_name, month_short_name, month_full_name, month_remaining_days, last_day_of_month

       , calendar_quarter_key, calendar_quarter_long_name, calendar_quarter_short_name

       , financial_quarter_key, financial_quarter_name

       , calendar_year_key, calendar_year_name, calendar_year_start, calendar_year_end, calendar_year_remaining_days

       , financial_year_key, financial_year_name, financial_year_start, financial_year_end, financial_year_remaining_days

       , is_last_day_of_month, is_last_day_of_calendar_year, is_last_day_of_financial_year

)

SELECT

       CONVERT(int, CONVERT(char(8), CalendarDate, 112))      -- date_key

       , CalendarDate       -- actual_date

       , CONVERT(VARCHAR(8), CalendarDate, 112) -- iso_date

       , CASE WHEN DATEPART(dw, CalendarDate) IN (6, 7) THEN 0 ELSE 1 END   -- is_weekday

       , CASE WHEN DATEPART(dw, CalendarDate) IN (6, 7) THEN 1 ELSE 0 END   -- is_weekend

       , LEFT(DATENAME (dw, CalendarDate), 3)   -- day_short_name

       , DATENAME (dw, CalendarDate)     -- day_long_name

       , DATEPART(dw, CalendarDate)      -- day_of_week

       , DAY(CalendarDate) -- day_of_month

       , DATEPART(dayofyear, (CalendarDate))    -- day_of_year

 

       -- Week

       , CASE

              WHEN DATEPART(ISO_WEEK, CalendarDate) >= 52 THEN DATEPART(yyyy, DATEADD(d, 1 - DATEPART(dw, CalendarDate), CalendarDate)) * 100 + DATEPART(ISO_WEEK, CalendarDate)      -- Same year as week_start_date

              WHEN DATEPART(ISO_WEEK, CalendarDate) = 1 THEN DATEPART(yyyy, DATEADD(d, 6, DATEADD(d, 1 - DATEPART(dw, CalendarDate), CalendarDate))) * 100 + DATEPART(ISO_WEEK, CalendarDate) -- Same year as week_end_date

              ELSE DATEPART(yyyy, CalendarDate) * 100 + DATEPART(ISO_WEEK, CalendarDate)

         END  -- week_of_year_key

       , DATEPART(ISO_WEEK, CalendarDate) -- ISOweek_of_year

       , 'Week ' + RIGHT('00' + CAST(DATEPART(ISO_WEEK, CalendarDate) AS VARCHAR(2)), 2) -- ISOweek_of_year_name

	   , DATEPART(WW, CalendarDate) + 1 - DATEPART(WW, CONVERT(VARCHAR, DATEPART(MM, CalendarDate)) + '/1/' + CONVERT(VARCHAR,DATEPART(YY, CalendarDate))) --week_of_month

       , DATEADD(d, 1 - DATEPART(dw, CalendarDate), CalendarDate)    -- week_start_date

       , DATEADD(d, 6, DATEADD(d, 1 - DATEPART(dw, CalendarDate), CalendarDate))  -- week_end_date


       , CONVERT(CHAR(11), DATEADD(d, 1 - DATEPART(dw, CalendarDate), CalendarDate), 106) -- week_start_name

       , CONVERT(CHAR(11), DATEADD(d, 6, DATEADD(d, 1 - DATEPART(dw, CalendarDate), CalendarDate)), 106)   -- week_end_name

 

       -- Month

       , CONVERT(int, CONVERT(char(6), CalendarDate, 112))    -- month_key

       , DATEPART(month, CalendarDate)   -- month_of_year

       , DATENAME(month, CalendarDate)   -- month_long_name

       , LEFT(DATENAME(month, CalendarDate), 3) -- month_short_name

       , LEFT(DATENAME(month, CalendarDate), 3) + ' ' + DATENAME(year, CalendarDate)     -- month_full_name

       , DATEDIFF(d, CalendarDate, DATEADD(d, -DATEPART(d, DATEADD(m, 1, CalendarDate)), DATEADD(m, 1, CalendarDate)))   -- month_remaining_days

       , CAST(DATEADD(dd, -1, DATEADD(m, DATEDIFF(m, -1, CalendarDate), 0)) AS DATE)     -- last_day_of_month

 

       -- Calendar Quarter

       , YEAR(CalendarDate) * 10 + DATEPART(q, CalendarDate)  -- calendar_quarter_key

       , 'Quarter ' + CAST(DATENAME(qq, CalendarDate) AS VARCHAR(1)) -- calendar_quarter_long_name

       , 'Qtr ' + CAST(DATENAME(qq, CalendarDate) AS VARCHAR(1))     -- calendar_quarter_short_name

 

       -- Financial Quarter

       , YEAR(DATEADD(m, 6, CalendarDate)) * 10 + DATEPART(q, DATEADD(m, 6, CalendarDate))      -- financial_quarter_key

       , 'FY ' + CAST(YEAR(DATEADD(m, 6, CalendarDate)) AS CHAR(4)) + ' Q' + CAST(DATEPART(q, DATEADD(m, 6, CalendarDate)) AS CHAR(1)) -- financial_quarter_name

 

       -- Calendar Year

       , YEAR(CalendarDate)       -- calendar_year_key

       , CONVERT(char(4), YEAR(CalendarDate))   -- calendar_year_name

       , CAST(DATEADD(YEAR,DATEDIFF(YEAR, 0, CalendarDate),0) AS DATE)      -- calendar_year_start

       , CAST(DATEADD(dd, -1, DATEADD(yy, DATEDIFF(yy, -1, CalendarDate), 0)) AS DATE)   -- calendar_year_end

       , DATEDIFF(d, CalendarDate, DATEADD(dd, -1, DATEADD(yy, DATEDIFF(yy, -1, CalendarDate), 0)))       -- calendar_year_remaining_days

 

       -- Financial Year

       , YEAR(DATEADD(month,6,CalendarDate))    -- financial_year_key

       , CONVERT(char(4),YEAR(DATEADD(month,6,CalendarDate))-1) + '/' + RIGHT(CONVERT(char(4),YEAR(DATEADD(month,6,CalendarDate))),2) -- financial_year_name

       , CAST(DATEADD(month, -6, DATEADD(YEAR, DATEDIFF(YEAR, 0, DATEADD(MONTH, 6, CalendarDate)),0)) AS DATE)      -- financial_year_start

       , CAST(DATEADD(MONTH, DATEDIFF(MONTH, 0, CalendarDate) - (12 + DATEPART(MONTH, CalendarDate) - 7) % 12 + 12, -1) AS DATE) -- financial_year_end

       , DATEDIFF(d, CalendarDate,DATEADD(MONTH, DATEDIFF(MONTH, 0, CalendarDate) - (12 + DATEPART(MONTH, CalendarDate) - 7) % 12 + 12, -1))     -- financial_year_remaining_days

       , CAST(CASE CAST(DATEADD(dd, -1, DATEADD(m, DATEDIFF(m, -1, CalendarDate), 0)) AS DATE)

                           WHEN CalendarDate then -1

                           ELSE 0

                           END AS BIT)   -- is_last_day_of_month

       , CAST(CASE CAST(DATEADD(dd, -1, DATEADD(yy, DATEDIFF(yy, -1, CalendarDate), 0)) AS DATE)

                           WHEN CalendarDate then -1

                           ELSE 0

                           END AS BIT)   -- is_last_day_of_calendar_year

       , CAST(CASE CAST(DATEADD(MONTH, DATEDIFF(MONTH, 0, CalendarDate) - (12 + DATEPART(MONTH, CalendarDate) - 7) % 12 + 12, -1) AS DATE)

                           WHEN CalendarDate then -1

                           ELSE 0

                           END AS BIT)   -- is_last_day_of_financial_year

FROM CalendarBase

;

END
