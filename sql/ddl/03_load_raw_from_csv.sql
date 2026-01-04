BEGIN;

-- 1) 建立暫存匯入表：欄位名與 CSV 完全一致
DROP TABLE IF EXISTS raw.online_retail_import;

CREATE TABLE raw.online_retail_import (
    "InvoiceNo"    TEXT,
    "StockCode"    TEXT,
    "Description"  TEXT,
    "Quantity"     INTEGER,
    "InvoiceDate"  TEXT,            -- 先用 TEXT，避免日期格式卡住
    "UnitPrice"    NUMERIC(12,4),
    "CustomerID"   TEXT,
    "Country"      TEXT,
    "__sheet_name" TEXT
);

COMMIT;
