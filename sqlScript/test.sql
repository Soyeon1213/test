WITH base AS (
    SELECT
        id,
        id % 50              AS grp,
        id * 3 + 7           AS v1,
        id * id              AS v2
    FROM range(0, 80000000) 
),
level1 AS (
    SELECT
        grp,
        COUNT(*)             AS cnt,
        AVG(v1)              AS avg_v1,
        AVG(v2)              AS avg_v2
    FROM base
    GROUP BY grp
),
level2 AS (
    SELECT
        SUM(cnt)             AS total_cnt,
        AVG(avg_v1)          AS global_avg_v1,
        AVG(avg_v2)          AS global_avg_v2
    FROM level1
)
SELECT *
FROM level2;
