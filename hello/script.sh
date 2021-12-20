#!/bin/ash
yq "$(cat filter.jq)" data.yaml
