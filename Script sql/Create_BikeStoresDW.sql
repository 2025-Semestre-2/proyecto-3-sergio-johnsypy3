use BikeStoresDW
go


CREATE TABLE DimProducts ( 
	product_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
	brand_name VARCHAR(255) NOT NULL, 
    category_id INT NOT NULL,
	category_name VARCHAR(255) NOT NULL,
	model_year SMALLINT NOT NULL,
	list_price DECIMAL(10,2) not null,
	start_date datetime,
	end_date datetime
)
go

CREATE TABLE DimStocks ( 
	stock_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
	quantity INT NOT NULL

)
go

CREATE TABLE DimCustomers ( 
	customer_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    customer_id INT NOT NULL,
	full_name VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(25) NOT NULL,
    zip_code VARCHAR(5) NOT NULL,
	start_date datetime,
	end_date datetime
) 
go

CREATE TABLE DimOrders ( 
	order_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    order_id INT NOT NULL,
    order_status INT NOT NULL,
	order_status_description VARCHAR(255) NOT NULL
)
go

CREATE TABLE DimStaffs ( 
	staff_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    staff_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    active tinyint NOT NULL,
    manager_id INT NULL,
	manager_name VARCHAR(100) NOT NULL,
	start_date datetime,
	end_date datetime
)
go

CREATE TABLE DimStores (
	store_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    store_id INT NOT NULL,
    store_name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state VARCHAR(10) NOT NULL,
    zip_code VARCHAR(5) NOT NULL
)
go

CREATE TABLE dbo.FactOrders (
	sales_key INT IDENTITY(1,1) NOT NULL,
	product_key INT NOT NULL,
	customer_key INT NOT NULL,
	staff_key INT NOT NULL,
	store_key INT NOT NULL,

	order_key INT NOT NULL,
	order_date_key INT NOT NULL, 
	required_date_key INT NOT NULL,
	shipped_date_key INT NOT NULL, 
	
	unit_price_order DECIMAL(10,2) NOT NULL,       -- precio por unidad
    quantity_order INT NOT NULL,                   -- cantidad vendida
    unit_discount DECIMAL(5,2) NOT NULL,     -- descuento 
	gross_amount DECIMAL(10,2) NOT NULL,  -- monto total sin descuento
    discount_amount DECIMAL(10,2) NOT NULL,  -- monto descontado
    net_amount DECIMAL(10,2) NOT NULL,       -- precio final después del descuento

PRIMARY KEY CLUSTERED 
(
	sales_key ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE dbo.FactOrders  WITH CHECK ADD FOREIGN KEY(customer_key)
REFERENCES dbo.DimCustomers (customer_key)
GO
ALTER TABLE dbo.FactOrders  WITH CHECK ADD FOREIGN KEY(staff_key)
REFERENCES dbo.DimStaffs (staff_key)
GO
ALTER TABLE dbo.FactOrders  WITH CHECK ADD FOREIGN KEY(store_key)
REFERENCES dbo.DimStores (store_key)
GO
ALTER TABLE dbo.FactOrders  WITH CHECK ADD FOREIGN KEY(order_key)
REFERENCES dbo.DimOrders (order_key)
GO
ALTER TABLE dbo.FactOrders  WITH CHECK ADD FOREIGN KEY(order_date_key) --DimDate
REFERENCES dbo.DimDate (date_key)
GO
ALTER TABLE dbo.FactOrders  WITH CHECK ADD FOREIGN KEY(product_key)
REFERENCES dbo.DimProducts (product_key)
GO
ALTER TABLE dbo.FactOrders  WITH CHECK ADD FOREIGN KEY(required_date_key) --DimDate
REFERENCES dbo.DimDate (date_key)
GO
ALTER TABLE dbo.FactOrders  WITH CHECK ADD FOREIGN KEY(shipped_date_key) --DimDate
REFERENCES dbo.DimDate (date_key)
GO
