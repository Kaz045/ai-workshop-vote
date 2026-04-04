# Document Artifacts

Read this file only when drafting or revising output documents for the skill.

The goal is not to force every project into the same paperwork. The goal is to create the smallest set of documents that makes the workspace understandable and maintainable.

## README.md

Prefer a concise README. Include only sections that are justified by the current project state.

### Good sections for an initial project

- Purpose
- Current inputs such as requirements or planning docs
- Intended structure summary
- Where future work should go
- Links to `structures.md` or `docs/`

### Good sections for an in-progress project

- Purpose
- What already exists
- Major directories or subsystems
- Where to find structural guidance
- Minimal contributor orientation

Avoid turning the README into a full architecture spec.

## structures.md

Use `structures.md` as the canonical structure note.

Typical sections:

- Current structure snapshot
- Directory responsibilities
- Naming or placement rules
- Recommended locations for future files
- Differences between current and intended structure
- Mapping notes when legacy layout must remain in place

If the project is still early, emphasize intended layout. If the project is mature, emphasize current layout first and future guidance second.

## docs/

Create `docs/` files only when root-level documents would become noisy.

Good candidates:

- `docs/project-overview.md`
- `docs/structure-notes.md`
- `docs/future-layout.md`

Prefer literal file names over clever ones.

## Empty directories

Create empty support directories only when they are part of the documented structure and unlikely to confuse contributors.

Use `.gitkeep` only when the empty directory is intentional and should persist.

## Editing style

- Prefer updating an existing file over replacing it wholesale
- Keep headings literal and easy to scan
- Do not erase unclear historical context unless it is obviously obsolete noise
- If a strong structural mismatch exists, explain it instead of forcing a risky cleanup
