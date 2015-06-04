#!/bin/sh
####
## Reverse (or, in current edit, just set) touchpad scroll-event
## distance (speed).
#### 

id=`xinput list | grep -Po "[Tt]ouch[^=]*id=[0-9]+" | grep -Po [0-9]+`
xinput --list-props $id | grep "Scrolling Distance"
prop_id=`xinput --list-props $id | grep -P ".*[^C][^i][^r][^c][^u][^l][^a][^r]\sScrolling Distance" | grep -Po '\([0-9]+\)' | grep -Po "[0-9]+"`
echo "$prop_id"
prop_xy=`xinput --list-props $id | grep -P ".*[^C][^i][^r][^c][^u][^l][^a][^r]\sScrolling Distance" | grep -Po '\s+[-+]{0,1}[0-9]+\,\s*[-+]{0,1}[0-9]+' | tr -d '-'`
echo "$prop_xy"
# xinput --list-props $id | grep -P ".*[^C][^i][^r][^c][^u][^l][^a][^r]\sScrolling Distance" | grep -Po '\s+[-+]?[0-9]+[,]?' | tr -d '-' | tr -d ',' | tr ' \t' '-' | xargs echo xinput --set-prop $id $prop_id
echo xinput --set-prop "$id" "$prop_id" -15 -15
xinput --set-prop "$id" "$prop_id" -15 -15
