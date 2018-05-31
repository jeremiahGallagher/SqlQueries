use AP

go


--1
select InvoiceNumber as Number
, InvoiceTotal as Total
, PaymentTotal + CreditTotal as Credits 
, InvoiceTotal - (PaymentTotal + CreditTotal) as Balance
from Invoices

--2
select VendorContactLName + ', ' + VendorContactFName as FullName
from Vendors
Order by VendorContactLName, VendorContactFName

--3
select VendorContactLName + ', ' + VendorContactFName as FullName
from Vendors
where VendorContactLName < 'D' or left(VendorContactLName, 1) = 'E'
Order by VendorContactLName, VendorContactFName

--4
select InvoiceTotal
, InvoiceTotal * .10 as TenPercentofTotal
, InvoiceTotal * .10 + InvoiceTotal as TotalPlusTenPercent
from Invoices
Where  InvoiceTotal - (PaymentTotal + CreditTotal) >= 1000
Order by InvoiceTotal desc

--5
select * 
from Invoices
where (InvoiceTotal - (PaymentTotal + CreditTotal) > 0 And PaymentDate is not null)
or (InvoiceTotal - (PaymentTotal + CreditTotal) <= 0 and PaymentDate is null)

