import pandas as pd
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parents[1]
SRC_XLSX = BASE_DIR / "data" / "online_retail_II.xlsx"
OUT_DIR = BASE_DIR / "data" / "csv"
OUT_DIR.mkdir(parents=True, exist_ok=True)

# 讀取所有工作表
sheets = pd.read_excel(
    SRC_XLSX,
    sheet_name=None,  # 關鍵
    dtype={
        "InvoiceNo": str,
        "StockCode": str,
        "Description": str,
        "CustomerID": str,
        "Country": str,
    }
)

dfs = []
for sheet_name, df in sheets.items():
    df["__sheet_name"] = sheet_name  # 保留來源（可選）
    dfs.append(df)

df_all = pd.concat(dfs, ignore_index=True)

# 正規化日期
df_all["InvoiceDate"] = pd.to_datetime(
    df_all["InvoiceDate"],
    errors="coerce"
)

out_path = OUT_DIR / "online_retail_raw.csv"
df_all.to_csv(out_path, index=False, encoding="utf-8")

print(f"CSV written to {out_path}")
