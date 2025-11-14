FROM --platform=linux/amd64 debian:bookworm-slim

RUN apt-get update && apt-get install unzip openssl ca-certificates -y
COPY ./metis-binary-x86_64-unknown-linux-gnu.zip ./metis-binary-x86_64-unknown-linux-gnu.zip
RUN unzip metis-binary-x86_64-unknown-linux-gnu.zip
RUN rm metis-binary-x86_64-unknown-linux-gnu.zip
RUN chmod +x metis-binary

ENV RUST_LOG=info

CMD ["./metis-binary"]
