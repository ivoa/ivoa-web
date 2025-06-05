# Use bash explicitly (required for some constructs)
SHELL = /bin/bash

# Formatting (optional)
BOLD=$(shell tput bold)
NORMAL=$(shell tput sgr0)

# URLs and Versions
HUGO_URL=https://github.com/gohugoio/hugo/releases/download
HUGO_VERSION=0.147.2

PAGEFIND_URL=https://github.com/CloudCannon/pagefind/releases/download
PAGEFIND_VERSION=1.3.0

# Directories and files
HUGO_DIR=hugo-bin
HUGO_DIR_OLD=hugo-bin_old
HUGO_VERSION_FILE=${HUGO_DIR}/.v${HUGO_VERSION}

PAGEFIND_DIR=pagefind-bin
PAGEFIND_DIR_OLD=pagefind-bin_old
PAGEFIND_VERSION_FILE=${PAGEFIND_DIR}/.v${PAGEFIND_VERSION}
PAGEFIND_INDEX_DIR=static/pagefind
PAGEFIND_CMD=${PAGEFIND_DIR}/pagefind

DIR_PUBLIC=public
DIR_PUBLIC_TMP=.public_tmp

HUGO_CMD=${HUGO_DIR}/hugo

# Detect OS and set archive names accordingly
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
   HUGO_ARCHIVE = hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz
   PAGEFIND_ARCHIVE = pagefind-v${PAGEFIND_VERSION}-x86_64-unknown-linux-musl.tar.gz
else ifeq ($(UNAME_S),Darwin)
   HUGO_ARCHIVE = hugo_${HUGO_VERSION}_darwin-universal.tar.gz
   PAGEFIND_ARCHIVE = pagefind-v${PAGEFIND_VERSION}-x86_64-apple-darwin.tar.gz
else
   $(error Unsupported OS: $(UNAME_S))
endif

# Determine download command: use wget if available, otherwise curl.
WGET := $(shell command -v wget 2>/dev/null)
CURL := $(shell command -v curl 2>/dev/null)
ifeq ($(WGET),)
  ifeq ($(CURL),)
    $(error "Neither wget nor curl is installed. Please install one to continue.")
  else
    DOWNLOAD = curl -L -O
  endif
else
  DOWNLOAD = wget -q --show-progress
endif

help:
	@printf "\nMake targets for ivoa-web:\n"
	@printf "* help        Display help (default target).\n"
	@printf "* preview     Start the preview service (on port 1313). All required tools\n              are installed/upgraded automatically, when needed.\n"
	@printf "* newsletter  Create a new newsletter.\n"
	@printf "* html        Generate the HTML version of the IVOA Website (with search\n              index).\n"
	@printf "* list-draft  List all draft pages (i.e. all pages only visible in preview\n              mode).\n"
	@printf "* clear       Delete local search index and generated public pages.\n"
	@printf "* install     Install Hugo and PageFind (or upgrade them if a different\n              version is set in Makefile).\n"
	@printf "* uninstall   Uninstall Hugo and PageFind.\n"

# Ensure Node is installed and its major version is at least 20.
.PHONY: ensure-node
ensure-node:
	@if ! command -v node >/dev/null 2>&1; then \
		echo "Error: Node.js is not installed. Node.js version 20 or greater is required." >&2; \
		exit 1; \
	fi
	@NODE_VERSION=$$(node --version | sed 's/v//'); \
	MAJOR_VERSION=$$(echo $$NODE_VERSION | cut -d. -f1); \
	if [ $$MAJOR_VERSION -lt 20 ]; then \
		echo "Error: Node.js version 20 or greater is required. Found version $$NODE_VERSION." >&2; \
		exit 1; \
	fi

# Node dependencies target (for Tailwind/PostCSS)
.PHONY: npm-install
npm-install: ensure-node
	@if [ -f package.json ]; then \
		echo "- Installing Node dependencies..."; \
		npm install; \
	else \
		echo "No package.json found, skipping Node dependency installation."; \
	fi

# Help target
.PHONY: help preview update-search-index clear-search-index newsletter list-draft html generate-public-pages clear-generated-public-pages index-public-pages clear-public-pages-index clear install uninstall uninstall-hugo uninstall-pagefind

# Preview target (now depends on Node deps)
preview: npm-install install update-search-index list-draft
	./local_preview.bash "${HUGO_DIR}" "${PAGEFIND_INDEX_DIR}"

