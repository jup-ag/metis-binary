# Dockerfile to create a secure and minimal container image for the Metis binary.

# Base stage: Use a minimal Debian image
FROM --platform=linux/amd64 debian:bookworm-slim

# Set the working directory for subsequent instructions
WORKDIR /app

# Install necessary dependencies (unzip for extraction, openssl/ca-certificates for HTTPS/TLS).
# The apt cache is immediately cleaned to keep the final image size minimal.
RUN apt-get update \
    && apt-get install -y --no-install-recommends unzip openssl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy the binary zip file into the container
COPY ./metis-binary-x86_64-unknown-linux-gnu.zip ./metis-binary-x86_64-unknown-linux-gnu.zip

# Combine extraction, cleanup, and permission setting into a single layer for efficiency
RUN unzip metis-binary-x86_64-unknown-linux-gnu.zip \
    && rm metis-binary-x86_64-unknown-linux-gnu.zip \
    && chmod +x metis-binary

# Create a non-root user and switch to it for running the application, enhancing security
RUN useradd --no-create-home --shell /bin/false metisuser
USER metisuser

# Set environment variable for Rust logging verbosity
ENV RUST_LOG=info

# Define the default command to execute the binary when the container starts
CMD ["./metis-binary"]
