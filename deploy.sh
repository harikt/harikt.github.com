
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
hugo --config config-blowfish.toml

echo "Updating master branch"
cd public && git add --all && git commit -m "Publishing to master (deploy.sh)"

echo "Pushing to github"
git push --all
