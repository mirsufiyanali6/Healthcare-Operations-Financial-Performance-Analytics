# KPI Definitions

Definitions and formulas for every metric shown in the Power BI dashboard and the business conclusion report. All formulas run against `healthcare_data` after cleaning (duplicates removed, dates parsed).

| KPI | Definition | Formula | Notes |
|---|---|---|---|
| Total Admission Records | Count of admission rows analyzed | `COUNT(*)` | 54,966, after removing 534 exact duplicates from the 55,500 raw rows |
| Total Patients | Count of distinct patient names in the dashboard filter | `COUNT(DISTINCT name)` | 40,235 unique names vs. 54,966 total rows — a patient can appear more than once; the dashboard's "55K Total Patients" card counts rows, not unique patients |
| Total Doctors | Count of distinct doctor names | `COUNT(DISTINCT doctor)` | ~40,341 unique names across 54,966 rows — most doctors appear only once, consistent with a synthetic dataset |
| Total Hospitals | Count of distinct hospital names | `COUNT(DISTINCT hospital)` | ~39,876 unique names across 54,966 rows — same caveat as above; hospital-level "top performer" comparisons carry limited statistical weight |
| Total Revenue | Sum of all billing amounts | `SUM(billing_amount)` | $1.40bn; includes 106 negative entries (down to -$2,008) flagged as a data quality issue |
| Average Billing per Patient | Mean billing amount per admission | `AVG(billing_amount)` | $25,544; distribution is close to uniform, not right-skewed — no small cluster of high-cost outliers |
| Average Length of Stay | Mean days between admission and discharge | `AVG(discharge_date - date_of_admission)` | 15.5 days; range 1–30 days |
| Admission Type Split | % of admissions by type (Elective / Emergency / Urgent) | `COUNT(*) per type / COUNT(*) total` | Elective 33.6% / Urgent 33.5% / Emergency 32.9% — statistically flat |
| Insurance Coverage Distribution | % of patients by insurance provider | `COUNT(*) per provider / COUNT(*) total` | ~20% per provider across all 5 providers (Cigna, Medicare, UnitedHealthcare, Blue Cross, Aetna) — statistically flat |
| Test Result Distribution | % of records by lab result | `COUNT(*) per result / COUNT(*) total` | Abnormal 33.5% / Normal 33.3% / Inconclusive 33.1% — statistically flat |
| Monthly Revenue Trend | Total billing summed by admission month | `SUM(billing_amount) GROUP BY MONTH(date_of_admission)` | Peak admission month is August (4,785 admissions); revenue trend does not show a clear seasonal pattern beyond that |
| Duplicate Records Removed | Exact-duplicate rows dropped during cleaning | Pre-cleaning row count − post-cleaning row count | 534 (55,500 → 54,966) |
| Negative Billing Entries | Records with a billing amount below $0 | `COUNT(*) WHERE billing_amount < 0` | 106 records, minimum -$2,008 — flagged as a data quality issue, not excluded from totals above |
