BEGIN;

-- 1) raw schema 中建立原始交易明細表
CREATE TABLE IF NOT EXISTS raw.online_retail_txn (
    raw_id         BIGSERIAL PRIMARY KEY,
    invoice_no     TEXT,
    stock_code     TEXT,
    description    TEXT,
    quantity       INTEGER,
    invoice_date   TIMESTAMP,
    unit_price     NUMERIC(12,4),
    customer_id    TEXT,
    country        TEXT,

    -- metadata
    source_file    TEXT,
    ingested_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 2) 常用查詢索引（後續清洗/彙總會用到）
CREATE INDEX IF NOT EXISTS idx_raw_online_retail_invoice_no
    ON raw.online_retail_txn (invoice_no);

CREATE INDEX IF NOT EXISTS idx_raw_online_retail_invoice_date
    ON raw.online_retail_txn (invoice_date);

CREATE INDEX IF NOT EXISTS idx_raw_online_retail_customer_id
    ON raw.online_retail_txn (customer_id);

COMMIT;
