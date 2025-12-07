CREATE TABLE raw_blob (content TEXT);
INSERT INTO raw_blob VALUES (readfile(:f));

CREATE TABLE rows AS 
WITH RECURSIVE split(y, txt, rest) AS (
    SELECT -1, '', (SELECT content FROM raw_blob) || char(10)
    
    UNION ALL
    
    SELECT 
        y + 1,
        substr(rest, 1, instr(rest, char(10)) - 1),
        substr(rest, instr(rest, char(10)) + 1)
    FROM split 
    WHERE rest != ''
)
SELECT y, txt FROM split WHERE y >= 0 AND txt != '';

CREATE TABLE cols AS 
WITH RECURSIVE seq(x) AS (
    SELECT 0
    UNION ALL 
    SELECT x + 1 FROM seq WHERE x < ((SELECT max(length(txt)) FROM rows) - 1)
)
SELECT x FROM seq;

CREATE TABLE splitters (x INT, y INT, is_used INT);

INSERT INTO splitters (x, y, is_used)
SELECT c.x, r.y, 0
FROM rows r
JOIN cols c ON c.x <= length(r.txt)
WHERE substr(r.txt, c.x + 1, 1) = '^';

CREATE TABLE beams (y INT, x INT, strength INT);

INSERT INTO beams (y, x, strength)
SELECT 0, c.x, 1
FROM rows r
JOIN cols c ON c.x <= length(r.txt)
WHERE substr(r.txt, c.x + 1, 1) = 'S';