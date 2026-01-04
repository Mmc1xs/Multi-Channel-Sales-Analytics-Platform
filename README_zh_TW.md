# 多通路銷售分析平台
**PostgreSQL · SQL ETL · 資料倉儲 · 分析資料集市**

---

## 📌 專案概述

本專案是一個以 **PostgreSQL** 為核心的 **端到端資料工程與分析流程**，使用公開的零售交易資料集，模擬實務中的資料倉儲建置情境。

專案目標在於展示如何將原始交易資料，經過系統化的清洗與轉換，建構成 **可直接支援商業分析的資料集市（Data Mart）**，並遵循現代資料倉儲的分層設計原則。

本專案適合作為 **資料工程師（Data Engineer）／分析工程師（Analytics Engineer）** 的作品集專案。

---

## 🏢 商業情境（模擬）

- 產業別：零售業  
- 資料型態：交易層級銷售資料  
- 核心分析問題：
  - 銷售表現隨時間的變化趨勢？
  - 每日與每月營收狀況為何？
  - 哪些客戶具有最高價值？

---

## 🏗️ 系統架構總覽

```text
[ Excel 原始資料 ]
        |
        v
[ Raw Layer ]      （原始資料層，僅做最小轉換）
  └─ raw.online_retail_txn
        |
        v
[ Staging Layer ]  （清洗與標準化後資料）
  └─ stg.online_retail_txn
        |
        v
[ Data Mart ]      （分析用彙總與特徵表）
  ├─ mart.sales_daily
  ├─ mart.sales_monthly
  └─ mart.customer_rfm
```

---

## 🧱 資料分層設計說明

### 1️⃣ Raw Layer（`raw`）
目的：**保留原始資料，確保資料可追溯性**

- 資料來源：Online Retail II 公開資料集
- 資料表：
  - `raw.online_retail_txn`
- 特性：
  - Append-only（不覆寫、不刪除）
  - 最小型別轉換
  - 完整保留來源資料狀態

---

### 2️⃣ Staging Layer（`stg`）
目的：**資料清洗與分析前標準化**

- 資料表：
  - `stg.online_retail_txn`
- 主要轉換規則：
  - 移除無效交易（負數數量或金額）
  - 排除缺失客戶 ID 的資料
  - 時間欄位標準化
  - 衍生營收與日期相關欄位

---

### 3️⃣ Data Mart（`mart`）
目的：**提供高效能、可直接分析的資料結構**

#### `mart.sales_daily`
每日銷售指標：
- 營收（Revenue）
- 訂單數（Orders）
- 客戶數（Customers）
- 銷售件數（Items Sold）
- 平均訂單金額（AOV）

#### `mart.sales_monthly`
每月彙總指標：
- 營收
- 訂單數
- 客戶數
- 銷售件數
- 平均訂單金額（AOV）

#### `mart.customer_rfm`
以 **RFM 分析** 進行客戶價值分群：
- Recency：距離最近一次消費的天數
- Frequency：消費次數
- Monetary：累積消費金額

---

## 🔄 ETL 流程設計

- 使用語言：**SQL + Python**
- 資料庫：**PostgreSQL**

### 處理流程：
1. Excel → CSV（Python / pandas）
2. CSV → Raw（PostgreSQL `\copy`）
3. Raw → Staging（資料清洗與正規化）
4. Staging → Data Mart（彙總與分析特徵產生）

所有流程皆設計為：
- 可重複執行（re-runnable）
- 具冪等性（idempotent）

---

## 📊 分析應用範例

- 每日／每月銷售績效追蹤
- 營收趨勢分析
- 客戶價值分群（RFM）
- 平均訂單金額與消費行為分析

---

## 🛠️ 技術堆疊

- PostgreSQL
- Python（pandas）
- SQL
- Git & GitHub

---

## 🎯 專案學習重點

本專案展示以下能力：

- 設計分層式資料倉儲架構（raw / stg / mart）
- 建立穩定可靠的 SQL 型 ETL 流程
- 套用實務中的資料清洗邏輯
- 建構分析導向的資料集市
- 將商業問題轉化為資料模型

---

## 🚀 延伸方向

- 建立維度表（日期、商品、客戶、國別）
- 實作增量載入（watermark / upsert）
- 加入近即時彙總（如 15 分鐘視窗）
- 串接 BI 工具（Power BI / Tableau）

---

## 📂 資料來源

- **Online Retail II Dataset**（公開零售交易資料集）
