#!/bin/bash

# Colores
RED='\033[91m'
NC='\033[0m' # SIn color

FILE_PATH="$1"
CSV_FILE="health_check_results.csv"

# Crear CSV
echo "timestamp,url,status_code,response_time_ms,estado" > "$CSV_FILE"

# Iterar sobre cada URL leída del archivo
while IFS= read -r url || [ -n "$url" ]; do
    # Ignorar líneas vacías
    if [ -z "$url" ]; then
        continue
    fi

    # Obtener timestamp 
    timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    
    #  Ejecutar cURL con timeout de 5 segundos 
    curl_output=$(curl -s -o /dev/null -w "%{http_code},%{time_total}" -m 5 "$url")
    exit_status=$? # Capturar el código de salida de cURL

    # Extraer variables separando por la coma
    http_code=$(echo "$curl_output" | cut -d',' -f1)
    time_total=$(echo "$curl_output" | cut -d',' -f2)

    # Lógica de evaluación de estado
    if [ $exit_status -eq 28 ]; then
        # Código 28 en cURL significa "Operation timeout"
        estado="DOWN (Timeout)"
        http_code="N/A"
        time_ms="N/A"
        
        # Imprimir en rojo
        echo -e "${RED}[CAÍDA] $url - Timeout: 5 segundos sin respuesta${NC}"
        
    elif [ $exit_status -ne 0 ]; then
        # Cualquier otro error de red 
        estado="DOWN (Red)"
        http_code="N/A"
        time_ms="N/A"
        
        echo -e "${RED}[CAÍDA] $url - Error de red (código cURL: $exit_status)${NC}"
        
    else
        # Transformar los segundos 
        time_ms=$(echo "$time_total" | awk '{print int($1 * 1000)}')

        # Evaluar si el código HTTP es 2xx o 3xx 
        if [[ "$http_code" =~ ^[23] ]]; then
            estado="UP"
            echo -e "[ARRIBA] $url - ${time_ms}ms"
        else
            # Errores 4xx y 5xx
            estado="DOWN"
            echo -e "${RED}[CAÍDA] $url - HTTP $http_code${NC}"
        fi
    fi

    # Agregar al csv
    echo "$timestamp,$url,$http_code,$time_ms,$estado" >> "$CSV_FILE"

done < "$FILE_PATH"
echo -e "\nVerificación completa. Resultados en: $CSV_FILE"