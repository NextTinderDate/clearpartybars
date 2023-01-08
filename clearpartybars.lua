
	addon.name      = 'ClearPartyBars';
	addon.author    = 'cerseii';
	addon.version   = '1.0';
	addon.desc      = 'Displays cleaner overlay of party status bars';
	addon.link      = 'N/A';


	----------------
	-- TPARTY (atom0s) and STATUSTIMERS (heals) were used as reference and learning Ashita/Lua/C syntax. Thanks!
	-- This is my first addon in Lua and Ashita and FFXI ~ I would not recommend using this script for learning
	-- Discord for suggestions/ideas: NextTinderDate 7766
	----------------


	require('common');
	local chat = require('chat');
	local fonts = require('fonts');
	local scaling = require('scaling');
	local settings = require('settings');
	local bit = require('bit');
	local d3d8 = require('d3d8');
	local ffi = require('ffi');


	jobsarray = {
		[1]  = 'WAR',
		[2]  = 'MNK',
		[3]  = 'WHM',
		[4]  = 'BLM',
		[5]  = 'RDM',
		[6]  = 'THF',
		[7]  = 'PLD',
		[8]  = 'DRK',
		[9]  = 'BST',
		[10] = 'BRD',
		[11] = 'RNG',
		[12] = 'SAM',
		[13] = 'NIN',
		[14] = 'DRG',
		[15] = 'SMN',
		[16] = 'BLU',
		[17] = 'COR',
		[18] = 'PUP',
		[19] = 'DNC',
		[20] = 'SCH',
		[21] = 'GEO',
		[22] = 'RUN'
	};

	zonesarray = {
	"unknown",
	"Phanauet_Channel",
	"Carp. Landing",
	"Manaclipper",
	"Bibiki Bay",
	"Uleguerand Rng.",
	"Bearclaw Pin.",
	"Attohwa Chasm",
	"Bnyd Gully",
	"PsoXja",
	"Shrouded Maw",
	"Oldton Mov.",
	"Newton Mov.",
	"Mine Shaft",
	"Hall of Trns",
	"Aby-Konschtat",
	"Promy-Holla",
	"Spire of Holla",
	"Promy-Dem",
	"Spire of Dem",
	"Promyv-Mea",
	"Spire of Mea",
	"Promy-Vahzl",
	"Spire of Vahzl",
	"Lufaise Meadows",
	"Misareaux Cst.",
	"Tavnazian Sfhld",
	"Phomiuna Aqdcts.",
	"Sacrarium",
	"Riverne-Site_B01",
	"Riverne-Site_A01",
	"Monarch Linn",
	"Sealions Den",
	"Al'Taieu",
	"Grd. Plc. of HuXzoi",
	"Garden of RuHmet",
	"Empyreal Pdx.",
	"Temenos",
	"Apollyon",
	"Dy-Valkurm",
	"Dy-Buburimu",
	"Dy-Qufim",
	"Dyn-Tavnazia",
	"Dio-Abdhaljs-Ghelsba",
	"Abdhaljs-Isle-Purgo.",
	"Aby-Tahrongi",
	"Boat to Al Zahbi",
	"Boat to Mhaura",
	"Al Zahbi",
	"49",
	"Whitegate",
	"Wajaom Wdlnds.",
	"Bhaflau Thkt.",
	"Nashmau",
	"Arrapago Reef",
	"Ilrusi Atoll",
	"Periqia",
	"Talacca Cove",
	"Boat to Nashmau",
	"Boat to Al Zahbi",
	"The Ashu Talif",
	"Mount Zhayolm",
	"Halvung",
	"Lebros Cavern",
	"Navukgo Exec. Chamber",
	"Mamook",
	"Mamool Grounds",
	"Jade Sepulcher",
	"Aydeewa Subterrane",
	"Leujaoam Sanctum",
	"Chocobo Circuit",
	"The Colosseum",
	"Alzadaal Undersea Ruins",
	"Zhayolm Remnants",
	"Arrapago Remnants",
	"Bhaflau Remnants",
	"Silver Sea Remnants",
	"NyzulIsle",
	"Hazhalm Grounds",
	"Caedarva_Mire",
	"S San d'Oria",
	"East Ronfaure",
	"Jugner Forest",
	"Vunkerl Inlet",
	"Batallia Downs",
	"La Vaule",
	"Everbloom Hollow",
	"Bastok Markets",
	"North Gustaberg",
	"Grauberg",
	"Pashhow Marshlands",
	"Rolanberry Fields",
	"Beadeaux",
	"Ruhotz Silvermines",
	"Windurst Waters",
	"West Sarutabaruta",
	"Fort Karugo-Narugo",
	"Meriphataud Mtns.",
	"Sauromugue Champaign",
	"Castle Oztroja",
	"West Ronfaure",
	"East Ronfaure",
	"La Theine Plateau",
	"Valkurm Dunes",
	"Jugner Forest",
	"Batallia Downs",
	"North Gustaberg",
	"South Gustaberg",
	"Konschtat Highlands",
	"Pashhow Marshlands",
	"Rolanberry Fields",
	"Beaucedine Glacier",
	"Xarcabard",
	"Cape Teriggan",
	"Eastern Altepa Desert",
	"West Sarutabaruta",
	"East Sarutabaruta",
	"Tahrongi Canyon",
	"Buburimu Pen.",
	"Meriphataud Mtns.",
	"Sauromugue Champaign",
	"The Sanctuary of ZiTah",
	"RoMaeve",
	"Yuhtunga Jungle",
	"Yhoator Jungle",
	"Western Altepa Desert",
	"Qufim Island",
	"Behemoths Dominion",
	"Valley of Sorrows",
	"Ghoyus Reverie",
	"RuAun Gardens",
	"Mordion Gaol",
	"Abyssea-La Theine",
	"133",
	"Dyn-Beaucedine",
	"Dyn-Xarcabard",
	"Beaucedine Glacier",
	"Xarcabard",
	"Castle Zvahl Baileys",
	"Horlais Peak",
	"Ghelsba Outpost",
	"Fort Ghelsba",
	"Yughott Grotto",
	"Palborough Mines",
	"Waughroon Shrine",
	"Giddeus",
	"Balgas Dais",
	"Beadeaux",
	"Qulun Dome",
	"Davoi",
	"Monastic Cavern",
	"Castle Oztroja",
	"Altar Room",
	"The Boyahda Tree",
	"Dragons Aery",
	"Castle Zvahl Keep",
	"Throne Room",
	"Middle Delkfutts Tower",
	"Upper Delkfutts Tower",
	"Temple of Uggalepih",
	"Den of Rancor",
	"Castle Zvahl Baileys",
	"Castle Zvahl Keep",
	"Sacrificial Chamber",
	"Garlaige Citadel",
	"Throne Room",
	"Ranguemont Pass",
	"Bostaunieux Oubliette",
	"Chamber of Oracles",
	"Toraimarai Canal",
	"Full Moon Fountain",
	"Crawlers Nest",
	"Zeruhn Mines",
	"Korroloka Tunnel",
	"Kuftal Tunnel",
	"The Eldieme Necropolis",
	"Sea Serpent Grotto",
	"VeLugannon Palace",
	"The Shrine of RuAvitau",
	"Stellar Fulcrum",
	"LaLoff Amphitheater",
	"The Celestial Nexus",
	"Walk of Echoes",
	"Maquette Abdhaljs-Legion",
	"Lower Delkfutts Tower",
	"Dynamis-San dOria",
	"Dynamis-Bastok",
	"Dynamis-Windurst",
	"Dynamis-Jeuno",
	"Residential Area",
	"King Ranperres Tomb",
	"Dangruf Wadi",
	"Inner Horutoto Ruins",
	"Ordelles Caves",
	"Outer Horutoto Ruins",
	"The Eldieme Necropolis",
	"Gusgen Mines",
	"Crawlers Nest",
	"Maze of Shakhrami",
	"Residential Area",
	"Garlaige Citadel",
	"Cloister of Gales",
	"Cloister of Storms",
	"Cloister of Frost",
	"FeiYin",
	"Ifrits Cauldron",
	"QuBia Arena",
	"Cloister of Flames",
	"Quicksand Caves",
	"Cloister of Tremors",
	"GM Home",
	"Cloister of Tides",
	"Gustav Tunnel",
	"Labyrinth of Onzozo",
	"Residential Area",
	"Abyssea-Attohwa",
	"Abyssea-Misareaux",
	"Abyssea-Vunkerl",
	"Abyssea-Altepa",
	"Mog House",
	"Boat to Selbina",
	"Boat to Mhaura",
	"Provenance",
	"Airship to Jeuno",
	"Airship to Jeuno",
	"Airship to Jeuno",
	"Airship to Jeuno",
	"Boat to Selbina",
	"Boat to Mhaura",
	"229",
	"S San d'Oria",
	"N San d'Oria",
	"Port San d'Oria",
	"Chateau d'Oraguille",
	"Bastok Mines",
	"Bastok Markets",
	"Port Bastok",
	"Metalworks",
	"Windurst Waters",
	"Windurst Walls",
	"Port Windurst",
	"Windurst Woods",
	"Heavens Tower",
	"RuLude Gardens",
	"Upper Jeuno",
	"Lower Jeuno",
	"Port Jeuno",
	"Rabao",
	"Selbina",
	"Mhaura",
	"Kazham",
	"Hall of the Gods",
	"Norg",
	"Abyssea-Uleguerand",
	"Abyssea-Grauberg",
	"Abyssea-Empyreal Paradox",
	"Western Adoulin",
	"Eastern Adoulin",
	"Rala Waterways",
	"Rala Waterways U",
	"Yahse Hunting Grounds",
	"Ceizak Battlegrounds",
	"Foret de Hennetiel",
	"Yorcia Weald",
	"Yorcia Weald U",
	"Morimar Basalt Fields",
	"Marjami Ravine",
	"Kamihr Drifts",
	"Sih Gates",
	"Moh Gates",
	"Cirdas Caverns",
	"Cirdas Caverns U",
	"Dho Gates",
	"Woh Gates",
	"Outer RaKaznar",
	"Outer RaKaznar U",
	"RaKaznar Inner Court",
	"RaKaznar Turris",
	"278",
	"279",
	"Mog Garden",
	"Leafallia",
	"Mount Kamihr",
	"Silver Knife",
	"Celennia Memorial Library",
	"Feretory",
	"286",
	"287",
	"Escha ZiTah",
	"Escha RuAun",
	"Desuetia Empyreal Paradox",
	"Reisenjima",
	"Reisenjima Henge",
	"Reisenjima Sanctorium",
	"Dynamis-San dOria [D]",
	"Dynamis-Bastok [D]",
	"Dynamis-Windurst [D]",
	"Dynamis-Jeuno [D]"

	}




