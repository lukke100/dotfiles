#!/bin/bash
stow $@ -vt ~ */ --ignore='\.ignore\.[^/]*'
