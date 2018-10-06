

CREATE PROCEDURE [Transform].[ResellerSalesWeeklyAggregate]
AS
BEGIN
       DECLARE @ReturnCode INT = 0;
    DECLARE @ProcName VARCHAR(255);
    SELECT @ProcName = OBJECT_NAME(@@PROCID);
       /* Log the successful start of Day End Procedure */
       INSERT INTO [Transform].[EDWDayEndProcedureLog] VALUES (GETDATE(),@ProcName, 'Start','');

       SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

       BEGIN TRAN

       BEGIN TRY
	   
	   SELECT 1;

       END TRY

       BEGIN CATCH
              ROLLBACK TRAN;



              DECLARE @ExceptionDetails NVARCHAR(MAX);
              EXEC [DBADb].[util].[GetErrorOutput] @ExceptionDetails OUTPUT;
              /* Log the failure of Day End Procedure */
              INSERT INTO [Transform].[EDWDayEndProcedureLog] VALUES (GETDATE(),@ProcName, 'Failure',@ExceptionDetails);
              THROW;        
              GOTO EXIT_PROC;
       END CATCH

       COMMIT TRAN
       /* Log the successful End of Day End Procedure */
       INSERT INTO [Transform].[EDWDayEndProcedureLog] VALUES (GETDATE(),@ProcName, 'Success','');

       EXIT_PROC:

       RETURN (@ReturnCode);
END

GO
EXECUTE sp_addextendedproperty @name = N'DailyUpdateExecutionOrder', @value = N'1005', @level0type = N'SCHEMA', @level0name = N'Transform', @level1type = N'PROCEDURE', @level1name = N'ResellerSalesWeeklyAggregate';

