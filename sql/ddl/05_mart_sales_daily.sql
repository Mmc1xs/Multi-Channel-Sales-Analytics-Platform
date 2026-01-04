BEGIN;

DROP TABLE IF EXISTS mart.sales_daily;

CREATE TABLE mart.sales_daily AS
SELECT
  invoice_date_d                               AS sales_date,
  COUNT(DISTINCT invoice_no)                   AS orders,
  COUNT(DISTINCT customer_id)                  AS customers,
  SUM(quantity)                                AS items_sold,
  SUM(revenue)                                 AS revenue,
  (SUM(revenue) / NULLIF(COUNT(DISTINCT invoice_no), 0))::numeric(14,4) AS aov
FROM stg.online_retail_txn
GROUP BY 1;

CREATE INDEX IF NOT EXISTS idx_mart_sales_daily_date
  ON mart.sales_daily (sales_date);

COMMIT;
