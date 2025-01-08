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


INSERT INTO "Store" (id, "Name", "Email_Address", "Phone_Number", "Tax_ID")
VALUES
(1, 'TechStore', 'info@techstore.com', '123-456-789', '1234567890');

INSERT INTO "Manufacturers" (id, "Name")
VALUES
(1, 'Analog Devices Inc.'),
(2, 'Trinamic');

INSERT INTO "Products" (id, "Name", "Description", "Price", "Composition", "Weight", "Store_id", "Manufacturers_id")
VALUES
(1, 'ADA4099-1HUJZ-RL7', 'Operational Amplifiers - Op Amps Precision, 10MHz, 7V/us OTT RRIO Amp', 27.99, 'Standard electronic components', 0.01, 1, 1),
(2, 'AD4080BBCZ', 'Analog to Digital Converters - ADC 20-Bit, 40 MSPS SAR ADC', 321.38, 'Advanced analog components', 0.02, 1, 1),
(3, 'ADXL382-1BCCZ-RL7', 'Accelerometers ADXL382 SPI', 110.51, 'Semiconductor components', 0.015, 1, 1),
(4, 'STM32F407VG Microcontroller', 'ARM Cortex-M4 32-bit Microcontroller with FPU, 1 MB Flash, 168 MHz', 60.50, 'Standard electronic components', 0.02, 1, 1),
(5, 'BC547 NPN Transistor', 'General-purpose NPN transistor for low-power amplification and switching', 1.20, 'Standard electronic components', 0.001, 1, 1),
(6, 'ESP32-WROOM-32 Wi-Fi Module', 'Low-power dual-core Wi-Fi and Bluetooth module with integrated antenna', 25.00, 'Standard electronic components', 0.005, 1, 2),
(7, 'LTC3643 Backup Power Controller', 'High-efficiency step-up DC/DC converter with integrated switches', 85.00, 'Standard electronic components', 0.01, 1, 2),
(8, 'LM7805 Voltage Regulator', '5V fixed output voltage regulator for linear power supplies', 3.50, 'Standard electronic components', 0.01, 1, 2),
(9, 'OLED Display Module 128x64', '1.3-inch OLED display with SSD1306 controller, I2C interface', 50.00, 'Standard electronic components', 0.03, 1, 2),
(10, 'MPU6050 Motion Sensor', '6-axis gyroscope and accelerometer module for motion tracking applications', 30.00, 'Standard electronic components', 0.0015, 1, 2);


INSERT INTO "Categories" (id, "Name", "Description", "Products_id")
VALUES
(1, 'Amplifier ICs', 'Integrated circuits designed to amplify electrical signals', 1),
(2, 'Analog to Digital Converters', 'Devices that convert analog signals into digital data', 2),
(3, 'Sensors', 'Devices that detect physical properties such as temperature, pressure, motion, or light and convert them into electrical signals', 3),
(4, 'Microcontrollers', 'Compact integrated circuits that contain a processor, memory, and input/output peripherals, used to control embedded systems', 4),
(5, 'Transistors', 'Semiconductor components used for amplification and switching', 5),
(6, 'Wi-Fi Modules', 'Modules equipped with wireless communication capabilities', 6),
(7, 'Power Controllers', 'Devices designed to manage and regulate the distribution of electrical power', 7),
(8, 'Voltage Regulators', 'Components that maintain a constant output voltage regardless of changes in input voltage or load conditions', 8),
(9, 'Graphic Displays', 'Electronic screens capable of rendering text, images, and video', 9),
(10, 'Motion Sensors', 'Sensors that detect movement or changes in position', 10);
