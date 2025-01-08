
INSERT INTO "Store" (id, "Name", "Email_Address", "Phone_Number", "Tax_ID")
VALUES
(1, 'TechStore', 'info@techstore.com', '123-456-789', '1234567890');


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


INSERT INTO "Manufacturers" (id, "Name")
VALUES
(1, 'Analog Devices Inc.'),
(2, 'Trinamic');


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