DROP TABLE IF EXISTS core.customer_360_snapshot;

CREATE TABLE core.customer_360_snapshot AS
SELECT
    cm.customer_id,
    cm.first_name,
    cm.last_name,
    cm.email,
    cm.phone,
    cm.gender,
    cm.city,
    cm.state,
    cm.country,
    cm.signup_date,
    cm.customer_status,
    cm.preferred_channel,
    cm.updated_at,

    COALESCE(os.total_orders, 0) AS total_orders,
    COALESCE(os.total_revenue, 0) AS total_revenue,
    COALESCE(os.avg_order_value, 0) AS avg_order_value,
    os.first_order_date,
    os.last_order_date,

    COALESCE(ss.total_tickets, 0) AS total_tickets,
    COALESCE(ss.open_tickets, 0) AS open_tickets,
    COALESCE(ss.resolved_tickets, 0) AS resolved_tickets,
    COALESCE(ss.avg_csat, 0) AS avg_csat,

    COALESCE(es.total_events, 0) AS total_events,
    COALESCE(es.page_views, 0) AS page_views,
    COALESCE(es.add_to_cart_events, 0) AS add_to_cart_events,
    COALESCE(es.checkout_events, 0) AS checkout_events,
    es.last_event_timestamp,

    CASE
        WHEN os.last_order_date IS NOT NULL THEN CURRENT_DATE - os.last_order_date
        ELSE NULL
    END AS recency_days,

    CASE
        WHEN COALESCE(os.total_orders, 0) >= 2 THEN 'Repeat Customer'
        WHEN COALESCE(os.total_orders, 0) = 1 THEN 'One-Time Customer'
        ELSE 'No Purchase'
    END AS purchase_segment,

    CASE
        WHEN COALESCE(es.total_events, 0) >= 2 THEN 'Engaged'
        WHEN COALESCE(es.total_events, 0) = 1 THEN 'Low Engagement'
        ELSE 'No Activity'
    END AS engagement_segment

FROM core.customer_master cm
LEFT JOIN core.customer_order_summary os
    ON cm.customer_id = os.customer_id
LEFT JOIN core.customer_support_summary ss
    ON cm.customer_id = ss.customer_id
LEFT JOIN core.customer_engagement_summary es
    ON cm.customer_id = es.customer_id;