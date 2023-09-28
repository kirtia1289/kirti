use fastkart;


1. List Top 3 products based on QuantityAvailable. (productid, productname,
#QuantityAvailable ). (3 Rows) [Note: Products]

SELECT ProductId,ProductName, QuantityAvailable
FROM Products
order by QuantityAvailable DESC limit 3;



 2. Display EmailId of those customers who have done more than ten
 purchases. (EmailId, Total_Transactions). (5 Rows) [Note: Purchasedetails,
 products] [8 MARKS]

SELECT pd.EmailId,pd.QuantityPurchased as Total_Transactions
FROM PurchaseDetails pd
INNER JOIN Products p
ON pd.ProductId=p.ProductId
GROUP by EmailId
HAVING count(QuantityPurchased)>10
ORDER by Total_Transactions DESC;



 3. List the Total QuantityAvailable category wise in descending order. (Name of the category,
 QuantityAvailable)
 (7 Rows) [Note: products, categories]

Select c.CategoryName as NameOfTheCategory, p.QuantityAvailable as
TotalQuantityAvailable
from Products p
INNER JOIN Categories c
ON p.CategoryId = c.CategoryId
group by c.CategoryName
Order by p.QuantityAvailable DESC



 4. Display ProductId, ProductName, CategoryName, Total_Purchased_Quantity for the product
 which has been sold maximum in terms of quantity?
(1 Row) [Note: purchasedetails, products, categories]

SELECT p.ProductId,p.ProductName,c.CategoryName,SUM(pd.QuantityPurchased) as
Total_Purchased_Quantity
FROM Categories c
INNER JOIN Products p
ON c.CategoryId=p.CategoryId
INNER JOIN PurchaseDetails pd
ON p.ProductId=pd.ProductId



-- 5. Display the number of male and female customers in fastkart. (2 Rows)
-- [Note: roles, users] [8 MARKS]
-- SOLUTION:

Select Gender, count(*) as NoOfMalesOrFemales
From Users
Group by Gender


-- 6. Display ProductId, ProductName, Price and Item_Classes of all the
-- products where Item_Classes are as follows: If the price of an item is less than
-- 2,000 then “Affordable”, If the price of an item is in between 2,000 and 50,000
-- then “High End Stuff”, If the price of an item is more than 50,000 then
-- “Luxury”. (57 Rows) [8 MARKS]

SELECT ProductId,ProductName,Price,
CASE
WHEN Price < 2000 THEN 'Affordable'
WHEN Price BETWEEN 2000 AND 50000 THEN 'High And Stuff'
WHEN Price > 50000 THEN 'Luxury'
ELSE Price
END as ItemClasses
FROM Products
ORDER BY Price desc;

-- 7. Write a query to display ProductId, ProductName, CategoryName,
-- Old_Price(price) and New_Price as per the following criteria a. If the category
-- is “Motors”, decrease the price by 3000 b. If the category is “Electronics”,
-- increase the price by 50 c. If the category is “Fashion”, increase the price by
-- 150 For the rest of the categories price remains same. Hint: Use case
-- statement, there should be no permanent change done in table/DB. (57 Rows)
-- [Note: products, categories] [8 MARKS]

SELECT p.ProductId,p.ProductName,c.CategoryName,p.Price,
CASE CategoryName
WHEN 'Motors' THEN Price - 3000
WHEN 'Electronics' THEN Price + 50
WHEN 'Fashion' THEN Price + 150
ELSE Price
END as NewPrice
FROM Products p
INNER JOIN Categories c
ON p.CategoryId=c.CategoryId
ORDER BY ProductId;


-- 8. Display the percentage of females present among all Users. (Round up to 2
-- decimal places) Add “%” sign while displaying the percentage. (1 Row)
-- [Note: user]

SELECT ROUND (count(Gender='F')/(select count(Gender) from Users)*100, 2)
as Females ,'%'
From Users
Where Gender ='F'

-- 9. Display the average balance for both card types for those records only
-- where CVVNumber > 333 and NameOnCard ends with the alphabet “e”. (2
-- Rows) [Note: carddetails] [8 MARKS]

SELECT CardType, avg(Balance)
FROM CardDetails
WHERE CVVNumber >333
AND NameOnCard like '%e'
GROUP by CardType;


-- 10. What is the 2nd most valuable item available which does not belong to the
-- “Motor” category. Value of an item = Price * QuantityAvailable. Display
-- ProductName, CategoryName, value. (1 Row) [Note: products, categories]
-- [8 MARKS]


SELECT p.ProductName,c.CategoryName,sum(p.Price*p.QuantityAvailable) as
VALUE
From Products p
INNER JOIN Categories c
On p.CategoryId=c.CategoryId
WHERE CategoryName!= 'Motors'
ORDER by VALUE