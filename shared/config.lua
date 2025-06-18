Config = {}

Config.Lang = {
    char_selction = "CHARACTER SELECTION",
    select_pg = "SELECT",
    gender = "Gender",
    date = "Date",
    money = "Money",
    bank = "Bank",
    played_time = "Played",
    create_char = "CREATE CHARACTER",
    male = "Male",
    female = "Female",
    create = "CREATE",
    last_position = "LAST POSITION",
    spawn = "SPAWN",
    enable = "ENABLE",
    disable = "DISABLE",
	pg_disabled = "DISABLED",
	new_slot = "New Slot",
	create_new_char = "Create new character",
    back = "BACK",
    set_pg = "How many characters do you want to set for this player?",
    confirm = "CONFIRM"
}

Config.Exports = {
    SetAutoSpawn = 'spawnmanager' --If you have integrated the functions of the spawnmanager into another resource, write the name here; if not, leave it as is.
}

Config.Skin = "fivem-appearance" --fivem-appearance --illenium-appearance


Config.fivemAppConfig = {
    ped = true,
    headBlend = true,
    faceFeatures = true,
    headOverlays = true,
    components = true,
    componentConfig = { masks = true, upperBody = true, lowerBody = true, bags = true, shoes = true, scarfAndChains = true, bodyArmor = true, shirts = true, decals = true, jackets = true },
    props = true,
    propConfig = { hats = true, glasses = true, ear = true, watches = true, bracelets = true },
    tattoos = true,
    enableExit = true,
}

Config.CanDelete = true
Config.Relog = true

Config.CamStartPos = vector3(-3082.96, 343.36, 18.84)
Config.ClothingPos = vector4(-269.32, -955.56, 30.24, 184.52)
Config.ShowAllwaysSpawnSelector = true -- if true it will always show the spawhselector when character choosen

Config.DefaultSlots = 1

Config.PanelAccess = {
    "admin",
    "mod",
    "helper"
}

Config.SpawnPositions = {
    [1] = {
        coords = vector4(119.16, 6626.6, 31.96, 218.08),
        camPos = vector3(126.48609161377, 6609.7426757813, 37.894180297852),
        camRot = vector3(-24.999946594238, 8.5377359937411e-07, 20.740854263306),
        label = "Paleto Bay"
    },
    [2] = {
        coords = vector4(245.32, -791.88, 30.44, 99.8),
        camPos = vector3(206.12658691406, -797.70849609375, 43.764671325684),
        camRot = vector3(-32.999942779541, -0.0, -74.237045288086),
        label = "City Center"
    },
    [3] = {
        coords = vector4(-1318.64, -1479.84, 4.92, 1.4),
        camPos = vector3(-1307.470703125, -1439.8234863281, 17.863227844238),
        camRot = vector3(-30.999965667725, -4.2688685653047e-07, 162.99847412109),
        label = "Vespucci"
    },
    [4] = {
        coords = vector4(-269.32, -955.56, 30.24, 184.52),
        camPos = vector3(-3098.8088378906, 342.54318237305, 15.140819549561),
        camRot = vector3(-27.19995880127, -1.2806606264348e-06, 92.662940979004),
        label = "Central city"
    },
}



Config.PosPeds = {
    [1] = {
        coords = vector4(-3100.24, 342.16, 14.44, 274.04),
        camPos = vector3(-3098.8088378906, 342.54318237305, 15.140819549561),
        camRot = vector3(-27.19995880127, -1.2806606264348e-06, 92.662940979004),
        camZoom = 70.0,
        anim = { "timetable@reunited@ig_10", "base_amanda", false }
    },
    [2] = {
        coords = vector4(-3093.52, 351.64, 13.44, 254.92),
        camPos = vector3(-3090.6613769531, 349.62677001953, 15.743614196777),
        camRot = vector3(-16.599975585938, -3.4150943974964e-06, 55.250301361084),
        camZoom = 70.0,
        anim = { "amb@world_human_leaning@female@wall@back@hand_up@idle_a", "idle_a", "WORLD_HUMAN_LEANING" }
    },
    [3] = {
        coords = vector4(-3094.0, 339.8, 7.48, 282.56),
        camPos = vector3(-3090.2978515625, 341.02301025391, 9.020655632019),
        camRot = vector3(-24.199848175049, 2.561320343375e-06, 101.50094604492),
        camZoom = 70.0,
        anim = { false, false, "WORLD_HUMAN_LEANING" }
    },
    [4] = {
        coords = vector4(-3086.92, 351.72, 7.48, 0.0),
        camPos = vector3(-3084.6994628906, 352.8180847168, 8.3106670379639),
        camRot = vector3(-31.199615478516, 1.2806603990612e-06, 102.03371429443),
        camZoom = 70.0,
        anim = { "amb@world_human_picnic@male@idle_a", "idle_a", false }
    },
}

