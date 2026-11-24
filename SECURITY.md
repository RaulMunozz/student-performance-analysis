# Security Policy

**Last reviewed:** 2026-11-24  
**Scope:** `RaulMunozz/student-performance-analysis` — offline R scripts and CSV datasets used for coursework.

## Architecture

- R scripts using base R, `ggplot2`, `C50`, `caret`, `randomForest`, `rpart` and `pROC`.
- Input files: eight CSV datasets read from relative paths in the repository root.
- No web server, API, database, authentication, sessions, cookies, network calls or user accounts.
- No command execution, dynamic code evaluation, deserialization or secret/token files.

## Applicability of OWASP controls

Web-specific categories do not apply: SQL injection, XSS, CSRF, SSRF, broken access control, IDOR, open redirects, mass assignment and session/authentication controls. There is no request/response cycle and no server-side input.

## Implemented protections

| Protection | Implementation |
|---|---|
| Fail-fast input check | `Perfomance_FinalProject_RaulMunozLopez.R` verifies that `student_perfomance.csv` exists before reading it and stops with a clear message otherwise. |
| No dynamic execution | No `eval`, `parse`, `system`, `shell`, `source` or `url`/`download.file` calls were found. |
| No secrets | No credentials, API keys, tokens or `.env` files are present. |
| Repository hygiene | `.gitignore` excludes `.Rhistory` and `.RData`. |

## Known limitations

- **Low — data sensitivity:** CSV columns include quasi-identifiers and sensitive-looking attributes such as `health`, `romantic`, demographic and school variables. The files appear to be public teaching datasets, not real customer data. Do not add real personal data to this repository.
- **Low — relative paths:** scripts depend on the working directory. A same-named CSV elsewhere could be read by mistake. Run from the repository root.
- **Low — reproducibility:** R packages are not pinned and there is no `renv.lock`. Record `sessionInfo()` with published results. Some homework scripts reference missing CSV files or objects; these are pre-existing functional issues, not security defects.
- **Informational — no automated tests:** verification here was static plus an R parser check; the statistical scripts were not re-run because doing so would overwrite plots/results and require all packages.

## Maintenance

- Keep datasets non-confidential and documented.
- Pin the R environment if results need to be reproducible.
- If a script ever downloads files, accepts command-line paths or reads untrusted archives, perform a new audit covering path validation, file size limits and code execution.

## Verification performed

- Source reviewed via GitHub API; local copy matched the remote blobs.
- Searches for network calls, shell execution, dynamic evaluation, secrets and SQL returned no matches.
- CSV headers reviewed for sensitive column names only; no row values were reproduced.
- R parser check run on the modified script.
