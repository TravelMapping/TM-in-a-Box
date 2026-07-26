#!/bin/bash
set -e

mkdir -p repos

REPOS=(
    "https://github.com/TravelMapping/HighwayData"
    "https://github.com/TravelMapping/UserData"
    "https://github.com/TravelMapping/RailwayData"
    "https://github.com/TravelMapping/Web"
    "https://github.com/TravelMapping/EduTools"
    "https://github.com/TravelMapping/DataProcessing"
)

echo "Checking and cloning TravelMapping repositories..."
for repo_url in "${REPOS[@]}"; do
    repo_name=$(basename "$repo_url")
    if [ ! -d "repos/$repo_name" ]; then
        echo "Cloning $repo_name..."
        git clone "$repo_url" "repos/$repo_name"
    else
        echo "Repository repos/$repo_name already exists. Skipping clone."
    fi
done

mkdir -p osf_data

echo "Setup complete! You can now run: docker compose up --build"