Config.SpawnClothes = {
	['illenium-appearance'] = {
		['m'] = {
			tattoos = {
			},
			props = {
			[1] = {
				prop_id = 0,
				texture = -1,
				drawable = -1,
				},
			[2] = {
				prop_id = 1,
				texture = -1,
				drawable = -1,
				},
			[3] = {
				prop_id = 2,
				texture = -1,
				drawable = -1,
				},
			[4] = {
				prop_id = 6,
				texture = -1,
				drawable = -1,
				},
			[5] = {
				prop_id = 7,
				texture = -1,
				drawable = -1,
				},
			},
			model = "mp_m_freemode_01",
			headOverlays = {
			moleAndFreckles = {
				opacity = 0.5,
				color = 0,
				style = 0,
				},
			ageing = {
				opacity = 0,
				color = 0,
				style = 0,
				},
			complexion = {
				opacity = 0,
				color = 0,
				style = 0,
				},
			chestHair = {
				opacity = 0,
				color = 0,
				style = 0,
				},
			beard = {
				opacity = 0,
				color = 20,
				style = 0,
				},
			eyebrows = {
				opacity = 1,
				color = 54,
				style = 30,
				},
			makeUp = {
				opacity = 0,
				color = 0,
				style = 0,
				},
			bodyBlemishes = {
				opacity = 0,
				color = 0,
				style = 0,
				},
			blemishes = {
				opacity = 0,
				color = 0,
				style = 0,
				},
			lipstick = {
				opacity = 0,
				color = 0,
				style = 0,
				},
			blush = {
				opacity = 0,
				color = 0,
				style = 0,
				},
			sunDamage = {
				opacity = 0,
				color = 0,
				style = 0,
				},
			},
			faceFeatures = {
			nosePeakHigh = -0.3,
			eyeBrownHigh = 0,
			noseBoneTwist = -0.3,
			cheeksBoneHigh = -0.2,
			jawBoneWidth = 0.5,
			eyeBrownForward = 0,
			cheeksWidth = 0.5,
			chinHole = 1,
			noseBoneHigh = 0.1,
			nosePeakLowering = 0.1,
			cheeksBoneWidth = -1,
			noseWidth = -0.7,
			neckThickness = 1,
			nosePeakSize = -0.1,
			eyesOpening = 0.8,
			chinBoneSize = 0,
			lipsThickness = 0,
			jawBoneBackSize = -0.6,
			chinBoneLowering = 0,
			chinBoneLenght = 0,
			},
			components = {
			[1] = {
				texture = 0,
				component_id = 0,
				drawable = 0,
				},
			[2] = {
				texture = 0,
				component_id = 1,
				drawable = 0,
				},
			[3] = {
				texture = 0,
				component_id = 2,
				drawable = 64,
				},
			[4] = {
				texture = 0,
				component_id = 3,
				drawable = 12,
				},
			[5] = {
				texture = 0,
				component_id = 4,
				drawable = 1,
				},
			[6] = {
				texture = 0,
				component_id = 5,
				drawable = 0,
				},
			[7] = {
				texture = 0,
				component_id = 6,
				drawable = 157,
				},
			[8] = {
				texture = 0,
				component_id = 7,
				drawable = 0,
				},
			[9] = {
				texture = 3,
				component_id = 8,
				drawable = 88,
				},
			[10] = {
				texture = 0,
				component_id = 9,
				drawable = 0,
				},
			[11] = {
				texture = 0,
				component_id = 10,
				drawable = 0,
				},
			[12] = {
				texture = 0,
				component_id = 11,
				drawable = 0,
				},
			},
			hair = {
			color = 20,
			highlight = 20,
			style = 64,
			},
			headBlend = {
			shapeFirst = 45,
			skinSecond = 0,
			shapeSecond = 45,
			skinMix = 0,
			skinFirst = 7,
			shapeMix = 0.4,
			},
			eyeColor = 24,
		},
		['f'] = {
			props = {
			[1] = {
				texture = -1,
				drawable = -1,
				prop_id = 0,
				},
			[2] = {
				texture = -1,
				drawable = -1,
				prop_id = 1,
				},
			[3] = {
				texture = -1,
				drawable = -1,
				prop_id = 2,
				},
			[4] = {
				texture = -1,
				drawable = -1,
				prop_id = 6,
				},
			[5] = {
				texture = -1,
				drawable = -1,
				prop_id = 7,
				},
			},
			headBlend = {
			skinSecond = 6,
			skinMix = 0.6,
			shapeFirst = 33,
			shapeMix = 0.6,
			shapeSecond = 6,
			skinFirst = 33,
			},
			model = "mp_f_freemode_01",
			eyeColor = 8,
			faceFeatures = {
			nosePeakHigh = 0.4,
			chinBoneSize = 0,
			eyeBrownHigh = -0.5,
			noseBoneHigh = 0,
			jawBoneBackSize = 0,
			chinBoneLowering = -1,
			cheeksWidth = 0,
			neckThickness = -0.5,
			jawBoneWidth = 0,
			cheeksBoneWidth = 0,
			noseWidth = -1,
			nosePeakSize = 0.5,
			eyesOpening = -0.6,
			noseBoneTwist = 0,
			lipsThickness = 0,
			chinHole = 0,
			cheeksBoneHigh = 0,
			nosePeakLowering = 0,
			eyeBrownForward = -0.8,
			chinBoneLenght = 1,
			},
			components = {
			[1] = {
				texture = 0,
				component_id = 0,
				drawable = 0,
				},
			[2] = {
				texture = 0,
				component_id = 1,
				drawable = 0,
				},
			[3] = {
				texture = 3,
				component_id = 2,
				drawable = 3,
				},
			[4] = {
				texture = 0,
				component_id = 3,
				drawable = 3,
				},
			[5] = {
				texture = 2,
				component_id = 4,
				drawable = 8,
				},
			[6] = {
				texture = 0,
				component_id = 5,
				drawable = 0,
				},
			[7] = {
				texture = 3,
				component_id = 6,
				drawable = 19,
				},
			[8] = {
				texture = 0,
				component_id = 7,
				drawable = 85,
				},
			[9] = {
				texture = 5,
				component_id = 8,
				drawable = 111,
				},
			[10] = {
				texture = 0,
				component_id = 9,
				drawable = 0,
				},
			[11] = {
				texture = 0,
				component_id = 10,
				drawable = 0,
				},
			[12] = {
				texture = 2,
				component_id = 11,
				drawable = 25,
				},
			},
			hair = {
			style = 3,
			color = 34,
			highlight = 38,
			},
			headOverlays = {
			makeUp = {
				opacity = 0,
				color = 0,
				style = 0,
				},
			blush = {
				opacity = 0,
				color = 0,
				style = 0,
				},
			bodyBlemishes = {
				opacity = 0,
				color = 0,
				style = 0,
				},
			lipstick = {
				opacity = 0,
				color = 0,
				style = 0,
				},
			sunDamage = {
				opacity = 0,
				color = 0,
				style = 0,
				},
			moleAndFreckles = {
				opacity = 0.8,
				color = 0,
				style = 12,
				},
			blemishes = {
				opacity = 0,
				color = 0,
				style = 0,
				},
			eyebrows = {
				opacity = 0.7,
				color = 52,
				style = 32,
				},
			complexion = {
				opacity = 0,
				color = 0,
				style = 0,
				},
			ageing = {
				opacity = 0,
				color = 0,
				style = 0,
				},
			beard = {
				opacity = 0,
				color = 0,
				style = 0,
				},
			chestHair = {
				opacity = 0,
				color = 0,
				style = 0,
				},
			},
			tattoos = {
			},
		}  
	},
	
	['fivem-appearance'] = {
		['m'] = {
			props = {
			[1] = {
				texture = -1,
				drawable = -1,
				prop_id = 0,
				},
			[2] = {
				texture = 0,
				drawable = 0,
				prop_id = 1,
				},
			[3] = {
				texture = -1,
				drawable = -1,
				prop_id = 2,
				},
			[4] = {
				texture = -1,
				drawable = -1,
				prop_id = 6,
				},
			[5] = {
				texture = -1,
				drawable = -1,
				prop_id = 7,
				},
			},
			headBlend = {
			skinSecond = 0,
			skinMix = 0.3,
			shapeFirst = 21,
			shapeMix = 0.4,
			shapeSecond = 0,
			skinFirst = 21,
			},
			model = "mp_m_freemode_01",
			eyeColor = 0,
			faceFeatures = {
			jawBoneWidth = -0.2,
			noseBoneTwist = -0.3,
			eyeBrownHigh = 0,
			noseBoneHigh = 0.1,
			jawBoneBackSize = -0.2,
			chinBoneLowering = 0,
			eyeBrownForward = 0,
			neckThickness = 0,
			nosePeakHigh = 0,
			nosePeakLowering = 0.1,
			lipsThickness = -0.4,
			nosePeakSize = -0.1,
			chinHole = 0,
			cheeksWidth = 0.5,
			chinBoneSize = 0,
			eyesOpening = 0,
			cheeksBoneHigh = -0.2,
			noseWidth = -0.5,
			cheeksBoneWidth = -1,
			chinBoneLenght = 0,
			},
			components = {
			[1] = {
				texture = 0,
				component_id = 0,
				drawable = 0,
				},
			[2] = {
				texture = 0,
				component_id = 1,
				drawable = 0,
				},
			[3] = {
				texture = 0,
				component_id = 2,
				drawable = 49,
				},
			[4] = {
				texture = 0,
				component_id = 3,
				drawable = 1,
				},
			[5] = {
				texture = 0,
				component_id = 4,
				drawable = 25,
				},
			[6] = {
				texture = 0,
				component_id = 5,
				drawable = 0,
				},
			[7] = {
				texture = 2,
				component_id = 6,
				drawable = 69,
				},
			[8] = {
				texture = 2,
				component_id = 7,
				drawable = 22,
				},
			[9] = {
				texture = 0,
				component_id = 8,
				drawable = 4,
				},
			[10] = {
				texture = 0,
				component_id = 9,
				drawable = 0,
				},
			[11] = {
				texture = 0,
				component_id = 10,
				drawable = 0,
				},
			[12] = {
				texture = 0,
				component_id = 11,
				drawable = 10,
				},
			},
			hair = {
			style = 49,
			color = 47,
			highlight = 29,
			},
			headOverlays = {
			makeUp = {
				style = 0,
				color = 0,
				opacity = 0,
				},
			chestHair = {
				style = 0,
				color = 0,
				opacity = 0,
				},
			bodyBlemishes = {
				style = 0,
				color = 0,
				opacity = 0,
				},
			lipstick = {
				style = 0,
				color = 0,
				opacity = 0,
				},
			sunDamage = {
				style = 0,
				color = 0,
				opacity = 0,
				},
			moleAndFreckles = {
				style = 0,
				color = 0,
				opacity = 0,
				},
			blemishes = {
				style = 0,
				color = 0,
				opacity = 0,
				},
			blush = {
				style = 0,
				color = 0,
				opacity = 0,
				},
			complexion = {
				style = 0,
				color = 0,
				opacity = 0,
				},
			eyebrows = {
				style = 0,
				color = 0,
				opacity = 0,
				},
			beard = {
				style = 11,
				color = 0,
				opacity = 1,
				},
			ageing = {
				style = 0,
				color = 0,
				opacity = 0,
				},
			},
			tattoos = {
			},
		},
		['f'] = {
			props = {
			   [1] = {
				  texture = -1,
				  drawable = -1,
				  prop_id = 0,
				},
			   [2] = {
				  texture = -1,
				  drawable = -1,
				  prop_id = 1,
				},
			   [3] = {
				  texture = -1,
				  drawable = -1,
				  prop_id = 2,
				},
			   [4] = {
				  texture = -1,
				  drawable = -1,
				  prop_id = 6,
				},
			   [5] = {
				  texture = -1,
				  drawable = -1,
				  prop_id = 7,
				},
			 },
			headBlend = {
			   skinSecond = 6,
			   skinMix = 0.6,
			   shapeFirst = 33,
			   shapeMix = 0.6,
			   shapeSecond = 6,
			   skinFirst = 33,
			 },
			model = "mp_f_freemode_01",
			eyeColor = 8,
			faceFeatures = {
			   nosePeakHigh = 0.4,
			   chinBoneSize = 0,
			   eyeBrownHigh = -0.5,
			   noseBoneHigh = 0,
			   jawBoneBackSize = 0,
			   chinBoneLowering = -1,
			   cheeksWidth = 0,
			   neckThickness = -0.5,
			   jawBoneWidth = 0,
			   cheeksBoneWidth = 0,
			   noseWidth = -1,
			   nosePeakSize = 0.5,
			   eyesOpening = -0.6,
			   noseBoneTwist = 0,
			   lipsThickness = 0,
			   chinHole = 0,
			   cheeksBoneHigh = 0,
			   nosePeakLowering = 0,
			   eyeBrownForward = -0.8,
			   chinBoneLenght = 1,
			 },
			components = {
			   [1] = {
				  texture = 0,
				  component_id = 0,
				  drawable = 0,
				},
			   [2] = {
				  texture = 0,
				  component_id = 1,
				  drawable = 0,
				},
			   [3] = {
				  texture = 3,
				  component_id = 2,
				  drawable = 3,
				},
			   [4] = {
				  texture = 0,
				  component_id = 3,
				  drawable = 3,
				},
			   [5] = {
				  texture = 2,
				  component_id = 4,
				  drawable = 8,
				},
			   [6] = {
				  texture = 0,
				  component_id = 5,
				  drawable = 0,
				},
			   [7] = {
				  texture = 3,
				  component_id = 6,
				  drawable = 19,
				},
			   [8] = {
				  texture = 0,
				  component_id = 7,
				  drawable = 85,
				},
			   [9] = {
				  texture = 5,
				  component_id = 8,
				  drawable = 111,
				},
			   [10] = {
				  texture = 0,
				  component_id = 9,
				  drawable = 0,
				},
			   [11] = {
				  texture = 0,
				  component_id = 10,
				  drawable = 0,
				},
			   [12] = {
				  texture = 2,
				  component_id = 11,
				  drawable = 25,
				},
			 },
			hair = {
			   style = 3,
			   color = 34,
			   highlight = 38,
			 },
			headOverlays = {
			   makeUp = {
				  opacity = 0,
				  color = 0,
				  style = 0,
				},
			   blush = {
				  opacity = 0,
				  color = 0,
				  style = 0,
				},
			   bodyBlemishes = {
				  opacity = 0,
				  color = 0,
				  style = 0,
				},
			   lipstick = {
				  opacity = 0,
				  color = 0,
				  style = 0,
				},
			   sunDamage = {
				  opacity = 0,
				  color = 0,
				  style = 0,
				},
			   moleAndFreckles = {
				  opacity = 0.8,
				  color = 0,
				  style = 12,
				},
			   blemishes = {
				  opacity = 0,
				  color = 0,
				  style = 0,
				},
			   eyebrows = {
				  opacity = 0.7,
				  color = 52,
				  style = 32,
				},
			   complexion = {
				  opacity = 0,
				  color = 0,
				  style = 0,
				},
			   ageing = {
				  opacity = 0,
				  color = 0,
				  style = 0,
				},
			   beard = {
				  opacity = 0,
				  color = 0,
				  style = 0,
				},
			   chestHair = {
				  opacity = 0,
				  color = 0,
				  style = 0,
				},
			 },
			tattoos = {
			 },
		}  
	},
}
