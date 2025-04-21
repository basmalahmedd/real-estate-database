-- Report 1: Available Properties
SELECT property_id, address, price, bedrooms, bathrooms 
FROM Property 
WHERE status = 'Available';

-- Report 2: Top Agents by Sales
SELECT a.name, COUNT(s.sale_id) AS total_sales, SUM(s.sale_price * a.commission_percent/100) AS total_commission
FROM Agent a
JOIN Sale s ON a.agent_id = s.agent_id
GROUP BY a.name
ORDER BY total_sales DESC;

-- Report 3: Clients Who Viewed But Didn’t Buy
SELECT c.name, p.address, v.viewing_date
FROM Client c
JOIN Viewing v ON c.client_id = v.client_id
JOIN Property p ON v.property_id = p.property_id
LEFT JOIN Sale s ON p.property_id = s.property_id
WHERE s.property_id IS NULL;

-- Report 4: Properties Sold Above Listing Price
SELECT p.property_id, p.address, p.price AS listed_price, s.sale_price
FROM Property p
JOIN Sale s ON p.property_id = s.property_id
WHERE s.sale_price > p.price;

-- Report 5: Monthly Sales Summary
SELECT 
    EXTRACT(MONTH FROM sale_date) AS month,
    COUNT(sale_id) AS sales_count,
    SUM(sale_price) AS total_revenue
FROM Sale
GROUP BY month
ORDER BY month;