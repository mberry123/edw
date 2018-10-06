﻿EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = N'
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
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


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
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


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
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '


GO
EXECUTE sp_addextendedproperty @name = N'DataDictionary', @value = '
