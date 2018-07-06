waitUntil {!isNull player && player == player};
if(player diarySubjectExists "rules")exitwith{};

player createDiarySubject ["asylum","Gaming Asylum"];
player createDiarySubject ["generalrules","General Rules"];
player createDiarySubject ["redzones","Illegal Areas (Redzones)"];
player createDiarySubject ["laws","Laws"];
player createDiarySubject ["coprules","Cop Rules"];
player createDiarySubject ["civrules","Civ Rules"];
player createDiarySubject ["Features","Features"];
player createDiarySubject ["controls","Controls"];

/*  Example
	player createDiaryRecord ["", //Container
		[
			"", //Subsection
				"
				TEXT HERE<br/><br/>
				"
		]
	];
*/

// Asylum Section
	player createDiaryRecord ["asylum",
		[
			"Teamspeak",
				"
				The Asylum Teamspeak can be found at:<br/><br/>
				ts3.gaming-asylum.com:9216<br/><br/>
				"
		]
	];
	
	player createDiaryRecord ["asylum",
		[
			"Website/Forums",
				"
				http://www.gaming-asylum.com<br/>
				Go to our website to report players, appeal bans, view player statistics, donate, be part of our community, and more!<br/><br/>
				"
		]
	];
		
	player createDiaryRecord ["asylum",
		[
			"Loot Crates",
				"
				Loot Crates are boxes which can be found through mining, excavating, and other activites.<br/>
				Alternatively, you can purchase them from the Home Improvements store.<br/><br/>
				Purchase Loot Crate Keys from our website to open Loot Crates, and permanently unlock the ability to purchase exclusive in-game items!<br/><br/>
				"
		]
	];
	
	player createDiaryRecord ["asylum",
		[
			"Donations",
				"
				Donations keep the server running.<br/>
				Donate securely with PayPal and unlock custom in-game skins!<br/><br/>
				All the details you need can be found on our website.<br/><br/>
				"
		]
	];
		
	
// General Rules

	player createDiaryRecord ["generalrules",
		[
			"",
				"
				1: Vehicles are not a weapon. You can use a vehicle to defend yourself if you are in immediate danger and the threat is directly in front of your vehicle. Bannable uses of vehicles include but are not limited to: running innocent people over for fun, ramming into stationary vehicles with the intent to blow them up, turning around to run over someone shooting at you from behind.<br/>
				2: Vehicle mounted weapons fall under the same rules as any other weapon.<br/>
				3: Disconnecting or re-spawning while being engaged by another player is a bannable offense (Combat Logging). Claims of RDM/other rule violations are not a defense for Combat Logging.<br/>
				4: Illegal areas are marked in red text on the map and include drug fields, drug processing areas, drug dealers, black market factories, cartels, and rebel outposts.<br/>  
				5: Players in and around illegal areas are responsible for their own survival as <b>RDM RULES DO NOT APPLY</b>. See our forums for a detailed list of the illegal area ranges.<br/>
				6: Random Death Matching (RDM):  Is the act of killing a player outside of an illegal area without valid RP reason and communication via in-game direct voice communication or cell phone text messages.  RDM is  a bannable offence. Example: you tell someone to STOP and put their hands on their head. If they comply you can role-play out robbing them, if they do not you are allowed to kill. If someone complies with your demands, you must continue the roleplay and find another reason to kill them.<br/>
				7: Warning shots are allowed at helicopters that are hovering or attempting to land near your position.  If the helicopter does not turn away, shooting it down is allowed. Remember, sufficient time must be given to allow the pilot to react and decide to leave.<br/>
				8: The rules are not designed to shield players from the consequences of their own actions or lack of awareness.   It is not considered RDM if players die for reasons such as: ignoring demands from any player, trying to drive through on-going gunfire, running into an active firefight, etc.<br/>
				9: Players must have in-game sound effects turned up so they can hear direct voice communication from other players.<br/>
				10: The use of racist, misogynistic, or hate speech will result in a permanent ban from the Asylum Servers.<br/>
				11: As a Bounty Hunter, do not profit by arresting your friends. Additionally, do not share your reward with the bounty that you have arrested. Such funds will be removed from your respective bank accounts and depending on severity, may result in a ban.<br/>
				12: Ghosting (abuse of persistent player location saving) will result in a server ban. Do not use the ability to logout/login to gain a tactical advantage over your enemies.<br/>
				13: For a more in-depth look at our rules, visit our website listed above.<br/>
				"
		]
	];
	
	// Illegal Areas

	player createDiaryRecord ["redzones",
		[
			"",
				"
				Illegal Areas (marked on the map as red markers) are Kill on Sight (KOS) zones. As such RDM RULES DO NOT APPLY. Some of these areas have extended KOS areas which surround the marker but may not necessarily be displayed on the map. Below is a summary of the redzones on Asylum.<br/><br/>
				Persistent 300 Meter Redzones:<br/>
				1. All Drug/Illegal Item Fields<br/>
				2. All Drug/Illegal Item Processors<br/>
				3. All Rebel Bases<br/>
				4. Black Market Production Facilities<br/>
				5. Cartel Locations<br/><br/>
				Persistent Specific-Range Redzones:<br/>
				1. Drug Dealers/Wongs Food and Liquor: (Interaction Range)<br/>
				2. Drug Runner Locations: (50m Radius from the vendor)<br/>
				3. Turtle Zones: (Red Circle on Map)<br/><br/>
				Event-Specific Redzones:<br/>
				1. Gas Station Robberies: (Immediate Area - Only armed players may be killed)<br/>
				2. Federal Reserve Robbery / Prison Break / Bank Robbery: (Immediate Area. These zones of conflict can understandably stretch across a relatively wide area; so please use your best judgment when engaging contacts who you know may not be involved in the event. Administrators will handle reports or RDM from near these locations on a case-by-case basis.)<br/><br/>
				Any player who is within the boundaries identified above may be killed or downed by any player at any time. You may be outside of an Illegal Area and fire upon those who are inside without initiation of roleplay.<br/><br/>
				In addition; any player whose name displays as RED may be fired upon without fear of repercussion. Red Names indicate that the player is either in a Gang War with you, or that their group is in a firefight with your group.<br/>
				"
		]
	];
	
