# 1. HRG Consistency Analysis: PGISUS vs. Unified SUS - SQL Scripts

## 1.1. version history

| **Ver.** | **Date**    | **Revised By**  | **Status**    | **Comments**         |
| :------- | :---------- | :-------------- | :------------ | :------------------- |
| 0.1      | 23/05/2025  | Sridhar Peddi | ![Live](https://img.shields.io/badge/Status-Live-green) | Shared by South West London ICB |

## 1.2. Contents

- [1. HRG Consistency Analysis: PGISUS vs. Unified SUS - SQL Scripts](#%31%2E%2D%68%72%67%2D%63%6F%6E%73%69%73%74%65%6E%63%79%2D%61%6E%61%6C%79%73%69%73%3A%2D%70%67%69%73%75%73%2D%76%73%2E%2D%75%6E%69%66%69%65%64%2D%73%75%73%2D%2D%2D%73%71%6C%2D%73%63%72%69%70%74%73)
  - [1.1. version history](#%31%2E%31%2E%2D%76%65%72%73%69%6F%6E%2D%68%69%73%74%6F%72%79)
  - [1.2. Contents](#%31%2E%32%2E%2D%63%6F%6E%74%65%6E%74%73)
  - [1.3. Overview](#%31%2E%33%2E%2D%6F%76%65%72%76%69%65%77)
  - [1.4. Scripts Included](#%31%2E%34%2E%2D%73%63%72%69%70%74%73%2D%69%6E%63%6C%75%64%65%64)
  - [1.5. Before You Start](#%31%2E%35%2E%2D%62%65%66%6F%72%65%2D%79%6F%75%2D%73%74%61%72%74)
  - [1.6. How to Use](#%31%2E%36%2E%2D%68%6F%77%2D%74%6F%2D%75%73%65)
  - [1.7. Understanding the Output:](#%31%2E%37%2E%2D%75%6E%64%65%72%73%74%61%6E%64%69%6E%67%2D%74%68%65%2D%6F%75%74%70%75%74%3A)
    - [1.7.1. `...aggregated_comparison...sql`](#%31%2E%37%2E%31%2E%2D%60%2E%2E%2E%61%67%67%72%65%67%61%74%65%64%5F%63%6F%6D%70%61%72%69%73%6F%6E%2E%2E%2E%73%71%6C%60)
    - [1.7.2. `...top_mismatched_hrg_pairs...sql`](#%31%2E%37%2E%32%2E%2D%60%2E%2E%2E%74%6F%70%5F%6D%69%73%6D%61%74%63%68%65%64%5F%68%72%67%5F%70%61%69%72%73%2E%2E%2E%73%71%6C%60)


## 1.3. Overview

These SQL scripts help compare HRGs from our local PGISUS system with national Unified SUS data. The goal is to see how well they match and find areas we could simplify.

## 1.4. Scripts Included

1. **`combined_hrg_aggregated_comparison_with_rates.sql`**
    * **What it does:** Counts total records, mismatches, and calculates match/mismatch percentages. Gives a summary by Outpatient/Inpatient, Financial Year, and Trust.
    * **Use it for:** Getting an overview of how consistent HRGs are, seeing trends, and comparing Trusts.

1. **`combined_top_mismatched_hrg_pairs.sql`**
    * **What it does:** Lists the actual HRG codes that do not match between the two systems and how often each specific mismatch occurs.
    * **Use it for:** Looking closer at *why* HRGs are different. Helps find common patterns in the mismatches.

## 1.5. Before You Start

* You need access to the `SUS` database. Specifically the tables:
  * `SUS.OP.EncounterDenormalised_DateRange` and
  * `SUS.IP.EncounterDenormalised_DateRange`.
* You will need an SQL tool (like SSMS, DBeaver, etc.) to run these.

## 1.6. How to Use

1. **Open the Script:** Load the `.sql` file you want to use into your SQL tool.
2. **Check Filters (Important!):**
    * **Years:** Inside the script, look for `WHERE dv_FinYear IN (...)`. Change the years if you need to analyse a different period.
    * **Trusts:** Look for `WHERE Organisation_Code_Code_of_Provider IN (...)`. Change the Trust codes if needed.
    * **Table Paths:** Make sure `SUS.OP...` and `SUS.IP...` match your database setup.
3. **Run the Script:** Execute the SQL.
4. **Get Results:** The output will appear in your SQL tool. You can copy this or export it (e.g., to CSV or Excel) for reports or charts.

## 1.7. Understanding the Output:

### 1.7.1. `...aggregated_comparison...sql`

* `DataType`: Outpatient/Inpatient
* `dv_FinYear`: Financial Year
* `Trust`: Trust Code
* `TotalRecords`: Total activity
* `MismatchedRecords`: How many HRGs did not match
* `MatchPercentage`: % of HRGs that matched
* `MismatchRate`: % of HRGs that did NOT match

### 1.7.2. `...top_mismatched_hrg_pairs...sql`

* `DataType`, `DataSource`, `dv_FinYear`, `Trust`: As above
* `SUS_Plus_HRG`: The HRG from Unified SUS
* `PGISUS_dv_HRG`: The HRG from PGISUS
* `CountOfMismatchPair`: How many times this specific pair of different HRGs occurred.
