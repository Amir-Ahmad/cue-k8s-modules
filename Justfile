# Print help
@help:
    just --list

@vet:
    find . -maxdepth 2 -name 'cue.mod' | xargs -I{} sh -c 'cd $(dirname "{}") && cue vet ./...'
    echo "Cue vet passed!"

# Run tests
test *args:
    cd {{justfile_directory()}}/test && gotestsum -f testname -- ./... -count=1 {{args}}

# Run tests with verbose output
test-verbose *args:
    cd {{justfile_directory()}}/test && gotestsum -f standard-verbose -- ./... -v -count=1 {{args}}
