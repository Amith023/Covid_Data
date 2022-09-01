USE portfolio_project

SELECT * FROM Nashville_Housing




-------------------------------------------------------

--Standardise date format



ALTER TABLE Nashville_Housing
ALTER COLUMN saleDate DATE


SELECT * FROM Nashville_Housing





--------------------------------------------------------

-- Populate Property Address data ( which contained null values )


SELECT a.uniqueid,
	a.ParcelID,
	a.propertyAddress, 
	b.uniqueid,
	b.ParcelID,
	b.PropertyAddress

FROM Nashville_Housing a
	join Nashville_Housing b
	on a.ParcelID = b.ParcelID
	and a.uniqueid <> b.uniqueid	
	
	--Gave one more criteria for joining the two TABLE

	where a.propertyAddress is null



UPDate a						--alias from below
SET propertyAddress = isnull(a.propertyAddress, b.propertyAddress)		--using isnull function
FROM Nashville_Housing a
	join Nashville_Housing b
	on a.ParcelID = b.ParcelID
	And a.[UniqueId] <> b.[Uniqueid]
where a.propertyAddress is null





--------------------------------------------------------------------


--Breaking out into induvidual columns (Address, city, state)


SELECT propertyAddress 
	,substring(propertyAddress, 1, charindex(',',propertyAddress)-1) Address
	,substring(propertyAddress, charindex(',', propertyAddress)+1, len(propertyAddress)) city
FROM Nashville_Housing


ALTER TABLE Nashville_Housing
	Add Property_Address_split VARCHAR(300)

UPDate Nashville_Housing
	SET Property_Address_split = substring(propertyAddress, 1, charindex(',',propertyAddress)-1) 


ALTER TABLE Nashville_Housing
	Add Property_city_split VARCHAR(200)

UPDate Nashville_Housing
	SET Property_city_split = substring(propertyAddress, charindex(',', propertyAddress)+1, len(propertyAddress)) 






-- Now owner_Address splitting


SELECT 
	ownerAddress
	,parsename(replace(ownerAddress, ',', '.'), 3)
	,parsename(replace(ownerAddress, ',','.'),2)
	,parsename(replace(ownerAddress, ',','.'),1)
FROM Nashville_Housing


ALTER TABLE Nashville_Housing
	Add owner_Address VARCHAR(200)

UPDate Nashville_Housing
	SET owner_Address = parsename(replace(ownerAddress, ',', '.'), 3)

ALTER TABLE Nashville_Housing
	Add owner_city VARCHAR(200)

UPDate Nashville_Housing
	SET owner_city = parsename(replace(ownerAddress, ',','.'),2)

ALTER TABLE Nashville_Housing
	Add owner_state VARCHAR(200)

UPDate Nashville_Housing
	SET owner_state = parsename(replace(ownerAddress, ',','.'),1)




--- Just renaming Two splitted columns

EXEC sp_rename 'Nashville_Housing.owner_state', 'Owner_State';

EXEC sp_rename 'Nashville_Housing.property_city_split', 'Property_City_Split';


SELECT * FROM Nashville_Housing;




----------------------------------------------------------------




--UPDate 'Y' and 'N' with 'Yes' and 'No' in Sold_as_vacant

SELECT soldasvacant, CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
WHEN soldasvacant = 'N' THEN 'No' 
ELSE soldasvacant END 
FROM Nashville_Housing;



UPDate Nashville_Housing
SET soldasvacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
WHEN soldasvacant = 'N' THEN 'No' 
ELSE soldasvacant END 
FROM Nashville_Housing;

SELECT DISTINCT(soldasvacant), count(soldasvacant) FROM Nashville_Housing
group by soldasvacant;

SELECT * FROM Nashville_Housing






-------------------------------------------------------------------------



--Remove duplicates value


with Base as
(
SELECT *, 
	ROW_NUMBER() OVER( PARTITION by ParcelID, 
	PropertyAddress,
	Saleprice,
	SaleDate, 
	Legalreference 
	order by UniqueId) row_num
FROM Nashville_Housing
)
DELETE FROM Base where row_num > 1  ---Deleted duplicate rows


SELECT * FROM Nashville_Housing





-------------------------------------------------------------------


-- Delete UnUSEd Columns


ALTER TABLE Nashville_Housing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

SELECT * FROM Nashville_Housing


