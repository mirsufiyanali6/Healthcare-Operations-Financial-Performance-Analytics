# Healthcare Operations & Financial Performance

End-to-end healthcare analytics project: SQL Server → Python (EDA + statistical testing) → Power BI dashboard, covering 54,966 hospital admission records.

## The Business Problem

Hospital management needs a single, data-driven view of who they treat, what it costs, and where operational risk sits — which age groups drive care volume, which conditions and hospitals drive cost, whether admission type or gender meaningfully affect billing and length of stay, and where the underlying data itself has quality problems that would undermine that reporting.

Full write-up, methodology, and results: [`Healthcare_Business_Conclusion_Report.pdf`](./reports/Healthcare_Business_Conclusion_Report.pdf)

## What's in this repo

```
healthcare-operations-financial-performance/
├── data/
│   └── healthcare_dataset.csv
├── sql/
│   └── Healthcare_analysis.sql
├── notebooks/
│   ├── Exploratory_Data_Analysis.ipynb
│   └── Statistical_Analysis.ipynb
├── dashboard/
│   ├── Healthcare_Operations___Financial_Performance.pbix
│   ├── Healthcare_Operations___Financial_Performance_Dashboard.png
│   └── data_model.png
├── reports/
│   ├── Healthcare_Business_Conclusion_Report.docx
│   └── Healthcare_Business_Conclusion_Report.pdf
└── README.md
```

## Data Model

![Data model](./dashboard/data_model.png)

Single-table model: `healthcare_data` (patient, admission, billing, and clinical fields) loaded into SQL Server after Python cleaning, then imported directly into Power BI.

## Dashboard

**Healthcare Operations & Financial Performance** — one page, filterable by year, month, hospital, admission type, and insurance provider. Shows total doctors/hospitals/patients, average billing per patient, average length of stay, total revenue, monthly revenue trend, top 5 hospitals by revenue, insurance coverage split, and test result split.

![Dashboard](./dashboard/Healthcare_Operations___Financial_Performance_Dashboard.png)

## Key Findings

- **$1.40bn** total billing across **54,966** admission records (55,500 raw rows, 534 duplicates removed), averaging **$25,544** per patient and **15.5 days** per stay.
- **No meaningful correlation** between age, billing amount, and length of stay (r ≈ 0.00–0.01).
- **No significant difference** in billing between Emergency and Elective admissions (t-test, p = 0.47), and **no significant difference** in length of stay across admission types (ANOVA, p = 0.135).
- Gender and admission type show a statistically significant association (χ², p = 0.007), but the effect size is small enough (<3% gap between groups) to be practically negligible.
- Hospital, doctor, insurer, and test-result distributions are all close to uniform, and 39,876 of 54,966 rows have a unique hospital name — evidence this dataset is synthetic rather than real operational history, so hospital/doctor "leaderboards" should be read as illustrative, not as real business signal.
- 106 records carry negative billing amounts (down to -$2,008), flagged as a data-quality issue to resolve before this pipeline is used on real financial data.

Full detail, methodology, and caveats: [`Healthcare_Business_Conclusion_Report.pdf`](./reports/Healthcare_Business_Conclusion_Report.pdf)

## Tech Stack

SQL Server · Python (pandas, seaborn, matplotlib, scipy) · Power BI · Jupyter
