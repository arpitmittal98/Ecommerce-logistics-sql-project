CREATE OR REPLACE FUNCTION delete_review(
    p_review_id INTEGER
)
RETURNS VOID AS $$
BEGIN
    DELETE FROM Reviews
    WHERE ReviewID = p_review_id;
END;
$$ LANGUAGE plpgsql;

SELECT delete_review(550);

SELECT *
FROM Reviews
WHERE ReviewID = 550;
