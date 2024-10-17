#!/bin/bash
cp config/sam.native.yaml target/
cp config/samconfig.toml target/
cp config/samconfig.toml .
sam deploy -t target/sam.native.yaml