# Customer-360-Data-Warehouse
Two-page Customer 360 Power BI report (Executive Overview + Segment Analysis) built on a star schema. I created a customer summary table and revenue-based segments, then designed focused pages with segment KPIs and behavior metrics rather than repeating visuals.

# Customer 360 Power BI Dashboard

A two-page Power BI dashboard project focused on customer performance and customer segment analysis.

## Project Overview

This project analyzes customer orders and revenue using a Customer 360 style report built in Power BI. The report is designed to help stakeholders understand overall business performance and compare customer segments based on revenue, orders, and customer value.

## Pages Included

### 1. Executive Overview
This page provides a high-level business summary using KPIs and overview visuals.

### 2. Customer Segments & Value Analysis
This page focuses on segment-level performance, including revenue by segment, customer count by segment, total orders by segment, and segment detail metrics.

## Tools Used

- Power BI
- DAX
- Data Modeling

## Key Metrics

- Total Revenue
- Total Orders
- Average Revenue per Customer
- High Value Customers

## Data Model

The report uses:
- `mart_fact_orders`
- `mart_dim_customer`
- `Customer Summary` table created for segmentation analysis

## Screenshots

### Executive Overview
![Executive Overview](images/page1-executive-overview.png)

### Customer Segments & Value Analysis
![Customer Segments](images/page2-customer-segments.png)

### Data Model
![Data Model](images/data-model.png)
