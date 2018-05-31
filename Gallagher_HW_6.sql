-- Jeremiah Gallagher
--SQL Server Assignment 6

--1
Select VendorId, 
	   PaymentTotal, 
	   InvoiceNumber, 
	   InvoiceTotal
	   From Invoices
	   Where PaymentTotal > All
	(
			SELECT TOP 50 Percent(PaymentTotal)
			From Invoices
			ORDER BY PaymentTotal ASC
	)
Order By VendorID, PaymentTotal;


--2
SELECT *
FROM Vendors as vMain

Where vMain.VendorCity + vMain.VendorState  not in
(
	SELECT v.VendorCity + VendorState
	FROM Vendors as v
	GROUP BY VendorCity, v.VendorState
	HAVING Count(*) > 1
)
ORDER BY VendorState ;

--3
SELECT v.VendorName,
	   i.InvoiceID,
	   ili2.InvoiceSequence,
	   ili2.InvoiceLineItemAmount
FROM Invoices as i
Join Vendors as v on i.vendorid = v.vendorid
join
(
	   select ili.InvoiceID
	   from InvoiceLineItems as ili
	   Group by ili.InvoiceID
	   Having count(*) > 1
) as ili on i.InvoiceID = ili.InvoiceID
Join InvoiceLineItems as ili2 on i.InvoiceID = ili2.InvoiceID;