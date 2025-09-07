# sipp-alpine
A minimal Alpine Linux based Docker image for the SIPp traffic generator. This image is built by downloading the official sipp binary from the official SIPp releases.

## Overview
The primary goal of this repository is to provide a lightweight and up-to-date Docker image for SIPp. Instead of compiling from source, which can be time-consuming, this image downloads the latest stable, pre-compiled binary directly from the official SIPp GitHub releases.

This project automates the build and deployment process using GitHub Actions, publishing the resulting image to both GitHub Container Registry (GHCR) and Docker Hub.

## Features
Minimal Base Image: Uses alpine for a small footprint.

Official Binary: Downloads and uses the official sipp binary.

Automated Builds: CI/CD pipeline with GitHub Actions.

Multi-registry Support: Publishes to GHCR and Docker Hub.

Version Tagging: Images are tagged to match the SIPp release version.

## Usage
### Prerequisites
Docker installed on your system.

### Pulling the Image
You can pull the image from either GHCR or Docker Hub.

From Docker Hub:
```
docker pull YOUR_USERNAME/sipp-alpine:latest
```
From GHCR:
```
docker pull ghcr.io/YOUR_USERNAME/sipp-alpine:latest
```
### Running SIPp
To run SIPp using this Docker image, you can mount your scenario files into the container.
```
docker run --rm -it -v $(pwd)/scenarios:/scenarios YOUR_USERNAME/sipp-alpine -sf /scenarios/uac.xml <target_ip>
```
Where:

- `$(pwd)/scenario`s is the local directory containing your SIPp XML scenario files.
- `/scenarios` is the corresponding directory inside the container.
- `-sf /scenarios/uac.xml` tells SIPp to use the uac.xml scenario file.
- `<target_ip>` is the IP address of the SIP server you want to test.

### Building the Image Locally
If you need to build the image yourself, you can clone the repository and use the docker build command.
```
git clone [https://github.com/YOUR_USERNAME/sipp-alpine.git](https://github.com/YOUR_USERNAME/sipp-alpine.git)
cd sipp-alpine
docker build -t sipp-alpine .
```
You can also specify the SIPp version to build using a build argument:
```
docker build --build-arg SIPP_VERSION=3.6.1 -t sipp-alpine:3.6.1 .
```
## Contributing
Contributions are welcome! If you find a bug or have a suggestion, please open an issue or submit a pull request.

1. Fork the repository.
2. Create a new branch: git checkout -b my-feature-branch
3. Make your changes.
4. Commit your changes: git commit -am 'Add some feature'
5. Push to the branch: git push origin my-feature-branch
6. Submit a pull request.

## License
This project is licensed under the MIT License - see the LICENSE file for details.