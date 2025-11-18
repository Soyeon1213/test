WITH base AS (
    SELECT
        id,
        id % 10            AS grp,
        id * id            AS squared
    FROM range(0, 30000000)
),
agg AS (
    SELECT
        grp,
        COUNT(*)           AS cnt,
        AVG(squared)       AS avg_sq,
        MAX(squared)       AS max_sq
    FROM base
    GROUP BY grp
)
SELECT *
FROM agg
ORDER BY grp;
