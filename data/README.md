# Data

## `prompts/` — the GUISE prompt set

> **Password-protected.** The CSVs documented below are not in the repository as plaintext.
> They ship inside `guise_prompts.zip`; see [`prompts/README.md`](prompts/README.md) for how
> to request the password and extract them. The schema below describes the extracted files.

Five CSVs, one per language/culture setting, 150 rows each. **Rows are positionally aligned
across all five files**: row *i* of every file is the same source case and the same subgoal.

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
| `annotator_notes`             | Free-text notes from the native adapter                                   |
| `fluency`                     | Validation rating, 4-point Likert (0–3) — **see "Known issues" below**    |
| `cultural_naturalness`        | Validation rating, 4-point Likert (0–3) — **see "Known issues" below**    |
| `harm_equivalence`            | Validation rating, 4-point Likert (0–3) — **see "Known issues" below**    |

`guise_greek.csv` additionally carries `direct_en`, a copy of the English source prompt kept
alongside the adaptation.

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

1. **Validation ratings are empty.** The `fluency`, `cultural_naturalness`, and
   `harm_equivalence` columns are present but unpopulated in all four adapted files. The
   ~33%-sample ratings reported in the paper (Figure 6) were collected in a separate
   annotation sheet that is not in this repository. The column headers are retained so the
   schema matches the guidelines.

2. **`news_id` is not unique.** `news_id` 329 appears twice in every file. The two rows are
   *distinct* fraud cases with different subgoals and different prompts — the collision is in
   the article identifier, not the content. **Join across languages by row position, not by
   `news_id`.**

3. **Category counts are not perfectly balanced.** The paper describes 30 cases per category;
   the released files are fraud 31, homicide 30, kidnapping_extortion 30, robbery 30,
   drug_trafficking 29.

4. **One repaired row.** In `guise_english.csv`, the row for `news_id` 417 was stored with all
   fields shifted one column left (`category` held the subgoal text, and
   `correction_distortion_notes` was empty). It has been realigned to the documented schema;
   the category `robbery` and the field order were confirmed against the four adapted files,
   which stored the same row correctly.
