# Vision Claw 👁️🐾

Vision-based automation and perception system built with OpenClaw, Docker, and MCP.

## 🎯 What This Is

Vision Claw brings computer vision capabilities to your OpenClaw setup:
- 📷 Image analysis and understanding
- 🔍 Object detection and recognition  
- 👤 Face detection and analysis
- 📝 OCR (text extraction from images)
- 🎥 Video stream processing
- 🤖 Vision-to-action automation

## 🏗️ Architecture

```
┌─────────────────┐
│   OpenClaw      │
│   Agent         │
└────────┬────────┘
         │
┌────────▼────────┐
│   Vision Claw   │
│   MCP Server    │
└────────┬────────┘
         │
┌────────▼────────┐
│  Docker         │
│  Containers     │
└────────┬────────┘
         │
┌────────▼────────┐
│  Vision Models  │
│  (CLIP, YOLO,   │
│   GPT-4V, etc)  │
└─────────────────┘
```

## 🛠️ Components

### Core Services
| Service | Purpose | Port |
|---------|---------|------|
| `vision-api` | Main vision processing API | 8080 |
| `clip-model` | Image embedding & search | 8081 |
| `yolo-detector` | Object detection | 8082 |
| `ocr-service` | Text extraction | 8083 |
| `face-recognition` | Face detection/analysis | 8084 |

### MCP Integration
- **Tools**: `analyze_image`, `detect_objects`, `extract_text`, `find_faces`
- **Transport**: stdio via Docker
- **Auth**: Local API keys

## 📦 Setup

### Prerequisites
- Docker Desktop
- OpenClaw with MCP support
- 8GB+ RAM (for vision models)

### Quick Start

```bash
# Clone this repo
git clone https://github.com/ARchemy86/vision-claw.git
cd vision-claw

# Start services
docker-compose up -d

# Configure OpenClaw MCP
# Add to your openclaw.json:
{
  "mcpServers": {
    "vision": {
      "command": "docker",
      "args": ["run", "--rm", "-i", "-p", "8080:8080", "vision-claw:latest"]
    }
  }
}
```

## 🚀 Usage

Once running, ask OpenClaw:

> "Analyze this image: [upload image]"
> 
> "Find all people in this photo"
> 
> "Extract text from this screenshot"
> 
> "What objects are in this video frame?"

## 📊 Example Output

```json
{
  "analysis": {
    "objects": [
      {"label": "person", "confidence": 0.98, "bbox": [100, 200, 300, 400]},
      {"label": "laptop", "confidence": 0.95, "bbox": [400, 300, 600, 500]}
    ],
    "text": ["Meeting Notes", "Project Alpha"],
    "faces": 2,
    "scene": "office_workspace"
  }
}
```

## 🔧 Configuration

### Environment Variables
| Variable | Default | Description |
|----------|---------|-------------|
| `VISION_MODEL` | `clip` | Default vision model |
| `CONFIDENCE_THRESHOLD` | `0.7` | Minimum detection confidence |
| `MAX_IMAGE_SIZE` | `4096` | Max image dimension |

### Supported Models
- **CLIP**: Image understanding, similarity search
- **YOLO v8**: Real-time object detection
- **PaddleOCR**: Text extraction (multilingual)
- **FaceNet**: Face recognition
- **GPT-4V API**: Advanced vision reasoning

## 🧪 Testing

```bash
# Test vision API
curl -X POST http://localhost:8080/analyze \
  -F "image=@test_image.jpg"

# Test object detection
curl -X POST http://localhost:8080/detect \
  -F "image=@scene.jpg" \
  -F "objects=person,car,dog"
```

## 🔒 Security

- Local processing (no cloud required)
- API key authentication
- Input validation on all images
- Sandboxed Docker containers

## 🤝 Integration with Your Stack

Vision Claw connects to:
- ✅ OpenClaw agents
- ✅ n8n workflows
- ✅ Grafana dashboards
- ✅ Jellyfin (thumbnail generation)
- ✅ Ignition SCADA (industrial vision)

## 📚 Roadmap

- [ ] Video stream processing
- [ ] Real-time object tracking
- [ ] Custom model training
- [ ] Multi-camera support
- [ ] Edge device deployment

## 📄 License

MIT License - Feel free to use and modify!

---

Built with ❤️ using OpenClaw + Docker + MCP
