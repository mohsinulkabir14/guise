# Code

## `score_responses.py`

Canonical implementation of the SRR/UCR metrics with bootstrap confidence intervals. Run
`python score_responses.py --help` for the full interface; input schema and an example
invocation are in the top-level README.

## `scoring.ipynb`

The original Colab notebook the paper's numbers were produced with, kept for provenance.
`score_responses.py` is a direct port of it with the same metric definitions, thresholds,
bootstrap parameters, and RNG seed, minus the Google Drive mount and with two rough edges
fixed: output filenames are taken from `--prefix` rather than hardcoded to `chinese_*`, and
`--input-dir` / `--output-dir` are arguments rather than empty string literals. Prefer the
script.
