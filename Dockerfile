FROM ghcr.io/go-shiori/shiori:v1.8.0@sha256:36b8aa7db6a55979dd591f6520c22e7935ff136ba7028355c76235928d959e59 AS upstream
FROM docker.io/library/debian:bookworm-slim@sha256:63a496b5d3b99214b39f5ed70eb71a61e590a77979c79cbee4faf991f8c0783e
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl && rm -rf /var/lib/apt/lists/*
COPY --from=upstream /usr/bin/shiori /usr/bin/shiori
COPY entrypoint.sh /usr/local/bin/shiori-railway-entrypoint
RUN chmod +x /usr/local/bin/shiori-railway-entrypoint
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/shiori-railway-entrypoint"]
