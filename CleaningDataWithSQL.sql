--Clening data with SQL
select * from dbo.NashvilleHousingData





--Alter the table by adding new column

ALTER Table dbo.NashvilleHousingData
Add  ConertedSaleDate Date


ALTER Table dbo.NashvilleHousingData
RENAME COLUMN ConertedSaleDate to ConvertedSaleDate

Update dbo.NashvilleHousingData
SET  ConertedSaleDate = CONVERT(Date, SaleDate)

Select  ConertedSaleDate
FROM dbo.NashvilleHousingData

--droping column
ALTER TABLE dbo.NashvilleHousingData
DROP COLUMN SaleDate

-- replaceing null values in propertyAddress table
SELECT n1.ParcelID, n1.PropertyAddress, n2.ParcelID, n2.PropertyAddress, ISNULL(n1.PropertyAddress, n2.PropertyAddress)
FROM dbo.NashvilleHousingData as n1
join dbo.NashvilleHousingData as n2
     ON n1.ParcelID = n2.ParcelID
	 AND n1.[UniqueID ] <> n2.[UniqueID ]
where n1.PropertyAddress is null

UPDATE n1
SET PropertyAddress = ISNULL(n1.PropertyAddress, n2.PropertyAddress)
FROM dbo.NashvilleHousingData as n1
join dbo.NashvilleHousingData as n2
     ON n1.ParcelID = n2.ParcelID
	 AND n1.[UniqueID ] <> n2.[UniqueID ]
where n1.PropertyAddress is null

--Separating PropertyAddress by using SubStinr method
--CHARINDEX return number value
SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1),
SUBSTRING(PropertyAddress,  CHARINDEX(',', PropertyAddress) +1 ,LEN(PropertyAddress))
FROM dbo.NashvilleHousingData

ALTER Table dbo.NashvilleHousingData
Add  PropertySplitAddress nvarchar(255)

Update dbo.NashvilleHousingData
SET   PropertySplitAddress  = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)


ALTER Table dbo.NashvilleHousingData
Add PropertySplitCity nvarchar(255)

Update dbo.NashvilleHousingData
SET  PropertySplitCity = SUBSTRING(PropertyAddress,  CHARINDEX(',', PropertyAddress) +1 ,LEN(PropertyAddress))


--Spliting by using Parsename
SELECT 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM dbo.NashvilleHousingData
where OwnerAddress is not null


ALTER Table dbo.NashvilleHousingData
Add  OwnerSplitAddress nvarchar(255)

Update dbo.NashvilleHousingData
SET  OwnerSplitAddress  = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)


ALTER Table dbo.NashvilleHousingData
Add  OwnerSplitCity nvarchar(255)

Update dbo.NashvilleHousingData
SET  OwnerSplitCity  = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER Table dbo.NashvilleHousingData
Add  OwnerSplitState nvarchar(255)

Update dbo.NashvilleHousingData
SET  OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)


-- change Y and N to Yes and No respectively to have consistent data form
SELECT DISTINCT(SoldAsVacant), count(SoldAsVacant)
FROM dbo.NashvilleHousingData
GROUP BY SoldAsVacant

--Using Case Statement
Update dbo.NashvilleHousingData
SET SoldAsVacant = 
    CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END


-- dropping column
ALTER TABLE dbo.NashvilleHousingData
DROP COLUMN OwnerAddress, PropertyAddress

--removing rows which have null value in the table
DELETE FROM dbo.NashvilleHousingData
Where OwnerName is null

DELETE FROM dbo.NashvilleHousingData
Where YearBuilt is null

-- replacing null values by 0
select FullBath, HalfBath, ISNULL(FullBath, 0), ISNULL(HalfBath, 0)
from dbo.NashvilleHousingData
where FullBath is null or HalfBath is null

Update dbo.NashvilleHousingData
SET FullBath =  ISNULL(FullBath, 0)

Update dbo.NashvilleHousingData
SET HalfBath =  ISNULL(FullBath, 0)











