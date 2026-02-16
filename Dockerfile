# Use a compatible Python version (e.g., Python 3.10 or 3.9)
FROM python:3.10-slim

# Set the working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    git-lfs \
    ffmpeg \
    libsm6 \
    libxext6 \
    cmake \
    rsync \
    libgl1 \
    && rm -rf /var/lib/apt/lists/* \
    && git lfs install

# Install pip and dependencies
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy the application files
COPY . /app

# Install other dependencies like Gradio with specific version for compatibility
RUN pip install --no-cache-dir gradio==2.9.0 \
    uvicorn[standard] \
    websockets>=10.4 \
    spaces

# Expose the port for the FastAPI server
EXPOSE 8000

# Command to run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
