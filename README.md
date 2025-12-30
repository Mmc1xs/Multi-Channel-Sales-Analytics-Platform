# Multi-Channel Sales Analytics Platform  
**Data Warehouse · ETL Pipelines · Near Real-Time Reporting · BI Dashboard**

---

## 📌 Project Overview

This project simulates a **real-world enterprise data engineering & analytics scenario** in a large retail / telecom company.

The goal is to build an **end-to-end data platform** that enables stakeholders to:

- Monitor **daily and monthly sales performance**
- Analyze **multi-channel efficiency** (direct stores, franchise stores, online)
- Track **near real-time sales war room metrics** (15-minute windows)
- Support **management and operations decision-making** via BI dashboards

This project is designed to be **portfolio-ready** and aligned with **Data Engineer / Data Analyst / Analytics Engineer** roles.

---

## 🏢 Business Scenario (Simulated)

- Industry: Retail / Telecommunications  
- Channels:
  - Direct Stores
  - Franchise Stores
  - Online
- Use Cases:
  - Daily / Monthly sales reports
  - Channel & store performance ranking
  - Sales anomaly detection
  - Near real-time sales monitoring during campaigns

---

## 🏗️ Architecture Overview

[ Data Source ]
└─ Public Dataset + Mock Data
↓
[ Raw Layer ] (PostgreSQL)
└─ raw_orders
└─ raw_order_items
└─ raw_product
└─ raw_store
└─ raw_channel
↓
[ Staging Layer ]
└─ Data cleaning, deduplication, normalization
↓
[ Data Warehouse ]
└─ Star Schema
├─ fact_sales
├─ dim_date
├─ dim_product
├─ dim_store
├─ dim_channel
↓
[ Data Marts ]
└─ Daily / Monthly Aggregates
└─ Near Real-Time (15-min window)
↓
[ BI Layer ]
└─ Management Dashboard
└─ Operations & Channel Analysis
└─ Near Real-Time War Room

---

## 🧱 Data Model (Star Schema)

**Fact Table**
- `fact_sales`
  - Grain: Order line level
  - Metrics: quantity, gross_amount, discount_amount, net_amount, margin
  - Time: order timestamp, load timestamp

**Dimension Tables**
- `dim_date` – calendar, month, week, weekday
- `dim_product` – SKU, category, brand
- `dim_store` – store, region, channel mapping
- `dim_channel` – direct / franchise / online

---

## 🔄 ETL & Data Pipeline

- Language: **Python + SQL**
- Database: **PostgreSQL**

### Pipeline Layers
1. **Raw Layer**
   - Append-only ingestion
   - Full data traceability
2. **Staging Layer**
   - Deduplication
   - Missing value handling
   - Data type standardization
3. **Warehouse Layer**
   - Surrogate key generation
   - Fact & dimension loading
   - Incremental and idempotent design
4. **Data Mart**
   - Optimized for BI & real-time queries

---

## ⚡ Near Real-Time Reporting

- Time window: **Last 15 minutes**
- Refresh strategy: batch simulation (every 5 minutes)
- Metrics:
  - Sales amount
  - Order count
  - Channel/store ranking
  - Short-term anomaly detection

This design reflects **practical enterprise constraints** where streaming systems may not always be available.

---

## 📊 BI Dashboard Design

### 1. Executive Overview
- Today sales
- Month-to-date (MTD)
- MoM growth rate
- Channel contribution
- Top stores & products

### 2. Operations & Channel Analysis
- Channel vs region performance
- Store ranking & efficiency
- Average order value (AOV)
- Sales trends with moving averages

### 3. Near Real-Time War Room
- Last 15-min sales & orders
- Live store ranking
- Sales fluctuation alerts

---

## 🧪 Data Quality & Reliability

Implemented checks include:
- Primary key uniqueness
- Foreign key integrity
- Sales amount validity
- Daily volume anomaly detection
- Late-arriving data monitoring

ETL jobs are designed to be **re-runnable and fault-tolerant**.

---

## 📂 Data Source

- **Online Retail II Dataset**
  - Public transactional retail dataset
  - Extended with simulated multi-channel & store dimensions
  - Used widely for analytics and data engineering practice

---

## 🛠️ Tech Stack

- PostgreSQL
- Python
- SQL
- Power BI / Tableau (assumed)
- Git & GitHub

---

## 🎯 Project Goal

This project demonstrates the ability to:

- Design scalable data models
- Build maintainable ETL pipelines
- Perform advanced SQL analytics
- Deliver actionable BI insights
- Think from both **engineering** and **business** perspectives

---

## 🚀 Next Steps

- Implement raw & staging schemas
- Build mock data generator
- Develop ETL scripts
- Create BI dashboards
- Add monitoring & logging



