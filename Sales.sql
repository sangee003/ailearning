-- Create Sales table
CREATE TABLE tbl_sales (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    ProductName VARCHAR(100) NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    TotalAmount DECIMAL(12,2) GENERATED ALWAYS AS (Quantity * UnitPrice) STORED,
    SaleDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Insert sample records
INSERT INTO tbl_sales (CustomerID, ProductName, Quantity, UnitPrice)
VALUES
(1, 'Laptop', 2, 750.00),
(2, 'Smartphone', 1, 500.00),
(3, 'Headphones', 3, 50.00),
(4, 'Tablet', 1, 300.00);
