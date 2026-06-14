DROP TABLE IF EXISTS mart.fact_orders;

CREATE TABLE mart.fact_orders AS
SELECT
    o.order_id,
    dc.customer_key,
    TO_CHAR(o.order_date, 'YYYYMMDD')::INT AS date_key,
    dg.geography_key,
    o.order_amount,
    1 AS order_count
FROM staging.stg_orders o
LEFT JOIN mart.dim_customer dc
    ON o.customer_id = dc.customer_id
LEFT JOIN core.customer_master cm
    ON o.customer_id = cm.customer_id
LEFT JOIN mart.dim_geography dg
    ON cm.country = dg.country
   AND cm.state = dg.state
   AND cm.city = dg.city
WHERE o.order_status = 'Completed';


DROP TABLE IF EXISTS mart.fact_support_tickets;

CREATE TABLE mart.fact_support_tickets AS
SELECT
    t.ticket_id,
    dc.customer_key,
    TO_CHAR(t.ticket_date, 'YYYYMMDD')::INT AS date_key,
    dg.geography_key,
    1 AS ticket_count,
    CASE WHEN t.ticket_status = 'Resolved' THEN 1 ELSE 0 END AS resolved_ticket_count,
    COALESCE(t.csat_score, 0) AS csat_score
FROM staging.stg_support_tickets t
LEFT JOIN mart.dim_customer dc
    ON t.customer_id = dc.customer_id
LEFT JOIN core.customer_master cm
    ON t.customer_id = cm.customer_id
LEFT JOIN mart.dim_geography dg
    ON cm.country = dg.country
   AND cm.state = dg.state
   AND cm.city = dg.city;


DROP TABLE IF EXISTS mart.fact_web_events;

CREATE TABLE mart.fact_web_events AS
SELECT
    e.event_id,
    dc.customer_key,
    TO_CHAR(DATE(e.event_timestamp), 'YYYYMMDD')::INT AS date_key,
    dg.geography_key,
    1 AS event_count,
    CASE WHEN e.event_type = 'page_view' THEN 1 ELSE 0 END AS page_view_count,
    CASE WHEN e.event_type = 'add_to_cart' THEN 1 ELSE 0 END AS add_to_cart_count,
    CASE WHEN e.event_type = 'checkout' THEN 1 ELSE 0 END AS checkout_count
FROM staging.stg_web_events e
LEFT JOIN mart.dim_customer dc
    ON e.customer_id = dc.customer_id
LEFT JOIN core.customer_master cm
    ON e.customer_id = cm.customer_id
LEFT JOIN mart.dim_geography dg
    ON cm.country = dg.country
   AND cm.state = dg.state
   AND cm.city = dg.city;