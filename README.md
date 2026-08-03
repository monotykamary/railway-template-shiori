# Shiori on Railway

Deploy Shiori 1.8.0 with generated owner credentials and durable bookmarks, archives, thumbnails, ebooks, sessions, and SQLite state.

The Deploy on Railway button is added after the published route is verified.

## Sign in

Use `SHIORI_ADMIN_USER` and the generated `SHIORI_ADMIN_PASSWORD`. The adapter replaces the upstream `shiori` / `gopher` first-run credential through Shiori's authenticated API before marking initialization complete.

## Topology

One Shiori service stores all state under `/data` on a daily-backed-up volume. The session secret is generated once by Railway. This SQLite topology is intentionally one replica; do not scale horizontally.

## Updating

Back up the volume, update the pinned Shiori and Debian digests deliberately, then repeat owner login, bookmark create/read/delete, archive behavior, persistence, and redeploy soak tests.

## Upstream

- Source: https://github.com/go-shiori/shiori/tree/v1.8.0
- Release: https://github.com/go-shiori/shiori/releases/tag/v1.8.0
- License: MIT

This repository contains Railway adapters and documentation. Shiori remains copyright its upstream contributors and is not affiliated with Railway.
