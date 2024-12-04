SET check_function_bodies = false;

CREATE TYPE "Order_Status" AS ENUM('pending', 'shipped', 'delivered');

CREATE TYPE "Gender" AS ENUM('F','M');

CREATE TABLE "Administrator"(
id integer NOT NULL, "Employee_id" integer NOT NULL,
  CONSTRAINT "Administrator_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Address"(
  id integer NOT NULL,
  "Country" varchar(30) NOT NULL,
  "City" varchar(30) NOT NULL,
  "Street" varchar(30) NOT NULL,
  "Building_Number" varchar(5) NOT NULL,
  "Apartment_Number" varchar(4),
  "Postal_Code" varchar(6) NOT NULL,
  "Store_id" integer NOT NULL,
  "Customer_id" integer NOT NULL,
  "Employee_id" integer NOT NULL,
  CONSTRAINT "Address_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Category"(
  id integer NOT NULL,
  "Name" varchar(50) NOT NULL,
  "Description" text NOT NULL,
  "Product_id" integer NOT NULL,
  CONSTRAINT "Category_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Customer"(
  id integer NOT NULL,
  "Email_Address" varchar(30) NOT NULL,
  "Phone_Number" varchar(15) NOT NULL,
  "First_Name" varchar(30) NOT NULL,
  "Last_Name" varchar(50) NOT NULL,
  "Gender" "Gender" NOT NULL,
  "User_id" integer NOT NULL,
  "Store_id" integer NOT NULL,
  CONSTRAINT "Customer_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Warehouse"(
  id integer NOT NULL,
  "Capacity" integer NOT NULL,
  "Store_id" integer NOT NULL,
  "Address_id" integer NOT NULL,
  CONSTRAINT "Warehouse_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Storage_Space"(
  id integer NOT NULL,
  "Product_id" integer NOT NULL,
  "Warehouse_id" integer NOT NULL,
  CONSTRAINT "Storage_Space_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Operator"(
id integer NOT NULL, "Employee_id" integer NOT NULL,
  CONSTRAINT "Operator_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Employee"(
  id integer NOT NULL,
  "First_Name" varchar(30) NOT NULL,
  "Last_Name" varchar(50) NOT NULL,
  "Birth_Date" date NOT NULL,
  "Pesel" char(11) NOT NULL,
  "Hire_Date" date NOT NULL,
  "Email_Address" varchar(30) NOT NULL,
  "Phone_Number" varchar(15) NOT NULL,
  "Bank_Account_Number" char(26),
  "User_id" integer NOT NULL,
  "Store_id" integer NOT NULL,
  CONSTRAINT "Employee_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Manufacturer"(
  id integer NOT NULL,
  "Name" varchar(30) NOT NULL,
  "Product_id" integer NOT NULL,
  CONSTRAINT "Manufacturer_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Product"(
  id integer NOT NULL,
  "Name" varchar(100) NOT NULL,
  "Description" text NOT NULL,
  "Price" money NOT NULL,
  "Composition" integer NOT NULL,
  "Store_id" integer NOT NULL,
  "Weight" internal NOT NULL,
  CONSTRAINT "Product_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Store"(
  id integer NOT NULL,
  "Name" varchar(30) NOT NULL,
  "Email_Address" varchar(30) NOT NULL,
  "Phone_Number" varchar(15) NOT NULL,
  "Tax_ID" integer(10) NOT NULL,
  CONSTRAINT "Store_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Order_Details"(
  id integer NOT NULL,
  "Order_id" integer NOT NULL,
  "Product_id" integer NOT NULL,
  CONSTRAINT "Order_Details_pkey" PRIMARY KEY(id)
);

CREATE TABLE "User"(
  id integer NOT NULL,
  "Username" varchar(30) NOT NULL,
  "Password" varchar(50) NOT NULL,
  "Creation_Date" date NOT NULL,
  CONSTRAINT "User_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Order"(
  id integer NOT NULL,
  "Amount" money NOT NULL,
  "Status" "Order_Status" NOT NULL,
  "Order_Date" date NOT NULL,
  "Shipping_Date" date NOT NULL,
  "Customer_id" integer NOT NULL,
  "History" varchar,
  CONSTRAINT "Order_pkey" PRIMARY KEY(id)
);

ALTER TABLE "Employee"
  ADD CONSTRAINT "Employee_User_id_fkey"
    FOREIGN KEY ("User_id") REFERENCES "User" (id);

ALTER TABLE "Customer"
  ADD CONSTRAINT "Customer_User_id_fkey"
    FOREIGN KEY ("User_id") REFERENCES "User" (id);

ALTER TABLE "Administrator"
  ADD CONSTRAINT "Administrator_Employee_id_fkey"
    FOREIGN KEY ("Employee_id") REFERENCES "Employee" (id);

ALTER TABLE "Operator"
  ADD CONSTRAINT "Operator_Employee_id_fkey"
    FOREIGN KEY ("Employee_id") REFERENCES "Employee" (id);

ALTER TABLE "Customer"
  ADD CONSTRAINT "Customer_Store_id_fkey"
    FOREIGN KEY ("Store_id") REFERENCES "Store" (id);

ALTER TABLE "Employee"
  ADD CONSTRAINT "Employee_Store_id_fkey"
    FOREIGN KEY ("Store_id") REFERENCES "Store" (id);

ALTER TABLE "Product"
  ADD CONSTRAINT "Product_Store_id_fkey"
    FOREIGN KEY ("Store_id") REFERENCES "Store" (id);

ALTER TABLE "Warehouse"
  ADD CONSTRAINT "Warehouse_Store_id_fkey"
    FOREIGN KEY ("Store_id") REFERENCES "Store" (id);

ALTER TABLE "Manufacturer"
  ADD CONSTRAINT "Manufacturer_Product_id_fkey"
    FOREIGN KEY ("Product_id") REFERENCES "Product" (id);

ALTER TABLE "Address"
  ADD CONSTRAINT "Address_Store_id_fkey"
    FOREIGN KEY ("Store_id") REFERENCES "Store" (id);

ALTER TABLE "Address"
  ADD CONSTRAINT "Address_Customer_id_fkey"
    FOREIGN KEY ("Customer_id") REFERENCES "Customer" (id);

ALTER TABLE "Category"
  ADD CONSTRAINT "Category_Product_id_fkey"
    FOREIGN KEY ("Product_id") REFERENCES "Product" (id);

ALTER TABLE "Order"
  ADD CONSTRAINT "Order_Customer_id_fkey"
    FOREIGN KEY ("Customer_id") REFERENCES "Customer" (id);

ALTER TABLE "Address"
  ADD CONSTRAINT "Address_Employee_id_fkey"
    FOREIGN KEY ("Employee_id") REFERENCES "Employee" (id);

ALTER TABLE "Warehouse"
  ADD CONSTRAINT "Warehouse_Address_id_fkey"
    FOREIGN KEY ("Address_id") REFERENCES "Address" (id);

ALTER TABLE "Storage_Space"
  ADD CONSTRAINT "Storage_Space_Product_id_fkey"
    FOREIGN KEY ("Product_id") REFERENCES "Product" (id);

ALTER TABLE "Storage_Space"
  ADD CONSTRAINT "Storage_Space_Warehouse_id_fkey"
    FOREIGN KEY ("Warehouse_id") REFERENCES "Warehouse" (id);

ALTER TABLE "Order_Details"
  ADD CONSTRAINT "Order_Details_Order_id_fkey"
    FOREIGN KEY ("Order_id") REFERENCES "Order" (id);

ALTER TABLE "Order_Details"
  ADD CONSTRAINT "Order_Details_Product_id_fkey"
    FOREIGN KEY ("Product_id") REFERENCES "Product" (id);