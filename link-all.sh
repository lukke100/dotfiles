#!/bin/bash
stow --no-folding $@ -vt ~ */ --ignore='\.ignore\.[^/]*'
