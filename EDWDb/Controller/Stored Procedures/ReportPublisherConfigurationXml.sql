
CREATE PROCEDURE [Controller].[ReportPublisherConfigurationXml](
		@ConfigurationXml xml(Controller.ReportPublisherXmlSchema) OUTPUT
)
AS
BEGIN
		SELECT @ConfigurationXml = (
			SELECT
				(
					SELECT 
						batch.[Name] AS '@Name'
						,NEWID() AS '@ID'
						,batch.[Code] AS '@Code'
						,batch.[BatchOutputPath] AS '@OutputLocation'
						,batch.[BatchType_Name] AS '@Type'
						,batch.[BatchSchedule_Name] AS 'Schedule/@Name'
						,sched.[EventType_Name] AS 'Schedule/@Type'
						,sched.[EventProcedureName] AS 'Schedule/@EventProcedureName'
						,(
							SELECT
									report.[Name] AS '@Name'
									,NEWID() AS '@ID'
									,report.[Code] AS '@Code'
									,ISNULL(report.[RelativeOutputLocation],'') AS '@RelativeOutputLocation'
									,report.[ExcelSheetName] AS '@ExcelSheetName'
									,report.[ExcelSheetPosition] AS '@ExcelSheetPosition'
									,report.[OutputFileType_Name] AS '@OutputFileType'
									,report.[Encoding_Code] AS '@Encoding'
									,report.[ReportType_Code] AS '@Type'
									,rserver.[ServerURI] + report.[ReportPath] AS '@Path'
									,report.[IsFileNameDateRequired_Name] AS '@IsFileNameDatePrefixRequired'
									,report.[IsFileNameTimeRequired_Name] AS '@IsFileNameTimePrefixRequired'
									,report.[IsHeaderExcluded_Name] AS '@IsHeaderExcluded'
									,(
											SELECT
													params.[Name] AS '@Name'
													,ISNULL(params.[ParameterValue],'') AS '@Value'
													,typ.[Name] AS '@Type'
													,typ.[ValueFunctionName] AS '@ValueFunctionName'
											FROM [MDSDB].[mdm].[ReportPublisher_Report_Parameters] AS params
											INNER JOIN [MDSDB].[mdm].[ReportPublisher_Parameter_Types] AS typ
													ON (typ.[Code] = params.[ParameterType_Code])
											WHERE (ISNULL(params.[Report_Code],'') = report.[Code])
											FOR XML PATH('Parameter'), TYPE
									)
							FROM [MDSDB].[mdm].[ReportPublisher_Report_Definitions] AS report
							INNER JOIN [MDSDB].[mdm].[ReportPublisher_Report_Types] AS rtype
								ON (rtype.[Code] = report.[ReportType_Code])
							INNER JOIN [MDSDB].[mdm].[ReportPublisher_Server_Types] AS rserver
								ON (rserver.[Code] = rtype.[ReportServer_Code])
							WHERE  (ISNULL(report.[ReportBatch_Code],'') = batch.[Code])
									AND(ISNULL(report.[ReportStatus_Code],'') = 1)
							FOR XML PATH('Report'), TYPE
						)
					FROM [MDSDB].[mdm].[ReportPublisher_Report_Batches] AS batch
					INNER JOIN [MDSDB].[mdm].[ReportPublisher_Schedule_Types] AS sched
							ON (sched.[Code] = batch.[BatchSchedule_Code])
					-- include only batches that have active reports
					INNER JOIN (
						SELECT DISTINCT [ReportBatch_Code]
						FROM [MDSDB].[mdm].[ReportPublisher_Report_Definitions]
						WHERE (ISNULL([ReportStatus_Code],'') = 1)
					) AS ReportBatches
						ON (ReportBatches.[ReportBatch_Code] = batch.[Code])
					ORDER BY
						batch.[PublishPriority] ASC
					FOR XML PATH('Batch'), TYPE
				)
			FOR XML PATH('Configuration')
		);

		RETURN(0);
END

