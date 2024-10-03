#!/bin/bash

HUGO_DIR="$1"
PAGEFIND_INDEX_DIR="$2"

PORT=1313
TMP_PREVIEW_DIR=preview

# Search for the best option to open a web browser:
OPEN_BROWSER=$(which xdg-open || which open || which x-www-browser || which firefox)

# Starting message:
echo "- Starting preview service..."
echo "  (rendered pages available in '${TMP_PREVIEW_DIR}/' while the preview is running)"
echo

# Test whether the preview port is available:
if nc -z localhost $PORT;
then
    echo "  => ERROR: Port $PORT already used! A preview might already be started."
    
    # Give the PID of the running Hugo process, if any:
    if hugoPID=$(pgrep -f 'hugo server');
    then
        echo "            (Hugo process found with PID $hugoPID (try 'kill $hugoPID' to close it)"
    fi
else
    # Enable job control (so that being able to start hugo in background and
    # then put it back in foreground):
    set -m

    # Delete former preview directory, if any:
    [ -d "$TMP_PREVIEW_DIR" ] && rm -rf "$TMP_PREVIEW_DIR"

    # Start Hugo in background:
    "$HUGO_DIR"/hugo server -d "$TMP_PREVIEW_DIR" --watch --port $PORT -DEF --printI18nWarnings &

    # Wait a bit that Hugo starts generating pages (so that we have time to see
    # whether Hugo is started ; because we cannot get the exit status of a
    # background process):
    sleep 1

    # If the preview directory exists, then Hugo is running and...
    if [ -d "$TMP_PREVIEW_DIR" ]
    then
        # If a browser can be opened:
        if [ -n "$OPEN_BROWSER" ]
        then
            # ...open it with the preview home page:
            exec "$OPEN_BROWSER" 'http://localhost:1313/' >/dev/null 2>&1 &
        else
            echo "  => WARNING: no command found to open the preview in a browser!"
        fi

        # Put back Hugo in foreground:
        fg %1 >/dev/null
        
        # When preview is stopped, delete temporary files
        # (i.e. generated search index and generated preview pages):
        rm -rf "$PAGEFIND_INDEX_DIR" "$TMP_PREVIEW_DIR"
    else
        echo "  => ERROR: failed to start preview service! (see error above)"
    fi
fi