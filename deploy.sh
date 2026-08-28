#!/bin/sh

if [ "`git status -s`" ]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

# Ensure we are on the source branch
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" != "source" ]; then
    echo "Error: You are on the '$CURRENT_BRANCH' branch."
    echo "Please switch to the 'source' branch before deploying."
    exit 1;
fi

echo "Deploying from branch: $CURRENT_BRANCH"

echo "Ensuring theme submodules are checked out"
git submodule update --init --recursive || exit 1

THEME=$(sed -n 's/^theme *= *"\(.*\)"/\1/p' hugo.toml)
if [ -n "$THEME" ] && [ ! -f "themes/$THEME/theme.toml" ]; then
    echo "Error: theme '$THEME' is missing or empty in themes/$THEME."
    echo "Run: git submodule update --init --recursive"
    exit 1;
fi

echo "Deleting old publication"
rm -rf public
mkdir public
git worktree prune
rm -rf .git/worktrees/public/

echo "Checking out master branch into public"
git worktree add -B master public origin/master

echo "Removing existing files"
rm -rf public/*

echo "Generating site"
hugo || exit 1

if [ ! -f public/index.html ]; then
    echo "Error: build produced no public/index.html - refusing to publish."
    exit 1;
fi

HTML_COUNT=$(find public -name '*.html' | wc -l | tr -d ' ')
if [ "$HTML_COUNT" -lt 10 ]; then
    echo "Error: build produced only $HTML_COUNT HTML files - refusing to publish."
    exit 1;
fi
echo "Build looks sane: $HTML_COUNT HTML files"

echo "Updating master branch"
cd public && git add --all && git commit -m "Publishing to master (deploy.sh)"

echo "Pushing to github"
git push --all
