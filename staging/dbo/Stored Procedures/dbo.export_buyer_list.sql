
CREATE PROCEDURE [dbo].[export_buyer_list] 
		@state AS varchar(max) 
	 , @postcodes AS varchar(max) 
	 , @start_age int
	 , @end_age int 
	 , @homeowner varchar(max)

AS

BEGIN
 
-- --=======================================
--declare @state AS varchar(max) = 'Queensland,Tasmania',   -- Set to All if you want to filter on Postcodes only
-- @postcodes AS varchar(max) = 
--'6000,6003,6004,6005,6006,6007,6008,6009,6010,6011,6012,6014,6015,6016,6017,6018,6019,6020,6021,6022,6023,6024,6025,6026,6027,6028,6029,6030,6031,6032,6033,6034,6036,6038,6050,6051,6052,6053,6054,6055,6056,6057,6058,6059,6060,6061,6062,6063,6064,6065,6066,6067,6068,6069,6070,6071,6072,6073,6074,6076,6081,6082,6083,6084,6090,6100,6101,6102,6103,6104,6105,6106,6107,6108,6109,6110,6111,6112,6121,6122,6147,6148,6149,6150,6151,6152,6153,6154,6155,6156,6157,6158,6159,6160,6161,6162,6163,6164,6165,6166,6167,6168,6501,6809,6817,6820,6827,6830,6937,6938,6940'
--, @start_age INT = 30
--, @end_age INT = 55
--, @homeowner varchar(MAX) = 'Cosponsor,Home Owner,Unknown'
----==========================================

DECLARE @statetable table (state varchar(28) )
DECLARE  @homeownerlist table (homeowner varchar(100))

BEGIN

IF @state = 'All'

	BEGIN 
		--insert into @statetable (state) 
		--SELECT DISTINCT [state] FROM buyer.buyer_list  
		DECLARE @List table (ID int)

		while charindex(',',@postcodes) > 0
			begin
			 insert into @List (ID) values(left(@postcodes,charindex(',',@postcodes)-1))
			 set @postcodes = right(@postcodes,len(@postcodes)-charindex(',',@postcodes))
			end
			 insert into @List (ID) values(@postcodes)

					--get homeowner into table


					WHILE charindex(',',@homeowner) > 0
					BEGIN
					 insert into @homeownerlist (homeowner) values(left(@homeowner,charindex(',',@homeowner)-1))
					 set @homeowner = right(@homeowner,len(@homeowner)-charindex(',',@homeowner))
					END
					INSERT INTO @homeownerlist (homeowner) values(@homeowner)

					SELECT 'Email'
						  ,'Title'
						  ,'First Name'
						  ,'Last Name'
						  ,'Address'
						  ,'City'
						  ,'State'
						  ,'Postcode'
						  ,'Mobile'
						  ,'Date of Birth'
						  ,'Age'
						  ,'Gender'
						  ,'Source'
						  ,'IP Address'
						  ,'Submission Date'
						  ,'Homeowner Answer'

					UNION ALL

					SELECT [Email]
						  ,[Title]
						  ,[First Name]
						  ,[Last Name]
						  ,REPLACE(Address, ',', ' ') AS [Address]
						  ,[City]
						  ,[State]
						  ,[Postcode]
						  ,[Mobile]
						  ,CAST([Date of Birth] AS varchar(200))
						  ,CAST([Age] AS varchar(100))
						  ,[Gender]
						  ,[Source]
						  ,[IP Address]
						  ,[Submission Date]
						  ,[Homeowner Answer]
					FROM [buyer].[vw_buyer_lead_list] l
						INNER JOIN @List li ON l.Postcode = li.ID
						INNER JOIN @homeownerlist hl ON l.[Homeowner Answer] = hl.homeowner
					WHERE l.Age >= @start_age
						AND l.Age <= @end_age
	END

ELSE 


	BEGIN
		while charindex(',',@state) > 0
		begin
		 insert into @statetable ([state]) values(left(@state,charindex(',',@state)-1))
		 set @state = right(@state,len(@state)-charindex(',',@state))
		end
		 insert into @statetable ([state]) values(@state)

		 --get homeowner into table

				WHILE charindex(',',@homeowner) > 0
				BEGIN
				 insert into @homeownerlist (homeowner) values(left(@homeowner,charindex(',',@homeowner)-1))
				 set @homeowner = right(@homeowner,len(@homeowner)-charindex(',',@homeowner))
				END
				INSERT INTO @homeownerlist (homeowner) values(@homeowner)

					SELECT 'Email'
						  ,'Title'
						  ,'First Name'
						  ,'Last Name'
						  ,'Address'
						  ,'City'
						  ,'State'
						  ,'Postcode'
						  ,'Mobile'
						  ,'Date of Birth'
						  ,'Age'
						  ,'Gender'
						  ,'Source'
						  ,'IP Address'
						  ,'Submission Date'
						  ,'Homeowner Answer'

					UNION ALL

				SELECT [Email]
						  ,[Title]
						  ,[First Name]
						  ,[Last Name]
						  ,REPLACE(Address, ',', ' ') AS [Address]
						  ,[City]
						  ,l.[State]
						  ,[Postcode]
						  ,[Mobile]
						  ,CAST([Date of Birth] AS varchar(200))
						  ,CAST([Age] AS varchar(100))
						  ,[Gender]
						  ,[Source]
						  ,[IP Address]
						  ,[Submission Date]
						  ,[Homeowner Answer]
				FROM [buyer].[vw_buyer_lead_list] l
					INNER JOIN @statetable s ON l.[State] = s.[state]
					INNER JOIN @homeownerlist hl ON l.[Homeowner Answer] = hl.homeowner
				WHERE l.Age >= @start_age
					AND l.Age <= @end_age



	END

END
END