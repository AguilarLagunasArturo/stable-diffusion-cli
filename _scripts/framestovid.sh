#!/bin/bash

# Set the path to the directory containing the frames
frames_dir="$1"

# Set the path to the reference video
ref_video="$2"

# Set the output file name and path
output_file="$3"

# Get the duration of the reference video
duration=$(ffprobe -i "$ref_video" -show_entries format=duration -v quiet -of csv="p=0")

# Get the number of frames in the frames directory
num_frames=$(ls -1 "$frames_dir"/*.png | wc -l)

# Calculate the frame rate as the number of frames divided by the duration of the reference video
frame_rate=$(echo "scale=2; $num_frames/$duration" | bc)

echo -e $duration
echo -e $num_frames
echo -e $frame_rate

# Use ffmpeg to render the frames into a video with the same length and audio as the reference video
# ffmpeg -r "$frame_rate" -i "$frames_dir/%04d.png" -i "$ref_video" -map 0:v -map 1:a -c:v libx264  -pix_fmt yuv420p -preset medium -crf 23 -c:a copy "$output_file"

ffmpeg -framerate "$frame_rate" -pattern_type glob -i "$frames_dir/*.png" -i "$ref_video"  -map 0:v -map 1:a -pix_fmt yuv420p -c:a aac -b:a 192k -shortest "$output_file"
