use AP

go


--1
SELECT GLAccounts.AccountDescription,
	    COUNT(*) AS LineItemCount,
	    SUM(InvoiceLineItemAmount) AS LineItemSum
	    FROm GLAccounts JOIN InvoiceLineItems
	    ON GLAccounts.AccountNo = InvoiceLineItems.AccountNo
	    GROUP BY GLAccounts.AccountDescription
	    HAVING COUNT(*) > 1
ORDER BY LineItemCount DESC;

--2
SELECT GLAccounts.AccountDescription, 
		COUNT(*) AS LineItemCount,
		SUM(InvoiceLineItemAmount) AS LineItemSum
		FROM GLAccounts JOIN InvoiceLineItems
		ON GLAccounts.AccountNo = InvoiceLineItems.AccountNo
		JOIN Invoices
		ON InvoiceLineItems.InvoiceID = Invoices.InvoiceID
		WHERE InvoiceDate BETWEEN '2012-01-01' AND '2012-06-30'
		GROUP By GLAccounts.AccountDescription
		HAVING COUNT(*) > 1
ORDER BY LineItemCount DESC;

--3

SELECT VendorName,
		COUNT(DISTINCT InvoiceLineItems.AccountNo) As [# of Accounts]
		FROM Vendors JOIN Invoices
		ON Vendors.VendorID = Invoices.VendorID
		JOIN InvoiceLineItems
		ON Invoices.InvoiceID = InvoiceLineItems.InvoiceID
		GROUP BY VendorName
		HAVING COUNT(DISTINCT InvoiceLineItems.AccountNo) > 1
ORDER BY Vendorname;


--4

SELECT AccountNo, 
		SUM(InvoiceLineItemAmount) AS LineItemSum
		From InvoiceLineItems
GROUP BY AccountNo With RollUp;
