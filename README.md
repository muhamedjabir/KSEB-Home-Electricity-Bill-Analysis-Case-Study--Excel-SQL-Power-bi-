# KSEB-Home-Electricity-Bill-Analysis-Case-Study--Excel-SQL-Power-bi-

- My home electricity bills kept going up every summer and I wanted to actually understand why — not just guess. So I turned 8 months of KSEB bills into a proper data project.

- This covers **January 2025 to March 2026** — 455 days, 4,256 kWh, Rs.36,204 spent across 8 bi-monthly billing cycles for a 5-member household in Kondotty, Kerala.



## What I did

- Pulled all values from original KSEB PDF bills and structured them in Excel. Ran SQL queries in MySQL to validate and dig into the numbers. Built a 4-page Power BI dashboard to visualise everything.

PDF Bills → Excel → MySQL → Power BI

## Dataset

- 16 columns — billing period, season, meter type, Normal/Off-Peak/Peak units, energy charge, fixed charge, electricity duty, FSM refund, meter rent, bill total.

- One thing worth noting: the meter changed from Cumulative to TOD in April 2025, so the first bill has no TOD split. I flagged that in the analysis and excluded it from TOD comparisons.


## I get

- Summer bills (3 ACs running) came to Rs.21,676 — that's 60% of the entire year's spend
- The Mar–Apr 2026 bill hit Rs.12,016, up 338% from the previous period. 1,122 kWh in 60 days.
- Monsoon naturally brings bills down. Jul–Aug 2025 was just Rs.1,995 — lowest of the whole period
- Peak hour usage (6–10 PM) stayed around 16% consistently, which is actually good
- The slab tariff makes bills grow faster than consumption. Units went up 73% in Nov–Dec 2025 but the bill jumped 149%
- 82.5% of every bill is just the energy charge. Everything else is mostly fixed

## Power BI Dashboard

4 pages:
- Overview — KPIs, seasonal bar chart, TOD donut, trend line across all 8 periods
- Consumption & Cost — TOD units comparison by billing period
- Detailed Data View — full matrix table with conditional formatting
- All values cross-checked against SQL output
