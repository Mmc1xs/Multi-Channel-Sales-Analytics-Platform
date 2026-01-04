BEGIN;

-- 1) 先刪掉舊的 stg 表（如果不存在，正常）
DROP TABLE IF EXISTS stg.online_retail_txn;

-- 2) 建立 stg 清洗後交易表
CREATE TABLE stg.online_retail_txn AS
SELECT
    raw_id,
    invoice_no,
    stock_code,
    description,
    quantity,
    unit_price,
    invoice_date,
    customer_id,
    country,
    source_file,
    ingested_at,

    -- 派生欄位
    (quantity * unit_price)                 AS revenue,
    invoice_date::date                      AS invoice_date_d,
    date_trunc('month', invoice_date)::date AS invoice_month_d
FROM raw.online_retail_txn
WHERE
    quantity > 0
    AND unit_price > 0
    AND customer_id IS NOT NULL
    AND invoice_date IS NOT NULL;

-- 3) 索引（針對常用 filter / join）
CREATE INDEX IF NOT EXISTS idx_stg_online_retail_invoice_date
    ON stg.online_retail_txn (invoice_date);

CREATE INDEX IF NOT EXISTS idx_stg_online_retail_customer_id
    ON stg.online_retail_txn (customer_id);

CREATE INDEX IF NOT EXISTS idx_stg_online_retail_invoice_no
    ON stg.online_retail_txn (invoice_no);

COMMIT;
