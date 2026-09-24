# Data

## `prompts/` — the GUISE prompt set

> **Password-protected.** The CSVs documented below are not in the repository as plaintext.
> They ship inside `guise_prompts.zip`; see [`prompts/README.md`](prompts/README.md) for how
> to request the password and extract them. The schema below describes the extracted files.

Five CSVs, one per language/culture setting, 150 rows each — **30 cases in each of the five
crime categories**, in every language. **Rows are positionally aligned across all five files**:
row *i* of every file is the same source case, the same category, and the same subgoal.

### Common columns

| Column             | Description                                                                 |
| ------------------ | --------------------------------------------------------------------------- |
| `news_id`          | Identifier of the source news article the case was drawn from                |
| `category`         | ICCS-aligned crime category (see the table in the top-level README)          |
| `selected_subgoal` | The single criminally relevant subgoal the prompt is built around (English)  |

### `guise_english.csv` (source)

| Column                        | Description                                                                          |
| ----------------------------- | ------------------------------------------------------------------------------------ |
| `direct`                      | Direct-request framing                                                                |
| `professional_pretext`        | Professional-pretext framing                                                          |
| `correction_seeking`          | Correction-seeking framing                                                            |
| `correction_distortion_notes` | What was deliberately distorted in the correction-seeking prompt, and the ground truth |

### `guise_bengali.csv`, `guise_chinese.csv`, `guise_greek.csv`, `guise_levantine.csv`

Prompt columns carry a language suffix: `_bn` (Bengali), `_zh` (Chinese),
`_el` (Greek), `_ar_ps` (Levantine / Palestinian Arabic).

| Column                        | Description                                                              |
| ----------------------------- | ------------------------------------------------------------------------ |
| `direct_<lang>`               | Culturally adapted direct request                                         |
| `professional_pretext_<lang>` | Culturally adapted professional pretext                                   |
| `correction_seeking_<lang>`   | Culturally adapted correction-seeking prompt                              |
| `adaptation_notes`            | What the adapter localised and why                                        |

`guise_greek.csv` additionally carries `direct_en`, a copy of the English source prompt kept
alongside the adaptation — redundant with `guise_english.csv`, which is authoritative (see
"Known issues").

The per-prompt validation ratings (fluency, cultural naturalness, harm equivalence) described
in the annotation guidelines were collected on a ~33% sample in a separate annotation sheet
and are not part of this release.

Adaptation and validation procedures are specified in
[`../docs/annotation_guidelines_cultural_adaptation.docx`](../docs/annotation_guidelines_cultural_adaptation.docx).

## `keywords/` — source-article collection

`keywords.csv` / `keywords.xlsx` — 135 search keywords with their `category` and
`iccs_section`, used in combination (e.g. *"murder case"* + *"court hearing"*) to crawl the 514
candidate news articles that were filtered down to 183 usable and sampled to 150.

---

## Known issues

These are properties of the released data, not of the loader — read them before joining or
aggregating.

1. **`news_id` is not unique.** `news_id` 329 appears twice in every file. The two rows are
   *distinct* fraud cases with different subgoals and different prompts — the collision is in
   the article identifier, not the content. **Join across languages by row position, not by
   `news_id`.**

2. **`guise_greek.csv`'s `direct_en` column is stale in two rows.** For `news_id` 417 it holds
   the professional-pretext text rather than the direct request, and for `news_id` 146 it holds
   an earlier wording of the direct request. The Greek prompts themselves (`direct_el`,
   `professional_pretext_el`, `correction_seeking_el`) are unaffected. `guise_english.csv` is
   the authoritative English source; treat `direct_en` as a convenience copy only.

3. **The released results predate this version of the prompt set.** The corrected files
   replace one fraud case (`news_id` 50) with one drug-trafficking case (`news_id` 436) to
   balance the categories at 30 each. Everything else — all other prompts, subgoals, and
   category labels — is unchanged. The SRR/UCR figures in `../results/` were computed before
   that swap; see [`../results/README.md`](../results/README.md).

### Resolved in this version

- **Category balance.** Every category now holds exactly 30 cases in every language
  (previously fraud 31, drug_trafficking 29).
- **Column shift on `news_id` 417.** The English row is now stored against the documented
  schema; the earlier file had every field shifted one column left.
