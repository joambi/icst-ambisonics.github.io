#!/bin/bash

# Function to stop background processes on exit
cleanup() {
    echo "Stopping servers..."
    kill $NODE_PID
    kill $HUGO_PID
    exit
}

# Set up trap to call cleanup function on script exit
trap cleanup EXIT

# Start Node.js upload server
echo "Starting Node.js upload server..."
node uploader.js &
NODE_PID=$!

# Check if Node.js server started successfully
sleep 2
if ! kill -0 $NODE_PID 2>/dev/null; then
    echo "Failed to start Node.js server"
    exit 1
fi

echo "Node.js server started with PID $NODE_PID"

# Start Hugo server with any provided arguments
echo "Starting Hugo server..."
hugo server $@ &
HUGO_PID=$!

# Check if Hugo server started successfully
sleep 2
if ! kill -0 $HUGO_PID 2>/dev/null; then
    echo "Failed to start Hugo server"
    exit 1
fi

echo "Hugo server started with PID $HUGO_PID"

# Keep the script running
wait