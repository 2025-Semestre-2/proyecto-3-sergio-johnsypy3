create database BikeStoresStage
go
use BikeStoresStage
go

create schema production
go
create schema sales
go

CREATE TABLE production.brands (
    brand_id INT NOT NULL,
    brand_name VARCHAR(255) NOT NULL
)
go

CREATE TABLE production.categories (
    category_id INT NOT NULL,
    category_name VARCHAR(255) NOT NULL
)
go

CREATE TABLE production.products (
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DECIMAL(10,2) NOT NULL
)
go

CREATE TABLE production.stocks (
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL
)
go

CREATE TABLE sales.customers (
    customer_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip_code VARCHAR(10) NOT NULL
    --email,phone,street
) 
go

CREATE TABLE sales.orders (
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    order_status INT NOT NULL,
    order_date DATETIME NOT NULL,
    required_date DATETIME NOT NULL,
    shipped_date DATETIME NULL,
    store_id INT NOT NULL,
    staff_id INT NOT NULL
)
go

CREATE TABLE sales.order_items (
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    list_price DECIMAL(10,2) NOT NULL,
    discount DECIMAL(5,2) NOT NULL
)
go

CREATE TABLE sales.staffs (
    staff_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    active BIT NOT NULL,
    store_id INT NOT NULL,
    manager_id INT NULL
    --email, phone, ¿active?
)
go

CREATE TABLE sales.stores (
    store_id INT NOT NULL,
    store_name VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip_code VARCHAR(10) NOT NULL
    --phone, email, street
);















