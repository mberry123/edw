create procedure [sp_MSins_PersonBusinessEntityContact]
    @c1 int,
    @c2 int,
    @c3 int,
    @c4 uniqueidentifier,
    @c5 datetime
as
begin  
	insert into [Person].[BusinessEntityContact] (
		[BusinessEntityID],
		[PersonID],
		[ContactTypeID],
		[rowguid],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3,
		@c4,
		@c5	) 
end  
