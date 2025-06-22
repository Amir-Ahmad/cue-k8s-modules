# Print help
@help:
    just --list

# Run tests
test:
    cd {{justfile_directory()}}/test && go test -v -count=1 ./...
