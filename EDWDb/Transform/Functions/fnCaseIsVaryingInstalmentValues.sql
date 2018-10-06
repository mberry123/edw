
CREATE FUNCTION [Transform].[fnCaseIsVaryingInstalmentValues] 
(
@PlanID				AS Numeric(38,0) = NULL,
@RevisionNumber		AS INT = NULL
)
RETURNS BIT
AS
BEGIN
	DECLARE @ReturnValue	BIT;
	DECLARE @ValuesCount	INT;
	DECLARE @ActiveRevision	INT;
/*----------------------------*/
--
	IF @PlanID IS NULL 
		RETURN 0
	ELSE IF @RevisionNumber IS NULL
		RETURN 0

-- Check that the ACTIVE Revision number has been passed in
	SET @ActiveRevision = ( SELECT 
								[PlanRevision].[rev_no]
							FROM 
								[EDWStagingDb].[dbo].[cms_rpln_det] [PlanRevision]
							WHERE
								[PlanRevision].[pln_num] = @PlanID
								AND [PlanRevision].[rev_stat] = 'A'
						  )

	IF @ActiveRevision IS NULL
		RETURN 0;
	ELSE IF @RevisionNumber <> @ActiveRevision
		RETURN 0;

--	
	WITH
	 cte_instalments([plan_num],[rev_no],[instalment_date], [amt])
	AS
	(SELECT
		@PlanID
		, @RevisionNumber
		, [PlanDetail].[dat]
		, [PlanDetail].[amt]
	FROM 
		[EDWStagingDb].[dbo].[cms_pln_chk] [PlanDetail] 
		INNER JOIN [EDWStagingDb].[dbo].[cms_pln] [PlanHeader]
		ON [PlanDetail].[pln_num] = [PlanHeader].[pln_num]
		 AND [PlanDetail].[rev_no] = [PlanHeader].[act_rev]
	WHERE
		[PlanHeader].[pln_num] = @PlanID 
		AND [PlanHeader].[canc_dat] IS NULL
		AND [PlanHeader].[act_rev] = @RevisionNumber
		AND [PlanDetail].[plan_or_std] <> 'S'
	),
	-- Determine the first and last instalment dates so we can exclude them later
	cte_boundarydates ([firstdate],[lastdate]) AS
	(SELECT
		 MIN([cte_instalments].[instalment_date])
		, MAX([cte_instalments].[instalment_date])
	FROM 
		cte_instalments
	),

	cte_valuecounts ([amt]) AS
	(SELECT 
		[cte_instalments].[amt]
	FROM
		[cte_instalments]
		INNER JOIN [cte_boundarydates] 
		ON [cte_instalments].[instalment_date] > [cte_boundarydates].[firstdate] 
		AND [cte_instalments].[instalment_date] < [cte_boundarydates].[lastdate]
	GROUP BY
		[cte_instalments].[amt]
	)

--
	SELECT @ValuesCount = COUNT([cte_valuecounts].[amt]) FROM [cte_valuecounts] HAVING COUNT([cte_valuecounts].[amt]) > 1

--
	IF @ValuesCount IS NULL
		SET @ReturnValue = 0

	ELSE IF @ValuesCount > 1
		SET @ReturnValue = 1
	
	ELSE
		SET @ReturnValue = 0
/*----------------------------*/
	RETURN @ReturnValue
END