// Laws

	player createDiaryRecord ["laws",
		[
			"",
				"
				1: Killing of another player in a non self defense situation is illegal.<br/>
				2: Stealing any vehicle is illegal.<br/>
				3: Cannibalism is illegal.<br/>
				4: Hitting people with a vehicle can result in a ticket or even jail time.<br/>
				5: Breaking people out of jail is illegal.<br/>
				6: Possession of illegal materials such as weed, cocaine, heroin, meth, etc. is illegal.<br/>
				7: Police will seize any Ifrit or Armed vehicle they capture, resulting in its removal from your garage. Additionally, any vehicle with more than $5,000 worth of illegal items may also be seized.<br/>
				8: Taking someone hostage is a illegal act.<br/>
				9: As a civilian, only guns purchased at city gun stores are considered legal when you have the required licence. All other guns are illegal including: Guns purchased from the rebel bases, guns obtained without a licence, and guns picked up from police officers. The SDAR is illegal, even if it may be purchased from the gun store.<br/>
				10: Interfering with an arrest after being warned will warrant an arrest with ticket and possible jail time.<br/>
				11: Armed robbery is an illegal act.<br/>
				12: Being inside of, or stealing money from the Federal Reserve / Bank of Altis is illegal.<br/>
				13: You are not allowed to carry weapons unholstered while in town.<br/>
				14: Any form of impersonating an officer is considered illegal.<br/>
				15: If a killing happens in self defence and you want to ensure your innocence, you must contact the police via 911's or in-person as soon as possible. If you wait to inform them of the self-defense homicide, your chances of being ticketed/jailed increase significantly!<br/>
				"
		]
	];
	
// Cop Rules
	player createDiaryRecord ["coprules",
		[
			"General",
				"
				1: Cops must stay in police channels with their current game name.<br/>
				2: Cops are not allowed to leak information to civilians. this is grounds for dismissal from the force.<br/>
				3: Cops may be demoted for selling weapons to civilians or lower grade officers.(no officer should carry or drive anything above his rank)<br/>
				4: Cops are not allowed to stay in an illegal area for more than 2 minutes without cause.<br/>
				5: All people around a crime are able to be restrained and held for a maximum of 10 minutes until the issue is resolved.<br/>
				6: Any police engagement must be complete before vehicles are able to be impounded/seized.<br/>
				7: No ticket/arrest will be issued more than one time per bounty.<br/>
				8: Less-lethal ammunition should be loaded unless given authorization by the appropriate officer on-scene.<br/>
				9: Civilians can be arrested for interfering with an officer or failing to follow commands such as vacating an area and moving vehicles.<br/>
				10: A person or vehicle cannot be searched without consent unless the officer has probable cause and states such at the time of the search.<br/>
				11: Cops must have undivided loyalty to the police department at all times when in uniform, and must not grant special favours for civilians, or take bribes or payments of any sort, whether monetary or otherwise.<br/>
				"
		]

	];
	
	player createDiaryRecord ["coprules",
		[
		"Chain of Command",
			"
			The highest ranking officer on duty is in charge of the police force as a whole on the server. The highest ranking officer in each City/Patrol Group is responsible to lead the officers under his/her care with all due diligence expected of his/her position. Report any misconduct of officers on our forums for review by the Lieutenants and Captains<br/><br/>

			Police Chain of Command:<br/>
			1. Captain<br/>
			2. Lieutenant<br/>
			3. Sergeant<br/>
			4. Corporal<br/>
			5. Constable<br/>
			6. Cadet<br/>
			"
		]
	];
	
