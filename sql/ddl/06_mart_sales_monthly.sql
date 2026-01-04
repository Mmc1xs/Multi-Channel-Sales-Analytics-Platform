BEGIN;

DROP TABLE IF EXISTS mart.sales_monthly;

CREATE TABLE mart.sales_monthly AS
SELECT
  invoice_month_d                              AS sales_month,
  COUNT(DISTINCT invoice_no)                   AS orders,
  COUNT(DISTINCT customer_id)                  AS customers,
  SUM(quantity)                                AS items_sold,
  SUM(revenue)                                 AS revenue,
  (SUM(revenue) / NULLIF(COUNT(DISTINCT invoice_no), 0))::numeric(14,4) AS aov
FROM stg.online_retail_txn
GROUP BY 1;

CREATE INDEX IF NOT EXISTS idx_mart_sales_monthly_month
  ON mart.sales_monthly (sales_month);

COMMIT;
