#!/bin/bash
# Arrange tiled windows in the focused i3 workspace into a near-square grid.
# Bound to $mod+x.

# Focused workspace name.
ws=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')

# Ordered tiled (non-floating) window container ids in that workspace.
mapfile -t wins < <(
    i3-msg -t get_tree | jq -r --arg ws "$ws" '
        [ .. | objects | select(.type=="workspace" and .name==$ws) ] | first
        | [ recurse(.nodes[]?) | select(.window != null) | .id ] | .[]
    '
)

n=${#wins[@]}
[ "$n" -lt 2 ] && exit 0

# columns = ceil(sqrt(n)); rows = ceil(n / cols)
cols=$(awk -v n="$n" 'BEGIN{ c=int(sqrt(n)); if (c*c < n) c++; print c }')
rows=$(( (n + cols - 1) / cols ))

# Stop autotiling (matched by its binary path) so it does not inject split
# commands while we restructure the tree.
at_bin=$(command -v autotiling)
at_running=false
if [ -n "$at_bin" ] && pgrep -f "$at_bin" >/dev/null; then
    at_running=true
    pkill -f "$at_bin"
    while pgrep -f "$at_bin" >/dev/null; do sleep 0.05; done
fi

# Flatten: keep the first window in place, shuttle the rest through a temp
# workspace and back, so they all return as flat children of the workspace.
tmp="grid_tmp_$$"
for w in "${wins[@]:1}"; do
    i3-msg "[con_id=$w] move container to workspace $tmp" >/dev/null
done
for w in "${wins[@]:1}"; do
    i3-msg "[con_id=$w] move container to workspace $ws" >/dev/null
done

# Build the grid column by column: wrap the first window of each column in a
# vertical split, then pull the remaining windows of that column into it.
idx=0
for (( c = 0; c < cols; c++ )); do
    i3-msg "[con_id=${wins[$idx]}] focus; split vertical" >/dev/null
    idx=$(( idx + 1 ))
    for (( r = 1; r < rows; r++ )); do
        [ "$idx" -lt "$n" ] || break
        i3-msg "[con_id=${wins[$idx]}] focus; move left" >/dev/null
        idx=$(( idx + 1 ))
    done
done

# Leave focus on the first window.
i3-msg "[con_id=${wins[0]}] focus" >/dev/null

# Restart autotiling if it was running.
if $at_running; then
    setsid -f "$at_bin" >/dev/null 2>&1
fi
