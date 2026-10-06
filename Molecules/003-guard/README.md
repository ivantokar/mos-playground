# Molecule #003 — guard: Keep the Main Path Flat

Companion executable for **guard: Keep the Main Path Flat**.

Article: https://ivantokar.com/posts/guard-keep-the-main-path-flat

## What it verifies

- a failed `guard` leaves the enclosing scope;
- optional bindings created by `guard` stay available after the statement;
- several requirements can be combined in one `guard`;
- `continue` can satisfy the exit requirement inside a loop;
- manual compiler experiments show the required control transfer and the scope difference from `if let`.

Run:

```sh
swift run molecule-003
```
