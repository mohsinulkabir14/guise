# Prompt set (password-protected)

The 2,250 GUISE prompts are **not** stored here in plaintext. They are distributed as
`../guise_prompts.zip`, a password-protected archive, because they are written to elicit
operational criminal-assistance content from language models.

## Getting the password

Open an issue on this repository, or contact the authors, stating your name, affiliation, and
intended use. The password is shared with researchers working on safety evaluation,
refusal alignment, red-teaming, or guard-model development.

## Extracting

Run from the repository root:

```bash
unzip data/guise_prompts.zip
```

This restores the five CSVs into this directory:

```
data/prompts/guise_english.csv
data/prompts/guise_bengali.csv
data/prompts/guise_chinese.csv
data/prompts/guise_greek.csv
data/prompts/guise_levantine.csv
```

Column schemas and known data issues are documented in [`../README.md`](../README.md).

## Note on the encryption

The archive uses standard ZipCrypto so that it opens with any zip tool and no extra software.
This gates the data against casual browsing, scraping, and automated crawlers. It is *not*
strong encryption and is not intended as a security control.
