#!/bin/bash
set -e

# Avvia Ollama in background
ollama serve &
OLLAMA_PID=$!

# Controlla se il servizio Ollama è in esecuzione

# Aspetta che il servizio Ollama sia pronto utilizzando /dev/tcp (funzionalità nativa di bash)
echo "Attendendo che il servizio Ollama sia pronto..."
MAX_RETRY=30
count=0
while [ $count -lt $MAX_RETRY ]; do
  if timeout 1 bash -c "echo > /dev/tcp/localhost/11434" 2>/dev/null; then
    echo "Servizio Ollama pronto all'uso!"
    break
  fi
  echo "Tentativo $((count+1))/$MAX_RETRY: Ollama non ancora pronto..."
  sleep 2
  count=$((count+1))
done

if [ $count -eq $MAX_RETRY ]; then
  echo "Impossibile connettersi a Ollama dopo $MAX_RETRY tentativi."
  exit 1
fi

echo "Scaricando il modello gemma3:1b..."
ollama pull gemma3:1b

# Crea un file per segnalare che il download è completato
touch /tmp/model_ready

# Mantieni il processo Ollama in esecuzione in primo piano
wait $OLLAMA_PID