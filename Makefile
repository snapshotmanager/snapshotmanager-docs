SITE=./public
PRE_SITE=./static
ZOLA := $(if $(shell which zola),,foo)

website-build:
ifdef ZOLA
	@echo "ERROR: No zola found in PATH, cannot build website. Follow instructions at https://getzola.org/documentation/"
	exit 1
endif
# Copy content to $(PRE_SIZE) here if defined

website-distrib: website-build
	mkdir -p templates
	zola build

website-test: website-distrib
	zola serve

yamllint:
	yamllint --strict .github/workflows/*.yml

check:
	make website-distrib

clean:
	- rm -Rf $(SITE)

check-typos:
	typos

WEBSITE_REPO ?=
test-website-repo:
	echo "Testing that WEBSITE_REPO environment variable is set to a directory path"
	test -d "${WEBSITE_REPO}"

COMMIT_MSG ?=
test-commit-msg:
	echo "Testing that COMMIT_MSG environment variable is non-empty"
	test "${COMMIT_MSG}"

website-copy: test-website-repo test-commit-msg clean website-distrib
	(cd ${WEBSITE_REPO} && git checkout gh-pages && test `git status --porcelain | wc -l` = "0" && git ls-files | xargs rm)
	(cd ./public; cp * -R ${WEBSITE_REPO})
	(cd ${WEBSITE_REPO}; git add .; git commit -m "${COMMIT_MSG}")

.PHONY:
	check
	clean
	test-commit-msg
	test-website-repo
	website-copy
	website-distrib
	yamllint
