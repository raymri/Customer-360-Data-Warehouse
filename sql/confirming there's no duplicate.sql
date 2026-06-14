SELECT
    email,
    COUNT(*) AS record_count
FROM core.customer_master
GROUP BY email
HAVING COUNT(*) > 1;