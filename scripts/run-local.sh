#!/bin/bash
cp config/sam.native.yaml target/
cp config/samconfig.toml target/
sam local start-api --template target/sam.native.yaml