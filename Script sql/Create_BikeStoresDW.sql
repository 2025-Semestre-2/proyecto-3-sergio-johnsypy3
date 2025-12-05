create database BikeStoresDW
go
use BikeStoresDW
go

/*
CREATE TABLE DimBrands (
    brand_id INT NOT NULL,
    brand_name VARCHAR(255) NOT NULL
)
go

CREATE TABLE DimCategories (
    category_id INT NOT NULL,
    category_name VARCHAR(255) NOT NULL
)
go
*/

--lista
CREATE TABLE DimProducts (
	product_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
	brand_name VARCHAR(255) NOT NULL, 
    category_id INT NOT NULL,
	category_name VARCHAR(255) NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DECIMAL(10,2) NOT NULL
)
go


-- lista
CREATE TABLE DimStocks (
	stock_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
	product_name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL
)
go


-- lista
CREATE TABLE DimCustomers (
	customer_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    customer_id INT NOT NULL,
    --first_name VARCHAR(255) NOT NULL,
    --last_name VARCHAR(255) NOT NULL,
	full_name VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(25) NOT NULL,
    zip_code VARCHAR(5) NOT NULL
) 
go


CREATE TABLE DimOrders (
	order_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    order_status INT NOT NULL,
    store_id INT NOT NULL,
    staff_id INT NOT NULL
)
go

/*
CREATE TABLE sales.order_items (
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    list_price DECIMAL(10,2) NOT NULL,
    discount DECIMAL(5,2) NOT NULL
)
go
*/

-- lista
CREATE TABLE DimStaffs (
	staff_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    staff_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    active tinyint NOT NULL,
    store_id INT NOT NULL,
	store_name VARCHAR(255) NOT NULL, 
    manager_id INT NULL,
	manager_name VARCHAR(100) NOT NULL
)
go



-- lista
CREATE TABLE DimStores (
	store_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    store_id INT NOT NULL,
    store_name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state VARCHAR(10) NOT NULL,
    zip_code VARCHAR(5) NOT NULL
)
go















