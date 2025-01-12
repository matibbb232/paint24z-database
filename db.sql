SET check_function_bodies = false;

CREATE TYPE "order_status" AS ENUM('pending', 'shipped', 'delivered');

CREATE TYPE "gender" AS ENUM('F', 'M');

CREATE TABLE "addresses"(
  id integer NOT NULL,
  "country" varchar(30) NOT NULL,
  "city" varchar(30) NOT NULL,
  "street" varchar(30) NOT NULL,
  "building_number" varchar(5) NOT NULL,
  "apartment_number" varchar(4),
  "postal_code" varchar(6) NOT NULL,
  "warehouses_id" integer NOT NULL,
  "clients_id" integer NOT NULL,
  "store_id" integer NOT NULL,
  "employees_id" integer NOT NULL,
  CONSTRAINT "addresses_pkey" PRIMARY KEY(id)
);

CREATE TABLE "administrators"(
  id integer NOT NULL, "employees_id" integer NOT NULL,
  CONSTRAINT "administrators_pkey" PRIMARY KEY(id)
);

CREATE TABLE "categories"(
  id integer NOT NULL,
  "name" varchar(50) NOT NULL,
  "description" text NOT NULL,
  CONSTRAINT "categories_pkey" PRIMARY KEY(id)
);

CREATE TABLE "clients"(
  id integer NOT NULL,
  "email_address" varchar(30) NOT NULL,
  "phone_number" varchar(15) NOT NULL,
  "name" varchar(30) NOT NULL,
  "last_name" varchar(50) NOT NULL,
  "gender" "gender" NOT NULL,
  "store_id" integer NOT NULL,
  CONSTRAINT "clients_pkey" PRIMARY KEY(id)
);

CREATE TABLE "employees"(
  id integer NOT NULL,
  "name" varchar(30) NOT NULL,
  "last_name" varchar(50) NOT NULL,
  "birth_date" date NOT NULL,
  "pesel" char(11),
  "hire_date" date NOT NULL,
  "email_address" varchar(30) NOT NULL,
  "phone_number" varchar(15) NOT NULL,
  "bank_account_number" char(26),
  "store_id" integer NOT NULL,
  CONSTRAINT "employees_pkey" PRIMARY KEY(id)
);

CREATE TABLE "manufacturers"(
  id integer NOT NULL,
  "name" varchar(30) NOT NULL,
  CONSTRAINT "manufacturers_pkey" PRIMARY KEY(id)
);

CREATE TABLE "operators"(
  id integer NOT NULL, "employees_id" integer NOT NULL,
  CONSTRAINT "operators_pkey" PRIMARY KEY(id)
);

CREATE TABLE "order_details"(
  id integer NOT NULL,
  "orders_id" integer NOT NULL,
  "products_id" integer NOT NULL,
  CONSTRAINT "order_details_pkey" PRIMARY KEY(id)
);

CREATE TABLE "orders"(
  id integer NOT NULL,
  "amount" money NOT NULL,
  "status" "order_status" NOT NULL,
  "order_date" date NOT NULL,
  "shipping_date" date NOT NULL,
  "history" varchar,
  "clients_id" integer NOT NULL,
  CONSTRAINT "orders_pkey" PRIMARY KEY(id)
);

CREATE TABLE "products"(
  id integer NOT NULL,
  "name" varchar(100) NOT NULL,
  "description" text NOT NULL,
  "price" money NOT NULL,
  "composition" varchar(100) NOT NULL,
  "weight" NUMERIC(10, 2) NOT NULL,
  "store_id" integer NOT NULL,
  "manufacturers_id" integer NOT NULL,
  "categories_id" integer NOT NULL,
  "storage_spaces_id" integer NOT NULL,
  CONSTRAINT "products_pkey" PRIMARY KEY(id)
);

CREATE TABLE "storage_spaces"(
  id integer NOT NULL,
  "warehouses_id" integer NOT NULL,
  CONSTRAINT "storage_spaces_pkey" PRIMARY KEY(id)
);

