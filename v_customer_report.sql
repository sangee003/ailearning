-- Create Customer Report View
CREATE VIEW v_customer_report AS
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Email,
    c.Phone,
    c.City,
    c.Country,
    s.SaleID,
    s.ProductName,
    s.Quantity,
    s.UnitPrice,
    s.TotalAmount,
    s.SaleDate
FROM tbl_customer c
INNER JOIN tbl_sales s
    ON c.CustomerID = s.CustomerID;
