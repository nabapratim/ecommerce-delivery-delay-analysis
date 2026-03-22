# 📦 E-Commerce Delivery Delay Analysis

## 🚀 Project Overview
This project analyzes delivery delays in an e-commerce dataset to understand their impact on **customer satisfaction, operations, and revenue**.  
It also includes a **data pipeline (SQL + Python)** to build a structured analytics-ready dataset.

---

## 🎯 Objectives
- 📊 Measure impact of delivery delay on customer reviews  
- 🚚 Identify whether delays are caused by **seller or logistics**  
- 🌍 Analyze regional delay patterns  
- 💰 Quantify revenue at risk  
- ⚙️ Build a scalable **data pipeline (raw → silver → gold)**  

---

## 🗂️ Data Pipeline Architecture

### 🔄 Pipeline Flow
Raw Data → Bronze Layer → Silver Layer → Gold Layer → Analysis (Notebook)

---

### 🥉 Raw Layer (`00_data/raw`)
- Stores original dataset (CSV files)
- No transformations applied  
- Acts as source of truth  

---

### 🥉 Bronze Layer (`src/raw`)
- Stores original dataset (CSV files)
- No transformations applied  
- Acts as source of truth  

---
### 🥈 Silver Layer (`01_sql/silver_layer`)
- Data cleaning & transformation layer  

**Files:**
- `silver_ddl.sql` → table creation  
- `silver_dml_insert.sql` → data insertion  
- `indexing.sql` → performance optimization  
- `silver_refresh_procedure.sql` → refresh logic  

**Responsibilities:**
- Handle missing values  
- Standardize formats  
- Prepare structured tables  

---

### 🥇 Gold Layer (`01_sql/gold_layer`)
- Business-ready aggregated tables  

**Files:**
- `summary_table.sql` → fact table creation  
- `stored_procedure.sql` → aggregation logic  

**Output:**
- `gold.fact_order_summary` (used for analysis)

---

### ⚙️ Pipeline Orchestration (`01_sql/pipeline`)
- `pipeline_refresh.sql` → executes full pipeline (silver → gold)

---

### 🐍 Python Pipeline (`02_src`)
**Files:**
- `ingestion.py` → loads raw data  
- `db.py` → database connection  
- `run_pipeline.py` → executes pipeline  
- `main.py` → entry point  

**Responsibilities:**
- Data ingestion  
- Pipeline execution  
- Logging (`logs/pipeline.log`)  

---

## 📊 Analysis Layer (`03_notebook`)
- `exploratory_analysis.ipynb`  
- `performance_analysis.ipynb`  

**Covers:**
- EDA  
- Hypothesis testing  
- Business impact analysis  

---

## 🔍 Key Analysis Performed

### 1. 📦 Delay Distribution Analysis

- Orders categorized into:
  - On-time  
  - Slight delay  
  - High delay  

---

### 2. ⭐ Review Impact Analysis

- Measured average review score by delay bucket  
- Calculated bad review rate (≤2 rating)  
- Hypothesis testing (t-test) to validate impact  

---

### 3. 🚚 Seller vs Logistics Contribution

- Decomposed delay into:
  - Seller delay  
  - Logistic delay  
- Used **paired t-test** to compare contributions  

---

### 4. 🌍 Regional Analysis

- Identified cities & states with highest delay rates  
- Analyzed average delay and late delivery percentage  

---

### 5. 💸 Freight & Price Impact

- Bucketed freight & price into quartiles  
- Analyzed impact on delivery time and reviews  

---

### 6. 📈 Business Impact Quantification

- Revenue from delayed orders  
- Rating improvement potential  
- Reduction in bad reviews  
- Estimated revenue recovery from retention improvement  

---

## 📊 Key Insights

- 🚨 Delay significantly reduces customer satisfaction (~2-point drop)  
- 📉 High delay orders → ~69% bad reviews  
- 🚚 Logistics contributes ~75% of total delay  
- 🌍 Certain regions consistently show higher delays  
- 💰 ~7.5% of total revenue impacted by late deliveries  
- 📈 Reducing high delays can:
  - Improve ratings by +1.87  
  - Reduce bad reviews by ~54%  
  - Recover revenue  

