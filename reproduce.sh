#!/bin/bash

set -e

echo "=========================================="
echo "TypeScript 5.3.3 + @vitejs/plugin-react-swc 4.2.2 Bug Reproduction"
echo "=========================================="
echo ""

echo "Step 1: Installing dependencies..."
npm install
echo ""

echo "Step 2: Checking TypeScript version..."
npx tsc --version
echo ""

echo "Step 3: Checking problematic line in node_modules..."
echo "Looking for: export { react as default, pluginForCjs as \"module.exports\" }"
grep -n "module.exports" node_modules/@vitejs/plugin-react-swc/index.d.ts || true
echo ""

echo "Step 4: Running build (this will fail with TypeScript errors)..."
npm run build || {
  echo ""
  echo "=========================================="
  echo "BUILD FAILED AS EXPECTED"
  echo "=========================================="
  echo ""
  echo "The error is caused by string literal export names"
  echo "which require TypeScript 5.5+, but this project uses 5.3.3"
  echo ""
  echo "To fix, run one of these:"
  echo "  1. npm install typescript@latest"
  echo "  2. npm install @vitejs/plugin-react-swc@^3.9.0"
  echo ""
}