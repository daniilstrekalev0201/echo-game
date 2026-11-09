#!/usr/bin/env bash
# Собирает автономную версию игры для игровых площадок (itch.io и др.):
# three.js и шрифты кладутся рядом с index.html, интернет игре не нужен.
# Результат: release/echo-web/ (папка) и release/echo-web.zip (её архив для загрузки).
#   bash tools/build-release.sh          — версия для itch.io и сайтов
#   bash tools/build-release.sh yandex   — версия для Яндекс Игр (с их SDK): release/echo-yandex.zip
set -euo pipefail
cd "$(dirname "$0")/.."
TARGET=${1:-web}
case "$TARGET" in web|yandex) ;; *) echo "Неизвестная сборка: $TARGET (нужно web или yandex)" >&2; exit 1 ;; esac
OUT=release/echo-$TARGET
THREE=https://cdn.jsdelivr.net/npm/three@0.160.0
UA='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36'

rm -rf "$OUT"
mkdir -p "$OUT/lib/addons/geometries" "$OUT/lib/addons/environments" "$OUT/fonts"

# движок three.js (та же версия, что в игре)
curl -fsSL "$THREE/build/three.module.js" -o "$OUT/lib/three.module.js"
curl -fsSL "$THREE/examples/jsm/geometries/RoundedBoxGeometry.js" -o "$OUT/lib/addons/geometries/RoundedBoxGeometry.js"
curl -fsSL "$THREE/examples/jsm/environments/RoomEnvironment.js" -o "$OUT/lib/addons/environments/RoomEnvironment.js"
curl -fsSL "$THREE/LICENSE" -o "$OUT/lib/THREE-LICENSE.txt"

# Шрифты Barlow и Barlow Condensed. Кириллицы у Barlow в Google Fonts нет, поэтому русский текст
# (и в онлайн-версии тоже) рисуется запасным шрифтом; берём латиницу и расширенную латиницу.
CSS=$(curl -fsSL -A "$UA" "https://fonts.googleapis.com/css2?family=Barlow+Condensed:wght@500;600;700&family=Barlow:wght@400;500&display=swap")
: > "$OUT/fonts/fonts.css"
subset=""; block=""
NL=$'\n'
while IFS= read -r line; do
  case "$line" in
    "/* "*" */")
      subset=${line#"/* "}; subset=${subset%" */"}; block="" ;;
    "}")
      block+="$line$NL"
      if [ "$subset" = "latin" ] || [ "$subset" = "latin-ext" ]; then
        url=$(grep -o 'https://fonts.gstatic.com/[^)]*' <<< "$block" | head -1)
        family=$(grep -o "font-family: '[^']*'" <<< "$block" | cut -d"'" -f2 | tr -d ' ')
        weight=$(grep -o 'font-weight: [0-9]*' <<< "$block" | grep -o '[0-9]*')
        file="$family-$weight-$subset.woff2"
        curl -fsSL "$url" -o "$OUT/fonts/$file"
        printf '/* %s */\n%s' "$subset" "${block//"$url"/"$file"}" >> "$OUT/fonts/fonts.css"
      fi
      block="" ;;
    *)
      block+="$line$NL" ;;
  esac
done <<< "$CSS"
curl -fsSL "https://raw.githubusercontent.com/google/fonts/main/ofl/barlow/OFL.txt" -o "$OUT/fonts/BARLOW-OFL.txt"

# index.html: локальные пути вместо CDN
sed -e 's|https://cdn.jsdelivr.net/npm/three@0.160.0/build/three.module.js|./lib/three.module.js|' \
    -e 's|https://cdn.jsdelivr.net/npm/three@0.160.0/examples/jsm/|./lib/addons/|' \
    -e '/<link rel="preconnect" href="https:\/\/fonts.googleapis.com">/d' \
    -e 's|<link href="https://fonts.googleapis.com/css2?[^"]*" rel="stylesheet">|<link href="./fonts/fonts.css" rel="stylesheet">|' \
    index.html > "$OUT/index.html"

# Яндекс Игры: SDK отдаёт сама площадка по адресу /sdk.js; флаг включает рекламу, облачные сохранения
# и прочую интеграцию в коде игры (см. «платформа: Яндекс Игры» в index.html)
if [ "$TARGET" = yandex ]; then
  sed -i 's|^<script type="importmap">|<script src="/sdk.js"></script>\n<script>window.__ECHO_PLATFORM = '"'yandex'"';</script>\n<script type="importmap">|' "$OUT/index.html"
  grep -q "__ECHO_PLATFORM = 'yandex'" "$OUT/index.html" || { echo "ОШИБКА: не удалось подключить SDK Яндекса" >&2; exit 1; }
fi

cat > "$OUT/LICENSES.txt" <<'TXT'
ЭХО — браузерная игра.
Использованы сторонние компоненты:
- three.js 0.160.0 — MIT License, (c) 2010-2023 three.js authors. Полный текст: lib/THREE-LICENSE.txt
- Шрифты Barlow и Barlow Condensed — SIL Open Font License 1.1, (c) The Barlow Project Authors. Полный текст: fonts/BARLOW-OFL.txt
Модели, звуки и музыка созданы в коде игры.
TXT

# проверки: внешних ссылок не осталось, шрифты скачались
if grep -nE 'cdn.jsdelivr|fonts.googleapis|fonts.gstatic' "$OUT/index.html"; then echo "ОШИБКА: в index.html остались внешние ссылки" >&2; exit 1; fi
if grep -n 'fonts.gstatic' "$OUT/fonts/fonts.css"; then echo "ОШИБКА: в fonts.css остались внешние ссылки" >&2; exit 1; fi
n=$(ls "$OUT/fonts"/*.woff2 | wc -l); [ "$n" -ge 5 ] || { echo "ОШИБКА: скачалось шрифтов: $n" >&2; exit 1; }

# архив для загрузки: index.html должен лежать в корне архива
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$(cygpath -w tools/zip-release.ps1)" -Source "$(cygpath -w "$OUT")" -Destination "$(cygpath -wa release)\\echo-$TARGET.zip"
echo "Готово: $OUT и release/echo-$TARGET.zip"