---

## 🧠 Business Recommendations

- 🎯 Focus on **logistics optimization (primary bottleneck)**  
- 📍 Target high-delay regions for operational improvements  
- 🚀 Reduce high-delay orders first (highest ROI segment)  
- 📊 Track delay KPIs continuously  

---

## 📁 Project Structure
```
Olist_E-Commerce
│
├── 00_data
│   ├── raw 
│   └── outputs
│
├── 01_sql
│   ├── 01_silver_layer
│   │   ├── silver_ddl.sql
│   │   ├── silver_dml_insert.sql
│   │   ├── indexing.sql
│   │   └── silver_refresh_procedure.sql
│   │
│   ├── 02_gold_layer
│   │   ├── summary_table.sql
│   │   ├── gold_indexing.sql
│   │   └── stored_procedure.sql
│   │
│   └── 03_pipeline
│       └── pipeline_refresh.sql
│
├── 02_src
│   ├── extraction.py
│   ├── ingestion.py
│   ├── db.py
│   └── main.py
│
├── 04_notebooks
│   └── performance_analysis.ipynb
│
├── config
│   └── db_config.env
│
└── reports
```

---

## 🔄 Data Pipeline Overview

1. **Ingestion Layer (Python)**
   - Load raw data into database
   - Handle schema alignment and logging

2. **Silver Layer (SQL)**
   - Data cleaning & transformation  
   - Standardization and indexing  
   - Incremental refresh via stored procedures  

3. **Gold Layer (SQL)**
   - Aggregated business metrics  
   - KPI tables (e.g., delay %, revenue impact)  

4. **Pipeline Orchestration**
   - `run_pipeline.py` triggers full refresh  
   - `pipeline_refresh.sql` manages SQL execution flow  

5. **Analysis Layer**
   - Jupyter notebooks for EDA + hypothesis testing  

6. **Reporting Layer**
   - Executive summary + insights in `/reports`  

---

## 💼 Business Impact & Estimated Gains

### 📊 Current Impact of Delays

- 💰 Total Revenue: **~$15.5M**
- ⚠️ Revenue from Late Deliveries: **~$1.16M (7.5%)**
- ⭐ Avg Rating Drop (Late vs On-time): **~1.7–2.0 points**
- 😡 Bad Reviews (High Delay): **~69% vs 15% (Slight Delay)**

👉 Delays are directly impacting **customer satisfaction and revenue risk**

---

### 📈 Improvement Opportunity

If **high delays are reduced to slight delays**:

- ⭐ Rating improvement: **+1.87 points**
- 📉 Bad reviews reduction: **~54%**
- 📊 Total rating uplift: **~10,350 points**

---

### 💰 Estimated Revenue Recovery

Assuming:
- 📈 **5% improvement in customer retention**

Then:

- 💵 Estimated revenue recovery: **~$44K+**

👉 This is a **conservative estimate** (excludes LTV, repeat purchases, referrals)

---

### 🧠 Key Business Takeaway

- 🚚 **75% of delays come from logistics**
- 🎯 Fixing logistics = **maximum ROI**
- ⚡ Focus on **high-delay orders (~5–6%) for fastest impact**

---

---

## 📌 Conclusion

Delivery delay is the **most critical driver of customer dissatisfaction and revenue risk**.  
Improving logistics performance can generate **high-impact gains in both customer experience and business outcomes**.

---

## 📬 Future Improvements

- 📈 Predictive modeling for delay risk  
- 🚚 Route optimization analysis  
- 🔁 Customer lifetime value (LTV) impact  
- 📊 Dashboard (Power BI / Tableau)  

---

## Contact

Author: Nava Pratim Dutta

LinkedIn: ([add your LinkedIn profile link](https://www.linkedin.com/in/nabapratimdutta/))

Email:[email] (nabapratim.dutta@gmail.com)

GitHub:([your GitHub profile link](https://github.com/nabapratim/vendor_performance_analysis))

Feel free to connect if you are interested in data analytics, supply chain analytics, or collaborative projects.
