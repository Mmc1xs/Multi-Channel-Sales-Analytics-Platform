# Multi-Channel Sales Analytics Platform
**PostgreSQL · SQL ETL · Data Warehouse · Analytics Mart**
> 中文版本請見 [README_zh_TW.md](README_zh_TW.md)
---

## 📌 Project Overview

This project is an **end-to-end data engineering & analytics pipeline** built on PostgreSQL, using a public retail transaction dataset.

The goal is to demonstrate how raw transactional data can be transformed into **clean, analytics-ready data marts** for business analysis, following **modern data warehouse layering principles**.

---

## 🏢 Business Context (Simulated)

- Industry: Retail
- Data Type: Transaction-level sales data
- Key Questions:
  - How is sales performing over time?
  - What are daily and monthly revenue trends?
  - Who are the most valuable customers?

---

## 🏗️ Architecture Overview

```text
[ Excel Dataset ]
        |
        v
[ Raw Layer ]      (append-only, traceable)
  └─ raw.online_retail_txn
        |
        v
[ Staging Layer ]  (cleaned, filtered, standardized)
  └─ stg.online_retail_txn
        |
        v
[ Data Mart ]      (analytics-ready aggregates & features)
  ├─ mart.sales_daily
  ├─ mart.sales_monthly
  └─ mart.customer_rfm
```

---

## 🧱 Data Layers & Design

### 1️⃣ Raw Layer (`raw`)
Purpose: **Preserve original data with minimal transformation**

- Source: Online Retail II dataset
- Table:
  - `raw.online_retail_txn`
- Characteristics:
  - Append-only ingestion
  - Minimal type casting
  - Full data traceability

---

### 2️⃣ Staging Layer (`stg`)
Purpose: **Clean and standardize data for analysis**

- Table:
  - `stg.online_retail_txn`
- Transformations:
  - Remove invalid records (negative quantity / price)
  - Exclude missing customer IDs
  - Standardize timestamps
  - Derive revenue and date fields

---

### 3️⃣ Analytics Mart (`mart`)
Purpose: **Optimized tables for BI and analytical queries**

#### `mart.sales_daily`
Daily sales KPIs:
- Revenue
- Orders
- Customers
- Items sold
- Average Order Value (AOV)

#### `mart.sales_monthly`
Monthly aggregated metrics:
- Revenue
- Orders
- Customers
- Items sold
- Average Order Value (AOV)

#### `mart.customer_rfm`
Customer segmentation using **RFM analysis**:
- Recency (days since last purchase)
- Frequency (distinct orders)
- Monetary (total revenue)

---

## 🔄 ETL Pipeline

- Language: **SQL + Python**
- Database: **PostgreSQL**
- Steps:
  1. Excel → CSV (Python / pandas)
  2. CSV → Raw (PostgreSQL `\copy`)
  3. Raw → Staging (data cleaning & standardization)
  4. Staging → Mart (aggregation & analytics features)

All transformations are **re-runnable and idempotent**.

---

## 📊 Example Analytics Use Cases

- Daily and monthly sales performance monitoring
- Revenue trend analysis
- Customer value segmentation (RFM)
- Average order value (AOV) and purchasing behavior analysis

---

## 🛠️ Tech Stack

- PostgreSQL
- Python (pandas)
- SQL
- Git & GitHub

---

## 🎯 Key Learning Outcomes

This project demonstrates the ability to:

- Design layered data warehouse schemas (raw / stg / mart)
- Build reliable SQL-based ETL pipelines
- Apply real-world data cleaning rules
- Create analytics-ready data marts
- Translate business questions into data models

---

## 🚀 Possible Extensions

- Add dimension tables (date, product, customer, country)
- Implement incremental loading (watermark / idempotent upsert)
- Add near real-time aggregation (e.g., 15-min window)
- Connect BI tools (Power BI / Tableau)

---

## 📂 Data Source

- **Online Retail II Dataset** (public dataset)
