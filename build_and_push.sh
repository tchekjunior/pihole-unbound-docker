#!/bin/bash
# Run this once: docker buildx create --use --name build --node build --driver-opt network=host
docker buildx build --platform linux/arm/v7,linux/arm64/v8,linux/amd64 -t tchekjunior/pihole-unbound-docker:2021.12.20 --push .
docker buildx build --platform linux/arm/v7,linux/arm64/v8,linux/amd64 -t tchekjunior/pihole-unbound-docker:latest --push .


