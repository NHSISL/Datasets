# 1. PGISUS vs. Unified SUS (SWL Trusts only)

## 1.1. version history

| **Ver.** | **Date**    | **Revised By**  | **Status**    | **Comments**         |
| :------- | :---------- | :-------------- | :------------ | :------------------- |
| 0.1      | 23/05/2025  | Sridhar Peddi | ![Live](https://img.shields.io/badge/Status-Live-green) | Shared by South West London ICB |

## 1.2. Contents

- [1. PGISUS vs. Unified SUS (SWL Trusts only)](#%31%2E%2D%70%67%69%73%75%73%2D%76%73%2E%2D%75%6E%69%66%69%65%64%2D%73%75%73%2D%28%73%77%6C%2D%74%72%75%73%74%73%2D%6F%6E%6C%79%29)
  - [1.1. version history](#%31%2E%31%2E%2D%76%65%72%73%69%6F%6E%2D%68%69%73%74%6F%72%79)
  - [1.2. Contents](#%31%2E%32%2E%2D%63%6F%6E%74%65%6E%74%73)
  - [1.1. Summary](#%31%2E%31%2E%2D%73%75%6D%6D%61%72%79)
  - [1.2. General Indication](#%31%2E%32%2E%2D%67%65%6E%65%72%61%6C%2D%69%6E%64%69%63%61%74%69%6F%6E)
  - [1.3. Trends Over Time](#%31%2E%33%2E%2D%74%72%65%6E%64%73%2D%6F%76%65%72%2D%74%69%6D%65)
  - [1.4. Trust-Level Detail (2024/2025 Focus)](#%31%2E%34%2E%2D%74%72%75%73%74%2D%6C%65%76%65%6C%2D%64%65%74%61%69%6C%2D%28%32%30%32%34%2F%32%30%32%35%2D%66%6F%63%75%73%29)
    - [1.4.1. Outpatients](#%31%2E%34%2E%31%2E%2D%6F%75%74%70%61%74%69%65%6E%74%73)
    - [1.4.2. Inpatients](#%31%2E%34%2E%32%2E%2D%69%6E%70%61%74%69%65%6E%74%73)
  - [1.5. Understanding the Differences](#%31%2E%35%2E%2D%75%6E%64%65%72%73%74%61%6E%64%69%6E%67%2D%74%68%65%2D%64%69%66%66%65%72%65%6E%63%65%73)
  - [1.6. Summary and Next Steps](#%31%2E%36%2E%2D%73%75%6D%6D%61%72%79%2D%61%6E%64%2D%6E%65%78%74%2D%73%74%65%70%73)
    - [1.6.1. Key Points](#%31%2E%36%2E%31%2E%2D%6B%65%79%2D%70%6F%69%6E%74%73)
    - [1.6.2. Next Steps](#%31%2E%36%2E%32%2E%2D%6E%65%78%74%2D%73%74%65%70%73)


## 1.1. Summary

This analysis reviews the consistency of Healthcare Resource Group (HRG) alignment between our local PGISUS system (specifically the `dv_HRG` field) and the national HRGs from Unified SUS data (`Core_HRG` for Outpatients and `Spell_Core_HRG` for Inpatients). The review spans financial years 2019/2020 to 2024/2025 and includes SWL Acute Trusts Kingston (RAX), Croydon (RJ6), St Georges (RJ7), Royal Marsden (RPY), and Epsom & St Helier (RVR).

The primary finding is positive: the systems show a high level of agreement, particularly for Inpatient care.

- For **Inpatients**, the alignment was even stronger, with a **99.91%** match. Only about 2,400 out of nearly 2.8 million records were different.
- For **Outpatients**, approximately **99.08%** of HRGs matched across all years. Out of roughly 20.1 million records, around 185,500 did not align.

This closer agreement suggests there may be an opportunity to streamline HRG grouping processes by relying more on Unified SUS HRGs. However, the discrepancies particularly in Outpatient data require further investigation before any changes are made.

## 1.2. General Indication

Across the majority of patient spells and appointments, both PGISUS and Unified SUS produce the same HRG. This provides a solid foundation and indicates that the national and local perspectives are largely aligned.

## 1.3. Trends Over Time

- **Inpatient Mismatches**: These have remained very low as a percentage of total activity. The number increased from 130 in 2019/20 to 704 in 2023/24, then slightly decreased to 572 in 2024/25. The match rate has consistently remained above 99.8%.
- **Outpatient Mismatches**: The trend is more variable. Mismatches dropped from over 20,000 in 2019/20 to around 8,000 in 2020/21, but have since increased annually, reaching over 58,000 in 2024/25. Although the match rate remains high (around 98.5% in 2024/25), the growing volume of differences is notable.

## 1.4. Trust-Level Detail (2024/2025 Focus)

### 1.4.1. Outpatients

- **RAX (99.94%)** and **RPY (99.86%)** showed strong alignment, with 382 and 707 mismatches respectively.
- **RJ6 (97.12%)** and **RVR (97.32%)** had over 20,000 mismatches each.
- **RJ7 (98.84%)** had over 13,000 mismatches.

While percentages remain high, the absolute number of mismatches in some trusts is significant and warrants attention (another issue)

### 1.4.2. Inpatients

- All trusts demonstrated very good consistency.
- **RVR (99.98%)** had only 15 mismatches; **RJ7 (99.97%)** had 46.
- **RPY (99.74%)** had the highest count at 249, still representing a very high agreement rate.
- **RAX (99.85%)** and **RJ6 (99.81%)** also had very few differences.

This shows that even with high percentages, the practical impact may vary depending on the volume of records involved.

## 1.5. Understanding the Differences

We currently know *how many* HRGs differ, but not *why*, although most of the OP mismatches for example at Croydon are around `NZ21Z`. The next step is to investigate the actual HRG codes that do not match. This will require a systematic approach.

We need to explore:

- Whether specific HRGs are consistently coded differently by PGISUS.
- If certain procedures or diagnoses are more prone to mismatches.
- Whether differences are minor (e.g. suffix variations) or entirely different HRGs.
- If one system has an HRG while the other has a blank or NULL value.

This will help determine whether the differences stem from grouper configurations, local rules in PGISUS, or data quality issues.

## 1.6. Summary and Next Steps

### 1.6.1. Key Points

1. PGISUS and Unified SUS HRGs are highly aligned, especially for Inpatients.
2. Outpatient mismatches are increasing and vary significantly by trust.
3. The root causes of mismatches are not yet fully understood.

### 1.6.2. Next Steps

1. **Investigate the Differences**: Each ICB have to begin their own exercise, with sampling or focus on the most frequent mismatches to identify common causes.
2. **Assess the Impact**: Determine whether mismatches affect payments or key reports.
3. **Review Local Pricing Rules**: Understand how a shift to Unified SUS grouping would affect local pricing logic currently handled by PGISUS.
4. **Propose a Simplified Approach**: Based on findings, outline a plan for transitioning away from PGISUS grouping to Unified SUS data more effectively, including required changes and expected benefits.
