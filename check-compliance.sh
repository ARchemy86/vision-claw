#!/bin/bash
# Vision Claw Compliance Checker Script
# Usage: ./check-compliance.sh <spec_file> <drawing_file> [tolerance_percent]

SPEC_FILE=$1
DRAWING_FILE=$2
TOLERANCE=${3:-5}

if [ -z "$SPEC_FILE" ] || [ -z "$DRAWING_FILE" ]; then
    echo "Usage: ./check-compliance.sh <specification.pdf> <drawing.pdf|png> [tolerance%]"
    exit 1
fi

echo "🔍 Vision Claw - Compliance Check"
echo "===================================="
echo "Specification: $SPEC_FILE"
echo "Drawing: $DRAWING_FILE"
echo "Tolerance: ${TOLERANCE}%"
echo ""

# Upload documents
echo "📤 Uploading documents..."
curl -s -X POST http://localhost:8090/api/upload/spec \
  -F "file=@$SPEC_FILE"

curl -s -X POST http://localhost:8090/api/upload/drawing \
  -F "file=@$DRAWING_FILE"

# Run comparison
echo ""
echo "🤖 Running comparison analysis..."
echo ""

curl -s -X POST http://localhost:8090/api/compare \
  -H "Content-Type: application/json" \
  -d "{
    \"spec_file\": \"$(basename $SPEC_FILE)\",
    \"drawing_file\": \"$(basename $DRAWING_FILE)\",
    \"tolerance_percent\": $TOLERANCE
  }" | jq .

echo ""
echo "✅ Compliance check complete!"
