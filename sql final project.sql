# How many staff do we have in the company? 
SELECT count(*) AS Number_of_staffs
FROM stafftable;

#How many staff are younger than 30 years?
SELECT count(Age) AS staff_below_30
FROM company_ltd.stafftable
WHERE AGE <30;
#How many staff are between 30 and 25 years?
SELECT count(AGE)
FROM stafftable
WHERE Age BETWEEN 25 AND 30;

#Select all the female staff and sort their age in descending order (from the oldest to the youngest)
SELECT *
FROM stafftable
WHERE StaffSex = "Female"
ORDER BY Age DESC;
# What is the Average age of Peter and Nina
SELECT avg(Age) AS Avg_age
FROM stafftable
WHERE StaffName in ('peter','Nina');


#CUSTOMERTABLE ONLY
# How many customers do we have
SELECT count(DISTINCT CUSTOMERCODE) AS Number_of_Customers
FROM customertable;

#How many customers are from Cameroon?
SELECT count(*)
FROM customertable
WHERE CustomerCountry = 'CAMEROON';
#How many customers are from Cameroon and are Males
SELECT count(*) AS Males_customers_from_cameroon
FROM customertable
WHERE CustomerCountry = 'Cameroon'
  AND CustomerSex = 'MALE';
  
# What are the First names and Last names of customers who come from Togo and USA
SELECT CustomerFirstName, CustomerLastName
FROM customertable
WHERE CustomerCountry IN ('TOGO','USA');

#Show the first 5 oldest customers and arrange the list in decreasing order of Age (Oldest to youngest)
SELECT CustomerFirstName,Age
FROM customertable
WHERE Age > 22
GROUP BY CustomerFirstName, Age
ORDER BY Age DESC
limit 5;

#What is the average age of customers per country
SELECT Customercountry, ROUND(AVG(Age),2) AS Avg_age_per_country
FROM customertable
GROUP BY CustomerCountry
ORDER BY CustomerCountry;


#JOINING TABLES
# What is the total profit we made
SELECT sum(Profit) AS TOTAL_PROFIT
FROM salestable;

#What is the total cost we incurred for these 03 countries "Cameroon","USA","Togo"
SELECT Customercountry, sum(cost) AS Total_cost
FROM salestable
JOIN customertable
   ON salestable.CustomerCode = customertable.CustomerCode
WHERE CustomerCountry IN ("Cameroon", "USA", "Togo")
GROUP BY CustomerCountry;

# What is the total profit we made per country?
SELECT Customercountry, sum(PROFIT) AS Total_PROFIT_country
FROM salestable
JOIN customertable
   ON salestable.CustomerCode = customertable.CustomerCode
GROUP BY CustomerCountry
ORDER BY customercountry;
#What is the average profit we made per country
SELECT Customercountry, ROUND(AVG(PROFIT),2) AS AVG_PROFIT_country
FROM salestable
JOIN customertable
   ON salestable.CustomerCode = customertable.CustomerCode
GROUP BY CustomerCountry
ORDER BY CustomerCountry;


#What is the total revenue per Staff
SELECT StaffName, SUM(Revenue) AS Total_revenue
FROM salestable
JOIN stafftable
   ON salestable.StaffCode = stafftable.MatriculeNo
GROUP BY StaffName
ORDER BY StaffName;
# Which countries made more than 100 sales transactions? Sort them in decreasing order (from biggest to smallest
SELECT Customercountry, COUNT(Staffcode) AS SUM_Sales
FROM salestable
JOIN customertable
  ON salestable.CustomerCode = customertable.CustomerCode
GROUP BY CustomerCountry
HAVING SUM_Sales > 100
ORDER BY SUM_sales DESC;

#What is the total profit made per country by the following staff "Emelda","Anita","Cynthia"
SELECT StaffName, Customercountry, SUM(profit) AS Profit_per_staff
FROM salestable
LEFT JOIN customertable
ON salestable.CustomerCode = customertable.CustomerCode
LEFT JOIN stafftable
ON salestable.StaffCode = stafftable.MatriculeNo
WHERE StaffName IN ("Emelda", "Anita", "Cynthia")
GROUP BY StaffName, CustomerCountry
ORDER BY CustomerCountry





