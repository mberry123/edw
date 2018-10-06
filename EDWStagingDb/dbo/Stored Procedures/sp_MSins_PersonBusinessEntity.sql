create procedure [sp_MSins_PersonBusinessEntity]
    @c1 int,
    @c2 uniqueidentifier,
    @c3 datetime
as
begin  
	insert into [Person].[BusinessEntity] (
		[BusinessEntityID],
		[rowguid],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3	) 
end  
