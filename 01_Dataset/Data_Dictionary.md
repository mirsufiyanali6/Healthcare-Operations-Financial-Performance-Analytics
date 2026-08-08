# Data Dictionary

Source file: `01_Dataset/healthcare_dataset.csv` — 55,500 raw rows / 15 columns; 54,966 rows after removing 534 exact duplicates. No null values in any column.

| Column (raw CSV) | Column (cleaned, SQL) | Type | Description | Example | Notes |
|---|---|---|---|---|---|
| Name | name | Text | Patient name | Bobby Jackson | Standardized to title case during cleaning; not a unique patient key — 40,235 distinct names across 54,966 rows |
| Age | age | Integer | Patient age in years | 30 | Range 13–89 |
| Gender | gender | Text | Patient gender | Male / Female | Two categories, roughly even split |
| Blood Type | blood_type | Text | Patient blood type | B- | 8 standard blood types (A+, A-, B+, B-, AB+, AB-, O+, O-) |
| Medical Condition | medical_condition | Text | Primary diagnosed condition | Cancer | 6 categories: Arthritis, Cancer, Diabetes, Hypertension, Obesity, Asthma |
| Date of Admission | date_of_admission | Date | Date patient was admitted | 2024-01-31 | Parsed to datetime during cleaning |
| Doctor | doctor | Text | Attending doctor's name | Matthew Smith | ~40,341 distinct names — most appear only once or twice |
| Hospital | hospital | Text | Admitting hospital/facility name | Sons and Miller | ~39,876 distinct names — most appear only once or twice; treat hospital-level comparisons as illustrative, not high-confidence rankings |
| Insurance Provider | insurance_provider | Text | Patient's insurance provider | Blue Cross | 5 categories: Aetna, Blue Cross, Cigna, Medicare, UnitedHealthcare — each covers ~20% of patients |
| Billing Amount | billing_amount | Decimal | Total billed amount for the admission | 18856.28 | Range -$2,008 to $52,764; 106 records are negative — flagged as a data quality issue, not excluded from totals |
| Room Number | room_number | Integer | Assigned room number | 328 | No fixed range enforced in source data |
| Admission Type | admission_type | Text | Type of admission | Urgent | 3 categories: Elective, Emergency, Urgent — each ~33% of records |
| Discharge Date | discharge_date | Date | Date patient was discharged | 2024-02-02 | Parsed to datetime during cleaning; used with date_of_admission to derive length_of_stay |
| Medication | medication | Text | Medication prescribed | Paracetamol | 5 categories: Aspirin, Ibuprofen, Lipitor, Paracetamol, Penicillin |
| Test Results | test_results | Text | Lab test outcome | Normal | 3 categories: Abnormal, Normal, Inconclusive — each ~33% of records |

## Derived fields (added during Python/SQL processing)

| Field | Type | Description | Formula |
|---|---|---|---|
| length_of_stay | Integer | Days between admission and discharge | `discharge_date - date_of_admission` |
| age_group | Text | Age bucketed into 5 bands | 0–18, 19–35, 36–50, 51–65, 65+ |

## Known data quality notes

- **534 duplicate rows** removed during cleaning (55,500 → 54,966); source had no null values in any column.
- **106 negative billing amounts** (down to -$2,008) — likely refund/adjustment entries miscoded as charges; not excluded from revenue totals, but should be resolved before this data is used for real financial reporting.
- **Near-unique hospital and doctor names** (39,876 and 40,341 distinct values across 54,966 rows) and **statistically flat distributions** across admission type, insurance provider, and test results are consistent with a synthetic, randomly generated dataset rather than real operational history. Full detail in `05_Documentation/Healthcare_Business_Conclusion_Report.pdf`.
