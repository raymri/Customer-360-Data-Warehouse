DROP TABLE IF EXISTS core.customer_order_summary;

CREATE TABLE core.customer_order_summary AS
SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    SUM(order_amount) AS total_revenue,
    AVG(order_amount) AS avg_order_value,
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM staging.stg_orders
WHERE order_status = 'Completed'
GROUP BY customer_id;


DROP TABLE IF EXISTS core.customer_support_summary;

CREATE TABLE core.customer_support_summary AS
SELECT
    customer_id,
    COUNT(ticket_id) AS total_tickets,
    SUM(CASE WHEN ticket_status = 'Open' THEN 1 ELSE 0 END) AS open_tickets,
    SUM(CASE WHEN ticket_status = 'Resolved' THEN 1 ELSE 0 END) AS resolved_tickets,
    AVG(csat_score) AS avg_csat
FROM staging.stg_support_tickets
GROUP BY customer_id;


DROP TABLE IF EXISTS core.customer_engagement_summary;

CREATE TABLE core.customer_engagement_summary AS
SELECT
    customer_id,
    COUNT(event_id) AS total_events,
    SUM(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) AS page_views,
    SUM(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS add_to_cart_events,
    SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) AS checkout_events,
    MAX(event_timestamp) AS last_event_timestamp
FROM staging.stg_web_events
GROUP BY customer_id;