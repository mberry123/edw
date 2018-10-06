
CREATE PROCEDURE [Support].[GetSSISPackageExceptions](
	@LastQueryTime datetime,
	@SSISPackageExceptionsXml xml OUTPUT
)
AS
BEGIN
	WITH PackageHistory AS (
		SELECT
			[package_name] AS 'PackageName'
			,(CASE [status] WHEN 7 THEN 1 ELSE 0 END)  AS 'Success'
			,(CASE [status] WHEN 3 THEN 1 ELSE 0 END)  AS 'Canceled'
			,(CASE [status] WHEN 4 THEN 1 ELSE 0 END)  AS 'Failed'
			,(CASE [status] WHEN 6 THEN 1 ELSE 0 END)  AS 'EndedUnexpectedly'
			,(CASE
					(LAST_VALUE([status]) OVER(
							PARTITION BY [package_name]
							ORDER BY [created_time] DESC
						)
					)
				WHEN 7 THEN 'Succeeded'
				ELSE 'Failed'
			END) AS 'CurrentStatus'
		FROM [SSISDB].[catalog].[executions]
		WHERE  ([status] NOT IN (1,2,5))
			AND(CAST([created_time] AS datetime) > @LastQueryTime)
	)
	SELECT @SSISPackageExceptionsXml = (
		SELECT
			[PackageName]
			,SUM([Success]) AS 'Success'
			,SUM([Canceled]) AS 'Cancellations'
			,SUM([Failed]) AS 'Failures'
			,SUM([EndedUnexpectedly]) AS 'Ends'
			,MIN([CurrentStatus]) AS 'CurrentStatus'
		FROM PackageHistory
		GROUP BY
			[PackageName]
		HAVING
				(SUM([Canceled]) > 0)
			OR	(SUM([Failed]) > 0)
			OR	(SUM([EndedUnexpectedly]) > 0)
		ORDER BY
			[PackageName]
		FOR XML RAW('tr'), ELEMENTS
	);

	RETURN(0);
END;
