#!/bin/bash

# Build the site
echo "Building the site..."
hugo

# Switch to gh-pages branch
echo "Switching to gh-pages branch..."
git checkout gh-pages || git checkout -b gh-pages

# Remove all files except .git and public directory
echo "Cleaning gh-pages branch..."
find . -maxdepth 1 ! -name '.git' ! -name 'public' ! -name '.' -exec rm -rf {} \;

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
