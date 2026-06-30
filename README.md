# NeuralBeat 🎵

> AI-powered music generation using an LSTM neural network trained on classical and jazz MIDI.

![NeuralBeat](https://img.shields.io/badge/Stack-React%20%2B%20FastAPI%20%2B%20TensorFlow-7C3AED)
![License](https://img.shields.io/badge/License-MIT-06B6D4)

---

## Quick Start

### Requirements
- **Python 3.10+**
- **Node.js 18+**
- (Optional) FluidSynth + soundfont for WAV export

### 1. Start the Backend

```bat
start-backend.bat
```

This will:
1. Create a Python virtual environment in `backend/.venv/`
2. Install all Python dependencies
3. Generate 20 synthetic MIDI training files
4. Start the FastAPI server at **http://localhost:8000**

> 📄 API docs available at http://localhost:8000/docs

### 2. Start the Frontend

Open a second terminal:

```bat
start-frontend.bat
```

Opens the React app at **http://localhost:5173**

---

## Features

| Feature | Description |
|---|---|
| 🎹 Piano Roll Visualizer | Canvas-based note display, color-coded by pitch |
| ▶️ In-Browser Playback | Tone.js synthesizes MIDI notes live |
| 🧠 LSTM Generation | 3-layer LSTM trained on classical/jazz MIDI |
| 🎛️ Full Controls | Genre, BPM, temperature, sequence length, seed note |
| 📥 MIDI Export | Download generated compositions as `.mid` |
| 🔊 WAV Export | Convert to WAV via FluidSynth (if installed) |
| 📜 History | SQLite-backed generation history with reload/delete |
| 🏋️ Train Model | Trigger LSTM training from the UI with live progress |

---

## Backend API

| Endpoint | Method | Description |
|---|---|---|
| `/health` | GET | Health check + model status |
| `/train` | POST | Start LSTM training (background) |
| `/train/status/{job_id}` | GET | Poll training progress |
| `/generate` | POST | Generate a new MIDI composition |
| `/convert-to-wav` | POST | Convert MIDI → WAV (FluidSynth) |
| `/history` | GET | List past generations |
| `/history/{id}` | DELETE | Delete a generation |
| `/files/generated/{file}` | GET | Download generated files |

---

## File Structure

```
ai/
├── backend/
│   ├── main.py              # FastAPI app + all endpoints
│   ├── model.py             # LSTM model + training + generation
│   ├── midi_utils.py        # MIDI parsing, encoding, file writing
│   ├── database.py          # SQLAlchemy + SQLite
│   ├── schemas.py           # Pydantic models
│   ├── generate_midi_data.py # Synthetic MIDI generator (run once)
│   ├── requirements.txt
│   ├── data/
│   │   ├── midi/            # Raw MIDI training files (20 generated)
│   │   └── processed/       # Preprocessed sequences (.pkl)
│   ├── models/              # Saved Keras models
│   └── generated/           # Output MIDI/WAV files
│
├── frontend/
│   └── src/
│       ├── App.jsx
│       ├── components/      # HeroSection, GeneratorPanel, PianoRoll, etc.
│       ├── hooks/           # useGenerate, usePlayback, useHistory
│       └── api/client.js
│
├── start-backend.bat
├── start-frontend.bat
└── README.md
```

---

## Training the LSTM Model

1. Open the app at `http://localhost:5173`
2. Click **"Train Model"** in the navbar
3. Select genre (Classical / Jazz / Hybrid) and epochs
4. Click **"Start Training"** — progress is tracked live

> **Note:** Training 20 epochs takes ~2-5 minutes on CPU. For better results, use 50+ epochs.
> The heuristic generator works without training and produces musical output immediately.

---

## WAV Export

WAV export requires FluidSynth:

```bash
# Windows (via Chocolatey)
choco install fluidsynth

# Then download a soundfont and place at:
# C:/soundfonts/FluidR3_GM.sf2
```

MIDI export always works without any extra dependencies.

---

## Tech Stack

- **Frontend:** React 19 + Vite + Tailwind CSS v4 + Framer Motion + Tone.js
- **Backend:** FastAPI + Uvicorn + SQLAlchemy (SQLite)
- **ML:** TensorFlow/Keras (LSTM) + pretty_midi + midiutil
- **Icons:** Lucide React
