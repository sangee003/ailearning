-- Create Customer table
CREATE TABLE tbl_customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Address VARCHAR(255),
    City VARCHAR(50),
    Country VARCHAR(50),
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample records
INSERT INTO tbl_customer (FirstName, LastName, Email, Phone, Address, City, Country)
VALUES 
('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Main St', 'New York', 'USA'),
('Jane', 'Smith', 'jane.smith@example.com', '9876543210', '456 Elm St', 'Los Angeles', 'USA'),
('Raj', 'Kumar', 'raj.kumar@example.com', '9988776655', '789 MG Road', 'Bangalore', 'India'),
('Maria', 'Garcia', 'maria.garcia@example.com', '1122334455', '321 Oak St', 'Madrid', 'Spain');
