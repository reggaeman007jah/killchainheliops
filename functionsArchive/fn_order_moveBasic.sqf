/*
Tinman Advanced
This function moves a given group based on given direction and distance 

"UNCHANGED" (unchanged)
"LIMITED" (half speed)
"NORMAL" (full speed, maintain formation)
"FULL" (do not wait for any other units in formation)

*/

params ["_grp", "_dir", "_dist"];
_group = _grp select 0;

_anchor = getPos leader _group;
_dest = _anchor getPos [_dist, _dir];
_group move _dest;
_group setSpeedMode "LIMITED";
_group setCombatMode "GREEN";
systemchat format ["Group %1 moving %2m at heading %3", _group, _dist, _dir];