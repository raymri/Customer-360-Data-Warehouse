DROP TABLE IF EXISTS staging.stg_customers;
CREATE TABLE staging.stg_customers AS
SELECT
    TRIM(customer_id) AS customer_id,
    TRIM(first_name) AS first_name,
    TRIM(last_name) AS last_name,
    LOWER(TRIM(email)) AS email,
    NULLIF(TRIM(phone), '') AS phone,
    TRIM(gender) AS gender,
    TRIM(city) AS city,
    TRIM(state) AS state,
    TRIM(country) AS country,
    signup_date,
    INITCAP(TRIM(customer_status)) AS customer_status,
    TRIM(preferred_channel) AS preferred_channel,
    updated_at
FROM raw.customers;

DROP TABLE IF EXISTS staging.stg_orders;
CREATE TABLE staging.stg_orders AS
SELECT
    TRIM(order_id) AS order_id,
    TRIM(customer_id) AS customer_id,
    order_date,
    INITCAP(TRIM(order_status)) AS order_status,
    order_amount,
    TRIM(payment_method) AS payment_method,
    TRIM(sales_channel) AS sales_channel
FROM raw.orders;

DROP TABLE IF EXISTS staging.stg_order_items;
CREATE TABLE staging.stg_order_items AS
SELECT
    TRIM(order_item_id) AS order_item_id,
    TRIM(order_id) AS order_id,
    TRIM(product_id) AS product_id,
    TRIM(product_name) AS product_name,
    TRIM(category) AS category,
    quantity,
    unit_price,
    line_amount
FROM raw.order_items;

DROP TABLE IF EXISTS staging.stg_support_tickets;
CREATE TABLE staging.stg_support_tickets AS
SELECT
    TRIM(ticket_id) AS ticket_id,
    TRIM(customer_id) AS customer_id,
    ticket_date,
    TRIM(issue_category) AS issue_category,
    INITCAP(TRIM(priority)) AS priority,
    INITCAP(TRIM(ticket_status)) AS ticket_status,
    resolution_date,
    csat_score
FROM raw.support_tickets;

DROP TABLE IF EXISTS staging.stg_web_events;
CREATE TABLE staging.stg_web_events AS
SELECT
    TRIM(event_id) AS event_id,
    TRIM(customer_id) AS customer_id,
    event_timestamp,
    LOWER(TRIM(event_type)) AS event_type,
    TRIM(page_name) AS page_name,
    TRIM(device_type) AS device_type,
    INITCAP(TRIM(traffic_source)) AS traffic_source
FROM raw.web_events;