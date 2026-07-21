# cros2-3p-cluster

CROS2 domain-level **third-party umbrella** repository (`cluster`).

## Purpose

Host many application-layer third-party sources as subtrees under `src/`, so release builds do **not** create one Git repo per library and do **not** fetch public remotes at compile time.

- Domain scope: **cluster**
- Policy: `cros2-docs-governance/docs/15_THIRD_PARTY_DEPENDENCY_MAINTENANCE.md`
- Manifest: pin this repo once in `cros2-manifest/profiles/deps/cluster.repos` (for `base` use `base.repos`)

## Layout

```text
cros2-3p-cluster/
├── README.md
├── VERSIONS.md              # component → upstream tag / license / intake date
├── scripts/sync_component.sh
└── src/                     # one directory per third-party component
    └── .gitkeep
```

## Rules

1. Add components only via intake review (`THIRD_PARTY_INTAKE_TEMPLATE.md`).
2. Formal CI/air-gap builds use this company remote or an offline checkout — never GitHub.com upstream URLs.
3. Split a component into its own repo only for heavy forks, strict ACL, or independent release cadence.
4. Bump an umbrella tag/commit in `cros2-manifest` locks when any `src/*` changes.

## Sync (intake machine with network)

```bash
./scripts/sync_component.sh <component_name> <upstream_git_url> <tag_or_sha>
# then update VERSIONS.md and open PR
```