CREATE TABLE "store"(
  id integer NOT NULL,
  "name" varchar(30) NOT NULL,
  "email_address" varchar(30) NOT NULL,
  "phone_number" varchar(15) NOT NULL,
  "tax_id" CHAR(10) NOT NULL,
  CONSTRAINT "store_pkey" PRIMARY KEY(id)
);

CREATE TABLE "users"(
  id integer NOT NULL,
  "username" varchar(30) NOT NULL,
  "password" varchar(50) NOT NULL,
  "creation_date" date NOT NULL,
  "employees_id" integer,
  "clients_id" integer,
  CONSTRAINT "users_pkey" PRIMARY KEY(id)
);

CREATE TABLE "warehouses"(
  id integer NOT NULL,
  "capacity" integer NOT NULL,
  "store_id" integer NOT NULL,
  CONSTRAINT "warehouses_pkey" PRIMARY KEY(id)
);

ALTER TABLE "users"
  ADD CONSTRAINT "users_employees_id_fkey"
    FOREIGN KEY ("employees_id") REFERENCES "employees" (id);

ALTER TABLE "administrators"
  ADD CONSTRAINT "administrators_employees_id_fkey"
    FOREIGN KEY ("employees_id") REFERENCES "employees" (id);

ALTER TABLE "operators"
  ADD CONSTRAINT "operators_employees_id_fkey"
    FOREIGN KEY ("employees_id") REFERENCES "employees" (id);

ALTER TABLE "users"
  ADD CONSTRAINT "users_clients_id_fkey"
    FOREIGN KEY ("clients_id") REFERENCES "clients" (id);

ALTER TABLE "employees"
  ADD CONSTRAINT "employees_store_id_fkey"
    FOREIGN KEY ("store_id") REFERENCES "store" (id);

ALTER TABLE "clients"
  ADD CONSTRAINT "clients_store_id_fkey"
    FOREIGN KEY ("store_id") REFERENCES "store" (id);

ALTER TABLE "orders"
  ADD CONSTRAINT "orders_clients_id_fkey"
    FOREIGN KEY ("clients_id") REFERENCES "clients" (id);

ALTER TABLE "order_details"
  ADD CONSTRAINT "order_details_orders_id_fkey"
    FOREIGN KEY ("orders_id") REFERENCES "orders" (id);

ALTER TABLE "order_details"
  ADD CONSTRAINT "order_details_products_id_fkey"
    FOREIGN KEY ("products_id") REFERENCES "products" (id);

ALTER TABLE "storage_spaces"
  ADD CONSTRAINT "storage_spaces_warehouses_id_fkey"
    FOREIGN KEY ("warehouses_id") REFERENCES "warehouses" (id);

ALTER TABLE "addresses"
  ADD CONSTRAINT "addresses_warehouses_id_fkey"
    FOREIGN KEY ("warehouses_id") REFERENCES "warehouses" (id);

ALTER TABLE "addresses"
  ADD CONSTRAINT "addresses_clients_id_fkey"
    FOREIGN KEY ("clients_id") REFERENCES "clients" (id);

ALTER TABLE "addresses"
  ADD CONSTRAINT "addresses_store_id_fkey"
    FOREIGN KEY ("store_id") REFERENCES "store" (id);

ALTER TABLE "addresses"
  ADD CONSTRAINT "addresses_employees_id_fkey"
    FOREIGN KEY ("employees_id") REFERENCES "employees" (id);

ALTER TABLE "warehouses"
  ADD CONSTRAINT "warehouses_store_id_fkey"
    FOREIGN KEY ("store_id") REFERENCES "store" (id);

ALTER TABLE "products"
  ADD CONSTRAINT "products_store_id_fkey"
    FOREIGN KEY ("store_id") REFERENCES "store" (id);

ALTER TABLE "products"
  ADD CONSTRAINT "products_manufacturers_id_fkey"
    FOREIGN KEY ("manufacturers_id") REFERENCES "manufacturers" (id);

ALTER TABLE "products"
  ADD CONSTRAINT "products_categories_id_fkey"
    FOREIGN KEY ("categories_id") REFERENCES "categories" (id);

