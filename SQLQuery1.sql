SELECT * 
FROM HousingNashville..NashvilleHousing

--Standardize Date Format	



SELECT SaleDateConverted, CONVERT(DATE,SaleDate)
FROM HousingNashville..NashvilleHousing

UPDATE NashvilleHousing
SET SaleDate= CONVERT(Date,SaleDate)

ALTER TABLE NashvilleHousing
ADD SaleDateConverted DATE;


UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)

--Populate Properrty Adress Data

SELECT PropertyAddress
FROM HousingNashville..NashvilleHousing
WHERE PropertyAddress IS NULL 

--Copying the same propertyadress if the parcelid is the same 

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM HousingNashville..NashvilleHousing a
JOIN HousingNashville..NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL 

UPDATE a 
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM HousingNashville..NashvilleHousing a
JOIN HousingNashville..NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL


--Divide address into (Addres, City, State)

SELECT PropertyAddress
FROM HousingNashville..NashvilleHousing
SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress)) AS Address
FROM HousingNashville..NashvilleHousing
