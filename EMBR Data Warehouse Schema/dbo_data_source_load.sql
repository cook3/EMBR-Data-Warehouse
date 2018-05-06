SET IDENTITY_INSERT [lead].[dim_data_source] ON 
GO
INSERT [lead].[dim_data_source] ([data_source_key], [source]) VALUES (1, N'oldleads')
GO
INSERT [lead].[dim_data_source] ([data_source_key], [source]) VALUES (2, N'databowl')
GO
SET IDENTITY_INSERT [lead].[dim_data_source] OFF
GO