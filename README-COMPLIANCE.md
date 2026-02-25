# Vision Claw - Construction Compliance Agent 👁️🏗️

AI-powered document comparison system for construction compliance checking.

## 🎯 Purpose

Compare IFC drawings against specification documents to:
- ✅ Detect deviations from approved designs
- ✅ Verify site was built to spec
- ✅ Flag contractor changes
- ✅ Generate compliance reports

## 🏗️ Architecture

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│  IFC Drawings   │     │  Vision Claw     │     │  Specification  │
│  (PDF/Images)   │────▶│  Compliance      │◀────│  Documents      │
│                 │     │  Engine          │     │  (PDF/DOCX)     │
└─────────────────┘     └────────┬─────────┘     └─────────────────┘
                                 │
                    ┌────────────▼────────────┐
                    │      RAG Pipeline       │
                    │  (Diff + LLM Analysis)  │
                    └────────────┬────────────┘
                                 │
                    ┌────────────▼────────────┐
                    │   Compliance Report     │
                    │   (Issues, Deviations)  │
                    └─────────────────────────┘
```

## 📋 Document Types Supported

| Document Type | Format | Processing |
|--------------|--------|------------|
| **IFC Drawings** | PDF, PNG, TIFF, DWG | OCR + Vision analysis |
| **Specifications** | PDF, DOCX, TXT | Text extraction + RAG |
| **Construction Photos** | JPG, PNG | Object detection + comparison |
| **Change Orders** | PDF | Document diff analysis |
| **Inspection Reports** | PDF | Structured data extraction |

## 🛠️ Services

### Core Components

| Service | Purpose | Port |
|---------|---------|------|
| `compliance-api` | Main REST API | 8090 |
| `ocr-engine` | Text extraction from drawings | 8091 |
| `vision-analyzer` | Image understanding (CLIP) | 8092 |
| `document-diff` | Compare documents | 8093 |
| `rag-embedding` | Vector search for specs | 8094 |
| `compliance-db` | Pinecone vector storage | - |

## 📦 Setup

```bash
# Clone and start
git clone https://github.com/ARchemy86/vision-claw.git
cd vision-claw
docker-compose -f docker-compose.compliance.yml up -d

# Upload documents
./scripts/upload_spec.sh specification_v1.pdf
./scripts/upload_ifc.sh drawing_sheet_A1.pdf

# Run comparison
curl http://localhost:8090/api/compare \
  -F "spec=specification_v1" \
  -F "drawing=drawing_sheet_A1" \
  -F "tolerance=5%"
```

## 🔍 Compliance Checks

### Automatic Detection
- [ ] **Dimensional deviations** (+/- tolerance compare)
- [ ] **Material substitution alerts** (specified vs actual)
- [ ] **Missing elements** (components in spec but not drawing)
- [ ] **Excess elements** (in drawing but not spec)
- [ ] **Specification conflicts** (contradictory requirements)
- [ ] **Version drift** (old spec vs new drawings)

### Output Format
```json
{
  "compliance_report": {
    "drawing_id": "IFC-SHEET-A1",
    "spec_version": "v2.3",
    "compliance_score": 87,
    "issues": [
      {
        "type": "DEVIATION",
        "severity": "HIGH",
        "location": "Section C, Row 4",
        "spec_value": "10ft clearance",
        "drawing_value": "8ft clearance",
        "recommendation": "Request contractor clarification"
      },
      {
        "type": "MISSING",
        "severity": "MEDIUM", 
        "element": "Emergency shutoff valve",
        "spec_section": "4.2.1",
        "suggested_action": "Add to RFI"
      }
    ]
  }
}
```

## 🔐 Security

- Documents stored locally only
- No cloud processing
- Audit trail of all comparisons
- Encrypted at rest

## 📄 License

MIT - Built for construction compliance teams
