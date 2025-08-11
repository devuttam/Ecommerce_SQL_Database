# MySQL Project: E-commerce Data Analysis

## 📌 Project Overview
This project is an end-to-end MySQL-based data analysis of an **E-commerce Dataset**.
It demonstrates **intermediate to advanced SQL skills** including:
- Data Cleaning & Table Creation
- Aggregation & Grouping
- Subqueries
- Joins
- Views
- Indexing
- Window Functions
- Analytical Insights

The dataset contains **500 rows of synthetic e-commerce transaction data** designed to run analytical queries without errors.

---

## 📂 Dataset Details
The dataset `ecommerce\\\_data` contains the following columns:

| Column Name   | Type         | Description |
|---------------|-------------|-------------|
| order_id      | INT         | Unique order identifier |
| customer_id   | INT         | Unique customer identifier |
| product_id    | INT         | Unique product identifier |
| product_name  | VARCHAR(100)| Name of the product |
| category      | VARCHAR(50) | Product category |
| region        | VARCHAR(50) | Geographic region of the order |
| order_date    | DATE        | Order placement date |
| ship_date     | DATE        | Date when the order was shipped |
| quantity      | INT         | Quantity of products ordered |
| revenue       | DECIMAL(10,2)| Total revenue from the order |

---

## 🛠️ Setup & Installation

### 1. Clone the Repository
```bash

git clone https://github.com/<your-username>/mysql-ecommerce-analysis.git

cd mysql-ecommerce-analysis



