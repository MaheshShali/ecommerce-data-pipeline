# 📊 E-Commerce Data Engineering Pipeline (Medallion Architecture)

## 🚀 Project Overview

This project demonstrates an end-to-end **Data Engineering pipeline** built using a modern **Medallion Architecture (Bronze → Silver → Gold)** approach.

The goal is to simulate a real-world e-commerce data platform where raw transactional data is ingested, cleaned, transformed, and modeled into analytics-ready datasets.

The project focuses on:

- Data ingestion pipelines using Python
- Layered data modeling
- SQL transformations
- Data quality practices
- Scalable architecture design inspired by modern data platforms.

---

## 🏗️ Architecture

The pipeline follows a layered architecture to separate responsibilities and ensure reliability.

### High-Level Components

- **Source Data** → External e-commerce dataset
- **Bronze Layer** → Raw ingestion (unchanged source data)
- **Silver Layer** → Cleaned and standardized datasets
- **Gold Layer** → Business-ready analytics models
- **Pipeline Scripts** → Python-based orchestration
- **SQL Models** → Transformations and analytical modeling

---

## 🥉🥈🥇 Medallion Layers

### 🥉 Bronze Layer — Raw Data

**Purpose**
- Store source data exactly as received
- Maintain historical fidelity
- Enable reprocessing

**Characteristics**
- Append-only
- No transformations
- Source-of-truth storage

**Example datasets**
- orders
- order_items
- customers
- products
- sellers

---

### 🥈 Silver Layer — Clean & Structured

**Purpose**
- Standardize and validate data
- Fix schema inconsistencies
- Prepare data for analytics

**Typical operations**
- Data type conversion
- Null handling
- Deduplication
- Timestamp standardization

**Example outputs**
- silver_orders
- silver_order_items
- silver_customers

---

### 🥇 Gold Layer — Analytics & Business Models

**Purpose**
- Deliver analytics-ready tables
- Enable reporting and BI use cases
- Optimize for querying

**Models**

**Fact Tables**
- fact_orders

**Dimension Tables**
- dim_customers
- dim_products
- dim_sellers

**Aggregations**
- daily_sales
- customer_lifetime_value
- top_products

---

## 📦 Dataset Source

This project uses the **Brazilian E-Commerce Public Dataset (Olist)**, a real-world marketplace dataset containing ~100K orders and multiple related tables.

### Why this dataset

- Real transactional relationships
- Multiple domains (orders, payments, reviews, products)
- Real-world data quality challenges
- Suitable for medium-scale data engineering pipelines

Source: Kaggle — Olist Brazilian E-commerce Dataset.

---

## 🔄 Data Flow Diagram

```text
              +---------------------+
              |   Source Dataset    |
              | (Olist CSV Files)   |
              +----------+----------+
                         |
                         v
                 +---------------+
                 |   Bronze Layer |
                 | Raw Ingestion  |
                 +-------+-------+
                         |
                         v
                 +---------------+
                 |   Silver Layer |
                 | Clean & Typed  |
                 +-------+-------+
                         |
                         v
                 +---------------+
                 |    Gold Layer  |
                 | Analytics Mart |
                 +-------+-------+
                         |
                         v
                Reporting / Analytics
```

## 📂 Project Structure
```text 
                ecommerce-medallion-pipeline/
                │
                ├── data/
                │   ├── bronze/
                │   ├── silver/
                │   └── gold/
                │
                ├── pipelines/
                │   ├── bronze/
                │   ├── silver/
                │   └── gold/
                │
                ├── sql/
                │   ├── silver/
                │   └── gold/
                │
                ├── tests/
                ├── config/
                └── orchestration/
```
## 🧠 Engineering Principles Followed

- Layered architecture separation
- Reproducible pipelines
- Idempotent transformations
- Source-of-truth raw storage
- SQL-first analytical modeling

## 🛠️ Tech Stack

- Python (data ingestion & orchestration)
- SQL (transformations and modeling
- Local file-based data lake simulation

## Future additions:

- Apache Airflow for orchestration
- dbt for transformation management
- Cloud storage concepts inspired by Amazon S3

##📈 Project Goals

- Build an industry-style data pipeline from scratch
- Apply Medallion Architecture principles
- Practice scalable data modeling
- Prepare a portfolio-ready data engineering project

## 🔮 Future Enhancements

- Incremental data loading
- Data quality monitoring
- Orchestration workflows
- Automated testing
- Cloud deployment simulation

## 👨‍💻 Author

Built as a hands-on learning project to develop practical Data Engineering skills through real-world architecture patterns.
