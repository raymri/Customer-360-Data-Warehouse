CREATE TABLE IF NOT EXISTS raw.customers (
    customer_id TEXT,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    phone TEXT,
    gender TEXT,
    city TEXT,
    state TEXT,
    country TEXT,
    signup_date DATE,
    customer_status TEXT,
    preferred_channel TEXT,
    updated_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS raw.orders (
    order_id TEXT,
    customer_id TEXT,
    order_date DATE,
    order_status TEXT,
    order_amount NUMERIC(10,2),
    payment_method TEXT,
    sales_channel TEXT
);

CREATE TABLE IF NOT EXISTS raw.order_items (
    order_item_id TEXT,
    order_id TEXT,
    product_id TEXT,
    product_name TEXT,
    category TEXT,
    quantity INTEGER,
    unit_price NUMERIC(10,2),
    line_amount NUMERIC(10,2)
);

CREATE TABLE IF NOT EXISTS raw.support_tickets (
    ticket_id TEXT,
    customer_id TEXT,
    ticket_date DATE,
    issue_category TEXT,
    priority TEXT,
    ticket_status TEXT,
    resolution_date DATE,
    csat_score INTEGER
);

CREATE TABLE IF NOT EXISTS raw.web_events (
    event_id TEXT,
    customer_id TEXT,
    event_timestamp TIMESTAMP,
    event_type TEXT,
    page_name TEXT,
    device_type TEXT,
    traffic_source TEXT
);