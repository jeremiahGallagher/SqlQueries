--Jeremiah Gallagher
--SQL Server Assignment 8

--3

CREATE FUNCTION fnUnpaidInvoiceID()
RETURNS int
BEGIN
	RETURN
(SELECT MIN(InvoiceID)
	FROM Invoices
	WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0 AND
	InvoiceDueDate =
(SELECT MIN(InvoiceDueDate)
	FROM Invoices
	WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0))
END
go

SELECT VendorName, 
	   InvoiceNumber, 
	   InvoiceDueDate,
	   InvoiceTotal - CreditTotal - PaymentTotal AS Balance
	   FROM Vendors v 
	   JOIN Invoices i ON v.VendorID = i.VendorID
WHERE InvoiceID = dbo.fnUnpaidInvoiceID()

--4

CREATE TABLE ShippingLabels
	(VendorName varchar(50),
	VendorAddress1 varchar(50),
	VendorAddress2 varchar(50),
	VendorCity varchar(50),
	VendorState char(2),
	VendorZipCode varchar(20))

go

CREATE TRIGGER Invoices_UPDATE_Shipping
ON Invoices
AFTER INSERT, UPDATE
AS
INSERT ShippingLabels
SELECT VendorName, 
	VendorAddress1,
	VendorAddress2,
	VendorCity, 
	VendorState, 
	VendorZipCode
	FROM Vendors JOIN Inserted
	ON Vendors.VendorID = (SELECT VendorID FROM Inserted)
WHERE Inserted.InvoiceTotal - Inserted.PaymentTotal - Inserted.CreditTotal = 0;

UPDATE Invoices
	SET PaymentTotal = 662, PaymentDate = '2006-06-23'
	WHERE InvoiceID = 100