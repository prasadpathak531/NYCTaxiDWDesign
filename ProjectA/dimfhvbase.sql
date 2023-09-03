CREATE TABLE dbo.dimfhvbase
WITH
(
    DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT ROW_NUMBER() OVER (ORDER BY BaseLicenseId) as baseID,
      BaseLicenseId,
	 BaseType,
	 AddressBuilding,
	 AddressStreet,
	 AddressCity,
	 AddressState,
	 AddressPostalCode
	 FROM dbo.stagedimbase;

select * from dbo.dimfhvbase;






