DROP TABLE IF EXISTS mart.dim_customer;

CREATE TABLE mart.dim_customer AS
SELECT
    ROW_NUMBER() OVER (ORDER BY customer_id) AS customer_key,
    customer_id,
    first_name,
    last_name,
    email,
    phone,
    gender,
    customer_status,
    preferred_channel,
    signup_date
FROM core.customer_master;


DROP TABLE IF EXISTS mart.dim_geography;

CREATE TABLE mart.dim_geography AS
SELECT DISTINCT
    ROW_NUMBER() OVER (ORDER BY country, state, city) AS geography_key,
    country,
    state,
    city
FROM core.customer_master;


DROP TABLE IF EXISTS mart.dim_date;

CREATE TABLE mart.dim_date AS
WITH date_source AS (
    SELECT signup_date AS full_date FROM core.customer_master
    UNION
    SELECT first_order_date FROM core.customer_order_summary
    UNION
    SELECT last_order_date FROM core.customer_order_summary
    UNION
    SELECT ticket_date FROM staging.stg_support_tickets
    UNION
    SELECT DATE(event_timestamp) FROM staging.stg_web_events
)
SELECT DISTINCT
    TO_CHAR(full_date, 'YYYYMMDD')::INT AS date_key,
    full_date,
    EXTRACT(DAY FROM full_date) AS day_num,
    EXTRACT(MONTH FROM full_date) AS month_num,
    TO_CHAR(full_date, 'Month') AS month_name,
    EXTRACT(YEAR FROM full_date) AS year_num,
    EXTRACT(QUARTER FROM full_date) AS quarter_num
FROM date_source
WHERE full_date IS NOT NULL
ORDER BY full_date;