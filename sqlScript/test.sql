WITH base AS (
    SELECT
        id,
        id % 1000              AS grp,
        id * 3 + 7             AS v1,
        id * id                AS v2
    FROM range(0, 10000)   -- 여기 숫자로 1차 조절 (200M → 300M → 500M 등)
),

-- subset만 잡아서 join (전체를 cross join하면 진짜 터질 수 있어서 제한)
subset AS (
    SELECT *
    FROM base
    WHERE id < 5000         -- 500만 행만 join 대상으로 사용 (느리면 줄여)
),

joined AS (
    SELECT
        a.grp,
        a.id          AS id1,
        b.id          AS id2,
        a.v1 + b.v1   AS v_sum,
        a.v2 + b.v2   AS v2_sum
    FROM subset a
    JOIN subset b
      ON a.grp = b.grp
     AND a.id % 50 = b.id % 50
),

with_window AS (
    SELECT
        grp,
        v_sum,
        v2_sum,
        ROW_NUMBER() OVER (PARTITION BY grp ORDER BY v2_sum DESC) AS rn
    FROM joined
)

SELECT *
FROM with_window
WHERE rn <= 100
ORDER BY grp, rn;
