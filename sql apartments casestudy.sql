# Apartments casestudy

# creating database
create Database if not exists apartments_dataset;

# create tables 
CREATE TABLE apartments (
    apartment_id INT PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100),
    size_sqft INT,
    bedrooms INT,
    rent DECIMAL(10, 2),
    is_furnished ENUM('YES', 'NO')
);
CREATE TABLE tenants (
    tenant_id INT PRIMARY KEY,
    tenant_name VARCHAR(100),
    apartment_id INT,
    move_in_date DATE,
    profession VARCHAR(100),
    FOREIGN KEY (apartment_id) REFERENCES apartments(apartment_id)
);

# inserting values
insert INTO apartments (apartment_id, name, location, size_sqft, bedrooms, rent, is_furnished) VALUES
(1, 'Green Heights', 'Whitefield', 1200, 2, 25000, 'YES'),
(2, 'Lake View', 'Marathahalli', 950, 1, 18000, 'NO'),
(3, 'Urban Nest', 'Koramangala', 1350, 3, 32000, 'YES'),
(4, 'Palm Residency', 'Indiranagar', 1600, 3, 40000, 'YES'),
(5, 'Cozy Corner', 'BTM Layout', 800, 1, 15000, 'NO'),
(6, 'Sky Towers', 'Whitefield', 1400, 2, 28000, 'YES'),
(7, 'City Scape', 'MG Road', 1000, 2, 27000, 'NO');

INSERT INTO tenants (tenant_id, tenant_name, apartment_id, move_in_date, profession) VALUES
(1, 'Aisha Khan', 1, '2023-05-10', 'Software Engineer'),
(2, 'Rohan Mehra', 2, '2023-06-01', 'Marketing Manager'),
(3, 'Neha Sharma', 3, '2023-03-15', 'Doctor'),
(4, 'Kunal Das', 4, '2022-12-01', 'Lawyer'),
(5, 'Priya Menon', 5, '2023-08-20', 'Data Analyst'),
(6, 'Ravi Patel', 6, '2023-09-01', 'Graphic Designer');

#Analysing the dataset

# 1  List all apartments located in Whitefield.
SELECT * 
FROM apartments
WHERE location = 'Whitefield';

# 2  Show the names and rent of all furnished apartments.
 SELECT name, rent
FROM apartments
WHERE is_furnished = 'YES';

# 3 Find the average rent per location.
SELECT location, ROUND(AVG(rent), 2) AS avg_rent
FROM apartments
GROUP BY location;

# 4 Count how many apartments have 2 or more bedrooms.

SELECT COUNT(*) AS count_2plus_bedrooms
FROM apartments
WHERE bedrooms >= 2;

# 5 ind the average rent per location.

SELECT location, ROUND(AVG(rent), 2) AS avg_rent
FROM apartments
GROUP BY location;

# 6 List tenants who moved in after July 2023.
SELECT tenant_name, move_in_date
FROM tenants
WHERE move_in_date > '2023-07-01';

# 7 which profession pays the highest average rent?

SELECT t.profession, ROUND(AVG(a.rent), 2) AS avg_rent
FROM tenants t
JOIN apartments a ON t.apartment_id = a.apartment_id
GROUP BY t.profession
ORDER BY avg_rent DESC
LIMIT 1;