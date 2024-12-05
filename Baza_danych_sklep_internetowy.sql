SET check_function_bodies = false;

CREATE TYPE "Order_Status" AS ENUM ('pending', 'shipped', 'delivered');
CREATE TYPE "Gender" AS ENUM ('F', 'M');

-- Create the basic reference tables first
CREATE TABLE "Users" (
  id SERIAL PRIMARY KEY,
  "Username" VARCHAR(30) NOT NULL,
  "Password" VARCHAR(50) NOT NULL,
  "Creation_Date" DATE NOT NULL
);

CREATE TABLE "Stores" (
  id SERIAL PRIMARY KEY,
  "Name" VARCHAR(30) NOT NULL,
  "Email_Address" VARCHAR(30) NOT NULL,
  "Phone_Number" VARCHAR(15) NOT NULL,
  "Tax_ID" CHAR(10) NOT NULL
);

CREATE TABLE "Employees" (
  id SERIAL PRIMARY KEY,
  "First_Name" VARCHAR(30) NOT NULL,
  "Last_Name" VARCHAR(50) NOT NULL,
  "Birth_Date" DATE NOT NULL,
  "Pesel" CHAR(11) NOT NULL,
  "Hire_Date" DATE NOT NULL,
  "Email_Address" VARCHAR(30) NOT NULL,
  "Phone_Number" VARCHAR(15) NOT NULL,
  "Bank_Account_Number" CHAR(26),
  "User_id" INTEGER NOT NULL,
  "Store_id" INTEGER NOT NULL,
  CONSTRAINT "Employees_User_id_fkey" FOREIGN KEY ("User_id") REFERENCES "Users" (id),
  CONSTRAINT "Employees_Store_id_fkey" FOREIGN KEY ("Store_id") REFERENCES "Stores" (id)
);

-- Now create other tables that depend on the previous ones
CREATE TABLE "Customers" (
  id SERIAL PRIMARY KEY,
  "Email_Address" VARCHAR(30) NOT NULL,
  "Phone_Number" VARCHAR(15) NOT NULL,
  "First_Name" VARCHAR(30) NOT NULL,
  "Last_Name" VARCHAR(50) NOT NULL,
  "Gender" "Gender" NOT NULL,
  "User_id" INTEGER NOT NULL,
  "Store_id" INTEGER,
  CONSTRAINT "Customers_User_id_fkey" FOREIGN KEY ("User_id") REFERENCES "Users" (id),
  CONSTRAINT "Customers_Store_id_fkey" FOREIGN KEY ("Store_id") REFERENCES "Stores" (id)
);

CREATE TABLE "Addresses" (
  id SERIAL PRIMARY KEY,
  "Country" VARCHAR(30) NOT NULL,
  "City" VARCHAR(30) NOT NULL,
  "Street" VARCHAR(30) NOT NULL,
  "Building_Number" VARCHAR(5) NOT NULL,
  "Apartment_Number" VARCHAR(4),
  "Postal_Code" VARCHAR(6) NOT NULL,
  "Store_id" INTEGER,
  "Customer_id" INTEGER,
  "Employee_id" INTEGER,
  CONSTRAINT "Addresses_Store_id_fkey" FOREIGN KEY ("Store_id") REFERENCES "Stores" (id),
  CONSTRAINT "Addresses_Customer_id_fkey" FOREIGN KEY ("Customer_id") REFERENCES "Customers" (id),
  CONSTRAINT "Addresses_Employee_id_fkey" FOREIGN KEY ("Employee_id") REFERENCES "Employees" (id)
);

CREATE TABLE "Products" (
  id SERIAL PRIMARY KEY,
  "Name" VARCHAR(100) NOT NULL,
  "Description" TEXT NOT NULL,
  "Price" NUMERIC(10, 2) NOT NULL,
  "Composition" TEXT NOT NULL,
  "Store_id" INTEGER NOT NULL,
  "Weight" NUMERIC(8, 2) NOT NULL,
  CONSTRAINT "Products_Store_id_fkey" FOREIGN KEY ("Store_id") REFERENCES "Stores" (id)
);

CREATE TABLE "Warehouses" (
  id SERIAL PRIMARY KEY,
  "Capacity" INTEGER NOT NULL,
  "Store_id" INTEGER NOT NULL,
  "Address_id" INTEGER NOT NULL,
  CONSTRAINT "Warehouses_Store_id_fkey" FOREIGN KEY ("Store_id") REFERENCES "Stores" (id),
  CONSTRAINT "Warehouses_Address_id_fkey" FOREIGN KEY ("Address_id") REFERENCES "Addresses" (id)
);

CREATE TABLE "Storage_Spaces" (
  id SERIAL PRIMARY KEY,
  "Product_id" INTEGER NOT NULL,
  "Warehouse_id" INTEGER NOT NULL,
  CONSTRAINT "Storage_Spaces_Product_id_fkey" FOREIGN KEY ("Product_id") REFERENCES "Products" (id),
  CONSTRAINT "Storage_Spaces_Warehouse_id_fkey" FOREIGN KEY ("Warehouse_id") REFERENCES "Warehouses" (id)
);

CREATE TABLE "Manufacturers" (
  id SERIAL PRIMARY KEY,
  "Name" VARCHAR(30) NOT NULL
);

CREATE TABLE "Orders" (
  id SERIAL PRIMARY KEY,
  "Amount" NUMERIC(10, 2) NOT NULL,
  "Status" "Order_Status" NOT NULL,
  "Order_Date" DATE NOT NULL,
  "Shipping_Date" DATE,
  "Customer_id" INTEGER NOT NULL,
  "History" TEXT,
  CONSTRAINT "Orders_Customer_id_fkey" FOREIGN KEY ("Customer_id") REFERENCES "Customers" (id)
);

CREATE TABLE "Order_Details" (
  id SERIAL PRIMARY KEY,
  "Order_id" INTEGER NOT NULL,
  "Product_id" INTEGER NOT NULL,
  CONSTRAINT "Order_Details_Order_id_fkey" FOREIGN KEY ("Order_id") REFERENCES "Orders" (id),
  CONSTRAINT "Order_Details_Product_id_fkey" FOREIGN KEY ("Product_id") REFERENCES "Products" (id)
);

CREATE TABLE "Operators" (
  id SERIAL PRIMARY KEY,
  "Employee_id" INTEGER NOT NULL,
  CONSTRAINT "Operators_Employee_id_fkey" FOREIGN KEY ("Employee_id") REFERENCES "Employees" (id)
);

CREATE TABLE "Categories" (
  id SERIAL PRIMARY KEY,
  "Name" VARCHAR(50) NOT NULL,
  "Description" TEXT NOT NULL,
  "Product_id" INTEGER NOT NULL,
  CONSTRAINT "Categories_Product_id_fkey" FOREIGN KEY ("Product_id") REFERENCES "Products" (id)
);
