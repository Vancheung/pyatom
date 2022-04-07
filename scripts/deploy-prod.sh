#!/usr/bin/env bash
if [[ $TRAVIS_BRANCH = "master" ]]; then
    if [[ $TRAVIS_PULL_REQUEST = "false" ]]; then
        rm -rfv dist/*
        git config --global user.name "semantic-release (via TravisCI)"
        git config --global user.email "semantic-release@travis"

        CUR_VERSION=$(semantic-release print-version --current)
        NEXT_VERSION=$(semantic-release print-version)

        if [[ "$NEXT_VERSION" != "$CUR_VERSION" ]]; then
            echo "Deploying"
            semantic-release publish
            flit publish
        else
            echo "Skipping"
        fi
    fi
fi