# Update search index (for preview purpose)
update-search-index: clear-search-index ${PAGEFIND_INDEX_DIR}

${PAGEFIND_INDEX_DIR}:
	@echo "- Generating search index..."
	@if [ -d "${DIR_PUBLIC_TMP}" ]; then \
		rm -rf "${DIR_PUBLIC_TMP}"; \
	fi
	@if [ -d "${PAGEFIND_INDEX_DIR}" ]; then \
		rm -rf "${PAGEFIND_INDEX_DIR}"; \
	fi
	@mkdir "${DIR_PUBLIC_TMP}" \
	&& ${HUGO_CMD} -d "${DIR_PUBLIC_TMP}" -DEF \
	&& ${PAGEFIND_CMD} --site "${DIR_PUBLIC_TMP}" \
	&& cp -r "${DIR_PUBLIC_TMP}/pagefind" "${PAGEFIND_INDEX_DIR}" \
	&& rm -rf "${DIR_PUBLIC_TMP}"

# Clear search index
clear-search-index:
	@if [ -d "${PAGEFIND_INDEX_DIR}" ]; then \
		echo "- Clearing search index (${PAGEFIND_INDEX_DIR})..."; \
		rm -rf "${PAGEFIND_INDEX_DIR}"; \
	fi

# Newsletter variables (using -E flags for portability)
DIR_NEWSLETTER  := content/newsletter
ID_LAST_NEWSLETTER := $(shell ls -1 $(DIR_NEWSLETTER) | grep -E '^[0-9]+\.md$$' | sort -rn | head -n1 | sed -E 's/^0*([1-9][0-9]*)\.md$$/\1/')
NEXT_NEWSLETTER := $(shell printf "%03d.md" "$$(( $(ID_LAST_NEWSLETTER) + 1 ))")

newsletter: install
	@if ${HUGO_CMD} new content "newsletter/$(NEXT_NEWSLETTER)" ; \
	then \
		echo "(from the template 'archetypes/newsletter.md')" ; \
		echo "=> Next steps are yours:" ; \
		echo "   1. Edit the file '$(DIR_NEWSLETTER)/$(NEXT_NEWSLETTER)'" ; \
		echo "   2. Replace all occurences of 'TBD'" ; \
		echo "   3. Add any other content" ; \
		echo "   4. Commit and push changes" ; \
	else \
		echo "=> FAILED to create the newsletter '$(DIR_NEWSLETTER)/$(NEXT_NEWSLETTER)'!" ; \
	fi

# List draft pages
list-draft: install
	@echo
	@echo "################################################################################"
	@echo "                                 DRAFT PAGES"
	@echo "        (a draft page is never published, but is visible in preview mode)"
	@echo "--------------------------------------------------------------------------------"
	@${HUGO_CMD} list drafts | cut -d',' -f1 | tail -n+2
	@echo "################################################################################"
	@echo

# Generate HTML version with search index (now depends on Node deps)
html: npm-install install generate-public-pages index-public-pages

generate-public-pages: clear-generated-public-pages
	@echo "- Generating the HTML pages..."
	@echo "######################################################################"
	@if [ -z "${BASEURL}" ]; then \
		${HUGO_CMD} -d "${DIR_PUBLIC}" --ignoreCache; \
	else \
		echo "(with base URL: ${BASEURL})"; \
		${HUGO_CMD} -b "${BASEURL}" -d "${DIR_PUBLIC}" --ignoreCache; \
	fi
	@echo "######################################################################\n"

clear-generated-public-pages:
	@echo "- Deleting all generated public pages..."
	@rm -rf "${DIR_PUBLIC}"

index-public-pages: clear-public-pages-index
	@echo "- Indexing the generated public pages..."
	@echo "######################################################################"
	@${PAGEFIND_CMD} --site "${DIR_PUBLIC}"
	@echo "######################################################################\n"

clear-public-pages-index:
	@rm -rf "${DIR_PUBLIC}/pagefind"

# Clear search index and generated pages
clear: clear-search-index clear-generated-public-pages

# Install Hugo and PageFind (or upgrade if versions differ)
install: ${HUGO_VERSION_FILE} ${PAGEFIND_VERSION_FILE}

