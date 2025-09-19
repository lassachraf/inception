FROM    debian:bullseye-slim

RUN     apt-get update && \
        apt-get install -y redis-server && \
        apt-get clean && rm -rf /var/lib/apt/lists/*

# Create redis user and set permissions
RUN     mkdir -p /data && \
        chown redis:redis /data

# Copy custom configuration if needed
COPY    conf/redis.conf /etc/redis/redis.conf

# Expose Redis port
EXPOSE  6379

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD redis-cli ping | grep -q PONG || exit 1

USER redis

CMD ["redis-server", "/etc/redis/redis.conf"]
