#!/usr/bin/env bash
mvn release:clean ^
	release:prepare ^
	release:perform ^
	-Paws