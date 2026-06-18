FROM --platform=linux/amd64 debian:trixie-slim

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends unzip openssl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY metis-binary-x86_64-unknown-linux-gnu.zip .
RUN unzip -q metis-binary-x86_64-unknown-linux-gnu.zip \
    && rm metis-binary-x86_64-unknown-linux-gnu.zip \
    && chmod +x metis-binary

ENV RUST_LOG=info

CMD ["/app/metis-binary"]
