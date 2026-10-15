# Molecules of Swift — Companion Template Rules

Use this directory as the **canonical starting point** for every new molecule. Copy the two files to `Molecules/NNN-topic/`, fill the placeholders, register the executable in `Package.swift`, and keep the final chapter title and slug consistent with the article.

## Required structure

1. Keep the branded header, author, article and repository links.
2. Use numbered `// MARK: -` sections. The exact number of sections may grow with the topic; never delete established sections when editing a published molecule without explicit approval.
3. Teach progressively: WHAT, WHY, a small runnable example, exact expected output, and a concrete TRY experiment for each meaningful section.
4. Include a practical Swift micro-pattern, an Under the Hood detail, composition/trade-offs, and a conclusion. Use compiler experiments only when they teach a verified rule.
5. Examples must be educational and observable. `assert` can support verification but must **not replace explanation or visible output**.
6. Preserve existing code, comments, metadata and structure when revising an existing molecule. Prefer targeted additions; review the diff against the original.
7. Confirm technical claims against primary Swift sources; verify the actual Swift toolchain, `swift build`, `swift run molecule-NNN`, and GitHub CI. Never invent results.
8. README must describe the code that is **actually in main.swift**, not a planned version.
9. Read back every file from GitHub after writing. Keep changes in a dedicated branch and do not merge automatically.

## Editorial acceptance

A reader should be able to explain each example without reading the article first. No generic explanations that restate section titles, no vague “change one input” exercises, and no test-suite-style output as the primary teaching experience.

Before approval, check every section for technical correctness, clarity, practical value, and consistency with the companion article. If any check fails, keep the PR as draft.
