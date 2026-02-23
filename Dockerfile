# --- Stage 1: The Builder ---
FROM alpine:3.23 AS builder

# Install build dependencies
RUN apk add --no-cache \
    build-base \
    cmake \
    make \
    ncurses-dev \
    openssl-dev \
    libpcap-dev \
    curl \
    tar

# Define the SIPp version
ARG SIPP_VERSION=v3.7.7
ENV SIPP_VERSION=${SIPP_VERSION}

# Download and extract the source tarball
WORKDIR /src
RUN curl -L https://github.com/SIPp/sipp/releases/download/${SIPP_VERSION}/sipp-${SIPP_VERSION#v}.tar.gz | tar xz --strip-components=1

# Compile with TLS support
RUN mkdir build && cd build \
    && cmake .. -DUSE_SSL=KL -DUSE_PCAP=1 \
    && make

# --- Stage 2: The Final Minimal Image ---
FROM alpine:3.23

# Install only essential runtime libraries
RUN apk add --no-cache \
    libstdc++ \
    ncurses-libs \
    openssl \
    libpcap

# Copy only the binary
COPY --from=builder /src/build/sipp /usr/local/bin/sipp

ENTRYPOINT ["sipp"]
CMD ["-h"]