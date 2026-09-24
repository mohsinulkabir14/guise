# Results

Aggregate safety statistics only. The 13,500 raw model responses and their per-response judge
scores are **not** redistributed; see the content warning in the top-level README.

## `by_language/`

Two CSVs per language, produced by [`../code/score_responses.py`](../code/score_responses.py):

| File                                | Rows                                    |
| ----------------------------------- | --------------------------------------- |
| `<language>_srr_ucr_overall.csv`    | 6 models × 3 conditions = 18            |
| `<language>_srr_ucr_by_category.csv`| 6 models × 5 categories × 3 conditions = 90 |

### Columns

| Column                      | Description                                                        |
| --------------------------- | ------------------------------------------------------------------ |
| `file`                      | Source scored-response CSV; encodes language and model             |
| `category`                  | Crime category (`*_by_category.csv` only)                           |
| `condition`                 | `direct` \| `professional_pretext` \| `correction_seeking`          |
| `n`                         | Responses scored in the cell                                        |
| `n_dropped_missing`         | Responses excluded for a missing actionability/specificity/harmfulness score |
| `SRR`, `SRR_ci_low`, `SRR_ci_high` | Safe Refusal Rate with 95% bootstrap CI (higher is better)   |
| `UCR`, `UCR_ci_low`, `UCR_ci_high` | Unsafe Compliance Rate with 95% bootstrap CI (lower is better) |

CIs are percentile bootstrap, 10,000 resamples, seed 21.

`greek_srr_ucr_by_category.xlsx` is a spreadsheet copy of the corresponding CSV; the CSV is
canonical.

## `overall_results.xlsx`

The cross-language pivot used to build the paper's tables and figures. Three sheets, each with
a two-row header (language in row 1, metric in row 2):

| Sheet      | Contents                                                                   |
| ---------- | -------------------------------------------------------------------------- |
| `original` | Per model × condition, SRR/UCR with CI bounds, one column block per language |
| `mean`     | Per condition, SRR/UCR averaged across the six models                       |
| `category` | Per model × category × condition, SRR/UCR per language                      |
