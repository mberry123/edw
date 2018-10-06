EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Currency Key</Name>
						<Description># Surrogate Key for the Currency dimension</Description>
						<Source>
								<System>N/A</System>
								<Table>N/A</Table>
								<Column>N/A</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCurrencyView', @level2type = N'COLUMN', @level2name = N'Currency Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Currency Alternate Key</Name>
						<Description>The ISO code for the Currency.</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Sales].[Currency]</Table>
								<Column>[CurrencyCode]</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCurrencyView', @level2type = N'COLUMN', @level2name = N'Currency Alternate Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Currency Name</Name>
						<Description>Currency name.</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Sales].[Currency]</Table>
								<Column>[Name]</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCurrencyView', @level2type = N'COLUMN', @level2name = N'Currency Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Key</Name>						<Description># Surrogate Key for the Customer dimension.</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Row Creation Date</Name>						<Description>The date that the DimCustomer was created</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Row Creation Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Row Closed Date</Name>						<Description>The date that the DimCustomer was closed</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Row Closed Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Current Row Flag</Name>						<Description>Flag to indicate if the row is historically the current version for the customer</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Current Row Flag';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer ID</Name>						<Description>Unique number identifying the customer assigned by the accounting system.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[Customer]</Table>								<Column>[AccountNumber]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer ID';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Title</Name>						<Description>A courtesy title. For example, Mr. or Ms.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Person]</Table>								<Column>[Title]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Title';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer First Name</Name>						<Description>First name of the person.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Person]</Table>								<Column>[FirstName]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer First Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Middle Name</Name>						<Description>Middle name or middle initial of the person.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Person]</Table>								<Column>[MiddleName]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Middle Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer LastName</Name>						<Description>Last name of the person.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Person]</Table>								<Column>[LastName]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer LastName';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer DOB</Name>						<Description>Customer Date of birth.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Person]</Table>								<Column>[Demographics] (BirthDate)</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer DOB';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Marital Status</Name>						<Description>M = Married, S = Single</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Person]</Table>								<Column>[Demographics] (MaritalStatus)</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Marital Status';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Gender</Name>						<Description>M = Male, F = Female</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Person]</Table>								<Column>[Demographics] (Gender)</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Gender';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Address Line 1</Name>						<Description>Customer First street address line.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Address]</Table>								<Column>[AddressLine1]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Address Line 1';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Address Line 2</Name>						<Description>Customer Second street address line.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Address]</Table>								<Column>[AddressLine2]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Address Line 2';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer City</Name>						<Description>Name of the city.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Address]</Table>								<Column>[City]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer City';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer State Province Code</Name>						<Description>ISO standard state or province code.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[StateProvince]</Table>								<Column>[StateProvinceCode]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer State Province Code';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer State Province Name</Name>						<Description>State or province description.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[StateProvince]</Table>								<Column>[Name]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer State Province Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Country Region Code</Name>						<Description>ISO standard code for countries and regions.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[CountryRegion]</Table>								<Column>[CountryRegionCode]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Country Region Code';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Country Region Name</Name>						<Description>Country or region name.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[CountryRegion]</Table>								<Column>[Name]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Country Region Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Sales Territory Name</Name>						<Description>Sales territory description</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesTerritory]</Table>								<Column>[Name]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Sales Territory Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Sales Territory Group</Name>						<Description>Geographic area to which the sales territory belong.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesTerritory]</Table>								<Column>[Group]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Sales Territory Group';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Post Code</Name>						<Description>Postal code for the street address.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Address]</Table>								<Column>[PostalCode]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Post Code';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Phone</Name>						<Description>Telephone number identification number.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[PersonPhone]</Table>								<Column>[PhoneNumber]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Phone';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Email Address</Name>						<Description>E-mail address for the person.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[EmailAddress]</Table>								<Column>[EmailAddress]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Email Address';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Anual Income</Name>						<Description>Customer Yearly Income Range</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Person]</Table>								<Column>[Demographics] (YearlyIncome)</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Anual Income';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Total Children</Name>						<Description>Customers number of children</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Person]</Table>								<Column>[Demographics] (TotalChildren)</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Total Children';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Children At Home</Name>						<Description>Customers number of children at home</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Person]</Table>								<Column>[Demographics] (NumberChildrenAtHome)</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Children At Home';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Education</Name>						<Description>Customers Education level</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Person]</Table>								<Column>[Demographics] (Education)</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Education';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Occupation</Name>						<Description>Customers occupation</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Person]</Table>								<Column>[Demographics] (Occupation)</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Occupation';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Is Home Owner</Name>						<Description>Flag to indicate if the customer owns a car</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Person]</Table>								<Column>[Demographics] (HomeOwnerFlag)</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Is Home Owner';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Number Of Vehicles</Name>						<Description>Number of vehicles own by the Customer</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Person]</Table>								<Column>[Demographics] (NumberCarsOwned)</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Number Of Vehicles';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer First Purchase Date</Name>						<Description>Date of Customers first purchase</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Person]</Table>								<Column>[Demographics] (DateFirstPurchase)</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer First Purchase Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Customer Commute Distance</Name>						<Description>Distance of the Customers commute</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Person]</Table>								<Column>[Demographics] (CommuteDistance)</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimCustomerView', @level2type = N'COLUMN', @level2name = N'Customer Commute Distance';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Date Key</Name>
									<Description># Surrogate Key of the date dimension.</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Date Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Date</Name>
									<Description># Used for the tabular model only.</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Full Date</Name>
									<Description>The full date eg. 2013-05-16</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Full Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Date Name</Name>
									<Description>This is the full date stored in text format eg. 2014/12/31</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Date Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Day Of Week</Name>
									<Description>The day number of the week eg. 7</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Day Of Week';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Day Name Of Week</Name>
									<Description>The day name of the week eg. Friday</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Day Name Of Week';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Day Of Month</Name>
									<Description>The day number of the month eg. 8</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Day Of Month';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Working Day Of Month</Name>
									<Description>The number of the dlc working day of the month.</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Working Day Of Month';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Is UK Bank Holiday</Name>
									<Description>A flag to indicate if it is a bank holiday.</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Is UK Bank Holiday';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>UK Bank Holiday Name</Name>
									<Description>A Description of the bank holiday eg. Easter Monday</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'UK Bank Holiday Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Day Of Year</Name>
									<Description>The day number of the year eg. 136</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Day Of Year';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Weekday Or Weekend</Name>
									<Description>Weekday or weekend.</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Weekday Or Weekend';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Week No. Of Year</Name>
									<Description>The number of the week in the year eg. 1</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Week No. Of Year';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Month Name</Name>
									<Description>The name of the month eg. January</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Month Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Month No. Of Year</Name>
									<Description>The number of the month in the year eg. 6</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Month No. Of Year';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Is Last Day Of Month</Name>
									<Description>A flag to indicate if it is the last day of the month.</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Is Last Day Of Month';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Calendar Quarter</Name>
									<Description>The quarter of the calender year eg. 1,2,3 or 4</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Calendar Quarter';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Calendar Year</Name>
									<Description>The calendar year eg. 2012</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Calendar Year';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Calendar Year Month</Name>
									<Description>The calendar year and month eg. 2014-01</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Calendar Year Month';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Calendar Year And Qtr</Name>
									<Description>The calendar year and quarter eg. 2014Q2</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Calendar Year And Qtr';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Fiscal Month Of Year</Name>
									<Description>The number of the month from the beggining of the fiscal Year (the fiscal year begins in April) eg. 4</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Fiscal Month Of Year';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Fiscal Quarter</Name>
									<Description>The number of the fiscal quarter eg. 4</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Fiscal Quarter';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Fiscal Year</Name>
									<Description>The fiscal year eg. 2014</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Fiscal Year';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Fiscal Year and Month</Name>
									<Description>The fiscal year and month eg. 2014-01</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Fiscal Year and Month';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Fiscal Year and Quarter</Name>
									<Description>The fiscal year and quarter eg. 2014Q4</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'Fiscal Year and Quarter';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>FourC Quarter</Name>
									<Description>The number of the FourC quarter eg. 4</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'FourC Quarter';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>FourC Year</Name>
									<Description>The FourC year eg. 2014</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'FourC Year';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>FourC Year and Quarter</Name>
									<Description>The FourC year and quarter eg. 2014Q4</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDateView', @level2type = N'COLUMN', @level2name = N'FourC Year and Quarter';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Execution Id</Name>
									<Description># The ETL execution that either inserted or updated this row.</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDescriptionView', @level2type = N'COLUMN', @level2name = N'Execution Id';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Description Key</Name>
									<Description># The surrogate key of the description dimension.</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDescriptionView', @level2type = N'COLUMN', @level2name = N'Description Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Description Code</Name>
									<Description>The Code used in conjunction with the description type.</Description>
									<Source>
										<System>N/A</System>
										<Table></Table>
										<Column></Column>
									</Source>
									<IsLogic>0</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDescriptionView', @level2type = N'COLUMN', @level2name = N'Description Code';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Description Type</Name>
									<Description>Groups the descriptions into manageable chunks. Used in conjunction with the description code.</Description>
									<Source>
										<System>N/A</System>
										<Table>N/A</Table>
										<Column>N/A</Column>
									</Source>
									<IsLogic>1</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDescriptionView', @level2type = N'COLUMN', @level2name = N'Description Type';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
									<Name>Description</Name>
									<Description>The description of the attribute relating to the code and type.</Description>
									<Source>
										<System>N/a</System>
										<Table>N/A</Table>
										<Column>narr</Column>
									</Source>
										<IsLogic>1</IsLogic>
									<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimDescriptionView', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
                                <DataDictionary>
                                        <Name>Employee Key</Name>
                                        <Description># Surrogate Key for the Employee dimension.</Description>
                                        <Source>
                                                <System>N/A</System>
                                                <Table>N/A</Table>
                                                <Column>N/A</Column>
                                        </Source>
                                        <IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
                                        <LegacyName>N/A</LegacyName>
                                </DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Row Creation Date</Name>
										<Description>The date that the DimEmployee row was created.</Description>
										<Source>
												<System>N/A</System>
												<Table>N/A</Table>
												<Column>N/A</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Row Creation Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Row Closed Date</Name>
										<Description>The date that the DimEmployee row was closed.</Description>
										<Source>
												<System>N/A</System>
												<Table>N/A</Table>
												<Column>N/A</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Row Closed Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Current Row Flag</Name>
										<Description>Flag to indicate if the row is historically the current version for the Employee</Description>
										<Source>
												<System>N/A</System>
												<Table>N/A</Table>
												<Column>N/A</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Current Row Flag';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Code</Name>
										<Description>Business key for Employee records from source data.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[HumanResources].[Employee]</Table>
												<Column>[BusinessEntityID]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Code';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Department</Name>
										<Description>Name of the department that the Employee works.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[HumanResources].[Department]</Table>
												<Column>[name]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Department';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Department Group Name</Name>
										<Description>Name of the group to which the Employee department belongs.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[HumanResources].[Department]</Table>
												<Column>[GroupName]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Department Group Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Department Start Date</Name>
										<Description>Date the employee started work in the department. </Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[HumanResources].[EmployeeDepartmentHistory]</Table>
												<Column>[StartDate]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Department Start Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Title</Name>
										<Description>A courtesy title. For example, Mr. or Ms.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Person].[Person]</Table>
												<Column>[Title]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Title';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee First Name</Name>
										<Description>First name of the Employee.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Person].[Person]</Table>
												<Column>[FirstName]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee First Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Middle Name</Name>
										<Description>Middle name of the Employee.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Person].[Person]</Table>
												<Column>[MiddleName]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Middle Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Last Name</Name>
										<Description>Last name of the Employee.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Person].[Person]</Table>
												<Column>[LastName]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Last Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Suffix</Name>
										<Description>Surname suffix. For example, Sr. or Jr.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Person].[Person]</Table>
												<Column>[Suffix]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Suffix';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Job Title</Name>
										<Description>Work title such as Buyer or Sales Representative.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[HumanResources].[Employee]</Table>
												<Column>[JobTitle]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Job Title';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Phone Number</Name>
										<Description>Employee Telephone number identification number.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Person].[PersonPhone]</Table>
												<Column>[PhoneNumber]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Phone Number';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Phone Number Type</Name>
										<Description>Name of the Employee telephone number type.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Person].[PhoneNumberType]</Table>
												<Column>[Name]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Phone Number Type';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Email Address</Name>
										<Description>E-mail address for the Employee.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Person].[EmailAddress]</Table>
												<Column>[EmailAddress]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Email Address';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Email Promotion</Name>
										<Description>0 = Contact does not wish to receive e-mail promotions, 1 = Contact does wish to receive e-mail promotions from AdventureWorks, 2 = Contact does wish to receive e-mail promotions from AdventureWorks and selected partners.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Person].[Person]</Table>
												<Column>[EmailPromotion]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Email Promotion';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Address Line 1</Name>
										<Description>Employee first street address line.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Person].[Address]</Table>
												<Column>[AddressLine1]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Address Line 1';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Address Line 2</Name>
										<Description>Employee second street address line.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Person].[Address]</Table>
												<Column>[AddressLine2]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Address Line 2';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee City</Name>
										<Description>Name of the Employee city.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Person].[Address]</Table>
												<Column>[City]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee City';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee State Province Name</Name>
										<Description>ISO standard state or province code.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Person].[StateProvince]</Table>
												<Column>[StateProvinceCode]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee State Province Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Postal Code</Name>
										<Description>Postal code for the street address.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Person].[Address]</Table>
												<Column>[PostalCode]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Postal Code';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Employee Country Region Name</Name>
										<Description>Employee Country or region name.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Person].[CountryRegion]</Table>
												<Column>[name]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimEmployeeView', @level2type = N'COLUMN', @level2name = N'Employee Country Region Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
                                <DataDictionary>
                                        <Name>Product Key</Name>
                                        <Description># Surrogate Key for the Product dimension.</Description>
                                        <Source>
                                                <System>N/A</System>
                                                <Table>N/A</Table>
                                                <Column>N/A</Column>
                                        </Source>
                                        <IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
                                        <LegacyName>N/A</LegacyName>
                                </DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Row Creation Date</Name>
										<Description>The date that the DimProduct row was created.</Description>
										<Source>
												<System>N/A</System>
												<Table>N/A</Table>
												<Column>N/A</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Row Creation Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Row Closed Date</Name>
										<Description>The date that the DimProduct row was closed.</Description>
										<Source>
												<System>N/A</System>
												<Table>N/A</Table>
												<Column>N/A</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Row Closed Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Current Row Flag</Name>
										<Description>Flag to indicate if the row is historically the current version for the Product</Description>
										<Source>
												<System>N/A</System>
												<Table>N/A</Table>
												<Column>N/A</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Current Row Flag';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Code</Name>
										<Description>Unique product identification number.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[Product]</Table>
												<Column>[ProductNumber]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Code';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Category Name</Name>
										<Description>Product Category description.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[ProductCategory]</Table>
												<Column>[name]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Category Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Subcategory Name</Name>
										<Description>Product Sub Category Description</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[ProductSubcategory]</Table>
												<Column>[name]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Subcategory Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Weight Unit Measure Code</Name>
										<Description>Unit of measure for Weight column.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[Product]</Table>
												<Column>[WeightUnitMeasureCode]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Weight Unit Measure Code';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Size Unit Measure Code</Name>
										<Description>Unit of measure for Size column.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[Product]</Table>
												<Column>[SizeUnitMeasureCode]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Size Unit Measure Code';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Name</Name>
										<Description>Unit of measure for Size column.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[Product]</Table>
												<Column>[name]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Standard Cost</Name>
										<Description>Standard cost of the product.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[Product]</Table>
												<Column>[StandardCost]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Standard Cost';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Finished Goods Flag</Name>
										<Description>0 = Product is not a salable item. 1 = Product is salable.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[Product]</Table>
												<Column>[FinishedGoodsFlag]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Finished Goods Flag';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Colour</Name>
										<Description>Product Colour</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[Product]</Table>
												<Column>[Color]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Colour';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Safety Stock Level</Name>
										<Description>Minimum inventory quantity.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[Product]</Table>
												<Column>[SafetyStockLevel]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Safety Stock Level';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Reorder Point</Name>
										<Description>Inventory level that triggers a purchase order or work order.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[Product]</Table>
												<Column>[ReorderPoint]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Reorder Point';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product List Price</Name>
										<Description>Product Selling price.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[Product]</Table>
												<Column>[ListPrice]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product List Price';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Size Range</Name>
										<Description>Product size.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[Product]</Table>
												<Column>N/A</Column>
										</Source>
										<IsLogic>1</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Size';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Weight</Name>
										<Description>Product size.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[Product]</Table>
												<Column>[Weight]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Weight';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Days To Manufacture</Name>
										<Description>Number of days required to manufacture the product.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[Product]</Table>
												<Column>[DaysToManufacture]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Days To Manufacture';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Line</Name>
										<Description>R = Road, M = Mountain, T = Touring, S = Standard</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[Product]</Table>
												<Column>[ProductLine]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Line';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Dealer Price</Name>
										<Description>Scalar function returning the dealer price for a given product on a particular order date.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[dbo].[ufnGetProductDealerPrice]</Table>
												<Column>[ProductLine]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Dealer Price';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Class</Name>
										<Description>H = High, M = Medium, L = Low</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[Product]</Table>
												<Column>[class]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Class';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Style</Name>
										<Description>W = Womens, M = Mens, U = Universal</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[Product]</Table>
												<Column>[Style]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Style';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Model Name</Name>
										<Description>Product model description.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[ProductModel]</Table>
												<Column>[Name]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Model Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Large Photo</Name>
										<Description>Large image of the product.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[ProductPhoto]</Table>
												<Column>[LargePhoto]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Large Photo';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product Description</Name>
										<Description>Description of the product.</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[ProductDescription]</Table>
												<Column>[Description]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product Description';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
								<DataDictionary>
										<Name>Product ID</Name>
										<Description>Primary key for Product records in source</Description>
										<Source>
												<System>AdventureWorks2012</System>
												<Table>[Production].[Product]</Table>
												<Column>[Description]</Column>
										</Source>
										<IsLogic>0</IsLogic>
										<FQLegacyColumnName>N/A</FQLegacyColumnName>
										<LegacyName>N/A</LegacyName>
								</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimProductView', @level2type = N'COLUMN', @level2name = N'Product ID';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Promotion Key</Name>						<Description># Surrogate Key for the Promotion dimension</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimPromotionView', @level2type = N'COLUMN', @level2name = N'Promotion Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Promotion Row Creation Date</Name>						<Description>Promotion Row Creation Date</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimPromotionView', @level2type = N'COLUMN', @level2name = N'Promotion Row Creation Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Promotion Row Closed Date</Name>						<Description>Promotion Row Closed Date</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimPromotionView', @level2type = N'COLUMN', @level2name = N'Promotion Row Closed Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Promotion Current Row Flag</Name>						<Description>Flag to indicate if the row is historically the current version for the Promotion</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimPromotionView', @level2type = N'COLUMN', @level2name = N'Promotion Current Row Flag';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Promotion ID</Name>						<Description>Primary key for SpecialOffer records.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SpecialOffer]</Table>								<Column>[SpecialOfferID]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimPromotionView', @level2type = N'COLUMN', @level2name = N'Promotion ID';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Promotion Name</Name>						<Description>Discount description.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SpecialOffer]</Table>								<Column>[Description]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimPromotionView', @level2type = N'COLUMN', @level2name = N'Promotion Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Promotion Discount Percentage</Name>						<Description>Discount precentage.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SpecialOffer]</Table>								<Column>[DiscountPct]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimPromotionView', @level2type = N'COLUMN', @level2name = N'Promotion Discount Percentage';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Promotion Type</Name>						<Description>Discount type category.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SpecialOffer]</Table>								<Column>[Type]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimPromotionView', @level2type = N'COLUMN', @level2name = N'Promotion Type';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Promotion Category</Name>						<Description>Group the discount applies to such as Reseller or Customer.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SpecialOffer]</Table>								<Column>[Category]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimPromotionView', @level2type = N'COLUMN', @level2name = N'Promotion Category';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Promotion Start Date</Name>						<Description>Discount start date.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SpecialOffer]</Table>								<Column>[StartDate]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimPromotionView', @level2type = N'COLUMN', @level2name = N'Promotion Start Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Promotion End Date</Name>						<Description>Discount end date.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SpecialOffer]</Table>								<Column>[EndDate]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimPromotionView', @level2type = N'COLUMN', @level2name = N'Promotion End Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Promotion Minimum Quantity</Name>						<Description>Minimum discount percent allowed.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SpecialOffer]</Table>								<Column>[MinQty]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimPromotionView', @level2type = N'COLUMN', @level2name = N'Promotion Minimum Quantity';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Promotion Maximum Quantity</Name>						<Description>Maximum discount percent allowed.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SpecialOffer]</Table>								<Column>[MaxQty]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimPromotionView', @level2type = N'COLUMN', @level2name = N'Promotion Maximum Quantity';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Key</Name>						<Description># Surrogate Key for the Reseller dimension</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Row Creation Date</Name>						<Description>Reseller Row Creation Date</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Row Creation Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Row Closed Date</Name>						<Description>Reseller Row Closed Date</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Row Closed Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Current Row Flag</Name>						<Description>Flag to indicate if the row is historically the current version for the Reseller</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Current Row Flag';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller City</Name>						<Description>Name of the reseller city.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Address]</Table>								<Column>[City]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller City';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller State Province Code</Name>						<Description>ISO standard state or province code.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[StateProvince]</Table>								<Column>[StateProvinceCode]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller State Province Code';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller State Province Name</Name>						<Description>Reseller State or province description.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[StateProvince]</Table>								<Column>[Name]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller State Province Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Country Region Code</Name>						<Description>ISO code for countries and regions.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[CountryRegion]</Table>								<Column>[CountryRegionCode]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Country Region Code';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Country Region Name</Name>						<Description>Reseller Country or region name.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[CountryRegion]</Table>								<Column>[Name]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Country Region Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Postal Code</Name>						<Description>Reseller Postal code for the street address.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Address]</Table>								<Column>[PostalCode]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Postal Code';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Territory Region</Name>						<Description>Reseller sales territory description</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesTerritory]</Table>								<Column>[Name]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Territory Region';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Territory Group</Name>						<Description>Reseller geographic area to which the sales territory belong.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesTerritory]</Table>								<Column>[Group]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Territory Group';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller ID</Name>						<Description>AW concatenated with the filled out BusinessEnitityID from store</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[Store]</Table>								<Column>[BusinessEntityID]</Column>						</Source>						<IsLogic>1</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller ID';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Phone</Name>						<Description>Reseller telephone number identification number.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[PersonPhone]</Table>								<Column>[PhoneNumber]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Phone';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Business Type</Name>						<Description>WHEN BM   THEN Value Added Reseller,   WHEN BS   THEN Specialty Bike Shop,   WHEN OS    THEN Warehouse</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[Store]</Table>								<Column>[Demographics].value((/ss:StoreSurvey/ss:BusinessType)[1], NVARCHAR(50))</Column>						</Source>						<IsLogic>1</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Business Type';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Reseller Name</Name>						<Description>Name of the reseller store.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[Store]</Table>								<Column>[Name]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Reseller Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Number Employees</Name>						<Description>Number of employees from demographic informationg about the store such as the number of employees, annual sales and store type.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[Store]</Table>								<Column>[Demographics].value((/ss:StoreSurvey/ss:NumberEmployees)[1], INT)</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Number Employees';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Order Frequency</Name>						<Description>Order Frequency from custom store Information.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[StoreOrderStats]</Table>								<Column>[OrderFrequency]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Order Frequency';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Order Month</Name>						<Description>Order Month from custom store Information.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[StoreOrderStats]</Table>								<Column>[OrderMonth]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Order Month';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller First Order Year</Name>						<Description>Last Order Year from custom store Information.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[StoreOrderStats]</Table>								<Column>[FirstOrderYear]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller First Order Year';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Last Order Year</Name>						<Description>First Order Year from custom store Information.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[StoreOrderStats]</Table>								<Column>[LastOrderYear]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Last Order Year';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Product Line</Name>						<Description>Specialty from demographic informationg about the store such as the number of employees, annual sales and store type.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[Store]</Table>								<Column>[Demographics].value((/ss:StoreSurvey/ss:Specialty)[1], NVARCHAR(50))</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Product Line';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Address Line 1</Name>						<Description>First street address line.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Address]</Table>								<Column>[AddressLine2]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Address Line 1';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Address Line 2</Name>						<Description>Second street address line.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[Address]</Table>								<Column>[AddressLine1]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Address Line 2';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Annual Sales</Name>						<Description>Bank Name from demographic informationg about the store such as the number of employees, annual sales and store type.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[Store]</Table>								<Column>[Demographics].value((/ss:StoreSurvey/ss:AnnualSales)[1], DECIMAL (18,2))</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Annual Sales';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Bank Name</Name>						<Description>Annual Sales from demographic informationg about the store such as the number of employees, annual sales and store type.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[Store]</Table>								<Column>[Demographics].value((/ss:StoreSurvey/ss:BankName)[1], NVARCHAR(50))</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Bank Name';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Min Payment Type</Name>						<Description>Minimum Payment Type from custom store Information.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[StoreOrderStats]</Table>								<Column>[MinPaymentType]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Min Payment Type';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Min Payment Amount</Name>						<Description>Minimum Payment Amount from custom store Information.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[StoreOrderStats]</Table>								<Column>[MinPaymentAmount]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Min Payment Amount';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Annual Revenue</Name>						<Description>Annual Revenue from demographic informationg about the store such as the number of employees, annual sales and store type.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[Store]</Table>								<Column>[Demographics].value((/ss:StoreSurvey/ss:AnnualRevenue)[1], DECIMAL (18,2))</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Annual Revenue';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Year Opened</Name>						<Description>Year Opened from demographic informationg about the store such as the number of employees, annual sales and store type.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[Store]</Table>								<Column>[Demographics].value((/ss:StoreSurvey/ss:YearOpened)[1], INT)</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimResellerView', @level2type = N'COLUMN', @level2name = N'Reseller Year Opened';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Sales Territory Key</Name>						<Description># Surrogate Key for the Sales Territory dimension</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimSalesTerritoryView', @level2type = N'COLUMN', @level2name = N'Sales Territory Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Sales Territory Row Creation Date</Name>						<Description>The date that the DimSalesTerritory row was created.</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimSalesTerritoryView', @level2type = N'COLUMN', @level2name = N'Sales Territory Row Creation Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Sales Territory Row Closed Date</Name>						<Description>The date that the DimSalesTerritory row was closed.</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimSalesTerritoryView', @level2type = N'COLUMN', @level2name = N'Sales Territory Row Closed Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Sales Territory Current Row Flag</Name>						<Description>Flag to indicate if the row is historically the current version for the Sales Territory</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>1</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimSalesTerritoryView', @level2type = N'COLUMN', @level2name = N'Sales Territory Current Row Flag';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Sales Territory Id</Name>						<Description>Unique Identifier for the Sales Territory</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesTerritory]</Table>								<Column>[TerritoryID]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimSalesTerritoryView', @level2type = N'COLUMN', @level2name = N'Sales Territory Id';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Sales Territory Region</Name>						<Description>Sales territory description</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesTerritory]</Table>								<Column>[name]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimSalesTerritoryView', @level2type = N'COLUMN', @level2name = N'Sales Territory Region';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Sales Territory Country</Name>						<Description>Sales Country or region name.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Person].[CountryRegion]</Table>								<Column>[name]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimSalesTerritoryView', @level2type = N'COLUMN', @level2name = N'Sales Territory Country';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Sales Territory Group</Name>						<Description>Geographic area to which the sales territory belong.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesTerritory]</Table>								<Column>[group]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimSalesTerritoryView', @level2type = N'COLUMN', @level2name = N'Sales Territory Group';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Sales Territory Image</Name>						<Description>The image pertaining to the Territory</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesTerritoryImage]</Table>								<Column>[SalesTerritoryImage]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'DimSalesTerritoryView', @level2type = N'COLUMN', @level2name = N'Sales Territory Image';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Product Key</Name>
						<Description>Foreign Key Referencing Surrogate Key on DimProduct for Product sold to customer</Description>
						<Source>
								<System>N/A</System>
								<Table>N/A</Table>
								<Column>N/A</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Product Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Order Date Key</Name>
						<Description>Foreign Key Referencing Surrogate Key on DimDate for the Order Date</Description>
						<Source>
								<System>N/A</System>
								<Table>N/A</Table>
								<Column>N/A</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Order Date Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Due Date Key</Name>
						<Description>Foreign Key Referencing Surrogate Key on DimDate for the Due Date</Description>
						<Source>
								<System>N/A</System>
								<Table>N/A</Table>
								<Column>N/A</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Due Date Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Ship Date Key</Name>
						<Description>Foreign Key Referencing Surrogate Key on DimDate for the Ship Date</Description>
						<Source>
								<System>N/A</System>
								<Table>N/A</Table>
								<Column>N/A</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Ship Date Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Customer Key</Name>
						<Description>Foreign Key Referencing Surrogate Key on DimCustomer</Description>
						<Source>
								<System>N/A</System>
								<Table>N/A</Table>
								<Column>N/A</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Customer Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Promotion Key</Name>
						<Description>Foreign Key Referencing Surrogate Key on DimPromotion</Description>
						<Source>
								<System>N/A</System>
								<Table>N/A</Table>
								<Column>N/A</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Promotion Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Currency Key</Name>
						<Description>Foreign Key Referencing Surrogate Key on DimDescriptions for the Currency Type</Description>
						<Source>
								<System>N/A</System>
								<Table>N/A</Table>
								<Column>N/A</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Currency Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Sales Territory Key</Name>
						<Description>Foreign Key Referencing Surrogate Key on DimTerritory</Description>
						<Source>
								<System>N/A</System>
								<Table>N/A</Table>
								<Column>N/A</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Sales Territory Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Internet Sales Order Number</Name>
						<Description>Unique sequence given to each sales order</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Sales].[SalesOrderHeader]</Table>
								<Column>[SalesOrderID]</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Internet Sales Order Number';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Internet Sales Order Line Number</Name>
						<Description>A unique line number per sales order ordered on SalesOrderDetail</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Sales].[SalesOrderDetail]</Table>
								<Column>[SalesOrderDetailID]</Column>
						</Source>
						<IsLogic>1</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Internet Sales Order Line Number';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Internet Sales Revision Number</Name>
						<Description>Incremental number to track changes to the sales order over time.</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Sales].[SalesOrderHeader]</Table>
								<Column>[SalesOrderID]</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Internet Sales Revision Number';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Internet Sales Order Quantity</Name>
						<Description>Quantity ordered per product.</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Sales].[SalesOrderDetail]</Table>
								<Column>[OrderQty]</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Internet Sales Order Quantity';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Internet Sales Unit Price</Name>
						<Description>Selling price of a single product.</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Sales].[SalesOrderDetail]</Table>
								<Column>[UnitPrice]</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Internet Sales Unit Price';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Internet Sales Extended Amount</Name>
						<Description>[OrderQty] * [UnitPrice]</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Sales].[SalesOrderDetail]</Table>
								<Column>[OrderQty], [UnitPrice]</Column>
						</Source>
						<IsLogic>1</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Internet Sales Extended Amount';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Internet Sales Unit Price Discount Percentage</Name>
						<Description>Discount Percentage</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Sales].[SalesOrderDetail]</Table>
								<Column>[UnitPriceDiscount]</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Internet Sales Unit Price Discount Percentage';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Internet Sales Discount Amount</Name>
						<Description>([OrderQty] * [UnitPrice]) * [UnitPriceDiscount]</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Sales].[SalesOrderDetail]</Table>
								<Column>([OrderQty],[UnitPrice],[UnitPriceDiscount]</Column>
						</Source>
						<IsLogic>1</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Internet Sales Discount Amount';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Internet Sales Unit Product Standard Cost</Name>
						<Description>Standard cost of the product.</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Production].[Product]</Table>
								<Column>[StandardCost]</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Internet Sales Unit Product Standard Cost';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Internet Sales Total Product Cost</Name>
						<Description>[SalesOrderDetails].[OrderQty] * [Product].[StandardCost]</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Sales].[SalesOrderDetail] ,[Production].[Product]</Table>
								<Column>[SalesOrderDetails].[OrderQty],[Product].[StandardCost]</Column>
						</Source>
						<IsLogic>1</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Internet Sales Total Product Cost';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Internet Sales Amount</Name>
						<Description>Per product subtotal. Computed as UnitPrice * (1 - UnitPriceDiscount) * OrderQty.</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Sales].[SalesOrderDetail]</Table>
								<Column>[LineTotal]</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Internet Sales Amount';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Internet Sales Tax Amount</Name>
						<Description>[SalesOrderDetails].[LineTotal] + ([SalesOrderDetails].[LineTotal] * (([SalesHeader].[TaxAmt] / [SalesHeader].[TotalDue]) * 100)) / 100 - [SalesOrderDetails].[LineTotal])</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Sales].[SalesOrderHeader],[Sales].[SalesOrderDetail]</Table>
								<Column>[SalesOrderDetails].[LineTotal] , [SalesHeader].[TaxAmt], [SalesHeader].[TotalDue]</Column>
						</Source>
						<IsLogic>1</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Internet Sales Tax Amount';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Internet Sales Freight Amount</Name>
						<Description>[SalesOrderDetails].[LineTotal] + ([SalesOrderDetails].[LineTotal] * (([SalesHeader].[Freight] / [SalesHeader].[TotalDue]) * 100)) / 100 - [SalesOrderDetails].[LineTotal])</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Sales].[SalesOrderHeader],[Sales].[SalesOrderDetail]</Table>
								<Column>[SalesOrderDetails].[LineTotal] ,[SalesOrderDetails].[LineTotal],[SalesHeader].[Freight], [SalesHeader].[TotalDue]</Column>
						</Source>
						<IsLogic>1</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Internet Sales Freight Amount';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Internet Sales Carrier Tracking Number</Name>
						<Description>Shipment tracking number supplied by the shipper.</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Sales].[SalesOrderDetail]</Table>
								<Column>[CarrierTrackingNumber]</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Internet Sales Carrier Tracking Number';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Internet Sales Purchase Order Number</Name>
						<Description>Customer purchase order number reference.</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Sales].[SalesOrderHeader]</Table>
								<Column>[PurchaseOrderNumber]</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Internet Sales Purchase Order Number';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Internet Sales Order Date</Name>
						<Description>Dates the sales order was created.</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Sales].[SalesOrderHeader]</Table>
								<Column>[OrderDate]</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Internet Sales Order Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Internet Sales Due Date</Name>
						<Description>Date the order is due to the customer.</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Sales].[SalesOrderHeader]</Table>
								<Column>[DueDate]</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Internet Sales Due Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
				<DataDictionary>
						<Name>Internet Sales Ship Date</Name>
						<Description>Date the order was shipped to the customer.</Description>
						<Source>
								<System>AdventureWorks2012</System>
								<Table>[Sales].[SalesOrderHeader]</Table>
								<Column>[ShipDate]</Column>
						</Source>
						<IsLogic>0</IsLogic>
						<LegacyName>N/A</LegacyName>
				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactInternetSalesView', @level2type = N'COLUMN', @level2name = N'Internet Sales Ship Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Product Key</Name>						<Description>Foreign Key Referencing Surrogate Key on DimProduct for Product sold to customer</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Product Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Order Date Key</Name>						<Description>Foreign Key Referencing Surrogate Key on DimDate for the Order Date</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Order Date Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Due Date Key</Name>						<Description>Foreign Key Referencing Surrogate Key on DimDate for the Due Date</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Due Date Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Ship Date Key</Name>						<Description>Foreign Key Referencing Surrogate Key on DimDate for the Ship Date</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Ship Date Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Key</Name>						<Description>Foreign Key Referencing Surrogate Key on DimReseller</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Reseller Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Employee Key</Name>						<Description>Foreign Key Referencing Surrogate Key on DimEmployee</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Employee Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Promotion Key</Name>						<Description>Foreign Key Referencing Surrogate Key on DimPromotion</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Promotion Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Currency Key</Name>						<Description>Foreign Key Referencing Surrogate Key on DimDescriptions for the Currency Type</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Currency Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Sales Territory Key</Name>						<Description>Foreign Key Referencing Surrogate Key on DimTerritory</Description>						<Source>								<System>N/A</System>								<Table>N/A</Table>								<Column>N/A</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Sales Territory Key';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Order Number</Name>						<Description>Unique sequence given to each sales order</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesOrderHeader]</Table>								<Column>[SalesOrderID]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Order Number';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Order Line Number</Name>						<Description>A unique line number per sales order ordered on SalesOrderDetail</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesOrderDetail]</Table>								<Column>[SalesOrderDetailID]</Column>						</Source>						<IsLogic>1</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Order Line Number';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Revision Number</Name>						<Description>Incremental number to track changes to the sales order over time.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesOrderHeader]</Table>								<Column>[SalesOrderID]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Revision Number';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Order Quantity</Name>						<Description>Quantity ordered per product.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesOrderDetail]</Table>								<Column>[OrderQty]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Order Quantity';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Unit Price</Name>						<Description>Selling price of a single product.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesOrderDetail]</Table>								<Column>[UnitPrice]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Unit Price';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Extended Amount</Name>						<Description>[OrderQty] * [UnitPrice]</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesOrderDetail]</Table>								<Column>[OrderQty], [UnitPrice]</Column>						</Source>						<IsLogic>1</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Extended Amount';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Unit Price Discount Percentage</Name>						<Description>Discount Percentage</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesOrderDetail]</Table>								<Column>[UnitPriceDiscount]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Unit Price Discount Percentage';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Discount Amount</Name>						<Description>([OrderQty] * [UnitPrice]) * [UnitPriceDiscount]</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesOrderDetail]</Table>								<Column>([OrderQty],[UnitPrice],[UnitPriceDiscount]</Column>						</Source>						<IsLogic>1</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Discount Amount';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Unit Product Standard Cost</Name>						<Description>Standard cost of the product.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Production].[Product]</Table>								<Column>[StandardCost]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Unit Product Standard Cost';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Total Product Cost</Name>						<Description>[SalesOrderDetails].[OrderQty] * [Product].[StandardCost]</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesOrderDetail] ,[Production].[Product]</Table>								<Column>[SalesOrderDetails].[OrderQty],[Product].[StandardCost]</Column>						</Source>						<IsLogic>1</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Total Product Cost';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Amount</Name>						<Description>Per product subtotal. Computed as UnitPrice * (1 - UnitPriceDiscount) * OrderQty.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesOrderDetail]</Table>								<Column>[LineTotal]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Amount';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Tax Amount</Name>						<Description>[SalesOrderDetails].[LineTotal] + ([SalesOrderDetails].[LineTotal] * (([SalesHeader].[TaxAmt] / [SalesHeader].[TotalDue]) * 100)) / 100 - [SalesOrderDetails].[LineTotal])</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesOrderHeader],[Sales].[SalesOrderDetail]</Table>								<Column>[SalesOrderDetails].[LineTotal] , [SalesHeader].[TaxAmt], [SalesHeader].[TotalDue]</Column>						</Source>						<IsLogic>1</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Tax Amount';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Freight Amount</Name>						<Description>[SalesOrderDetails].[LineTotal] + ([SalesOrderDetails].[LineTotal] * (([SalesHeader].[Freight] / [SalesHeader].[TotalDue]) * 100)) / 100 - [SalesOrderDetails].[LineTotal])</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesOrderHeader],[Sales].[SalesOrderDetail]</Table>								<Column>[SalesOrderDetails].[LineTotal] ,[SalesOrderDetails].[LineTotal],[SalesHeader].[Freight], [SalesHeader].[TotalDue]</Column>						</Source>						<IsLogic>1</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Freight Amount';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Carrier Tracking Number</Name>						<Description>Shipment tracking number supplied by the shipper.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesOrderDetail]</Table>								<Column>[CarrierTrackingNumber]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Carrier Tracking Number';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Purchase Order Number</Name>						<Description>Customer purchase order number reference.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesOrderHeader]</Table>								<Column>[PurchaseOrderNumber]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Purchase Order Number';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Order Date</Name>						<Description>Dates the sales order was created.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesOrderHeader]</Table>								<Column>[OrderDate]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Order Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Due Date</Name>						<Description>Date the order is due to the customer.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesOrderHeader]</Table>								<Column>[DueDate]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Due Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '				<DataDictionary>						<Name>Reseller Sales Ship Date</Name>						<Description>Date the order was shipped to the customer.</Description>						<Source>								<System>AdventureWorks2012</System>								<Table>[Sales].[SalesOrderHeader]</Table>								<Column>[ShipDate]</Column>						</Source>						<IsLogic>0</IsLogic>						<LegacyName>N/A</LegacyName>				</DataDictionary>', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'VIEW', @level1name = N'FactResellerSalesView', @level2type = N'COLUMN', @level2name = N'Reseller Sales Ship Date';

