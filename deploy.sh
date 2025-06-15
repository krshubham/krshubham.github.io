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

# Check if build was successful
if [ ! -d "public" ] || [ -z "$(ls -A public)" ]; then
    echo "❌ Hugo build failed or public directory is empty!"
    exit 1
fi

# Create a temporary directory for the built site
TEMP_DIR=$(mktemp -d)
echo "Copying built site to temporary directory: $TEMP_DIR"
cp -r public/* "$TEMP_DIR/"

# Switch to gh-pages branch (create if it doesn't exist)
echo "Switching to gh-pages branch..."
git checkout gh-pages 2>/dev/null || git checkout --orphan gh-pages || { echo "Failed to switch to gh-pages branch"; exit 1; }

# If this is a new orphan branch, remove all files
if [ ! -f "index.html" ]; then
    echo "Initializing new gh-pages branch..."
    git rm -rf . 2>/dev/null || true
fi

# Remove all files except .git
echo "Cleaning gh-pages branch..."
find . -maxdepth 1 ! -name '.git' ! -name '.' -exec rm -rf {} \; 2>/dev/null || true

# Copy the built site from temp directory
echo "Copying built site to gh-pages branch..."
cp -r "$TEMP_DIR"/* .

# Clean up temp directory
rm -rf "$TEMP_DIR"

# Add all changes to git
echo "Adding changes to git..."
git add .

# Check if there are any changes to commit
if git diff --staged --quiet; then
    echo "No changes to deploy."
    git checkout -
    exit 0
fi

# Commit changes
echo "Committing changes..."
git commit -m "Deploy website - $(date)"

# Push to gh-pages
echo "Pushing to gh-pages branch..."
git push origin gh-pages

# Switch back to main/master branch
echo "Switching back to original branch..."
git checkout -

echo "✅ Deployment complete!"
echo "Your site should be available at: https://krshubham.github.io"
