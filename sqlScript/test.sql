WITH users_recent AS (
  SELECT id, email, created_at
  FROM users
  WHERE created_at >= DATE '2025-01-01'
)
SELECT r.id, r.email
FROM users_recent r
ORDER BY r.created_at DESC;
