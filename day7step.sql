UPDATE splitters 
SET is_used = 1
WHERE EXISTS (
    SELECT 1 FROM beams b 
    WHERE b.y = :y 
      AND b.x = splitters.x 
      AND b.y = splitters.y
);

INSERT INTO beams (y, x, strength)
SELECT 
    :y + 1,
    new_x,
    SUM(strength)
FROM (
    SELECT 
        CASE 
            WHEN s.x IS NOT NULL THEN b.x - 1
            ELSE b.x
        END as new_x,
        b.strength
    FROM beams b
    LEFT JOIN splitters s ON s.x = b.x AND s.y = b.y
    WHERE b.y = :y
    
    UNION ALL

    SELECT 
        b.x + 1 as new_x,
        b.strength
    FROM beams b
    JOIN splitters s ON s.x = b.x AND s.y = b.y
    WHERE b.y = :y
)
GROUP BY new_x;