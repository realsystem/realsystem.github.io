#!/bin/bash

# Preview a specific project
# Opens dev server and browser to project page

if [ -z "$1" ]; then
    echo "Usage: ./preview-project.sh project-slug"
    echo ""
    echo "Available projects:"
    ./tools/list-projects.sh
    exit 1
fi

PROJECT_SLUG="$1"
PROJECT_FILE="src/content/projects/${PROJECT_SLUG}.md"

if [ ! -f "$PROJECT_FILE" ]; then
    echo "Project not found: $PROJECT_SLUG"
    echo ""
    echo "Available projects:"
    ./tools/list-projects.sh
    exit 1
fi

URL="http://localhost:4321/projects/${PROJECT_SLUG}"

echo "Starting dev server..."
echo "Opening: $URL"

# Start server in background
npm run dev &
SERVER_PID=$!

# Wait for server to start
sleep 3

# Open browser
if [[ "$OSTYPE" == "darwin"* ]]; then
    open "$URL"
else
    xdg-open "$URL" 2>/dev/null || echo "Please open: $URL"
fi

echo ""
echo "Press Ctrl+C to stop the server"

# Wait for Ctrl+C
trap "kill $SERVER_PID 2>/dev/null" EXIT
wait $SERVER_PID
