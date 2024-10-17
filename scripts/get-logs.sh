#!/bin/bash
cp config/samconfig.toml .
sam logs --stack-name ServerlessApi
