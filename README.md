# 🧼 SQL Data Cleaning Project – Layoffs Dataset

This project focuses on cleaning and preparing a real-world dataset on company layoffs for analysis using MySQL. The goal was to ensure the data is consistent, reliable, and analysis-ready by following key data cleaning steps.

## 🗂️ Dataset Overview

The dataset includes information about layoffs across various companies and industries, including:

- Company name
- Location
- Industry
- Total laid off
- Percentage laid off
- Date
- Stage
- Country
- Funds raised

---

## 🛠️ Cleaning Steps Performed

1. **Duplicate Removal**
   - Identified and removed exact duplicates using `ROW_NUMBER()` and CTEs.

2. **Data Standardization**
   - Trimmed whitespace from text fields (e.g., company names).
   - Normalized values for industry and country fields.
   - Converted the `date` column from text to `DATE` format using `STR_TO_DATE()`.

3. **Handling Missing Values**
   - Detected and removed rows with completely missing layoff data.
   - Used a self-join strategy to populate missing `industry` values based on known company matches.
   - Replaced blank strings with `NULL` for clarity.

4. **Column Cleanup**
   - Removed intermediate columns like `row_num` once they were no longer needed.

---

## 📊 Tools Used

- **Database:** MySQL
- **Techniques:** CTEs, `ROW_NUMBER()`, string functions (`TRIM`, `LIKE`), date conversion, self joins.

---

## ✅ Outcome

A clean and consistent dataset is now ready for further analysis, visualization, or use in a BI tool.

---

## 📁 Project Structure


---

## 👤 Author

- Akeira Green
- @akeiragreen

---

## 🔍 Next Steps

- Perform exploratory data analysis (EDA).
- Load into Power BI or Tableau for visualization.
- Integrate with time-series analysis for trend insights.

