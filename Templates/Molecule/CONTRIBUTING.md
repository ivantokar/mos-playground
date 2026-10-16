# Molecules of Swift — Companion Template Rules

Use this directory as the **canonical starting point** for every new molecule. Copy the two files to `Molecules/NNN-topic/`, fill the placeholders, register the executable in `Package.swift`, and keep the final chapter title and slug consistent with the article.

## Required structure

1. Keep the branded header, author, article and repository links.
2. Use numbered `// MARK: -` sections. The exact number of sections may grow with the topic; never delete established sections when editing a published molecule without explicit approval.
3. Choose a topic-specific learning progression rather than a fixed number or order of sections. Explain WHAT and WHY, demonstrate visible output, interpret that output, and provide a concrete TRY experiment for meaningful examples.
4. Include micro-patterns, language internals, composition, limitations and compiler experiments when they genuinely help teach this particular feature; do not force them into every lesson. End with a meaningful takeaway or experiment.
5. Examples must be educational and observable. Do not use `assert` as the lesson or mechanically convert assertions to unlabeled Boolean prints. Put automated verification outside the learning narrative.
6. Preserve existing code, comments, metadata and structure when revising an existing molecule. Prefer targeted additions; review the diff against the original.
7. Confirm technical claims against primary Swift sources; verify the actual Swift toolchain, `swift build`, `swift run molecule-NNN`, and GitHub CI. Never invent results.
8. README must describe the code that is **actually in main.swift**, not a planned version.
9. Read back every file from GitHub after writing. Keep changes in a dedicated branch and do not merge automatically.

## Editorial acceptance

A reader should be able to explain each example without reading the article first. No generic explanations that restate section titles, no vague “change one input” exercises, and no test-suite-style output as the primary teaching experience.

Before approval, check every section for technical correctness, clarity, practical value, and consistency with the companion article. If any check fails, keep the PR as draft.
