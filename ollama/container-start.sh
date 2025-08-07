#!/bin/sh
ollama serve &
sleep 5
ollama pull gpt-oss:20b
wait
