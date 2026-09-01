#!/bin/sh
# Build research-readout-deck.skill from its source directory.
#
# The .skill file is a zip. It is what gets installed; skills/research-readout-deck/
# is what gets reviewed. Edit the source, run this, commit both — a .skill that
# disagrees with its source is the one file in this repo nobody can check.
set -e
cd "$(dirname "$0")"
SRC=skills/research-readout-deck
OUT=research-readout-deck.skill

[ -f "$SRC/SKILL.md" ] || { echo "missing $SRC/SKILL.md" >&2; exit 1; }

rm -f "$OUT"
(cd skills && zip -q -r -X "../$OUT" research-readout-deck -x '.*' -x '__MACOSX/*')
echo "built $OUT"
unzip -l "$OUT"
