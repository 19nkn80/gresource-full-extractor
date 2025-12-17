#!/bin/bash
# Extrahiert eine gresource-Datei vollständig in ein Verzeichnis / Extracts a gresource file completely into a directory

set -e

if [ "$#" -ne 1 ]; then
echo "Verwendung: $0 <dateiname.gresource>"
exit 1
fi

RESOURCE_FILE="$1"
OUTPUT_DIR="${RESOURCE_FILE%.gresource}"

mkdir -p "$OUTPUT_DIR"
echo "Extrahiere Ressourcen aus $RESOURCE_FILE nach $OUTPUT_DIR"

gresource list "$RESOURCE_FILE" | while read -r resource_path; do
filepath="${resource_path#/}"
target="$OUTPUT_DIR/$filepath"

mkdir -p "$(dirname "$target")"
gresource extract "$RESOURCE_FILE" "$resource_path" > "$target"

echo " Extrahiert: $resource_path"
done

echo "Fertig"

#Anwendungsbeispiel / How to use:
# Speichern Sie dieses Skript als gextract.sh, machen Sie es ausführbar mit chmod +x gextract.sh / Save this script as gextract.sh, make it executable with chmod +x gextract.sh
# Führen Sie es aus mit ./gextract.sh dateiname.gresource / Run it with ./gextract.sh filename.gresource
# Die extrahierten Dateien werden im Verzeichnis dateiname/ gespeichert / The extracted files will be saved in the directory filename/
