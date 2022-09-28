#!/bin/sh
fetch() {
    curl \
    -H 'User-Agent: Dalvik/2.1.0 (Linux; U; Android 9; ALP-AL00 Build/HUAWEIALP-AL00)' \
    -s \
    -w @wo.txt \
    -o /dev/null \
    -L \
    --connect-timeout 3 \
    $@
}

(
    curl --connect-timeout 3 "https://ipinfo.io/json" > ipinfo.json

    uma=$(fetch "https://api-umamusume.cygames.jp/")
    wf=$(fetch "https://api.worldflipper.jp/")
    kc=$(fetch "http://203.104.209.7/kcscontents/news/")
    knsb=$(fetch "https://api.konosubafd.jp/")
    krr=$(fetch "https://kirara.star-api.com/cat_news/update")

    jq -n \
        --argjson uma "$uma" \
        --argjson wf "$wf" \
        --argjson kc "$kc" \
        --argjson knsb "$knsb" \
        --argjson krr "$krr" \
        '{uma: $uma, wf: $wf, kc: $kc, knsb: $knsb, krr: $krr}' \
        > result.json
) &