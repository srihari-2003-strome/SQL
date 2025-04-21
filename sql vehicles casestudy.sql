# Vehicles Casestudy
create database if not exists vehicles_dataset;

# create the tables 
CREATE TABLE owners (
    owner_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    phone VARCHAR(15)
);
CREATE TABLE vehicles (
    vehicle_id INT PRIMARY KEY,
    make VARCHAR(50),
    model VARCHAR(50),
    year INT,
    price DECIMAL(10, 2),
    owner_id INT,
    FOREIGN KEY (owner_id) REFERENCES owners(owner_id)
);
CREATE TABLE service_records (
    record_id INT PRIMARY KEY,
    vehicle_id INT,
    service_date DATE,
    service_type VARCHAR(100),
    cost DECIMAL(10, 2),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

# inserting values 
INSERT INTO owners (owner_id, name, city, phone) VALUES
(101, 'Anil Sharma', 'Bangalore', '9990011122'),
(102, 'Reema Das', 'Mumbai', '8882233445'),
(103, 'Vikram Joshi', 'Delhi', '7773344556'),
(104, 'Meera Menon', 'Hyderabad', '9998877665');

INSERT INTO service_records (record_id, vehicle_id, service_date, service_type, cost) VALUES
(201, 1, '2023-02-15', 'Oil Change', 1500),
(202, 2, '2023-04-10', 'Tire Replacement', 5000),
(203, 3, '2023-01-25', 'Brake Inspection', 1200),
(204, 1, '2023-07-18', 'Engine Tuning', 3500),
(205, 5, '2023-06-05', 'AC Repair', 3000);

INSERT INTO service_records (record_id, vehicle_id, service_date, service_type, cost) VALUES
(201, 1, '2023-02-15', 'Oil Change', 1500),
(202, 2, '2023-04-10', 'Tire Replacement', 5000),
(203, 3, '2023-01-25', 'Brake Inspection', 1200),
(204, 1, '2023-07-18', 'Engine Tuning', 3500),
(205, 5, '2023-06-05', 'AC Repair', 3000);

# Analysing the dataset
# 1 List all vehicles made by 'Toyota'.
SELECT * 
FROM vehicles 
WHERE make = 'Toyota';

# 2 Show each owner's name and the number of vehicles they own.

SELECT o.name, COUNT(v.vehicle_id) AS num_vehicles
FROM owners o
JOIN vehicles v ON o.owner_id = v.owner_id
GROUP BY o.owner_id, o.name;

# 3 Find all vehicle models manufactured after 2019.
SELECT make, model, year 
FROM vehicles 
WHERE year > 2019;

# 4 Find the total service cost for each vehicle.
SELECT v.make, v.model, SUM(s.cost) AS total_service_cost
FROM vehicles v
JOIN service_records s ON v.vehicle_id = s.vehicle_id
GROUP BY v.vehicle_id, v.make, v.model;

# 5 List vehicles with service costs greater than ₹3,000 in any record.

SELECT DISTINCT v.make, v.model, s.cost
FROM vehicles v
JOIN service_records s ON v.vehicle_id = s.vehicle_id
WHERE s.cost > 3000;

# 6 Get the vehicle with the highest total service cost.

SELECT v.make, v.model, SUM(s.cost) AS total_cost
FROM vehicles v
JOIN service_records s ON v.vehicle_id = s.vehicle_id
GROUP BY v.vehicle_id, v.make, v.model
ORDER BY total_cost DESC
LIMIT 1;