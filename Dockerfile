# Use Alpine as a minimal base image
FROM alpine:3.20

# Install necessary dependencies
# wget for downloading, libpcap for sipp to run with PCAP support
RUN apk add --no-cache \
    wget \
    libpcap \
    openssl-dev \
    ncurses-dev

# Set build arguments for SIPp version
ARG SIPP_VERSION
ENV SIPP_VERSION=${SIPP_VERSION}

# Download the official SIPp binary, make it executable, and move to /usr/local/bin
# RUN wget https://github.com/SIPp/sipp/releases/download/v${SIPP_VERSION}/sipp-v${SIPP_VERSION}.tar.gz -O /tmp/sipp.tar.gz && \
RUN wget https://github.com/SIPp/sipp/releases/download/${SIPP_VERSION}/sipp -O /usr/local/bin/sipp && \
    chmod +x /usr/local/bin/sipp

# Set the entrypoint to sipp
ENTRYPOINT ["sipp"]

# By default, display the help message
CMD ["-h"]
