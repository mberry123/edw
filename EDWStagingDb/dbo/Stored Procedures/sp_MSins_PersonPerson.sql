create procedure [sp_MSins_PersonPerson]
    @c1 int,
    @c2 nchar(2),
    @c3 bit,
    @c4 nvarchar(8),
    @c5 nvarchar(50),
    @c6 nvarchar(50),
    @c7 nvarchar(50),
    @c8 nvarchar(10),
    @c9 int,
    @c10 xml,
    @c11 xml,
    @c12 uniqueidentifier,
    @c13 datetime
as
begin  
	insert into [Person].[Person] (
		[BusinessEntityID],
		[PersonType],
		[NameStyle],
		[Title],
		[FirstName],
		[MiddleName],
		[LastName],
		[Suffix],
		[EmailPromotion],
		[AdditionalContactInfo],
		[Demographics],
		[rowguid],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3,
		@c4,
		@c5,
		@c6,
		@c7,
		@c8,
		@c9,
		@c10,
		@c11,
		@c12,
		@c13	) 
end  
