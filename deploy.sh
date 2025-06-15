#!/bin/bash

# Check for uncommitted changes outside the public folder
echo "Checking for uncommitted changes..."
git config user.email "kumarshubham347@gmail.com"
git config user.name "Kumar Shubham"
if git status --porcelain | grep -v "^?? public/" | grep -v "^ M public/" | grep -v "^M  public/" | grep -q .; then
    echo "⚠️  WARNING: You have uncommitted changes outside the public folder:"
    git status --porcelain | grep -v "^?? public/" | grep -v "^ M public/" | grep -v "^M  public/"
    echo ""
    echo "Please commit these changes to your current branch before deploying:"
    echo "  git add ."
    echo "  git commit -m \"Your commit message\""
    echo ""
    read -p "Do you want to continue with deployment anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Deployment cancelled."
        exit 1
    fi
fi

# Ensure git submodules are initialized (for themes)
echo "Initializing git submodules..."
git submodule update --init --recursive

# Build the site
echo "Building the site..."
hugo

# Stash any changes (including the public directory changes)
echo "Stashing changes..."
git add .
git stash push -m "Temporary stash before deployment"

# Switch to gh-pages branch
echo "Switching to gh-pages branch..."
git checkout gh-pages || git checkout -b gh-pages || { echo "Failed to switch to gh-pages branch: $?"; exit 1; }

# Restore the stashed changes
echo "Restoring stashed changes..."
git stash pop || { echo "No stash to pop, continuing..."; }

# Remove all files except .git, public directory, and themes directory
echo "Cleaning gh-pages branch..."
find . -maxdepth 1 ! -name '.git' ! -name 'public' ! -name 'themes' ! -name '.' -exec rm -rf {} \;

# Copy contents from public to root
echo "Moving contents from public to root..."
cp -r public/* .
rm -rf public

# Add all changes to git
echo "Adding changes to git..."
git add .

# Commit changes
echo "Committing changes..."
git commit -m "Deploy website - $(date)"

# Push to gh-pages
echo "Pushing to gh-pages branch..."
git push origin gh-pages

# Switch back to main/master branch
echo "Switching back to original branch..."
git checkout -

echo "Deployment complete!"
