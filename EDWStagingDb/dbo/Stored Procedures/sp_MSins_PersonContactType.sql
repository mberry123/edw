create procedure [sp_MSins_PersonContactType]
    @c1 int,
    @c2 nvarchar(50),
    @c3 datetime
as
begin  
	insert into [Person].[ContactType] (
		[ContactTypeID],
		[Name],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3	) 
end  
