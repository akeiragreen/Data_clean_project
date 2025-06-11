# 🧹 SQL Data Cleaning Project: Layoff Records

## 📌 Project Overview
This project focuses on cleaning and preparing a dataset of global company layoffs for accurate and reliable analysis. The raw data contained inconsistencies, duplicates, null values, and formatting issues that could mislead business insights. Using SQL, the dataset was cleaned and structured for analysis, reporting, and potential integration with business intelligence tools.

---

## 📊 Dataset Description
The original dataset includes layoff-related records with the following key columns:

- **company**: Name of the company that performed layoffs
- **location**: Geographic location of the company
- **industry**: Industry sector of the company
- **total_laid_off**: Number of employees laid off
- **percentage_laid_off**: Proportion of workforce laid off
- **date**: Reported date of the layoff event
- **stage**: Company funding or business stage (e.g., Series A, Public)
- **country**: Country of the company
- **funds_raised_millions**: Total funds raised in millions

---

## ❓ Business Questions Addressed
- Are there any duplicate records in the layoff data?
- How consistent are the company, industry, and country fields?
- Are there missing or incomplete values that need to be addressed?
- Can missing industry fields be intelligently filled based on existing data?
- How can the dataset be cleaned for time-series analysis?

---

## 🔍 Insights Summary
- **Data Accuracy Improved**: Duplicates were removed using advanced SQL window functions, ensuring only valid and unique records remain.
- **Consistent Labeling**: Inconsistent company, industry, and country names were standardized, making the dataset cleaner for segmentation.
- **Missing Data Recovery**: Null values in the `industry` column were filled using self-joins based on company name, recovering valuable classification.
- **Prepared for Time-Series Analysis**: Dates were converted from string format to proper SQL `DATE` type, enabling chronological trend analysis.
- **Ready for Dashboards & Models**: Clean and standardized structure allows the dataset to be plugged into dashboards and predictive models with ease.

---

## 🛠️ Tools Used
- **SQL**: MySQL Workbench
- **Window Functions**: `ROW_NUMBER()` for duplicate detection
- **String Functions**: `TRIM()`, `STR_TO_DATE()` for formatting cleanup
- **Joins & CTEs**: Used for data recovery and filtering

---

## 💼 Business Implications
- **Reliable Reporting**: Clean data supports trustworthy insights for stakeholders evaluating industry-wide layoff trends.
- **Operational Efficiency**: Removes data inconsistencies that could slow down reporting pipelines or introduce analytical errors.
- **Enhanced Strategy**: Improved dataset allows teams to drill down into layoff patterns by country, company stage, or funding levels—supporting HR, finance, or investor decisions.

---

## 👤 Author & Contact
**Author**: Akeira Green  
**LinkedIn**: www.linkedin.com/in/akeira-green

---

## ✅ Status
✅ Completed – Dataset is cleaned and ready for analysis or visualization tools like Tableau or Power BI.

