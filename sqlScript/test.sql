SELECT 
    (id % 10) AS grp, 
    COUNT(*), 
    AVG(id * 1.5), 
    STDDEV(id) -- Standard deviation is CPU intensive
FROM generate_series(1, 50000000) AS id
GROUP BY (id % 10)
ORDER BY grp;
