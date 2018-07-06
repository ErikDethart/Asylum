/*
	File: fn_charge.sqf
	Author: John "Paratus" VanderZwet

	Description:
	Prompts to add a charge to a player
*/

life_charged = cursorTarget;
if (isNull life_charged || !isPlayer life_charged || !alive life_charged) exitWith {};
if (!isNull (findDisplay 5520)) exitWith {}; //Already at the menu, block for abuse?

createDialog "life_charge_diag";
disableSerialization;
waitUntil {!isNull (findDisplay 5520)};
_display = findDisplay 5520;
_control = _display displayCtrl 5521;

_charges = [
	["141","Aiding escape from custody"],
	["215","Attempted Auto Theft"],
	["2113A","Attempted Bank Robbery"],
	["214","Attempted Manslaughter"],
	["lowair","Aviation altitude violation"],
	["can","Cannabalism"],
	["dwc","Discharge Within City Limits"],
	["order","Disobeying an Order from an Officer"],
	["div","Driving an Illegal Vehicle"],
	["duv","Driving Unregistered Vehicle"],
	["dt","Drug Trafficking"],
	["evade","Evading Arrest"],
	["fth","Failure to Headlight"],
	["fts","Failure to Stop"],
	["487","Grand Theft"],
	["har","Harassment"],
	["id","Identity Fraud"],
	["isr","Illegal Street Racing"],
	["207","Kidnapping"],
	["pdm","Money Laundering"],
	["org","Organ Theft"],
	["488","Petty Theft"],
	["check","Police Checkpoint Gates"],
	["coc","Possession of Cocaine"],
	["1091","Possession of Explosives"],
	["her","Possession of Heroin"],
	["pif","Possession of Illegal Firearm"],
	["pil","Possession of Illegal Liquor"],
 	["mar","Possession of Marijuana"],
	["met","Possession of Meth/Crank/Ephedra"],
	["pcp","Possession of PCP"],
	["poseq","Possession of Police Equipment"],
	["gold","Possession of Reserve Gold"],
	["tur","Possession of Turtle/Dog Meat"],
	["pi","Public Intoxication"],
	["261","Rape"],
	["rdr","Reckless Driving"],
	["211","Robbery"],
	["spd","Speeding"],
	["terror","Terrorism"],
	["threat","Threatening an Officer"],
	["park","Unauthorized Parking"],
	["trw","Weapons Trafficking (2+ Rifles)"]
];

// Load up charges
{

	_control lbAdd (_x select 1);
	_control lbSetData [(lbSize _control)-1,(_x select 0)];
} foreach _charges;

lbSetCurSel [5521,0];
