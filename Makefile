
BOLD=$(shell tput bold)
NORMAL=$(shell tput sgr0)

HUGO_URL=https://github.com/gohugoio/hugo/releases/download
HUGO_VERSION=0.140.2
HUGO_ARCHIVE=hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz
HUGO_DIR=hugo-bin
HUGO_DIR_OLD=hugo-bin_old
HUGO_VERSION_FILE=${HUGO_DIR}/.v${HUGO_VERSION}

PAGEFIND_URL=https://github.com/CloudCannon/pagefind/releases/download
PAGEFIND_VERSION=1.3.0
PAGEFIND_ARCHIVE=pagefind-v${PAGEFIND_VERSION}-x86_64-unknown-linux-musl.tar.gz
PAGEFIND_DIR=pagefind-bin
PAGEFIND_DIR_OLD=pagefind-bin_old
PAGEFIND_VERSION_FILE=${PAGEFIND_DIR}/.v${PAGEFIND_VERSION}
PAGEFIND_INDEX_DIR=static/pagefind
PAGEFIND_CMD=${PAGEFIND_DIR}/pagefind

DIR_PUBLIC=public
DIR_PUBLIC_TMP=.public_tmp

HUGO_CMD=${HUGO_DIR}/hugo

.PHONY: help preview update-search-index clear-search-index newsletter list-draft html generate-public-pages clear-generated-public-pages index-public-pages clear-public-pages-index clear install uninstall uninstall-hugo uninstall-pagefind

#: Display this help (i.e. list all available targets). (DEFAULT TARGET)
help:
	@echo "\nMake targets for ivoa-web:\n"
	@echo "* help        Display help (default target).\n"
	@echo "* preview     Start the preview service (on port 1313). All required tools\n              are installed/upgraded automatically, when needed.\n"
	@echo "* newsletter  Create a new newsletter.\n"
	@echo "* html        Generate the HTML version of the IVOA Website (with search\n              index).\n"
	@echo "* list-draft  List all draft pages (i.e. all pages only visible in preview\n              mode).\n"
	@echo "* clear       Delete local search index and generated public pages.\n"
	@echo "* install     Install Hugo and PageFind (or upgrade them if a different\n              version is set in Makefile).\n"
	@echo "* uninstall   Uninstall Hugo and PageFind.\n"


#: Start the preview service (on port 1313). All required tools are installed/upgraded automatically, when needed.
preview: install update-search-index list-draft
	./local_preview.bash "${HUGO_DIR}" "${PAGEFIND_INDEX_DIR}"

#: Update local search index (only for preview purpose). All pages (event draft) are generated with Hugo and then indexed by PageFind. The generated index is stored in the 'static/' directory in order to be available in preview mode.
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

#: Delete the local search index.
clear-search-index:
	@if [ -d "${PAGEFIND_INDEX_DIR}" ]; then \
		echo "- Clearing search index (${PAGEFIND_INDEX_DIR})..."; \
		rm -rf "${PAGEFIND_INDEX_DIR}"; \
	fi

DIR_NEWSLETTER  := content/newsletter
ID_LAST_NEWSLETTER := $(shell ls -1 $(DIR_NEWSLETTER) | grep '^[0-9]\+\.md$$' | sort -rn | head -n1 | sed 's/^0*\([1-9][0-9]*\)\.md$$/\1/' )
NEXT_NEWSLETTER := $(shell printf "%03d.md" "$$(( $(ID_LAST_NEWSLETTER) + 1 ))")

#: Create a new newsletter.
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

#: Generate the HTML version of the IVOA Website (with search index).
html: install generate-public-pages index-public-pages

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


#: Delete local search index and generated public pages.
clear: clear-search-index clear-generated-public-pages

#: Install Hugo and PageFind (or upgrade them if a different version is set in Makefile).
install: ${HUGO_VERSION_FILE} ${PAGEFIND_VERSION_FILE}


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


${PAGEFIND_VERSION_FILE}:
	@if [ -d "${PAGEFIND_DIR}" ]; then \
		echo "- Upgrading PageFind to v${PAGEFIND_VERSION}..."; \
	else \
		echo "- Installing PageFind..."; \
	fi

	@echo "  - 1/6 - Downloading PageFind (version: ${PAGEFIND_VERSION})..."
	@wget -q "${PAGEFIND_URL}/v${PAGEFIND_VERSION}/${PAGEFIND_ARCHIVE}"
	
	@echo "  - 2/6 - Deprecating existing PageFind version..."
	@if [ -d "${PAGEFIND_DIR}" ]; then \
		rm -rf "${PAGEFIND_DIR_OLD}"; \
		mv "${PAGEFIND_DIR}" "${PAGEFIND_DIR_OLD}"; \
	fi

	@echo "  - 3/6 - Installing PageFind in this directory (inside ${PAGEFIND_DIR})..."
	@mkdir ${PAGEFIND_DIR} && tar -xzf ${PAGEFIND_ARCHIVE} -C ${PAGEFIND_DIR}/ && rm -f ${PAGEFIND_ARCHIVE}

	@echo "  - 4/6 - Giving execute permission..."
	@chmod 775 ${PAGEFIND_CMD}

	@echo "  - 5/6 - Testing installation (and give version)...."
	@${PAGEFIND_CMD} --version

	@echo "  - 6/6 - Removing deprecated Pagefind version..."
	@if [ -d "${PAGEFIND_DIR_OLD}" ]; then \
		rm -rf "${PAGEFIND_DIR_OLD}"; \
	fi

	@touch ${PAGEFIND_VERSION_FILE}


#: Uninstall everything (Hugo and PageFind).
uninstall: uninstall-hugo uninstall-pagefind

#: Uninstall Hugo.
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


#: Uninstall PageFind.
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
