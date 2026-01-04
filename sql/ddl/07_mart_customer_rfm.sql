BEGIN;

DROP TABLE IF EXISTS mart.customer_rfm;

CREATE TABLE mart.customer_rfm AS
WITH base AS (
  SELECT
    customer_id,
    MAX(invoice_date)          AS last_purchase_ts,
    COUNT(DISTINCT invoice_no) AS frequency,
    SUM(revenue)               AS monetary
  FROM stg.online_retail_txn
  GROUP BY customer_id
),
asof AS (
  SELECT MAX(invoice_date)::date AS asof_date
  FROM stg.online_retail_txn
),
rfm AS (
  SELECT
    b.customer_id,
    (a.asof_date - b.last_purchase_ts::date) AS recency_days,
    b.frequency,
    b.monetary
  FROM base b
  CROSS JOIN asof a
),
scored AS (
  SELECT
    customer_id,
    recency_days,
    frequency,
    monetary,
    -- recency 越小越好，所以用 DESC 讓小值拿到高分
    ntile(5) OVER (ORDER BY recency_days DESC) AS r_score,
    ntile(5) OVER (ORDER BY frequency)         AS f_score,
    ntile(5) OVER (ORDER BY monetary)          AS m_score
  FROM rfm
)
SELECT
  customer_id,
  recency_days,
  frequency,
  monetary::numeric(14,4) AS monetary,
  r_score,
  f_score,
  m_score,
  (r_score * 100 + f_score * 10 + m_score) AS rfm_score
FROM scored;

CREATE INDEX IF NOT EXISTS idx_mart_customer_rfm_score
  ON mart.customer_rfm (rfm_score);

COMMIT;
