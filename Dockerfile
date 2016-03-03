FROM postgres:9.4.5
MAINTAINER Ferdinand Hübner <ferdinand.huebner@bedag.ch>

COPY postgres.sh /postgres.sh
RUN chmod +x /postgres.sh && \
    chmod +x /docker-entrypoint.sh

VOLUME ["/var/lib/postgresql/data", "/etc/postgres-credentials"]

CMD ["/postgres.sh"]
