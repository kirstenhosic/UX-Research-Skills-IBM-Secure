#!/bin/sh
# Build the .skill packages from their source directories.
#
# A .skill file is a zip. It is what gets installed; the matching directory
# under skills/ is what gets reviewed. Edit the source, run this, commit both —
# a .skill that disagrees with its source is the one file in this repo nobody
# can check.
#
# The build is reproducible: same source, same bytes. A zip records each file's
# mtime, and a fresh clone or checkout rewrites those, so building without
# pinning them produces a new binary on every run with identical content inside.
# That diff is noise, and noise in the one file nobody can read is how a .skill
# drifts from its source without anyone noticing.
set -e
cd "$(dirname "$0")"
SKILLS="research-readout-deck research-findings-report research-participant-summary"
STAMP=202001010000.00   # fixed; the archives are content-addressed, not dated

for NAME in $SKILLS; do
  SRC=skills/$NAME
  OUT=$NAME.skill

  [ -f "$SRC/SKILL.md" ] || { echo "missing $SRC/SKILL.md" >&2; exit 1; }

  TMP=$(mktemp -d)
  trap 'rm -rf "$TMP"' EXIT
  cp -R "$SRC" "$TMP/$NAME"
  find "$TMP" -exec touch -t "$STAMP" {} +

  rm -f "$OUT"
  (cd "$TMP" && zip -q -r -X "$OLDPWD/$OUT" "$NAME" -x '.*' -x '__MACOSX/*')
  rm -rf "$TMP"
  echo "built $OUT"
done
