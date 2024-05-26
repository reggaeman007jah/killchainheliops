params ["_vic", "_coPilot"];

_vic enableCopilot true;

_coPilot action ["TakeVehicleControl", _vic];

// _coPilot moveInDriver _vic;
// _coPilot assignAsDriver _vic;
// _cpGrp move [10482.9,6510.67,0]; 