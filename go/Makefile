default: help
PROJECTNAME := $(shell basename "$(PWD)")

.PHONY: help
help: ## Show help for all commands
	@echo
	@echo "Available commands:"
	@echo
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: release
release: ## Build project for release
	@echo "Building project..."
	@rm -rf ./release
	@mkdir -p ./release
	@go build -o ./release/${PROJECTNAME}
	@chmod +x ./release/${PROJECTNAME}

.PHONY: validate
validate: ## Validate project
	@echo "Starting static analysis..."
	@go vet ./...
	@golint ./...
	@echo "Static analysis finished"

.PHONY: debug
debug: ## Build project and debug it
	@rm -rf ./build
	@mkdir -p ./build
	@go build -race -o ./build/${PROJECTNAME} 
	@echo "You can find the current built code in ./build/${PROJECTNAME}"
	@./build/${PROJECTNAME}

.PHONY: test
test: ## Test project
	@echo "Running tests"
	@go test -race ./...
	@echo "Running stress tests"
	@go test -race ./... -count=100

.PHONY: test_full
test_full: ## Test project without cache
	@go clean -testcache
	@$(MAKE) -s test

.PHONY: coverage
coverage: ## Get project coverage
	@go test ./... -coverprofile=/tmp/cover_${PROJECTNAME}.out
	@go tool cover -html=/tmp/cover_${PROJECTNAME}.out
	@rm -f /tmp/cover_${PROJECTNAME}.out

.PHONY: resolve_dependencies
resolve_dependencies: ## Resolve all dependencies
	@go clean -modcache
	@go get ./...
	@go get golang.org/x/lint/golint


.PHONY: list_dependencies
list_dependencies: ## list all dependencies
	@go list -m -u all

.PHONY: clean
clean: ## Clean project
	@echo "Cleaning..."
	@rm -rf ./release
	@rm -rf ./build
