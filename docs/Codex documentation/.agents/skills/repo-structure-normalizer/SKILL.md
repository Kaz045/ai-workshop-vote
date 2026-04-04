---
name: repo-structure-normalizer
description: Use when the user explicitly wants to standardize a project's non-code structure from either requirements-only documents or an existing codebase. Inspect the current workspace, then create or update README.md, structures.md, docs/ notes, and support directories without changing application code, tests, runtime settings, or moving code files.
---

# Repo Structure Normalizer

Standardize a project's non-code structure while leaving code behavior alone.

This skill supports two situations:

- Requirements-first projects with little or no code yet
- In-progress projects that already have meaningful code, tests, settings, or layout

This skill is explicit-only in intent. If the user invokes it, treat that as permission to apply the skill within the allowed boundaries. Do not re-ask whether to apply the standard. Inspect the workspace only to determine the safest way to do so.

## Quick start

1. Inspect the workspace root, major config files, existing docs, and top-level directories.
2. Classify the project as either `initial` or `in-progress`.
3. Apply only safe non-code structural changes.
4. Summarize created or updated files plus any remaining structural gaps that were documented instead of changed.

## Classification

- `initial`: requirements, notes, or planning docs exist, but application structure is sparse
- `in-progress`: meaningful code, tests, settings, or established directory conventions already exist

This classification decides the workflow. It does not decide whether the skill should be applied.

## Allowed changes

- Create or update `README.md`
- Create or update root-level `structures.md`
- Create or update `docs/` files that explain structure, workflow, or intended future layout
- Create non-code support directories when they clarify organization
- Add placeholder files such as `.gitkeep` when needed to preserve intentional empty folders
- Document current structure, intended structure, naming conventions, and mappings between them

## Forbidden changes

- Do not edit application, library, or test code
- Do not move, rename, or delete code files
- Do not change imports, module resolution, runtime settings, or dependency manifests
- Do not alter build, lint, test, deploy, or execution behavior
- Do not "clean up" an existing code layout by relocating files; document the preferred future shape instead

## Workflow

### 1. Inspect the workspace

Review only the context needed to understand structure:

- workspace root files
- main config files
- existing `README.md`, `structures.md`, and `docs/` content
- top-level directories
- representative code and test locations when present

### 2. Choose the mode

#### Initial project

Use this path when the workspace is mostly requirements and planning material.

- Build the smallest useful documentation scaffold
- Create a concise `README.md` from the available requirements and project intent
- Create `structures.md` that defines the intended layout and placement rules
- Create `docs/` only when it materially improves navigation or planning clarity
- Create empty non-code support directories only when they match the documented structure
- Avoid inventing framework-specific folders without evidence from the requirements or existing config

#### In-progress project

Use this path when the workspace already contains a real codebase or established layout.

- Preserve existing code placement
- Update or add `README.md` so the current structure is understandable
- Create or update `structures.md` to describe current layout, folder responsibilities, conventions, and future placement guidance
- If current and intended layouts differ, document the mapping and future direction instead of moving files
- Prefer additive edits and careful consolidation over wholesale doc rewrites

## Artifact guidance

Read [references/document-artifacts.md](references/document-artifacts.md) when drafting or revising documentation artifacts.

Minimum outputs when useful:

- `README.md`: project purpose, current scope, major areas, and links to deeper docs
- `structures.md`: current layout, folder responsibilities, placement rules, and future structure guidance
- `docs/` notes: only for content that would clutter root-level docs

## Decision rules

- Explicit invocation means "standardize this project now within the allowed boundaries"
- Optimize for clarity and consistency, not abstract ideal architecture
- Prefer the repo's existing patterns over generic best practices
- If the ideal structure would require destructive changes, do not perform them; document them
- If the workspace is very sparse, produce the smallest scaffold that still gives clear direction
- If existing docs conflict, preserve intent and clarify; avoid aggressive deletion

## Completion criteria

Stop when all of the following are true:

- the project structure is understandable from the generated or updated docs
- future contributors can tell where to add new non-code artifacts
- no code or runtime behavior has been changed
- the final summary distinguishes applied changes from documented future recommendations
