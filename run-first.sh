#!/bin/bash

# Script to install and configure NVIDIA Docker runtime
# Run this before docker-compose up if you want GPU acceleration

set -e  # Exit on any error

echo "🔧 Setting up NVIDIA Docker runtime for GPU acceleration..."

# Check if running as root or with sudo
if [[ $EUID -eq 0 ]]; then
    SUDO=""
else
    SUDO="sudo"
fi

# Check if nvidia-smi is available (NVIDIA drivers installed)
if ! command -v nvidia-smi &> /dev/null; then
    echo "❌ NVIDIA drivers not found. Please install NVIDIA drivers first."
    echo "   Visit: https://www.nvidia.com/drivers"
    exit 1
fi

echo "✅ NVIDIA drivers found"

# Add NVIDIA container toolkit repository
echo "📦 Adding NVIDIA container toolkit repository..."
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | $SUDO gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg

curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
  sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
  $SUDO tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Update package list
echo "🔄 Updating package list..."
$SUDO apt-get update

# Install NVIDIA container toolkit
echo "📥 Installing NVIDIA container toolkit..."
$SUDO apt-get install -y nvidia-container-toolkit

# Configure Docker to use NVIDIA runtime
echo "⚙️  Configuring Docker daemon for NVIDIA runtime..."
$SUDO nvidia-ctk runtime configure --runtime=docker

# Restart Docker daemon
echo "🔄 Restarting Docker daemon..."
$SUDO systemctl restart docker

# Test GPU access
echo "🧪 Testing GPU access in Docker..."
if docker run --rm --gpus all nvidia/cuda:11.0.3-base-ubuntu20.04 nvidia-smi > /dev/null 2>&1; then
    echo "✅ GPU acceleration is working!"
    echo "🚀 You can now run: docker-compose up"
else
    echo "❌ GPU test failed. Please check your setup."
    exit 1
fi
