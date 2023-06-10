#!/bin/bash
mvn package -Dnative -Dquarkus.native.container-build=true
cp config/sam.native.yaml target/