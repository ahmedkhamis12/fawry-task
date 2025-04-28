#!/bin/bash

# Usage function
usage() {
    echo "Usage: $0 [-n] [-v] search_string filename"
    exit 1
}

# Help option
if [[ "$1" == "--help" ]]; then
    echo "Mini grep version - mygrep.sh"
    echo "Usage: $0 [-n] [-v] search_string filename"
    echo "Options:"
    echo "  -n    Show line numbers"
    echo "  -v    Invert match (show non-matching lines)"
    echo "  --help Show this help message"
    exit 0
fi

# Variables
show_line_numbers=false
invert_match=false

# Parse options
while getopts ":nv" opt; do
  case $opt in
    n) show_line_numbers=true ;;
    v) invert_match=true ;;
    \?) usage ;;
  esac
done

# Shift parsed options
shift $((OPTIND -1))

# Remaining arguments
search_string=$1
filename=$2

# Validate input
if [[ -z "$search_string" || -z "$filename" ]]; then
    echo "Error: Missing search string or filename."
    usage
fi

if [[ ! -f "$filename" ]]; then
    echo "Error: File '$filename' not found."
    exit 1
fi

# Build the grep command
grep_options="-i"

if $invert_match; then
    grep_options="$grep_options -v"
fi

if $show_line_numbers; then
    grep_options="$grep_options -n"
fi

# Run grep
grep $grep_options -- "$search_string" "$filename"
