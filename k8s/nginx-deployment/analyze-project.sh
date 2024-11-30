#!/bin/bash

# Enhanced Project Structure Analyzer Script

# Function to create directory structure
create_tree_structure() {
    local dir="$1"
    local output_file="$2"
    
    echo "# Project Structure Analysis" > "$output_file"
    echo "========================" >> "$output_file"
    echo "" >> "$output_file"
    
    echo "## Directory Structure" >> "$output_file"
    echo "\`\`\`" >> "$output_file"
    (cd "$dir" && find . -not -path '*/\.*' -not -path '*/node_modules/*' | sort | sed '1d;s/^\.//;s/\/\([^/]*\)$/|--\1/;s/\/[^/|]*/|  /g') >> "$output_file"
    echo "\`\`\`" >> "$output_file"
    echo "" >> "$output_file"
}

# Function to analyze file content
analyze_file_content() {
    local file="$1"
    local output_file="$2"
    local file_ext="${file##*.}"
    
    echo "### File: $(basename "$file")" >> "$output_file"
    echo "" >> "$output_file"
    
    # Choose appropriate markdown code block based on file extension
    case "$file_ext" in
        tf|tfvars)
            echo "\`\`\`hcl" >> "$output_file"
            ;;
        yaml|yml)
            echo "\`\`\`yaml" >> "$output_file"
            ;;
        tpl)
            echo "\`\`\`gotpl" >> "$output_file"
            ;;
        *)
            echo "\`\`\`" >> "$output_file"
            ;;
    esac
    
    cat "$file" >> "$output_file"
    echo "\`\`\`" >> "$output_file"
    echo "" >> "$output_file"
}

# Function to analyze directory
analyze_directory() {
    local dir="$1"
    local output_file="$2"
    
    echo "## Contents of directory: $dir" >> "$output_file"
    echo "" >> "$output_file"
    
    # Find all files in the directory (excluding hidden files and specific directories)
    find "$dir" -type f \
        -not -path '*/\.*' \
        -not -path '*/node_modules/*' \
        -not -name '*.tfstate' \
        -not -name '*.tfstate.*' \
        -not -path '*/.terraform/*' \
        | sort \
        | while read -r file; do
            analyze_file_content "$file" "$output_file"
        done
}

# Main execution
main() {
    local output_file="project_analysis.md"
    
    # Initialize the output file with the root directory's structure
    create_tree_structure "${1:-.}" "$output_file"
    
    # Process each directory argument
    for dir in "$@"; do
        if [ -d "$dir" ]; then
            analyze_directory "$dir" "$output_file"
        fi
    done
    
    echo "Analysis complete! Check $output_file for results."
}

# Run the script with provided directories
main "$@"