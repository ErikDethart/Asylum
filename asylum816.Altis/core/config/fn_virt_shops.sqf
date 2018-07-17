/*
	File: fn_virt_shops.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Config for virtual shops.
	
	FORMAT:
	[Shop Name,
		[buy],
		[sell]
	]
*/
private _shop = _this select 0;


_items = switch (_shop) do
{
	case "rebel" : {
		["Rebel Market",
			["water","apple","redgull","adrenalineShot","fuelF","tbacon","painkillers","towRope","lockpick","ziptie","blindfold","vammo","boltCutter","demoCharge","drill","speedbomb","razorwire","bagwallshort","bagwalllong","bagwallround"],
			["water","apple","redgull","adrenalineShot","fuelF","tbacon","painkillers","towRope","lockpick","ziptie","blindfold","goldbar","dirty_money"]
		]
	};
	case "turf" : {
		["Turf Market",
			["water","apple","redgull","adrenalineShot","fuelF","tbacon","painkillers","towRope","lockpick","ziptie","blindfold","boltCutter","drill","razorwire","bagwallshort","bagwalllong","bagwallround"],
			["water","apple","redgull","adrenalineShot","fuelF","tbacon","painkillers","towRope","lockpick","ziptie","blindfold","goldbar"]
		]
	};
	case "gas" : {
		["Gas Station Market",
			["water","apple","redgull","tbacon","kebab","donerkebab","fuelF","towRope","nitro","tracker","caralarm","airalarm","campfire"],
			["water","apple","redgull","tbacon","fuelF","towRope","nitro","tracker","caralarm","airalarm","campfire"]
		]
	};
	case "market": {
		[format["%1 Market", worldName],
			["water","apple","peach","beer","redgull","tbacon","kebab","donerkebab","painkillers","yeast","woodaxe","shovel","skinningknife","campfire","tent1","tent2","fuelF","pickaxe","phos","hydro","excavator","caralarm","lootcrate1","lootcrate2","lootcrate3"],
			["water","rabbit","apple","peach","chicken","chickenp","snake","snakep","rabbitp","goat","goatp","sheep","sheepp","redgull","tbacon","painkillers","yeast","towRope","skinningknife","timber","timberl","timberh","campfire","tent1","tent2","fuelF","pickaxe","phos","hydro","excavator","caralarm","berry","banana","ginger","sugar","sugarcane"]
		]
	};
	case "redburger": {
		["Red Burger",
			["redburger","soda","water","coffee","beer"],
			[]
		]
	};
	case "hospital": {
		["Asylum Hospital",
			["adrenalineShot","defib","bloodbag","splint","painkillers","marijuanam"],
			["marijuanam"]
		]
	};
	case "wongs": {
		["Wong's Food & Liquor",
			["yeast"],
			["turtlesoup","turtle","dog","dogp","moonshine","scotch_0","scotch_1","scotch_2","scotch_3","whiskeyc_0","whiskeyc_1","whiskeyc_2","whiskeyc_3","whiskeyr_0","whiskeyr_1","whiskeyr_2","whiskeyr_3","manfleshp"]
		]
	};
	case "coffee": {
		["Stratis Coffee Club",
			["coffee","donuts"],
			[]
		]
	};
	case "heroin": {
		["Drug Dealer",
			["pcp"],
			["cocainep","heroinp","marijuana","marijuanam","meth","ephedra","pcp","crank","crankp"]
		]
	};
	case "oil": {
		["Oil Trader",
			["oilp","pickaxe","fuelF","rubber"],
			["oilp","pickaxe","fuelF","rubber"]
		]
	};
	case "fishmarket": {
		[format["%1 Fish Market", worldName],
			["salema","ornate","mackerel","mullet","tuna","catshark"],
			["salema","ornate","mackerel","mullet","tuna","catshark"]
		]
	};
	case "glass": {
		["Glass Dealer",
			["glass"],
			["glass"]
		]
	};
	case "diamond": {
		["Jewelery Store",
			["diamondc","diamondf","ruby","pearl","doubloon","silverpiece","pickaxe"],
			["diamond","diamondc","diamondf","ruby","pearl","doubloon","silverpiece","pickaxe","treasure"]
		]
	};
	case "salt": {
		["Salt Dealer",
			["salt_r"],
			["salt_r"]
		]
	};
	case "cop": {
		["Cop Item Shop",
			["donuts","coffee","water","apple","redgull","fuelF","spikeStrip","roadCone","roadBarrier","cncBarrier","cncBarrierL","barGate","painkillers"],
			["donuts","coffee","water","apple","redgull","fuelF","spikeStrip","roadCone","roadBarrier","cncBarrier","cncBarrierL","barGate","painkillers"]
		]
	};
	case "commod": {
		["Commodities Trader",
			["diamondc","iron_r","copper_r","woodaxe","pickaxe","glass","rubber","oilp"],
			["diamond","diamondc","iron_r","copper_r","pickaxe","glass","rubber","oilp","timber","timberl","timberh","plank","sugar","plankl","plankh"]
		]
	};
	case "home": {
		["Home Improvement",
			["storage1","storage2","tent1","tent2","agingbarrel","woodaxe","lootcrate1","lootcrate2","lootcrate3"],
			["tent1","tent2","agingbarrel","woodaxe"]
		]
	};
	case "vig": {
		["Bounty Hunter Shop",
			["water","apple","redgull","fuelF","tbacon","ziptie"],
			["water","apple","redgull","fuelF","tbacon","ziptie"]
		]
	};
	case "skiptracer": {
		["Skiptracer Shop",
			["water","apple","redgull","fuelF","tbacon","ziptie","lockpick","blindfold","painkillers","redgull","adrenalineShot","fuelF"],
			["water","apple","redgull","fuelF","tbacon","ziptie"]
		]
	};
	case "toasty": {
		["Toasty Palace",
			["toasty","kebab","donerkebab","soda","water","coffee","beer"],
			[]
		]
	};
	case "sandwich": {
		["Sandwich Palace",
			["sandwich","kebab","donerkebab","soda","water","coffee","beer"],
			[]
		]
	};
	case "blackmarket": {
		["Blackmarket",
			["oilp"],
			["manflesh"]
		]
	};
};

if ({player distance2D getMarkerPos format["turf_label_%1",_x] < 200} count [1,2,3] > 0) then {(_items select 2) deleteRange [((_items select 2) find "timber"),3]};
_items;