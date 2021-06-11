#!/bin/sh -x
####
## Reverse (or, in current edit, just set) touchpad scroll-event
## distance (speed).
####

set -Eeu

val="${TSS_VALUE:--15}"
id="$(
    xinput list | \
    sed -rn 's/.*([Tt]ouch|DLL07A0)[^=]*id=([0-9]+).*/\2/ p'
)"
if xinput --list-props "$id" | grep "Scrolling Distance"; then
    prop_id="$(xinput --list-props $id | grep -P ".*[^C][^i][^r][^c][^u][^l][^a][^r]\sScrolling Distance" | grep -Po '\([0-9]+\)' | grep -Po "[0-9]+")"
    prop_xy="$(xinput --list-props $id | grep -P ".*[^C][^i][^r][^c][^u][^l][^a][^r]\sScrolling Distance" | grep -Po '\s+[-+]{0,1}[0-9]+\,\s*[-+]{0,1}[0-9]+' | tr -d '-')"
    xinput --set-prop "$id" "$prop_id" "$val" "$val"
fi

if xinput --list-props "$id" | grep "Natural Scrolling"; then
    prop_id="$(xinput --list-props $id | grep -P "Natural Scrolling Enabled \(" | grep -Po '\([0-9]+\)' | grep -Po "[0-9]+")"
    xinput --set-prop "$id" "$prop_id" "1"
fi