// Civ Rules
	player createDiaryRecord ["civrules",
		[
			"",
				"
				1: Racist, misogynist, hateful, etc. speech is not tolerated. Being a bigot is grounds for a permanent ban.<br/>
				2: Once killed you are not allowed to seek revenge on the person or group that killed you without re-initiation of roleplay.<br/>
				3: Civilians cannot keep anyone restrained or hostage for more then ten minutes without gaining the consent of the victim. If you have been restrained by civilians for 10 minutes or more, you may disconnect without fear of punishment.<br/>
				"
		]
	];
	
// Housing Section
	player createDiaryRecord ["features",
		[
			"Features",
				"
					1: Player Housing: The first step to owning a home is obtaining a home owner license from the DMV. With the license, find a vacant home in the world and you may see a buy house action menu option. You may lock doors of your homes and with access to Home Improvements, place storage containers in your homes. Larger and more expensive homes will offer more storage ability. You have the ability to spawn at your home upon death. Additionally, you may own garages and access your garage from them! (Be careful, vehicles larger than the garage may result in explosions).<br/>    
					2: Hostage Taking: You can take hostages in Asylum Life by having another player press the TAB key, this will activate surrender mode. You may also shoot your target with a less-lethal weapon. When your target is in surrender mode or downed, you can restrain, escort, put into, and pull them out of vehicles.<br/>
					3: Cartels: Gangs may take control of various cartel locations in order to gain financial or other benefits. Claim your territory!<br/>    
					4: Turfs: Much like Cartels, Turfs are capturable by gangs and may be used as a spawn location. Capture of multiple Turfs can result in various discounts and perks.<br/>
					5: Bounty Hunting: Take justice into your own hands. Gear up and track up to four wanted fugitives across the island. Return them to a courthouse or the Skiptracer Base for arrest and be rewarded with cash!<br/>        
					6: Full Saving: On Aslyum Life, everything saves. Your location, your equipment, your inventory items, and your vehicles.<br/>     
					7: Crafting System: By gathering multiple resources from various areas, you can now combine them to create new materials and items. Visit a Firearms, Vehicle, or Black Market Factory to see the crafting recipes!<br/>
					8: Racing: When prompted, join a Rally Race to compete for cash prizes!<br/>
					9: Parole: When caught by the police, a civilian may be given the option to be placed on parole. Violating of parole will alert the police to your location, so stay out of trouble!<br/>
					10: Jury Trials: When in jail, a player may request a trial by Jury is certain criteria are met. Then can then plead their case to other players who choose to attend!<br/>
					11: LaserTag: When prompted, join a game of lasertag! You'll be sent to our custom-built facility and fight with gear we provide!<br/>
					12: Cannibalism: Carry a Skinning Knife to gut your enemies! You can then cook their organs for sale or consumption!<br/>
					13: Asylum Exchange: Use the Exchange to sale items, vehicles, weapons, and even houses to other players! The Exchange is a player-driven economy; and anything placed on the market is available for purchase whether you are online or not! Items purchased while you are offline will result in the cash being placed in your mailbox for collection at your leisure.<br/>
					14: Drug Running Missions: Proceed to Drug Runner points and race against time to deliver a plane full or drugs to another location! Successful runs will reward you greatly; failing will result in monetary losses, however. (REQUIRES APEX DLC)<br/>
				"
		]
	];
	
	
// Controls Section
	player createDiaryRecord ["controls",
		[
			"",
				"
				1: Open wanted/bounty list<br/>
				4: Holster active weapon<br/>
				5: Open phone messaging<br/>
				6: Activate vehicle nitrous<br/><br/>
				
				TAB: Surrender<br/>
				H: Holster active weapon<br/>
				Y: Open player menu<br/>
				U: Lock and unlock cars<br/>
				F: Siren (if cop or paramedic)<br/>
				L: Speed radar (if cop)<br/>
				T: Vehicle trunk<br/><br/>
				
				Custom 1: Open player menu<br/>
				Custom 2: Pickup nearby items<br/>
				Custom 3: Open virtual inventory<br/>
				Custom 8: Speed radar (if cop)<br/>
				Custom 9: Activate spike strip<br/>
				Custom 10: Toggle Earplugs<br/>
				Custom 11: Consume Red Gull<br/>
				Custom 15: Detonate Suicide Vest<br/>
				"
		]
	];