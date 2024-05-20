
BOLD=$(shell tput bold)
NORMAL=$(shell tput sgr0)

HUGO_URL=https://github.com/gohugoio/hugo/releases/download
HUGO_VERSION=0.126.1
HUGO_ARCHIVE=hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz
HUGO_DIR=hugo-bin
HUGO_DIR_OLD=hugo-bin_old
HUGO_VERSION_FILE=${HUGO_DIR}/.v${HUGO_VERSION}

HUGO_CMD=${HUGO_DIR}/hugo

.PHONY: help install list-draft uninstall uninstall-hugo preview

#: Display this help (i.e. list all available targets). (DEFAULT TARGET)
help:
	@echo
	@echo "Available targets:"
	@grep -B1 -E "^[a-zA-Z0-9_-]+\:([^\=]|$$)" Makefile \
	| grep -v -- -- \
	| sed 'N;s/\n/###/' \
	| sed -n "s/^#: \(.*\)###\(.*\):.*/* \2@\1/p" \
	| fold -s -w 65 \
	| sed 's/^[ \n\t]*\([^*]\)/@\1/' \
	| column -t -o '  ' -s '@' \
	| sed "s/^\* \([a-zA-Z-]\+\) /\n* ${BOLD}\1${NORMAL} /"
	@echo


#: Start the preview service (on port 1313). All required tools are installed/upgraded automatically, when needed.
preview: install list-draft
	./local_preview.bash "${HUGO_DIR}"


#: List all draft pages (i.e. all pages only visible in preview mode).
list-draft: install
	@echo
	@echo "################################################################################"
	@echo "                                 DRAFT PAGES"
	@echo "        (a draft page is never published, but is visible in preview mode)"
	@echo "--------------------------------------------------------------------------------"
	@${HUGO_CMD} list drafts | cut -d',' -f1 | tail -n+2
	@echo "################################################################################"
	@echo


#: Install Hugo (or upgrade it if a different version is set in Makefile).
install: ${HUGO_VERSION_FILE}


${HUGO_VERSION_FILE}:
	@if [ -d "${HUGO_DIR}" ]; then \
		echo "- Upgrading Hugo to v${HUGO_VERSION}..."; \
	else \
		echo "- Installing Hugo..."; \
	fi
	
	@echo "  - 1/6 - Downloading Hugo (version: ${HUGO_VERSION})..."
	@wget -q --show-progress "${HUGO_URL}/v${HUGO_VERSION}/${HUGO_ARCHIVE}"
	
	@echo "  - 2/6 - Deprecating existing Hugo version..."
	@if [ -d "${HUGO_DIR}" ]; then \
		rm -rf "${HUGO_DIR_OLD}"; \
		mv "${HUGO_DIR}" "${HUGO_DIR_OLD}"; \
	fi

	@echo "  - 3/6 - Installing Hugo in this directory (inside ${HUGO_DIR})..."
	@mkdir ${HUGO_DIR} && tar -xzf ${HUGO_ARCHIVE} -C ${HUGO_DIR}/ && rm -f ${HUGO_ARCHIVE}

	@echo "  - 4/6 - Giving execute permission..."
	@chmod 775 ${HUGO_DIR}/hugo

	@echo "  - 5/6 - Testing installation (and give version)...."
	@${HUGO_CMD} version

	@echo "  - 6/6 - Removing deprecated Hugo version..."
	@if [ -d "${HUGO_DIR_OLD}" ]; then \
		rm -rf "${HUGO_DIR_OLD}"; \
	fi

	@touch ${HUGO_VERSION_FILE}


#: Uninstall Hugo.
uninstall:
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
