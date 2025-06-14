# 🧹 SQL Data Cleaning Project: Layoff Records

## 🦋 Butterfly Effect Format: Small Fixes, Big Impact

Cleaning a messy dataset may seem like a minor backend task — but behind every reliable dashboard, trendline, or executive report lies structured, trusted data. This project showcases how a series of precise SQL transformations can transform chaotic layoff records into a foundation for strategic business insight.

---

## 📌 Project Overview

This SQL project cleans and prepares a global dataset of company layoffs for accurate analysis. The original dataset was riddled with duplicates, nulls, inconsistent labels, and poorly formatted values — all of which could distort downstream insights. Using MySQL, the data was refined to support time-series analysis, reporting automation, and integration into BI tools.

---

## 📊 Dataset Description

Key columns included in the raw dataset:

- `company`: Name of the company executing layoffs  
- `location`: City or region of the company  
- `industry`: Sector the company operates in  
- `total_laid_off`: Number of employees laid off  
- `percentage_laid_off`: Proportion of workforce laid off  
- `date`: Reported date of layoff  
- `stage`: Company’s business or funding stage (e.g., Series A, Public)  
- `country`: Country of operations  
- `funds_raised_millions`: Capital raised in millions  

---

## ❓ Business Questions Addressed

- Are there duplicate records in the layoff data?
- How consistent are values in the `company`, `industry`, and `country` fields?
- Can missing or null fields (especially `industry`) be intelligently recovered?
- Is the dataset structured for reliable time-series analysis?
- Can the dataset now support BI tools like Tableau or Power BI?

---

## 🔍 Insights Summary

- **Data Accuracy Improved**:  
  Duplicates removed using `ROW_NUMBER()` in SQL window functions — ensuring one unique record per event.

- **Label Consistency Restored**:  
  Inconsistent entries in `company`, `industry`, and `country` were standardized for clarity and grouping.

- **Missing Data Recovered**:  
  `industry` nulls filled using self-joins on `company` names, restoring critical classification.

- **Time-Series Ready**:  
  Converted text-based dates to proper SQL `DATE` format, enabling chronological sorting and forecasting.

- **Dashboard-Compatible**:  
  Output is now structured for seamless plug-in to visualization tools or predictive modeling workflows.

---

## 🛠️ Tools & Techniques Used

- **SQL Platform**: MySQL Workbench  
- **Window Functions**: `ROW_NUMBER()` for de-duplication  
- **String Functions**: `TRIM()`, `STR_TO_DATE()` for formatting  
- **Joins & CTEs**: To recover and enrich incomplete data  

---

## 💼 Business Implications

- **Trustworthy Reporting**:  
  Clean dataset ensures confident decision-making in volatile job markets.

- **Operational Efficiency**:  
  Reduces rework and accelerates the data-to-insight pipeline for analysts.

- **Strategic Planning**:  
  Enables drill-down into trends by region, funding stage, or sector for HR, finance, and investor use cases.

---

## 👤 Author & Contact

**Author**: Akeira Green  
**LinkedIn**: [www.linkedin.com/in/akeira-green](https://www.linkedin.com/in/akeira-green)

---

## ✅ Project Status

**✅ Completed** – Dataset is cleaned, validated, and ready for use in analytics platforms like Tableau, Power BI, or SQL-driven dashboards.