${HUGO_VERSION_FILE}:
	@if [ -d "${HUGO_DIR}" ]; then \
		echo "- Upgrading Hugo to v${HUGO_VERSION}..."; \
	else \
		echo "- Installing Hugo..."; \
	fi
	@echo "  - 1/6 - Downloading Hugo (version: ${HUGO_VERSION})..."
	@$(DOWNLOAD) "${HUGO_URL}/v${HUGO_VERSION}/${HUGO_ARCHIVE}"
	@echo "  - 2/6 - Deprecating existing Hugo version..."
	@if [ -d "${HUGO_DIR}" ]; then \
		rm -rf "${HUGO_DIR_OLD}"; \
		mv "${HUGO_DIR}" "${HUGO_DIR_OLD}"; \
	fi
	@echo "  - 3/6 - Installing Hugo in this directory (inside ${HUGO_DIR})..."
	@mkdir ${HUGO_DIR} && tar -xzf ${HUGO_ARCHIVE} -C ${HUGO_DIR}/ && rm -f ${HUGO_ARCHIVE}
	@echo "  - 4/6 - Giving execute permission..."
	@chmod 775 ${HUGO_DIR}/hugo
	@echo "  - 5/6 - Testing installation (and show version)..."
	@${HUGO_CMD} version
	@echo "  - 6/6 - Removing deprecated Hugo version..."
	@if [ -d "${HUGO_DIR_OLD}" ]; then \
		rm -rf "${HUGO_DIR_OLD}"; \
	fi
	@touch ${HUGO_VERSION_FILE}

${PAGEFIND_VERSION_FILE}:
	@if [ -d "${PAGEFIND_DIR}" ]; then \
		echo "- Upgrading PageFind to v${PAGEFIND_VERSION}..."; \
	else \
		echo "- Installing PageFind..."; \
	fi
	@echo "  - 1/6 - Downloading PageFind (version: ${PAGEFIND_VERSION})..."
	@$(DOWNLOAD) "${PAGEFIND_URL}/v${PAGEFIND_VERSION}/${PAGEFIND_ARCHIVE}"
	@echo "  - 2/6 - Deprecating existing PageFind version..."
	@if [ -d "${PAGEFIND_DIR}" ]; then \
		rm -rf "${PAGEFIND_DIR_OLD}"; \
		mv "${PAGEFIND_DIR}" "${PAGEFIND_DIR_OLD}"; \
	fi
	@echo "  - 3/6 - Installing PageFind in this directory (inside ${PAGEFIND_DIR})..."
	@mkdir ${PAGEFIND_DIR} && tar -xzf ${PAGEFIND_ARCHIVE} -C ${PAGEFIND_DIR}/ && rm -f ${PAGEFIND_ARCHIVE}
	@echo "  - 4/6 - Giving execute permission..."
	@chmod 775 ${PAGEFIND_CMD}
	@echo "  - 5/6 - Testing installation (and show version)..."
	@${PAGEFIND_CMD} --version
	@echo "  - 6/6 - Removing deprecated PageFind version..."
	@if [ -d "${PAGEFIND_DIR_OLD}" ]; then \
		rm -rf "${PAGEFIND_DIR_OLD}"; \
	fi
	@touch ${PAGEFIND_VERSION_FILE}

# Uninstall targets
uninstall: uninstall-hugo uninstall-pagefind

uninstall-hugo:
	@if [ -d "${HUGO_DIR}" ]; then \
		if read -p "Uninstall Hugo? [Y/n] " confirm ; then \
			if [ $${confirm:-'Y'} = 'n' ]; then \
				echo "=> Aborted"; \
			else \
				rm -rf ${HUGO_DIR} \
				&& echo "=> OK. Hugo successfully uninstalled." \
				|| echo "=> ERROR: Failed to delete the directory '${HUGO_DIR}'!"; \
			fi \
		fi \
	else \
		echo "INFO: Hugo is not installed. Nothing to do."; \
	fi

uninstall-pagefind:
	@if [ -d "${PAGEFIND_DIR}" ]; then \
		if read -p "Uninstall PageFind? [Y/n] " confirm ; then \
			if [ $${confirm:-'Y'} = 'n' ]; then \
				echo "=> Aborted"; \
			else \
				rm -rf ${PAGEFIND_DIR} \
				&& echo "=> OK. PageFind successfully uninstalled." \
				|| echo "=> ERROR: Failed to delete the directory '${PAGEFIND_DIR}'!"; \
			fi \
		fi \
	else \
		echo "INFO: PageFind is not installed. Nothing to do."; \
	fi
