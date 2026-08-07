# Business Problem Statement

## Background

A multi-hospital network admits patients across many facilities, doctors, and insurance providers. Admissions, billing, and clinical outcome data currently exist as a single flat extract with no analytical layer on top — there is no consolidated view of who is being treated, what it costs, or whether common operational assumptions (e.g. "emergency admissions cost more," "longer stays cost more") actually hold up under scrutiny.

## Business Objective

Answer, in one place: which age groups and conditions drive admission volume, which conditions, hospitals, and insurers drive billing revenue, whether admission type or gender meaningfully affect cost and length of stay, and whether the underlying data is reliable enough to support real financial and operational decisions.

## Workstreams

**Problem 1 — Patient Demographics & Care Volume**
Identify which age groups, medical conditions, and blood types drive admission volume.

**Problem 2 — Cost & Revenue Analysis**
Determine which conditions, hospitals, and insurance providers drive billing revenue, and whether admission type affects average cost.

**Problem 3 — Hospital & Provider Performance**
Compare hospitals and doctors on patient volume, revenue, and average length of stay.

**Problem 4 — Statistical Validation**
Test whether commonly assumed cost and stay drivers (admission type, gender) are statistically significant, rather than accepting them at face value.

**Problem 5 — Data Quality Assessment**
Identify structural issues — duplicate records, negative billing values, distribution anomalies — that would undermine trust in the findings if left unaddressed.

## Final Deliverable

A single-page Power BI executive dashboard (`04_PowerBI/`), backed by SQL Server business-question queries (`02_SQL/`), Python data cleaning and statistical testing (`03_Python/`), and a full business conclusion report (`05_Documentation/Healthcare_Business_Conclusion_Report.pdf`) covering methodology, findings, and data quality caveats.
