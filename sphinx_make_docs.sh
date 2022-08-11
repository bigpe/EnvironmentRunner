#!/bin/bash

cd docs || exit
make html
cd - &> /dev/null || exit