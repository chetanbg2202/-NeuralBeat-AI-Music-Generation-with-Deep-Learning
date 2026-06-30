@echo off
echo ============================================================
echo  NeuralBeat Backend Setup ^& Start
echo ============================================================
echo.

REM Navigate to backend
cd /d "%~dp0backend"

REM Create virtual environment if missing
if not exist ".venv" (
    echo [1/3] Creating Python virtual environment...
    python -m venv .venv
    if errorlevel 1 (
        echo ERROR: Python not found. Please install Python 3.10+
        pause
        exit /b 1
    )
)

REM Activate venv
echo [2/3] Activating virtual environment...
call .venv\Scripts\activate.bat

REM Install dependencies
echo [3/3] Installing Python dependencies...
pip install -q -r requirements.txt

REM Generate MIDI training data if not present
python -c "import os; files = [f for f in os.listdir('data/midi') if f.endswith('.mid')]; print(f'MIDI files: {len(files)}')"
for /f %%i in ('python -c "import os; print(len([f for f in os.listdir('data/midi') if f.endswith('.mid')]))"') do set MIDI_COUNT=%%i
if %MIDI_COUNT% LSS 5 (
    echo Generating synthetic MIDI training data...
    python generate_midi_data.py
)

echo.
echo ============================================================
echo  Starting NeuralBeat API on http://localhost:8000
echo  API Docs: http://localhost:8000/docs
echo ============================================================
echo.
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
