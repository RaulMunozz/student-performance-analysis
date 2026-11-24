# Student Performance Analysis

R scripts from the DAT 115 final project. They analyse a student performance
dataset using linear regression, decision trees (C5.0) and k-means clustering,
with train/test splits, RMSE evaluation and ggplot2 visualisations.

## Contents

- `Perfomance_FinalProject_RaulMunozLopez.R` — main analysis
- Other `.R` files — homeworks and earlier exercises
- `.csv` files — datasets used by the scripts

Open the project in RStudio and run the scripts from the project directory. The
main script now checks that its CSV file exists before reading it.

## Dependencies

The scripts use base R plus `ggplot2`, `C50`, `caret`, `randomForest`, `rpart`
and `pROC`. Package versions are not pinned; record `sessionInfo()` alongside
any results you publish so the environment is reproducible.

## Data handling

The CSV files are teaching/demo datasets included for coursework. Some contain
quasi-identifiers or sensitive-looking attributes (for example health,
relationship and demographic fields). They are included in this public
repository, so treat them as non-confidential test data only and do not add
real personal data. `read.csv` does not execute code from these files, but paths
are relative to the working directory: run the scripts from the repository root.

See `SECURITY.md` for the security scope and limitations.