local function round(x)
	return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

local function round1(num)
	local mult = 10^(1 or 0)
	return math.floor(num * mult + 0.5) / mult
end

local function filtername(str)
	str = string.gsub(str," of","");
	str = string.gsub(str,"The ","");	
	str = string.gsub(str," A "," ");	
	str = string.gsub(str,"-"," ");	
	str = string.gsub(str,","," ");	
	str = string.gsub(str,"/."," ");	
	return(str);
end

local function indexOf(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end

local function mysplit (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

local function spaces(count)

	local tex = "";

	for x = 1, count do
		tex = tex.." ";
	end

	return tex;
end

local function get_member_status(i)
    local party = AshitaCore:GetMemoryManager():GetParty();
    if (party == nil) then
        return nil;
    end

            local icons_lo = party:GetStatusIcons(i);
			
            local icons_hi = party:GetStatusIconsBitMask(i);
            local status_ids = T{};

            for j = 0,31,1 do
                local high_bits;
                if j < 16 then
                    high_bits = bit.lshift(bit.band(bit.rshift(icons_hi, 2* j), 3), 8);
                else
                    local buffer = math.floor(icons_hi / 0xffffffff);
                    high_bits = bit.lshift(bit.band(bit.rshift(buffer, 2 * (j - 16)), 3), 8);
                end

                local buff_id = icons_lo[j+1] + high_bits;
								
                if (buff_id ~= 255) then
				    if (buff_id~= 0) then

					end
                    status_ids[#status_ids + 1] = buff_id;
                end
            end

            if (next(status_ids)) then
                return status_ids;
            end

    return nil;
end

local function get_player_status()
    local player = AshitaCore:GetMemoryManager():GetPlayer();


    local icons = player:GetStatusIcons();
    local status_ids = {};

    for j = 0,31,1 do
        if (icons[j + 1] ~= 255 and icons[j + 1] > 0) then
					
            status_ids[#status_ids+1] = icons[j + 1];
			
        end
    end
    if (next(status_ids)) then
        return status_ids;
    end
    return nil;
end

local function getMemberBuffs(member)
	if (member == 0) then
	return get_player_status();
	end
	if (member > 0) then
	return get_member_status(member-1);
	end
return nil;
end

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end
	
local function frames(template)
-- Using fonts as frames for now ~ I don't see another basic alternative that scales with UI

	return fonts.new(template);

end



	
	local targetcoverimage = nil;
	local targetleftcoverimage = nil;
	local targetnamelabel = nil;
	local targetnamelabel2 = nil;
	local targetnamelabel3 = nil;
	
	local targethealthbackimage = nil;
	local targethealthfrontimage = nil;
	local targetrangelabel = nil;
	local targetrangelabelback = nil;

	local backimage = nil;
	local backleftimage = nil;

	local coverimage = {}
	local namelabel = {}
	local healthback = {}
	local healthfront = {}
	local healthlabel = {}
	local manaback = {}
	local manafront = {}
	local manalabel = {}
	local selectedlabel1 = {}
	local selectedlabel2 = {}
	local tplabel= {}
	local statuslabel= {}
	local castbar = {}
	local reccastbar = {}

	
	local joblabel= {}


	local ftargetcoverimage = T{
		auto_resize = false;

		position_x = scaling.scale_w(-1);
		
		position_y_scaling = scaling.scale_h(-20);
		position_y_constant = scaling.scale_h(-32);
	
		visible = true,
		
		background = T{
		
			width = scaling.scale_h(-137.0),
			height = scaling.scale_h(-45.0),
		
			visible = true,
			color = 0xFF000010,
			border_visible = true,
			border_color = 0xFFFFFFFF,
			border_sizes = '-1,-1,-1,-1',
			border_flags = FontBorderFlags.Top+FontBorderFlags.Bottom+FontBorderFlags.Left,
			
		}
	}

	local ftargetleftcoverimage = T{
		auto_resize = false;

		position_x = scaling.scale_w(-500);
		
		position_y_scaling = scaling.scale_h(-20);
		position_y_constant = scaling.scale_h(-32);
	
		visible = true,
		
		background = T{
		
			width = scaling.scale_w(363.0),
			height = scaling.scale_h(-46.0),
		
			visible = true,
			color = 0x33000010,
			border_visible = true,
			border_color = 0xAAFFFFFF,
			border_sizes = '-1,1,1,1',
			border_flags = FontBorderFlags.Top+FontBorderFlags.Bottom+FontBorderFlags.Left,
			
		}
	}

	local ftargetlockedtext = T{
		auto_resize = false;

		position_x = scaling.scale_w(-15);
		
		position_y_scaling = scaling.scale_h(-20);
		position_y_constant = scaling.scale_h(-94);
	
		font_family = 'Arial',
		visible = true;
		right_justified = true,
		font_height = scaling.scale_f(12);
		
		text = "Target Locked",
		color = 0xFFFFFFFF;
		italic = true,
		--bold = true,		
		color_outline = 0xFFFFFFFF,
		draw_flags = bit.bor(FontDrawFlags.Outlined),		
		
		background = T{
		
			width = scaling.scale_w(-135.0),
			height = scaling.scale_h(-10.0),
		

		}
		
		
		
		
	}

	local ftargetnamelabel = T{
	
		position_x = scaling.scale_w(-110);
		
		position_y_scaling = scaling.scale_h(-20);
		position_y_constant = scaling.scale_h(-60);	
	
	
	
	
	
	
		font_family = 'Calibri',
		font_height = scaling.scale_f(15),
		bold = false;
		italic = true;
		color = 0xFFFFFFFF,
		left_justified = true,
		text = "Blank",
		
	
	
	}	
	
	local ftargetnamelabel2 = T{
	
		position_x = scaling.scale_w(-133);
		
		position_y_scaling = scaling.scale_h(-20);
		position_y_constant = scaling.scale_h(-77);	
	
	
	


		font_height = scaling.scale_f(17),
		bold = true;
		italic = true;
		color = 0x01FFFFFF,
		left_justified = true,
		text = "Blank",
		color_outline = 0x40FFFFFF,
		draw_flags = bit.bor(FontDrawFlags.Outlined),	
	
	
	}	
	
	local ftargetnamelabel3 = T{
	
		position_x = scaling.scale_w(-122);
		
		position_y_scaling = scaling.scale_h(-20);
		position_y_constant = scaling.scale_h(-68);	
	
	
	
	
		font_family = 'Calibri',
		font_height = scaling.scale_f(16),
		bold = false;
		italic = true;
		color = 0xFFFFFFFF,
		left_justified = true,
		text = "Blank",
		
	
	
	}		
	
	local ftargetrangelabelback = T{
		auto_resize = false;
	
		position_x = scaling.scale_w(-148);
		
		position_y_scaling = scaling.scale_h(-20);
		position_y_constant = scaling.scale_h(-36);	
	
		right_justified = true,
		background = T{
			visible = true,
			color = 0x60000000,
			
			width = scaling.scale_w(-135.0),
			height = scaling.scale_h(-10.0),
			
			
		}
	}	
		
	local ftargetrangelabel = T{
		auto_resize = false;
	
		position_x = scaling.scale_w(-148);
		
		position_y_scaling = scaling.scale_h(-20);
		position_y_constant = scaling.scale_h(-36);	
	
	
		right_justified = true,
		background = T{
			visible = true,
			color = 0xFF000000,
			
			width = scaling.scale_w(-50.0),
			height = scaling.scale_h(-10.0),
			

			
			
		}
	}	

	local ftargethealthbackimage = T{
		auto_resize = false;
	
		position_x = scaling.scale_w(-148);
		
		position_y_scaling = scaling.scale_h(-20);
		position_y_constant = scaling.scale_h(-52);	
	
	
		right_justified = true,
		background = T{
			visible = true,
			color = 0x60000000,
			
			width = scaling.scale_w(-340.0),
			height = scaling.scale_h(-20.0),
			
			
			
		}
	}	
		
	local ftargethealthfrontimage = T{
		auto_resize = false;
	
		position_x = scaling.scale_w(-148);
		
		position_y_scaling = scaling.scale_h(-20);
		position_y_constant = scaling.scale_h(-52);	
	
	
		right_justified = true,
		background = T{
			visible = true,
			color = 0xAA000000,
			
			width = scaling.scale_w(-50.0),
			height = scaling.scale_h(-20.0),
			
			
			
		}
	}
	
	local fbackimage = T{
	
	
		position_x = scaling.scale_w(-1),
		position_y = scaling.scale_h(-16),
		
		size_y_scaling = scaling.scale_h(-20),
		size_y_constant = scaling.scale_h(-15),
		
		auto_resize = false;
		
		background = T{
		
		
		
		
			width = scaling.scale_w(-137.0),
			height = scaling.scale_h(-50.0),
			visible = true;
			color = 0xFF000010;
			border_visible = true,
			border_color = 0xFFFFFFFF,
			border_sizes = '-1,-1,-1,-1',
			border_flags = FontBorderFlags.Bottom+FontBorderFlags.Top+FontBorderFlags.Left,
			
		}
	}
	
	local fbackleftimage = T{
	
	
		position_x = scaling.scale_w(-500),
		position_y = scaling.scale_h(-15),
		
		size_y_scaling = scaling.scale_h(-20),
		size_y_constant = scaling.scale_h(-17),
		
		auto_resize = false;
		
		background = T{
		
		
		
		
			width = scaling.scale_w(363.0),
			height = scaling.scale_h(-50.0),
			visible = true;
			color = 0x29000010;
			border_visible = true,
			border_color = 0xAAFFFFFF,
			border_sizes = '-1,1,1,1',
			border_flags = FontBorderFlags.Bottom+FontBorderFlags.Top+FontBorderFlags.Left,
			
		}
	}
		
	local fnamelabel = T{
	
	
	
	
	
	
		visible = true,
		font_family = 'Calibri',
		font_height = scaling.scale_f(14),
		bold = false;
		italic = false;
		color = 0xFFFFFFFF,
		left_justified = true,
		font_width = 3;
	}

	local fjoblabel = T{
		visible = true,
		font_family = 'Calibri',
		font_height = scaling.scale_f(17),
		bold = true;
		italic = true;
		color = 0x01FFFFFF,
		left_justified = true,
		color_outline = 0x20FFFFFF,
		draw_flags = bit.bor(FontDrawFlags.Outlined),

	}
	
	local fhealthback = T{
				auto_resize = false;
		visible = true,
		left_justified = true,
		background = T{
			visible = true,
			color = 0x80000000,
			
		
			
			width = scaling.scale_w(-140.0),
			height = scaling.scale_h(-20.0),
						
			
			
			
			
			
			
		}
	}

	local fhealthfront = T{
				auto_resize = false;
		visible = true,
		left_justified = true,
		background = T{
			visible = true,
			color = 0xffb83773,
			
			
			width = scaling.scale_w(10.0),
			height = scaling.scale_h(-20.0),
			
						border_visible = true,
			border_color = 0xCCFFFFFF,
			border_sizes = '1,1,-1,1',
			border_flags = FontBorderFlags.Right,
			
			
		}
	}

	local fhealthlabel = T{
		visible = true,
		font_family = 'Calibri',
		font_height = scaling.scale_f(14),
		bold = true;
		italic = false,
		color = 0xFFFFD9D9,
		left_justified = true,
		color_outline = 0xFF000000,
		draw_flags = bit.bor(FontDrawFlags.Outlined),
	}

	local fmanaback = T{
					auto_resize = false;
		visible = true,
		background = T{
			visible = true,
			color = 0x60000000,
			
			
			width = scaling.scale_w(-90.0),
			height = scaling.scale_h(-20.0),
			
			
			
		}
	}

	local fmanafront = T{
					auto_resize = false;
		visible = true,
		font_family = 'Arial',
		right_justified = true,
		background = T{
			visible = true,
			color = 0xff0039d6,
			
			width = scaling.scale_w(-90.0),
			height = scaling.scale_h(-20.0),			
			
			border_visible = true,
			border_color = 0xCCFFFFFF,
			border_sizes = '1,1,-1,1',
			border_flags = FontBorderFlags.Right,
			
			
			
			
		}
	}

	local fmanalabel = T{
		visible = false,
		font_family = 'Calibri',
		font_height = scaling.scale_f(14),
		bold = true;
		italic = false,

		color = 0xFFD9D9FF,
		right_justified = true,
		color_outline = 0xFF000000,
		draw_flags = bit.bor(FontDrawFlags.Outlined),

	}

	local fcastbar = T{
	auto_resize = false;
		visible = false,
		right_justified = true,
		
		
		background = T{
			visible = true,
			color = 0x55FFFFFF,
			
			width = 0,
			height = scaling.scale_h(-24.0),
		}
	}

	local freccastbar = T{
	auto_resize = false;
		visible = false,
		right_justified = true,
		
		
		background = T{
			visible = true,
			color = 0x22000000,
			
			width = 0,
			height = scaling.scale_f(-24.0),
		}
	}

	local fselectback = T{
	auto_resize = false;
		visible = false,
		right_justified = true,
		
		background = T{
			visible = true,
			color = 0x55FFFFFF,
			
			width = scaling.scale_w(-500.0),
			height = scaling.scale_h(-24.0),
		}
	}

	local ftplabel = T{
		visible = true,
		font_family = 'Calibri',
		font_height = scaling.scale_f(11),
		bold = true;
		--italic = true,
		color = 0xFFFFFFFF,
		left_justified = true,
		text = "100%",
		color_outline = 0xFF000000,
		draw_flags = bit.bor(FontDrawFlags.Outlined),
	}		
			
	local fstatuslabel = T{
		visible = true,
		font_family = 'Calibri',
		font_height = scaling.scale_f(13),
		
		left_justified = true,
		color = 0xFFFFFFFF,
		color_outline = 0xFFFFFFFF,
		--draw_flags = bit.bor(FontDrawFlags.Outlined),		

	}


	--[[ Disabled dialog cleanup for now ~ it seems natively addressed
	* event: load
	* desc : Event called when the addon is being loaded.
	--]]
	ashita.events.register('load', 'load_cb', function ()



	--CREATE BACK IMAGE

	backimage = frames(fbackimage);
	
	--CREATE BACK LEFT IMAGE

	backleftimage = frames(fbackleftimage);

	--CREATE TARGET COVER IMAGE

	targetcoverimage = frames(ftargetcoverimage);
	
	--CREATE TARGET LEFT COVER IMAGE

	targetleftcoverimage = frames(ftargetleftcoverimage);
	
	--CREATE TARGET RIGHT COVER IMAGE

	targetlockedtext = frames(ftargetlockedtext);

	--CREATE TARGET NAME LABEL

	targetnamelabel = fonts.new(ftargetnamelabel);

	--CREATE TARGET NAME LABEL2

	targetnamelabel2 = fonts.new(ftargetnamelabel2);
	
	--CREATE TARGET NAME LABEL3

	targetnamelabel3 = fonts.new(ftargetnamelabel3);
	
	
	--CREATE TARGET HEALTH BACK IMAGE

	targethealthbackimage = fonts.new(ftargethealthbackimage);

	--CREATE TARGET HEALTH FRONT IMAGE

	targethealthfrontimage = fonts.new(ftargethealthfrontimage);
	
	
		--CREATE RANGE FRONT IMAGE

	targetrangelabel = fonts.new(ftargetrangelabel);
	
	--CREATE RANGE BACK IMAGE

	targetrangelabelback = fonts.new(ftargetrangelabelback);
	





	--CREATE SELECT LABEL
	for x = 1, 6 do
	selectedlabel2[x] = fonts.new(fselectback);
	selectedlabel2[x].position_y = scaling.scale_h(((x-1) * -20) + -21);
	selectedlabel2[x].position_x = scaling.scale_w(-1);
	end

	--CREATE CASTBAR LABEL
	for x = 1, 6 do
	castbar[x] = fonts.new(fcastbar);
	castbar[x].position_y = scaling.scale_h(((x-1) * -20) + -21);
	castbar[x].position_x = scaling.scale_w(-500);
	end

	--CREATE RECCASTBAR LABEL
	for x = 1, 6 do
	reccastbar[x] = fonts.new(freccastbar);
	reccastbar[x].position_y = scaling.scale_h(((x-1) * -20) + -21);
	reccastbar[x].position_x = scaling.scale_w(-1);
	end
	
	--CREATE JOB LABEL
	for x = 1, 6 do
	joblabel[x] = fonts.new(fjoblabel);
	joblabel[x].position_y = scaling.scale_h(((x-1) * -20) + -48);
	joblabel[x].position_x = scaling.scale_w(-45);
	end

	--CREATE NAME LABEL
	for x = 1, 6 do
	namelabel[x] = fonts.new(fnamelabel);
	namelabel[x].position_y = scaling.scale_h(((x-1) * -20) + -46);
	namelabel[x].position_x = scaling.scale_w(-133);
	end
	



	--CREATE HEALTH BACK
	for x = 1, 6 do
	healthback[x] = fonts.new(fhealthback);
	healthback[x].position_y = scaling.scale_h(((x-1) * -20) + -23);
	healthback[x].position_x = scaling.scale_w(-179);

	end

	--CREATE HEALTH FRONT
	for x = 1, 6 do
	healthfront[x] = fonts.new(fhealthfront);
	healthfront[x].position_y = scaling.scale_h(((x-1) * -20) + -23);
	healthfront[x].position_x = scaling.scale_w(-179-140);
	end


	--CREATE HEALTH LABEL
	for x = 1, 6 do
	healthlabel[x] = fonts.new(fhealthlabel);
	healthlabel[x].position_y = scaling.scale_h(((x-1) * -20) + -46);
	healthlabel[x].position_x = scaling.scale_w(-174);
	end



	--CREATE MANA BACK
	for x = 1, 6 do
	manaback[x] = fonts.new(fmanaback);
	manaback[x].position_y = scaling.scale_h(((x-1) * -20) + -23);
	manaback[x].position_x = scaling.scale_w(-321);
	end

	--CREATE MANA FRONT
	for x = 1, 6 do
	manafront[x] = fonts.new(fmanafront);
	manafront[x].position_y = scaling.scale_h(((x-1) * -20) + -23);
	manafront[x].position_x = scaling.scale_w(-321);
	end


	--CREATE MANA LABEL
	for x = 1, 6 do
	manalabel[x] = fonts.new(fmanalabel);
	manalabel[x].position_y = scaling.scale_h(((x-1) * -20) + -46);
	manalabel[x].position_x = scaling.scale_w(-417);	
	
	end


	--CREATE TP LABEL
	for x = 1, 6 do
	tplabel[x] = fonts.new(ftplabel);
	tplabel[x].position_y = scaling.scale_h(((x-1) * -20) + -43);
	tplabel[x].position_x = scaling.scale_w(-480);
	end


	--CREATE STATUS LABEL
	for x = 1, 6 do
	statuslabel[x] = fonts.new(fstatuslabel);
	statuslabel[x].position_y = scaling.scale_h(((x-1) * -20) + -43);
	statuslabel[x].position_x = scaling.scale_w(-412);
	end	


	end);



	--[[
	* event: unload
	* desc : Event called when the addon is being unloaded.
	--
	ashita.events.register('unload', 'unload_cb', function ()



	if (targetcoverimage ~= nil) then
		targetcoverimage:destroy();
		targetcoverimage = nil;
	end
	if (targetlockedtext ~= nil) then
		targetlockedtext:destroy();
		targetlockedtext = nil;
	end
	if (targetnamelabel ~= nil) then
		targetnamelabel:destroy();
		targetnamelabel = nil;
	end
	if (targetnamelabel2 ~= nil) then
		targetnamelabel2:destroy();
		targetnamelabel2 = nil;
	end
	if (targetnamelabel3 ~= nil) then
		targetnamelabel3:destroy();
		targetnamelabel3 = nil;
	end
	if (targetrangelabel ~= nil) then
		targetrangelabel:destroy();
		targetrangelabel = nil;
	end
	if (targetrangelabelback ~= nil) then
		targetrangelabelback:destroy();
		targetrangelabelback = nil;
	end
	if (targethealthbackimage ~= nil) then
		targethealthbackimage:destroy();
		targethealthbackimage = nil;
	end
	if (targethealthfrontimage ~= nil) then
		targethealthfrontimage:destroy();
		targethealthfrontimage = nil;
	end
	
	for x = 1, 6 do
	--if (coverimage[x] ~= nil) then
		--coverimage[x]:destroy();
		--coverimage[x] = nil;
	--end

	if (namelabel[x] ~= nil) then
		namelabel[x]:destroy();
		namelabel[x] = nil;
	end	
	
	if (joblabel[x] ~= nil) then
		joblabel[x]:destroy();
		joblabel[x] = nil;
	end	

	if (selectedlabel1[x] ~= nil) then
		selectedlabel1[x]:destroy();
		selectedlabel1[x] = nil;
	end

	if (selectedlabel2[x] ~= nil) then
		selectedlabel2[x]:destroy();
		selectedlabel2[x] = nil;
	end	

	if (healthlabel[x] ~= nil) then
		healthlabel[x]:destroy();
		healthlabel[x] = nil;
	end	
	if (healthback[x] ~= nil) then
		healthback[x]:destroy();
		healthback[x] = nil;
	end

	if (healthfront[x] ~= nil) then
		healthfront[x]:destroy();
		healthfront[x] = nil;
	end	

	if (manaback[x] ~= nil) then
		manaback[x]:destroy();
		manaback[x] = nil;
	end

	if (manafront[x] ~= nil) then
		manafront[x]:destroy();
		manafront[x] = nil;
	end		
	if (manalabel[x] ~= nil) then
		manalabel[x]:destroy();
		manalabel[x] = nil;
	end		
	if (tplabel[x] ~= nil) then
		tplabel[x]:destroy();
		tplabel[x] = nil;
	end		
	if (statuslabel[x] ~= nil) then
		statuslabel[x]:destroy();
		statuslabel[x] = nil;
	end	
	end

	end);

local function test1()

	print("test");

end
--]]


local spells = T {}

local casts = T {}

local function castsclean()

	if (#casts ~= nil and casts ~= nil) then


	
	for x = 1, #casts do
	
	
	
	
	
		--print(tostring(#casts));
		--print(tostring(
		
		if (casts[x]~=nil) then	
	
		if (ashita.time.clock()['ms'] > casts[x][4]) then
		
			table.remove(casts,x);
		
		end
		
		end
	
	end
	
	
	
	
	end
	
	
	if (#spells ~= nil and spells ~= nil) then


	
	for x = 1, #spells do
	
	
	
	
	
		--print(tostring(#casts));
		--print(tostring(
		
		if (spells[x]~=nil) then	
	
		if (ashita.time.clock()['ms'] > spells[x][4]) then
		
			table.remove(spells,x);
		
		end
		
		end
	
	end
	
	
	
	
	end	
	
	
end


	local lastcount = 0;

	local lasttarget = nil;

	--[[
	* event: d3d_present
	* desc : Event called when the Direct3D device is presenting a scene.
	--]]
	ashita.events.register('d3d_present', 'present_cb', function ()

	castsclean();
	

	local party = AshitaCore:GetMemoryManager():GetParty();
	local zone = party:GetMemberZone(0);

	local partycount = party:GetAlliancePartyMemberCount1();



	local target = GetEntity(AshitaCore:GetMemoryManager():GetTarget():GetTargetIndex(0));
	

	
	
	local target2    = AshitaCore:GetMemoryManager():GetTarget();

	--	print(tostring(target2:GetWindowHPPercent(0)));


			if(targetcoverimage.visible ==false) then
			targetlockedtext.visible = false;
			end


	
		if (target ~= nil) then
			namefitlered = filtername(target.Name);
			if (#mysplit(namefitlered)==1) then
			targetnamelabel3.text = mysplit(namefitlered)[1];
			targetnamelabel2.text = " ";
			targetnamelabel.text = " ";
			end
			if (#mysplit(namefitlered)>=2) then
			targetnamelabel3.text = " ";
			targetnamelabel2.text = mysplit(namefitlered)[1];
			targetnamelabel.text = mysplit(namefitlered)[2];
			end
			
			
			if (target.Type==0)then
			targethealthfrontimage.background.color = 0xFFFFFFFF;
			else
			targethealthfrontimage.background.color = 0xFFFF0000;
			end
			
			local thp = target2:GetWindowHPPercent(0);
			
			
			
			
			
			if(target2:GetLockedOnFlags()==1 and targetcoverimage.visible ==true) then
			targetlockedtext.visible = true;
			else
			targetlockedtext.visible = false;
			end
			
			
			
			
			thp = thp / 100;
			thp = thp * targethealthbackimage.background.width;
			thp = round(thp);
			targethealthfrontimage.background.width = thp;
			
			--targethealthfrontimage.text = spaces(thp);
			
			
			local ran = math.sqrt(target.Distance);
			--print(ran);
					ran = ran / 20.4;	
			if (ran >1) then
			targetrangelabel.background.color = 0x80FF0000;
			else
			targetrangelabel.background.color = 0xFF008000;
			end
			
			
			--ran = ran / 21.8;

			
			targetrangelabel.background.width = math.ceil(ran * targetrangelabelback.background.width,500);
			--targetrangelabel.text = spaces(ran);			
			
			
			
		
			if (targetcoverimage.visible == false) then
				targetcoverimage.visible = true;
				targetleftcoverimage.visible = true;
				targetnamelabel.visible = true;
				targetnamelabel2.visible = true;
				targetnamelabel3.visible = true;
				targethealthbackimage.visible = true;
				targethealthfrontimage.visible = true;
				targetrangelabelback.visible = true;
				targetrangelabel.visible = true;
			end
		
		
		
		
		
		

			if (target ~= lasttarget or partycount ~= lastcount) then
				local targetname = tostring(target.Name);
				lasttarget = targetname;
			
				for x = 1, 6 do
				

					selectedlabel2[x].visible = false;
					--coverimage[x].background.color = 0xFF000010;
					
					
				end
				
				
				for x = 1, partycount do
				
					if (party:GetMemberName(partycount-x) == targetname) then
					
					targethealthfrontimage.background.color = 0xCCFF0000;
					
					healthfront[x].visible = false;					
					
					selectedlabel2[x].visible = true;
					--coverimage[x].background.color = 0xFF303010;
					

						healthfront[x].visible = true;
					end
				
				end
				
				
			
			end
		
		else

			if (targetcoverimage.visible == true) then
				targetcoverimage.visible = false;
				targetleftcoverimage.visible = false;
				targetnamelabel.visible = false;
				targetnamelabel2.visible = false;
				targetnamelabel3.visible = false;
				targethealthbackimage.visible = false;
				targethealthfrontimage.visible = false;
				targetrangelabelback.visible = false;
				targetrangelabel.visible = false;
			end








			if (lasttarget ~= nil) then
			
				for x = 1, 6 do
				
					selectedlabel2[x].visible = false;	
					--coverimage[x].background.color = 0xFF000010;
					
					
					
					
				end		
			end
		
		end
		
		
		



	if (partycount ~= lastcount) then


		for x = 1, 6 do
			--coverimage[x].visible = false;
			namelabel[x].visible = false;
			healthlabel[x].visible = false;
			healthback[x].visible = false;
			healthfront[x].visible = false;
			manaback[x].visible = false;
			manafront[x].visible = false;
			manalabel[x].visible = false;
			tplabel[x].visible = false;
			statuslabel[x].visible = false;
			joblabel[x].visible = false;
			castbar[x].visible = false;
			reccastbar[x].visible = false;
		end
		
		

		for x = 1, partycount do
			--coverimage[x].visible = true;
			namelabel[x].visible = true;
			healthlabel[x].visible = true;
			healthback[x].visible = true;
			healthfront[x].visible = true;
			manaback[x].visible = true;
			manafront[x].visible = true;
			manalabel[x].visible = true;
			tplabel[x].visible = true;
			statuslabel[x].visible = true;
			joblabel[x].visible = true;
			castbar[x].visible = true;
			reccastbar[x].visible = true;
		end	

















	targetleftcoverimage.position_y = partycount * targetleftcoverimage.position_y_scaling + targetleftcoverimage.position_y_constant;
	targetcoverimage.position_y = partycount * targetcoverimage.position_y_scaling + targetcoverimage.position_y_constant;
	targetlockedtext.position_y = partycount * targetlockedtext.position_y_scaling + targetlockedtext.position_y_constant;
	targetnamelabel.position_y =  partycount * targetnamelabel.position_y_scaling + targetnamelabel.position_y_constant;
	targetnamelabel2.position_y =  partycount * targetnamelabel2.position_y_scaling + targetnamelabel2.position_y_constant;
	targetnamelabel3.position_y =  partycount * targetnamelabel3.position_y_scaling + targetnamelabel3.position_y_constant;
targethealthbackimage.position_y =  partycount * targethealthbackimage.position_y_scaling + targethealthbackimage.position_y_constant;
targethealthfrontimage.position_y =  partycount * targethealthfrontimage.position_y_scaling + targethealthfrontimage.position_y_constant;
	targetrangelabelback.position_y = partycount *targetrangelabelback.position_y_scaling + targetrangelabelback.position_y_constant;
	targetrangelabel.position_y = partycount * targetrangelabel.position_y_scaling + targetrangelabel.position_y_constant;


	backimage.background.height = partycount * backimage.size_y_scaling + backimage.size_y_constant;


backleftimage.background.height = partycount * backleftimage.size_y_scaling + backleftimage.size_y_constant;





	end












	for x = 1, partycount do
	
		local memberentity = GetEntity(party:GetMemberTargetIndex(partycount-x));
		
		if (memberentity ~= nil) then

			if (math.sqrt(memberentity.Distance) < 20.4) then

				namelabel[x].color = 0xFFFFFFFF;
			else
		
				namelabel[x].color = 0x80FFFFFF;
			end

		else
		
			namelabel[x].color = 0x80FFFFFF;
		end
		
		

		
		
		
		
		
		
		
		
		
	end








	for x = 1, partycount do


		local mzone = party:GetMemberZone(partycount-x)
		
		if (mzone ~= zone and healthfront[x].visible == true) then
				


			healthfront[x].visible = false;
			healthlabel[x].visible = false;
			manafront[x].visible = false;
			manalabel[x].visible = false;
			tplabel[x].visible = false;
				


			end

			if (mzone == zone and healthfront[x].visible == false) then


				healthlabel[x].visible = true;
				healthfront[x].visible = true;
				manafront[x].visible = true;
				manalabel[x].visible = true;
				tplabel[x].visible = true;
		

			

		end


		--statuslabel[x].text = " ";

		if (mzone == zone) then
			statuslabel[x].text = " ";
			else
			statuslabel[x].text = spaces(24)..zonesarray[party:GetMemberZone(partycount-x)+1];
		end
			
			
		if (tostring(jobsarray[party:GetMemberMainJob(partycount-x)])~="nil") then
		joblabel[x].text = jobsarray[party:GetMemberMainJob(partycount-x)];
		else
		joblabel[x].text = " ";
		end
			
		namelabel[x].text = string.sub(party:GetMemberName(partycount-x),1,8);
		
	if(party:GetMemberServerId(x) == party:GetAlliancePartyLeaderServerId1(x) and party:GetMemberServerId(x) ~= 0) then
	namelabel[x].text = namelabel[x].text.."*";
	end		
		
		
		
		manalabel[x].text = tostring(party:GetMemberMP(partycount-x));
		healthlabel[x].text = tostring(party:GetMemberHP(partycount-x));



		hpp = party:GetMemberHPPercent(partycount-x);
		hpp = hpp / -100;
				if (hpp == 	-1) then
					healthfront[x].background.border_visible = false; 
				else
					healthfront[x].background.border_visible = true; 
				end
		hpp = hpp * healthback[x].background.width;
		
		healthfront[x].background.width = hpp;
			

			
		--healthfront[x].text = spaces(hpp);

		if (mzone == zone) then
			if (hpp == 0) then
			statuslabel[x].text = spaces(30).."DEAD";
			else
			statuslabel[x].text = " ";
			end
		end


		local buffids = getMemberBuffs(partycount-x);
		--print(partycount-x);
		
		
		
		if (buffids ~= nil) then
		if (has_value(buffids,2)) then
		
		statuslabel[x].text = statuslabel[x].text.."SLE'd ";
		end
		if (has_value(buffids,3)) then
		statuslabel[x].text = statuslabel[x].text.."POI'd ";
		end		
		if (has_value(buffids,4)) then
		statuslabel[x].text = statuslabel[x].text.."PAR'd ";
		end				
		if (has_value(buffids,5)) then
		statuslabel[x].text = statuslabel[x].text.."BLI'd ";
		end				
		if (has_value(buffids,6)) then
		statuslabel[x].text = statuslabel[x].text.."SIL'd ";
		end			
		if (has_value(buffids,7)) then
		statuslabel[x].text = statuslabel[x].text.."PET'd ";
		end	
		if (has_value(buffids,8)) then
		statuslabel[x].text = statuslabel[x].text.."DIS'd ";
		end	
		if (has_value(buffids,9)) then
		statuslabel[x].text = statuslabel[x].text.."CURS'd ";
		end	

		end
		


		local lowestrec = 0;
		local lowestrecmax = 0;
		
		for x2 = 1, #casts do
			
			if (casts[x2][1] == party:GetMemberName(partycount-x)) then
				if ((casts[x2][4])-ashita.time.clock()["ms"] > lowestrec) then
					lowestrec = ashita.time.clock()["ms"]-casts[x2][4];
					lowestrecmax = casts[x2][5];
				end
				
				statuslabel[x].text = statuslabel[x].text..casts[x2][3].."- "..string.format("%1.1f", (casts[x2][4]-ashita.time.clock()["ms"])/1000).." ";
		
			end
	
		end


		if (lowestrec ~= 0) then
			reccastbar[x].background.width = (lowestrec/lowestrecmax) * scaling.scale_w(500);
		
		else
			reccastbar[x].background.width = 0;
		
		end









		local notcasting = true;
		for x2 = 1, #casts do
			
			if (casts[x2][2] == party:GetMemberName(partycount-x)) then
				notcasting = false;
				manalabel[x].visible = false;
				local tim = ((casts[x2][4]-ashita.time.clock()["ms"])/casts[x2][5])*scaling.scale_w(500);
				castbar[x].background.width = tim;
	--statuslabel[x].text = statuslabel[x].text..casts[x2][3].."- "..string.format("%1.1f", (casts[x2][4]-ashita.time.clock()["ms"])/1000).." ";			
				--statuslabel[x].text = statuslabel[x].text..casts[x2][3].."- "..string.format("%1.1f", (casts[x2][4]-ashita.time.clock()["ms"])/1000).." ";
				tplabel[x].color = 0xFFFFFFFF;
				tplabel[x].text = casts[x2][3];
			end
	
		end

		if (notcasting == true and mzone == zone) then
		castbar[x].background.width = 0;
		manalabel[x].visible = true;
		end





		mpp = party:GetMemberMPPercent(partycount-x);
		mpp = mpp / 100;
				if (mpp == 	1) then
					manafront[x].background.border_visible = false; 
				else
					manafront[x].background.border_visible = true; 
				end
		mpp = mpp * manaback[x].background.width;
	
		manafront[x].background.width = mpp;
			
			
		--manafront[x].text = spaces(mpp);
			
			
			
		tpp = party:GetMemberTP(partycount-x);			
		tppp = false;

	
	if (notcasting == true) then
		if (tppp == false) then
			if (tpp==3000) then
			tpp = "RDY";
			tplabel[x].color = 0xFFFF1010;
			tppp = true;
			end
		end		
		if (tppp == false) then
			if (tpp>=2000) then
			tpp = "RDY";
			tplabel[x].color = 0xFFFFA500;
			tppp = true;
			end
		end				
		if (tppp == false) then
			if (tpp>=1000) then
			tpp = "RDY";
			tplabel[x].color = 0xFF80FF80;
			tppp = true;
			end
		end		
			
		if (tppp == false) then
			if (tpp<=500) then
			tpp = " ";
			tppp = true;
			end
		end

		if (tppp == false) then		
			if (tpp>501) then
			tpp = tostring(round(tpp/10)).."%";
			tplabel[x].color = 0xFFFFFFFF;
			tppp = true;
			end
		end		

		tplabel[x].text = tpp;				
	end
			

			
	
			
			
			
			
			
			
			
			
			
			
			
			

				



	end



	lastcount = partycount;

end);








ashita.events.register('text_in', 'text_in_cb', function (e)
    -- Obtain the mode information..
    local mex = bit.band(e.mode_modified,  0xFFFFFF00);
    local mid = bit.band(e.mode_modified,  0x000000FF);
	




    -- Parse the message for auto-translate tags to prevent collisions with linebreak matching..
    local msg = AshitaCore:GetChatManager():ParseAutoTranslate(e.message_modified, true);
	
	
	
	
	
	
	
	if (string.match(msg," interrupted")) then	
		local words = mysplit(msg);
		
		local targetafter = indexOf(words, "casting");

		local caster = words[targetafter-1];
		
		caster = mysplit(caster,"'");
		
		caster = caster[1];
	
		if (#casts ~= nil) then


	
			for x = 1, #casts do
				if(casts[x] ~= nil) then
				if (caster == casts[x][2]) then
		
				table.remove(casts,x);
				
				end
				end
			end
	
		end
	
	
	
	
	end
	
	
	
	
	
	if (string.match(msg," starts casting ")) then
		
		castsclean();
	
		local words = mysplit(msg);
		
		local targetafter = indexOf(words, "starts");
		
		local caster = words[targetafter-1];
	
		local target = words[#words];
		
		target = mysplit(target,".");
		
		target = target[1];
		
		local time = os.time();
		
		local spell = "";
		
		local duration = 0;
		
		if (string.match(msg, "Cure o")) then
			spell = "CUR1";
			duration = 2;
		end
		if (string.match(msg, "Cure II")) then
			spell = "CUR2";
			duration = 2.25;
		end		
		if (string.match(msg, "Cure III")) then
			spell = "CUR3";
			duration = 2.5;
		end		
		if (string.match(msg, "Cure VI")) then
			spell = "CUR4";
			duration = 2.5;
		end			
		if (string.match(msg, "Cure V")) then
			spell = "CUR5";
			duration = 2.5;
		end				
		if (string.match(msg, "Poisona")) then
			spell = "POI.a";
			duration = 2;
		end			
		if (string.match(msg, "Stona")) then
			spell = "PET.a";
			duration = 1;
		end	
		if (string.match(msg, "Paralyna")) then
			spell = "PAR.a";
			duration = 1;
		end	
		if (string.match(msg, "Silena")) then
			spell = "SIL.a";
			duration = 1;
		end	
		if (string.match(msg, "Blindna")) then
			spell = "BLI.a";
			duration = 1;
		end	
		if (string.match(msg, "Cursena")) then
			spell = "CURS.a";
			duration = 3;
		end			
		if (string.match(msg, "Viruna")) then
			spell = "VIR.a";
			duration = 1;
		end					
		
		
		if (duration ~= nil) then
			duration = duration * 1000;
		end
		
		
		
		if (spell ~= "" and target ~= nil and caster ~= nil and spell ~= nil and duration ~= nil) then
		
			
		
			
			
			casts[#casts+1] = {target,caster,spell,ashita.time.clock()['ms']+duration,duration};
			
			
		end
	end



end);















--[[

	if (mzone == zone) then
	statuslabel[x].text = "";
	else
	statuslabel[x].text = zonesarray[party:GetMemberZone(partycount-x)+1];
	end
	
	
	]]
	

