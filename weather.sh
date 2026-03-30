#!/usr/bin/env bash

set -euo pipefail

WTTR_URL="https://wttr.in/Yukuhashi?format=j1"
OPEN_METEO_BASE_URL="https://api.open-meteo.com/v1/forecast"

extract_first_quoted_value() {
  local json="$1"
  local key="$2"

  printf '%s' "$json" |
    tr -d '\n' |
    grep -o "\"$key\"[[:space:]]*:[[:space:]]*\"[^\"]*\"" |
    head -n 1 |
    cut -d '"' -f 4
}

extract_array_values() {
  local json="$1"
  local key="$2"

  printf '%s' "$json" |
    grep -o "\"$key\"[[:space:]]*:[[:space:]]*\\[[^]]*\\]" |
    head -n 1 |
    sed -E "s/\"$key\"[[:space:]]*:[[:space:]]*\\[([^]]*)\\]/\\1/" |
    tr -d '"' |
    tr ',' '\n'
}

weather_label() {
  case "$1" in
    0) echo "快晴" ;;
    1) echo "晴れ" ;;
    2) echo "晴れ時々曇り" ;;
    3) echo "曇り" ;;
    45|48) echo "霧" ;;
    51|53|55|56|57) echo "霧雨" ;;
    61|63|65|66|67|80|81|82) echo "雨" ;;
    71|73|75|77|85|86) echo "雪" ;;
    95|96|99) echo "雷雨" ;;
    *) echo "不明" ;;
  esac
}

wttr_json=$(curl -fsSL "$WTTR_URL")
latitude=$(extract_first_quoted_value "$wttr_json" "latitude")
longitude=$(extract_first_quoted_value "$wttr_json" "longitude")

if [[ -z "$latitude" || -z "$longitude" ]]; then
  echo "wttr.in から行橋市の座標を取得できませんでした。" >&2
  exit 1
fi

# wttr.in の無料JSONは 3 日分のため、7 日分の詳細は同地点の別APIで補完する。
forecast_json=$(curl -fsSL \
  "$OPEN_METEO_BASE_URL?latitude=$latitude&longitude=$longitude&daily=weather_code,temperature_2m_max,temperature_2m_min,precipitation_probability_max&forecast_days=7&timezone=Asia%2FTokyo")
forecast_json=$(printf '%s' "$forecast_json" | tr -d '\n')

dates=()
weather_codes=()
max_temps=()
min_temps=()
rain_probs=()

while IFS= read -r value; do
  dates+=("$value")
done < <(extract_array_values "$forecast_json" "time")

while IFS= read -r value; do
  weather_codes+=("$value")
done < <(extract_array_values "$forecast_json" "weather_code")

while IFS= read -r value; do
  max_temps+=("$value")
done < <(extract_array_values "$forecast_json" "temperature_2m_max")

while IFS= read -r value; do
  min_temps+=("$value")
done < <(extract_array_values "$forecast_json" "temperature_2m_min")

while IFS= read -r value; do
  rain_probs+=("$value")
done < <(extract_array_values "$forecast_json" "precipitation_probability_max")

if [[ ${#dates[@]} -eq 0 ]]; then
  echo "週間天気予報の取得に失敗しました。" >&2
  exit 1
fi

printf '| 日付 | 天気 | 最高気温 | 最低気温 | 降水確率 |\n'
printf '|------|------|---------|---------|---------|\n'

for i in "${!dates[@]}"; do
  printf '| %s | %s | %s°C | %s°C | %s%% |\n' \
    "${dates[$i]}" \
    "$(weather_label "${weather_codes[$i]}")" \
    "${max_temps[$i]}" \
    "${min_temps[$i]}" \
    "${rain_probs[$i]}"
done
