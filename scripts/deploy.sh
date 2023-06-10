#!/bin/bash
cp config/sam.native.yaml target/
cp config/samconfig.toml target/
sam deploy -t target/sam.native.yaml