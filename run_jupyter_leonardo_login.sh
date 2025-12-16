#!/bin/bash
# find_and_launch.sh

echo "Finding available ports on Leonardo..."
echo ""

# Check which ports are free (10000-10020 range)
echo "Checking ports 10000-10020..."
for PORT in {10000..10020}; do
    if ! ssh mtagliaz@login.leonardo.cineca.it "netstat -tuln 2>/dev/null | grep -q ':$PORT '" 2>/dev/null; then
        echo "Port $PORT is FREE"
        FREE_PORT=$PORT
        break
    fi
done

if [ -z "$FREE_PORT" ]; then
    echo "No free ports found in range. Trying 11000-11020..."
    for PORT in {11000..11020}; do
        if ! ssh mtagliaz@login.leonardo.cineca.it "netstat -tuln 2>/dev/null | grep -q ':$PORT '" 2>/dev/null; then
            echo "Port $PORT is FREE"
            FREE_PORT=$PORT
            break
        fi
    done
fi

if [ -z "$FREE_PORT" ]; then
    echo "ERROR: Cannot find any free ports!"
    echo "Try: ssh mtagliaz@login.leonardo.cineca.it 'netstat -tuln | head -50'"
    exit 1
fi

echo ""
echo "🚀 Launching Jupyter on port $FREE_PORT..."
echo ""

# Start Jupyter
ssh -t -L ${FREE_PORT}:localhost:${FREE_PORT} mtagliaz@login.leonardo.cineca.it \
    "echo 'Starting Jupyter Lab on port $FREE_PORT...'; \
     jupyter-lab --no-browser --port=$FREE_PORT --ip=127.0.0.1"
