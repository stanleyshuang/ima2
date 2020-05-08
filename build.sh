#!/usr/bin/env bash
base_dir=$(dirname "$0")

echo "Building mirai VM..."

echo "cd $base_dir"
      cd $base_dir

echo "vagrant up mirai"
      vagrant up mirai
