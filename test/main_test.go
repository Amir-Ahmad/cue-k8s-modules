package test

import (
	"flag"
	"fmt"
	"io/fs"
	"maps"
	"os"
	"path/filepath"
	"regexp"
	"slices"
	"strings"
	"testing"

	"github.com/rogpeppe/go-internal/testscript"
)

var module string

func TestMain(m *testing.M) {
	flag.StringVar(&module, "module", "", "module to test")
	flag.Parse()
	testscript.Main(m, map[string]func(){})
}

// RegexFilterFS filters to files matching a regex
type RegexFilterFS struct {
	FS    fs.FS
	Regex regexp.Regexp
}

// implement fs.FS
func (e RegexFilterFS) Open(name string) (fs.File, error) {
	return e.FS.Open(name)
}

// ReadDir implements fs.ReadDirFS and filters to matching files
func (e RegexFilterFS) ReadDir(name string) ([]fs.DirEntry, error) {
	entries, err := fs.ReadDir(e.FS, name)
	if err != nil {
		return nil, err
	}

	// remove all files that don't match
	return slices.DeleteFunc(entries, func(entry fs.DirEntry) bool {
		return !entry.IsDir() && !e.Regex.MatchString(entry.Name())
	}), nil
}

// TestScript runs all testscript tests
func TestScript(t *testing.T) {
	cwd, err := os.Getwd()
	if err != nil {
		t.Fatalf("failed to get current directory: %v", err)
	}

	// if UPDATE_GOLDEN is set, golden test data will be updated.
	_, update := os.LookupEnv("UPDATE_GOLDEN")

	repoRoot := filepath.Join(cwd, "..")
	// if module is specified, only run tests within it
	testRoot := repoRoot
	if module != "" {
		testRoot = filepath.Join(repoRoot, module)
	}

	dirs, err := findDirectoriesWithTests(testRoot)
	if err != nil {
		t.Fatalf("failed to find test directories: %v", err)
	}

	modCache := cacheDir(t)

	for _, dir := range dirs {
		moduleName := getModuleName(t, repoRoot, dir)
		modulePath := filepath.Join(repoRoot, moduleName)

		t.Run(strings.TrimPrefix(dir, "/"), func(t *testing.T) {
			testscript.Run(t, testscript.Params{
				Setup:         setupTestEnvironment(modCache, modulePath),
				Dir:           dir,
				UpdateScripts: update,
			})
		})
	}
}

func getModuleName(t *testing.T, repoRoot, dir string) string {
	t.Helper()

	relativePath, err := filepath.Rel(repoRoot, dir)
	if err != nil {
		t.Fatalf("failed to get relative path: %v", err)
	}

	dirParts := strings.Split(relativePath, string(os.PathSeparator))
	if len(dirParts) < 2 {
		t.Fatalf("unexpected directory format: %s", relativePath)
	}

	return dirParts[0]
}

// cacheDir returns the cue cache directory, this will be used to cache modules in tests
func cacheDir(t *testing.T) string {
	t.Helper()

	if dir := os.Getenv("CUE_CACHE_DIR"); dir != "" {
		return dir
	}
	dir, err := os.UserCacheDir()
	if err != nil {
		t.Fatalf("failed to get system cache directory: %v", err)
	}
	return filepath.Join(dir, "cue")
}

func setupTestEnvironment(cacheDir, modulePath string) func(*testscript.Env) error {
	return func(env *testscript.Env) error {
		env.Vars = append(env.Vars,
			"CUE_REGISTRY=github.com/amir-ahmad=ghcr.io",
			"CUE_CACHE_DIR="+cacheDir,
		)

		regex := regexp.MustCompile(`^.*\.cue$`)

		// copy all cue files to test directory
		return os.CopyFS(env.WorkDir, RegexFilterFS{FS: os.DirFS(modulePath), Regex: *regex})
	}
}

// findDirectoriesWithTests finds all directories containing tests
func findDirectoriesWithTests(baseDir string) ([]string, error) {
	testDirs := make(map[string]bool)

	err := filepath.WalkDir(baseDir, func(path string, file fs.DirEntry, err error) error {
		if err != nil {
			return err
		}

		if !file.IsDir() && strings.HasSuffix(file.Name(), "_test.txtar") {
			testDirs[filepath.Dir(path)] = true
		}

		return nil
	})

	if err != nil {
		return nil, fmt.Errorf("failed to walk directory %s: %w", baseDir, err)
	}

	return slices.Sorted(maps.Keys(testDirs)), nil
}
