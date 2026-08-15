ARG VERSION=2.35.3

# n8nio/n8n ships as a Docker Hardened Image without a package manager, so su-exec (needed to
# drop privileges after the runtime chown below) has to come from a regular Alpine build stage.
FROM alpine:3.24 AS su-exec
RUN apk add --no-cache su-exec

FROM n8nio/n8n:${VERSION}

# The upstream image bakes in USER node at build time, so nothing ever runs as root at
# container start. Railway mounts requiredMountPath fresh (root-owned) on first boot, which
# the node user then can't write to ("EACCES: permission denied, open '/home/node/.n8n/config'").
# su-exec lets railway-entrypoint.sh start as root, fix ownership, then drop privileges again.
USER root
COPY --from=su-exec /sbin/su-exec /usr/local/bin/su-exec

ENV N8N_HOST=0.0.0.0
ENV N8N_PROTOCOL=http

EXPOSE 5678

COPY railway-entrypoint.sh /usr/local/bin/railway-entrypoint.sh
RUN chmod +x /usr/local/bin/railway-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/railway-entrypoint.sh"]
CMD ["start"]
