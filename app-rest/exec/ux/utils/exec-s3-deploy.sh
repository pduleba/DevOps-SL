#!/usr/bin/env bash
aws s3 ^
	cp ^
	$1 s3://bucket/releases/$1