ALTER TABLE "products"
  ADD CONSTRAINT "products_storage_spaces_id_fkey"
    FOREIGN KEY ("storage_spaces_id") REFERENCES "storage_spaces" (id);

INSERT INTO "store" (id, "name", "email_address", "phone_number", "tax_id")
VALUES
(1, 'TechStore', 'info@techstore.com', '123-456-789', '1234567890');

INSERT INTO "manufacturers" (id, "name")
VALUES
(1, 'Analog Devices Inc.'),
(2, 'Trinamic');

INSERT INTO "categories" (id, "name", "description")
VALUES
(1, 'Amplifier ICs', 'Integrated circuits designed to amplify electrical signals'),
(2, 'Analog to Digital Converters', 'Devices that convert analog signals into digital data'),
(3, 'Sensors', 'Devices that detect physical properties such as temperature, pressure, motion, or light and convert them into electrical signals'),
(4, 'Microcontrollers', 'Compact integrated circuits that contain a processor, memory, and input/output peripherals, used to control embedded systems'),
(5, 'Transistors', 'Semiconductor components used for amplification and switching'),
(6, 'Wi-Fi Modules', 'Modules equipped with wireless communication capabilities'),
(7, 'Power Controllers', 'Devices designed to manage and regulate the distribution of electrical power'),
(8, 'Voltage Regulators', 'Components that maintain a constant output voltage regardless of changes in input voltage or load conditions'),
(9, 'Graphic Displays', 'Electronic screens capable of rendering text, images, and video'),
(10, 'Motion Sensors', 'Sensors that detect movement or changes in position');

INSERT INTO "warehouses" (id, "capacity", "store_id")
VALUES
(1, 100, 1);

INSERT INTO "storage_spaces" (id, "warehouses_id")
VALUES
(1, 1);

INSERT INTO "products" (id, "name", "description", "price", "composition", "weight", "store_id", "manufacturers_id", "categories_id", "storage_spaces_id")
VALUES
(1, 'ADA4099-1HUJZ-RL7', 'Operational Amplifiers - Op Amps Precision, 10MHz, 7V/us OTT RRIO Amp', 27.99, 'Standard electronic components', 0.01, 1, 1, 1, 1),
(2, 'AD4080BBCZ', 'Analog to Digital Converters - ADC 20-Bit, 40 MSPS SAR ADC', 321.38, 'Advanced analog components', 0.02, 1, 1, 2, 1),
(3, 'ADXL382-1BCCZ-RL7', 'Accelerometers ADXL382 SPI', 110.51, 'Semiconductor components', 0.015, 1, 1, 3, 1),
(4, 'STM32F407VG Microcontroller', 'ARM Cortex-M4 32-bit Microcontroller with FPU, 1 MB Flash, 168 MHz', 60.50, 'Standard electronic components', 0.02, 1, 1, 4, 1),
(5, 'BC547 NPN Transistor', 'General-purpose NPN transistor for low-power amplification and switching', 1.20, 'Standard electronic components', 0.001, 1, 1, 5, 1),
(6, 'ESP32-WROOM-32 Wi-Fi Module', 'Low-power dual-core Wi-Fi and Bluetooth module with integrated antenna', 25.00, 'Standard electronic components', 0.005, 1, 2, 6, 1),
(7, 'LTC3643 Backup Power Controller', 'High-efficiency step-up DC/DC converter with integrated switches', 85.00, 'Standard electronic components', 0.01, 1, 2, 7, 1),
(8, 'LM7805 Voltage Regulator', '5V fixed output voltage regulator for linear power supplies', 3.50, 'Standard electronic components', 0.01, 1, 2, 8, 1),
(9, 'OLED Display Module 128x64', '1.3-inch OLED display with SSD1306 controller, I2C interface', 50.00, 'Standard electronic components', 0.03, 1, 2, 9, 1),
(10, 'MPU6050 Motion Sensor', '6-axis gyroscope and accelerometer module for motion tracking applications', 30.00, 'Standard electronic components', 0.0015, 1, 2, 10, 1);
