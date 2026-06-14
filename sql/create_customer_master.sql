DROP TABLE IF EXISTS core.customer_master;

CREATE TABLE core.customer_master AS
WITH ranked_customers AS (
    SELECT
        customer_id,
        first_name,
        last_name,
        email,
        phone,
        gender,
        city,
        state,
        country,
        signup_date,
        customer_status,
        preferred_channel,
        updated_at,
        ROW_NUMBER() OVER (
            PARTITION BY email
            ORDER BY updated_at DESC
        ) AS rn
    FROM staging.stg_customers
)
SELECT
    customer_id,
    first_name,
    last_name,
    email,
    phone,
    gender,
    city,
    state,
    country,
    signup_date,
    customer_status,
    preferred_channel,
    updated_at
FROM ranked_customers
WHERE rn = 1;