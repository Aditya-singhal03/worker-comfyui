#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "--- Starting Model Download Script ---"

# Note: We are using the environment variables set in the RunPod Endpoint config.
# Make sure HUGGINGFACE_ACCESS_TOKEN and CIVITAI_API_KEY are set there.

# --- Create all necessary model directories ---
echo "Creating model directories..."
mkdir -p \
    /comfyui/models/vae \
    /comfyui/models/clip_vision \
    /comfyui/models/t5_text_encoders \
    /comfyui/models/loras \
    /comfyui/models/rife \
    /comfyui/models/upscale_models \
    /comfyui/models/checkpoints \
    /comfyui/models/text_encoders

# --- Download all models using wget ---
echo "Downloading VAE models..."
wget -O /comfyui/models/vae/Wan2_1_VAE_bf16.safetensors "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2_1_VAE_bf16.safetensors?download=true"

echo "Downloading CLIP Vision models..."
wget -O /comfyui/models/clip_vision/clip_vision_h.safetensors "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors?download=true"

echo "Downloading Text Encoders..."
wget -O /comfyui/models/text_encoders/umt5-xxl-enc-bf16.safetensors "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/umt5-xxl-enc-bf16.safetensors?download=true"

echo "Downloading LoRA models..."
wget -O /comfyui/models/loras/Wan21_T2V_14B_lightx2v_cfg_step_distill_lora_rank32.safetensors "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan21_T2V_14B_lightx2v_cfg_step_distill_lora_rank32.safetensors?download=true"
wget -O /comfyui/models/loras/BouncyWalkV01.safetensors "https://huggingface.co/dnad244/wan_loras/resolve/main/BouncyWalkV01.safetensors?download=true"

echo "Downloading RIFE models..."
wget -O /comfyui/models/rife/rife49.pth "https://huggingface.co/Isi99999/Frame_Interpolation_Models/resolve/main/rife49.pth?download=true"

echo "Downloading Upscale models..."
RUN wget -O "/comfyui/models/upscale_models/4xLSDIR.pth" "https://github.com/Phhofm/models/raw/main/4xLSDIR/4xLSDIR.pth"

echo "Downloading main Checkpoint (this will take the longest)..."
wget -O /comfyui/models/checkpoints/wan2.1_i2v_720p_14B_bf16.safetensors "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/diffusion_models/wan2.1_i2v_720p_14B_bf16.safetensors?download=true"

echo "--- Model Download Script Finished Successfully ---"

# Now, execute the original start command to launch the worker handler
exec /start.sh