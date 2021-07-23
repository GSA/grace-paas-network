GOOS = linux
GOARCH = amd64
GOBIN := $(GOPATH)/bin
GOLANGCILINT := $(GOBIN)/golangci-lint
GOSEC := $(GOBIN)/gosec
GHR := $(GOBIN)/ghr
RELEASEDIR ?= ../release/
ARTIFACT_NAME := grace-paas-associate-zone
CIRCLE_PROJECT_REPONAME ?= $(ARTIFACT_NAME)
export GO111MODULE=on

.PHONY: build release clean test lint dependencies integration_test
build: lint clean
	mkdir -p $(RELEASEDIR)
	GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o $(RELEASEDIR)$(ARTIFACT_NAME) -v
	zip -j $(RELEASEDIR)$(ARTIFACT_NAME).zip $(RELEASEDIR)$(ARTIFACT_NAME)
	rm -f $(RELEASEDIR)$(ARTIFACT_NAME)

release: build
	export CIRCLE_TAG=$(CIRCLE_TAG)
ifeq ($(strip $(GITHUB_TOKEN)),)
	@echo "GITHUB_TOKEN must be provided"
	@exit 0
else ifeq ($(strip $(CIRCLE_TAG)),)
	@echo "CIRCLE_TAG must be set"
	@exit 0
else
	ghr -u $(CIRCLE_PROJECT_USERNAME) -r $(CIRCLE_PROJECT_REPONAME) -c $(CIRCLE_SHA1) -n $(CIRCLE_TAG) -delete $(CIRCLE_TAG) $(RELEASEDIR)
endif

clean: precommit
	rm -rf $(RELEASEDIR)

test: lint
	go test -v -cover ./...

integration_test: test
	go test -v -cover --tags=integration ./...

lint: go.mod dependencies
	go mod tidy
	./bin/golangci-lint run ./...
	./bin/gosec ./...

go.mod:
ifeq (,$(wildcard go.mod))
	go mod init
endif

dependencies: precommit $(GOLANGCILINT) $(GOSEC) $(GHR)

$(GOLANGCILINT):
	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s v1.41.1

$(GOSEC):
	curl -sfL https://raw.githubusercontent.com/securego/gosec/master/install.sh | sh -s v2.8.1

$(GHR):
	go get -u github.com/tcnksm/ghr

precommit:
ifneq ($(strip $(hooksPath)),.github/hooks)
	@git config --add core.hooksPath .github/hooks
endif
