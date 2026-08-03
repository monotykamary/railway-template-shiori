# Deploy and Host Shiori on Railway

## About Hosting Shiori

Shiori is a simple self-hosted bookmark manager that stores links, tags, excerpts, archives, thumbnails, and ebooks. This template deploys stable version 1.8.0 with a generated owner account and durable SQLite-backed storage.

Sign in with `SHIORI_ADMIN_USER` and the generated `SHIORI_ADMIN_PASSWORD` service variable.

## Common Use Cases

- Save and tag private bookmarks
- Preserve readable copies and page archives
- Import or export browser and Pocket bookmark collections

## Dependencies for Shiori Hosting

### Deployment Dependencies

- One Shiori service with a daily-backed-up persistent volume
- Railway managed HTTPS

### Implementation Details

The adapter starts Shiori, replaces its documented first-run credential through the authenticated v1 API, stores a stable session secret, and persists all application data under `/data`. Public account registration is not opened.

This is a one-replica SQLite topology. Do not scale horizontally.

## Why Deploy Shiori on Railway?

Railway provides managed HTTPS, generated owner credentials, persistent storage with backups, health checks, and Git-driven rollouts for a private bookmark archive.
