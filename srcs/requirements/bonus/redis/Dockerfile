FROM            debian:bullseye

RUN             apt update && apt install -y redis-server

CMD             ["redis-server", "--protected-mode", "no"]
