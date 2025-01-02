SET check_function_bodies = false
;

CREATE TYPE "Order_Status" AS ENUM('pending', 'shipped', 'delivered');

CREATE TYPE "Gender" AS ENUM('F','M');

CREATE TABLE "Addresses"(
  id integer NOT NULL,
  "Country" varchar(30) NOT NULL,
  "City" varchar(30) NOT NULL,
  "Street" varchar(30) NOT NULL,
  "Building_Number" varchar(5) NOT NULL,
  "Apartment_Number" varchar(4),
  "Postal_Code" varchar(6) NOT NULL,
  "Warehouses_id" integer NOT NULL,
  "Clients_id" integer NOT NULL,
  "Store_id" integer NOT NULL,
  "Employees_id" integer NOT NULL,
  CONSTRAINT "Addresses_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Administrators"(
id integer NOT NULL, "Employees_id" integer NOT NULL,
  CONSTRAINT "Administrators_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Categories"(
  id integer NOT NULL,
  "Name" varchar(50) NOT NULL,
  "Description" text NOT NULL,
  "Products_id" integer NOT NULL,
  CONSTRAINT "Categories_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Clients"(
  id integer NOT NULL,
  "Email_Address" varchar(30) NOT NULL,
  "Phone_Number" varchar(15) NOT NULL,
  "Name" varchar(30) NOT NULL,
  "Last_Name" varchar(50) NOT NULL,
  "Gender" "Gender" NOT NULL,
  "Store_id" integer NOT NULL,
  CONSTRAINT "Clients_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Employees"(
  id integer NOT NULL,
  "Name" varchar(30) NOT NULL,
  "Last_Name" varchar(50) NOT NULL,
  "Birth_Date" date NOT NULL,
  "Pesel" char(11),
  "Hire_Date" date NOT NULL,
  "Email_Address" varchar(30) NOT NULL,
  "Phone_Number" varchar(15) NOT NULL,
  "Bank_Account_Number" char(26),
  "Store_id" integer NOT NULL,
  CONSTRAINT "Employees_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Manufacturers"(
  id integer NOT NULL,
  "Name" varchar(30) NOT NULL,
  CONSTRAINT "Manufacturers_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Operators"(
id integer NOT NULL, "Employees_id" integer NOT NULL,
  CONSTRAINT "Operators_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Order_Details"(
  id integer NOT NULL,
  "Orders_id" integer NOT NULL,
  "Products_id" integer NOT NULL,
  CONSTRAINT "Order_Details_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Orders"(
  id integer NOT NULL,
  "Amount" money NOT NULL,
  "Status" "Order_Status" NOT NULL,
  "Order_Date" date NOT NULL,
  "Shipping_Date" date NOT NULL,
  "History" varchar,
  "Clients_id" integer NOT NULL,
  CONSTRAINT "Orders_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Products"(
  id integer NOT NULL,
  "Name" varchar(100) NOT NULL,
  "Description" text NOT NULL,
  "Price" money NOT NULL,
  "Composition" varchar(100) NOT NULL,
  "Weight" NUMERIC(10, 2) NOT NULL,
  "Store_id" integer NOT NULL,
  "Manufacturers_id" integer NOT NULL,
  CONSTRAINT "Products_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Storage_Spaces"(
  id integer NOT NULL,
  "Products_id" integer NOT NULL,
  "Warehouses_id" integer NOT NULL,
  CONSTRAINT "Storage_Spaces_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Store"(
  id integer NOT NULL,
  "Name" varchar(30) NOT NULL,
  "Email_Address" varchar(30) NOT NULL,
  "Phone_Number" varchar(15) NOT NULL,
  "Tax_ID" CHAR(10) NOT NULL,
  CONSTRAINT "Store_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Users"(
  id integer NOT NULL,
  "Username" varchar(30) NOT NULL,
  "Password" varchar(50) NOT NULL,
  "Creation_Date" date NOT NULL,
  "Employees_id" integer,
  "Clients_id" integer,
  CONSTRAINT "Users_pkey" PRIMARY KEY(id)
);

CREATE TABLE "Warehouses"(
  id integer NOT NULL,
  "Capacity" integer NOT NULL,
  "Store_id" integer NOT NULL,
  CONSTRAINT "Warehouses_pkey" PRIMARY KEY(id)
);

ALTER TABLE "Users"
  ADD CONSTRAINT "Users_Employees_id_fkey"
    FOREIGN KEY ("Employees_id") REFERENCES "Employees" (id);

ALTER TABLE "Administrators"
  ADD CONSTRAINT "Administrators_Employees_id_fkey"
    FOREIGN KEY ("Employees_id") REFERENCES "Employees" (id);

ALTER TABLE "Operators"
  ADD CONSTRAINT "Operators_Employees_id_fkey"
    FOREIGN KEY ("Employees_id") REFERENCES "Employees" (id);

ALTER TABLE "Users"
  ADD CONSTRAINT "Users_Clients_id_fkey"
    FOREIGN KEY ("Clients_id") REFERENCES "Clients" (id);

ALTER TABLE "Employees"
  ADD CONSTRAINT "Employees_Store_id_fkey"
    FOREIGN KEY ("Store_id") REFERENCES "Store" (id);

ALTER TABLE "Clients"
  ADD CONSTRAINT "Clients_Store_id_fkey"
    FOREIGN KEY ("Store_id") REFERENCES "Store" (id);

ALTER TABLE "Orders"
  ADD CONSTRAINT "Orders_Clients_id_fkey"
    FOREIGN KEY ("Clients_id") REFERENCES "Clients" (id);

ALTER TABLE "Order_Details"
  ADD CONSTRAINT "Order_Details_Orders_id_fkey"
    FOREIGN KEY ("Orders_id") REFERENCES "Orders" (id);

ALTER TABLE "Order_Details"
  ADD CONSTRAINT "Order_Details_Products_id_fkey"
    FOREIGN KEY ("Products_id") REFERENCES "Products" (id);

ALTER TABLE "Storage_Spaces"
  ADD CONSTRAINT "Storage_Spaces_Products_id_fkey"
    FOREIGN KEY ("Products_id") REFERENCES "Products" (id);

ALTER TABLE "Storage_Spaces"
  ADD CONSTRAINT "Storage_Spaces_Warehouses_id_fkey"
    FOREIGN KEY ("Warehouses_id") REFERENCES "Warehouses" (id);

ALTER TABLE "Categories"
  ADD CONSTRAINT "Categories_Products_id_fkey"
    FOREIGN KEY ("Products_id") REFERENCES "Products" (id);

ALTER TABLE "Addresses"
  ADD CONSTRAINT "Addresses_Warehouses_id_fkey"
    FOREIGN KEY ("Warehouses_id") REFERENCES "Warehouses" (id);

ALTER TABLE "Addresses"
  ADD CONSTRAINT "Addresses_Clients_id_fkey"
    FOREIGN KEY ("Clients_id") REFERENCES "Clients" (id);

ALTER TABLE "Addresses"
  ADD CONSTRAINT "Addresses_Store_id_fkey"
    FOREIGN KEY ("Store_id") REFERENCES "Store" (id);

ALTER TABLE "Addresses"
  ADD CONSTRAINT "Addresses_Employees_id_fkey"
    FOREIGN KEY ("Employees_id") REFERENCES "Employees" (id);

ALTER TABLE "Warehouses"
  ADD CONSTRAINT "Warehouses_Store_id_fkey"
    FOREIGN KEY ("Store_id") REFERENCES "Store" (id);

ALTER TABLE "Products"
  ADD CONSTRAINT "Products_Store_id_fkey"
    FOREIGN KEY ("Store_id") REFERENCES "Store" (id);

ALTER TABLE "Products"
  ADD CONSTRAINT "Products_Manufacturers_id_fkey"
    FOREIGN KEY ("Manufacturers_id") REFERENCES "Manufacturers" (id);

