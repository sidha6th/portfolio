#!/bin/bash

# Build the Flutter web app
fvm flutter build web --release

# Extract version from pubspec.yaml
VERSION=$(grep '^version:' pubspec.yaml | awk '{print $2}')

# Deploy to Firebase with version in the message
firebase deploy -m "v: $VERSION"
