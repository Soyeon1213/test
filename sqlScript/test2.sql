-- Sample SQL for preview testing in branch
SELECT p.id, p.name, COUNT(o.id) AS order_count
FROM products p
LEFT JOIN orders o ON p.id = o.product_id
WHERE p.is_active = TRUE
GROUP BY p.id, p.name
HAVING COUNT(o.id) > 5
ORDER BY order_count DESC
LIMIT 10;
