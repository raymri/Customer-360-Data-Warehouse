DROP VIEW IF EXISTS analytics.vw_customer_kpis;
CREATE VIEW analytics.vw_customer_kpis AS
SELECT
    customer_id,
    first_name,
    last_name,
    email,
    city,
    state,
    country,
    customer_status,
    preferred_channel,
    total_orders,
    total_revenue,
    avg_order_value,
    total_tickets,
    avg_csat,
    total_events,
    page_views,
    add_to_cart_events,
    checkout_events,
    recency_days,
    purchase_segment,
    engagement_segment
FROM core.customer_360_snapshot;


DROP VIEW IF EXISTS analytics.vw_customer_segments;
CREATE VIEW analytics.vw_customer_segments AS
SELECT
    customer_id,
    first_name,
    last_name,
    email,
    total_orders AS frequency,
    total_revenue AS monetary,
    recency_days AS recency,
    CASE
        WHEN total_revenue >= 10000 THEN 'High Value'
        WHEN total_revenue >= 5000 THEN 'Medium Value'
        WHEN total_revenue > 0 THEN 'Low Value'
        ELSE 'No Value'
    END AS value_segment,
    CASE
        WHEN recency_days IS NULL THEN 'No Purchase'
        WHEN recency_days <= 30 THEN 'Active'
        WHEN recency_days <= 90 THEN 'Warm'
        ELSE 'At Risk'
    END AS lifecycle_segment
FROM core.customer_360_snapshot;


DROP VIEW IF EXISTS analytics.vw_monthly_revenue;
CREATE VIEW analytics.vw_monthly_revenue AS
SELECT
    DATE_TRUNC('month', o.order_date)::DATE AS revenue_month,
    COUNT(o.order_id) AS total_orders,
    SUM(o.order_amount) AS total_revenue,
    AVG(o.order_amount) AS avg_order_value
FROM staging.stg_orders o
WHERE o.order_status = 'Completed'
GROUP BY DATE_TRUNC('month', o.order_date)::DATE
ORDER BY revenue_month;


DROP VIEW IF EXISTS analytics.vw_segment_summary;
CREATE VIEW analytics.vw_segment_summary AS
SELECT
    value_segment,
    lifecycle_segment,
    COUNT(customer_id) AS customer_count,
    SUM(frequency) AS total_orders,
    SUM(monetary) AS total_revenue,
    AVG(recency) AS avg_recency_days
FROM analytics.vw_customer_segments
GROUP BY value_segment, lifecycle_segment
ORDER BY total_revenue DESC;