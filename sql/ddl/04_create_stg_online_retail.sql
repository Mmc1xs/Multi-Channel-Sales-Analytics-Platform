BEGIN;

DROP TABLE IF EXISTS stg.online_retail_txn;

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

    -- 派生欄位（後續分析會用）
    (quantity * unit_price) AS revenue,
    DATE(invoice_date)      AS invoice_date_d,
    DATE_TRUNC('month', invoice_date) AS invoice_month

FROM raw.online_retail_txn
WHERE
    -- 1) 有效銷售
    quantity > 0
    AND unit_price > 0

    -- 2) 必須有客戶
    AND customer_id IS NOT NULL

    -- 3) 必須有時間
    AND invoice_date IS NOT NULL
;

-- 核心分析索引
CREATE INDEX idx_stg_online_retail_invoice_date
    ON stg.online_retail_txn (invoice_date);

CREATE INDEX idx_stg_online_retail_customer_id
    ON stg.online_retail_txn (customer_id);

CREATE INDEX idx_stg_online_retail_invoice_no
    ON stg.online_retail_txn (invoice_no);

COMMIT;
