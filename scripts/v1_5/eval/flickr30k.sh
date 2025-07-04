#!/bin/bash

# Set paths
MODEL_PATH="./llava-v1.5-7b"
IMAGE_FOLDER="/home/jinglong/.cache/kagglehub/datasets/hsankesara/flickr-image-dataset/versions/1/flickr30k_images/flickr30k_images"
QUESTION_FILE="./data/flickr30k/question.json"
ANSWERS_FILE="./data/flickr30k/answers/llava-v1.5-7b.jsonl"

# Create answers directory if it doesn't exist
mkdir -p ./data/flickr30k/answers

# Generate question.json if it doesn't exist
if [ ! -f "$QUESTION_FILE" ]; then
    echo "Generating question.json file..."
    python generate_flickr30k_questions.py
fi

echo "Running Flickr30k evaluation..."
python -m llava.eval.model_caption_loader \
    --model-path $MODEL_PATH \
    --question-file $QUESTION_FILE \
    --image-folder $IMAGE_FOLDER \
    --answers-file $ANSWERS_FILE \
    --temperature 0 \
    --conv-mode vicuna_v1

echo "Flickr30k evaluation completed!"
