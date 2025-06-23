# Print help
@help:
    just --list

# Run tests
test *args:
    cd {{justfile_directory()}}/test && gotestsum -f testname -- ./... -count=1 {{args}}

# Run tests with verbose output
test-verbose *args:
    cd {{justfile_directory()}}/test && gotestsum -f standard-verbose -- ./... -v -count=1 {{args}}
