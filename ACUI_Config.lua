-- ACUI Configuration Loader module
-- Version 0.6.0 for ACUI v0.6.0
-- 
-- Author: Arnvid (with tons of code lent and learnt from other authors)
-- Email: arnvid@gmail.com
--
--	Updates:
--
--	0.6.0
--		Updated for 111100
--		Completely redone system loading.. Autoconfig of entire system now works
--
--	0.5.0
--		Updated for 10900
--		Added support for accountant
--
--	0.4.1
--		Updated for 1800 patch
--		Added update command
--		Added support for FishingBuddy and Equipmanager
--		Updated config for AutoBar
-- 
--	0.4.0:
--		Recoded the whole thing. Updated for 1700 patch
--		Prepared for public release
--		Properly loads variables now.. hopefully it's without flaws so far ;)
--

------------------------------------------------------------------------------
-- Global+Local Variables
------------------------------------------------------------------------------
local ACUI_Version = "0.6.0"
local ACUI_cfgversion = "0.6.0"
local ACUI_CharName = "";
local ACUI_ProfileName1 = "";  -- config type Player of Realm
local ACUI_ProfileName2 = "";  -- config type Player - Realm
local ACUI_ProfileName3 = "";  -- config type Player|Realm
local ACUI_WOW_patch = "11000"
------------------------------------------------------------------------------
-- myAddOns - configuration settings.
------------------------------------------------------------------------------
ACUI_CONFIG_NAME = "ACUI_CONFIG";
ACUI_CONFIG_DESC = "configuration and defaults loader for ACUI.";
ACUI_CONFIG_VER = "0.6.0";
ACUI_CONFIG_LASTCHANGED = "0.6.0";
ACUI_CONFIG_FRAME = "ACUI_CONFIG_Frame";
ACUI_CONFIG_OPTIONSFRAME = "ACUI_CONFIG_ConfigFrame";
ACUI_Config = {}; 
ACUI_Config["releaseDate"] = "January 15, 2006";
ACUI_Help = {};
ACUI_Help[1] ="More info will be\n\nadded later!\n\n";
ACUI_Help[2] ="";
ACUI_Help[3] ="";
ACUI_Help[4] ="";


------------------------------------------------------------------------------
-- SLASH commands configuration
------------------------------------------------------------------------------
SLASH_ACUI_CONFIG1 = "/acuicfg";
SLASH_ACUI_CONFIG2 = "/acuiconfig";
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- ACUI System Loader
------------------------------------------------------------------------------
function ACUI_Config_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("ADDON_LOADED");

	SlashCmdList["ACUI_CONFIG"] = function(msg)
		ACUI_CONFIG__Command(msg);
	end
end

-----------------------------------------------------------------------------
-- ACUI reset default configs
------------------------------------------------------------------------------
function ACUI_Config_1024()
end 

function ACUI_Config_1280()
	ACUI_CONFIG__ChatPrint("ACUI: Loading FlexBar settings...");
	FB_Command_LoadProfile("Profile='Default1200 of ACUI'");
	FB_Command_SaveProfile("Profile='" .. ACUI_ProfileName1 .. "'");

	ACUI_CONFIG__ChatPrint("ACUI: Updating UberQuest config");
	UberQuest_Config[ACUI_CharName].lockminion = 1;
	UberQuest_Config[ACUI_CharName].minionvisible = 1;
	UberQuest_Config[ACUI_CharName].lock = {};
	UberQuest_Config[ACUI_CharName].lock.pointone = 1008;
	UberQuest_Config[ACUI_CharName].lock.pointtwo = 183.129;
	UberQuest_Config[ACUI_CharName].lock.corner = "BOTTOMRIGHT";
	UberQuest_Config_Update();
	
	ACUI_CONFIG__ChatPrint("ACUI: Updating MyInventory settings");
	ACUI_MyInventory_Toggle_Option("Lock", 1, 1);
	ACUI_MyInventory_Toggle_Option("Freeze", 1, 1);
	ACUI_MyInventory_Toggle_Option("ReplaceBags", 1, 1);
	ACUI_MyInventory_Toggle_Option("Count", 0, 1);
	ACUI_MyInventory_SetScale(0.71);
	ACUI_MyInventoryFrame_SetColumns(9);


	ACUI_CONFIG__ChatPrint("ACUI: Updating AutoBar settings");
	-- AutoBar_Config[ACUI_ProfileName2].
	
	AutoBar_Config[ACUI_ProfileName2].display.rows = 6;
	AutoBar_Config[ACUI_ProfileName2].display.alpha = 0.8;
	AutoBar_Config[ACUI_ProfileName2].display.columns = 2;
	AutoBar_Config[ACUI_ProfileName2].display.buttonwidth = 22;
	AutoBar_Config[ACUI_ProfileName2].display.buttonheight = 22;
	AutoBar_Config[ACUI_ProfileName2].display.reversebuttons = 1;
	AutoBar_Config[ACUI_ProfileName2].display.gapping = 2;
	AutoBar_Config[ACUI_ProfileName2].display.showemptybuttons = 1;
	AutoBar_Config[ACUI_ProfileName2].display.position = {};
	AutoBar_Config[ACUI_ProfileName2].display.position.y = 178.8084906232861;
	AutoBar_Config[ACUI_ProfileName2].display.position.x = 352.7012234744353;
	AutoBar_ConfigUpdated();

	ACUI_CONFIG__ChatPrint("ACUI: Updating ACUI Toolbar settings");
	GreenButtonsDisabled[ACUI_CharName] = true;
	UpdateACUI_GreenButtons();
-- 	UpdateACUI_GreenButtonsToggle();
-- this bugs.. will fix that later
	
--	ACUI_CONFIG__ChatPrint("ACUI: Updating x settings");

	ACUI_CONFIG__ChatPrint("ACUI: Updating UberActions settings");
	-- UberActions_Config[ACUI_CharName].lockactionbar = 1;
	-- UberActions_Config[ACUI_CharName].lockexceptshift = 1;
	-- UberActions_Config[ACUI_CharName].updatespells = 1;
	-- UberActions_Config[ACUI_CharName].showreagents = 1;
	-- ShowUIPanel(UberActions_ConfigFrame);
	-- UberActions_ConfigEdit();
	
	

	ACUI_CONFIG__ChatPrint("ACUI: Updating MyBank settings");
	ACUI_MyBank_Toggle_Option("Freeze", 0, 1);
	ACUI_MyBank_Toggle_Option("ReplaceBank", 1, 1);
	--- MyBankFrame_SetColumns(8);

	ACUI_CONFIG__ChatPrint("ACUI: Updating FishingBuddy settings");
--	FishingBuddy_SetSetting("MinimapButtonPosition",195);
--	FishingBuddy_UpdateMinimap();
	
	
	ACUI_CONFIG__ChatPrint("ACUI: Updating QuickCash settings");
	QuickCash_State[ACUI_ProfileName1].Locked = 1;

	ACUI_CONFIG__ChatPrint("ACUI: Updating Accountant settings");
	Accountant_SaveData[UnitName("player")]["options"].showbutton = true;
	Accountant_SaveData[UnitName("player")]["options"]["weekstart"] = 2;
	Accountant_SaveData[UnitName("player")]["options"].buttonpos = 123;
	AccountantButton_UpdatePosition();

	ACUI_CONFIG__ChatPrint("ACUI: Fixing screen positions...");
	ACUI_AvgXP:ClearAllPoints();
	ACUI_AvgXP:SetUserPlaced(1);
	ACUI_AvgXP:SetPoint("TOPLEFT", "UIParent", "TOPLEFT",0,-830);

	ACUI_ActionBarMicroDragButton:ClearAllPoints();
	ACUI_ActionBarMicroDragButton:SetUserPlaced(1);
	ACUI_ActionBarMicroDragButton:SetPoint("TOPLEFT", "UIParent", "TOPLEFT",482,-810);

	ACUI_BagBarDragButton:ClearAllPoints();
	ACUI_BagBarDragButton:SetUserPlaced(1);
	ACUI_BagBarDragButton:SetPoint("TOPLEFT", "UIParent", "TOPLEFT",510,-776);

	ACUI_ShapeshiftBarDragButton:ClearAllPoints();
	ACUI_ShapeshiftBarDragButton:SetUserPlaced(1);
	ACUI_ShapeshiftBarDragButton:SetPoint("TOPLEFT", "UIParent", "TOPLEFT",469,-1122);

	ACUI_PetBarDragButton:ClearAllPoints();
	ACUI_PetBarDragButton:SetUserPlaced(1);
	ACUI_PetBarDragButton:SetPoint("TOPLEFT", "UIParent", "TOPLEFT",346,-900);

	QuickCashFrame:ClearAllPoints();
	QuickCashFrame:SetUserPlaced(1);
	QuickCashFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT",368,-805);
	ClockFrame:ClearAllPoints();
	ClockFrame:SetUserPlaced(1);
	ClockFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT",640,-730);
	HonorTabFrame:ClearAllPoints();
	HonorTabFrame:SetUserPlaced(1);
	HonorTabFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT",690,-702);	


	KombatStatsDPSFrame:ClearAllPoints();
	KombatStatsDPSFrame:SetUserPlaced(1);
	KombatStatsDPSFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT",210,-722);	

	Perl_Config_Global_Load_Settings();

	ChatFrame_RemoveAllMessageGroups(ChatFrame1);
	ChatFrame_RemoveAllMessageGroups(ChatFrame2);
	ChatFrame_RemoveAllMessageGroups(ChatFrame3);
	ChatFrame_RemoveAllMessageGroups(ChatFrame4);
	ChatFrame_RemoveAllMessageGroups(ChatFrame5);
	ChatFrame_RemoveAllChannels(ChatFrame1);
	ChatFrame_RemoveAllChannels(ChatFrame2);
	ChatFrame_RemoveAllChannels(ChatFrame3);
	ChatFrame_RemoveAllChannels(ChatFrame4);
	ChatFrame_RemoveAllChannels(ChatFrame5);
	
	ACUI_CONFIG__ChatPrint("ACUI: Chatframe 1");

	ChatFrame1:ClearAllPoints();
	ChatFrame1:SetUserPlaced(1);
	ChatFrame1:SetPoint("TOPLEFT", "UIParent", "TOPLEFT",28,-590);
	ChatFrame1:SetWidth(296);
	ChatFrame1:SetHeight(101);
	FCF_SetChatWindowFontSize(ChatFrame1, 12);
	FCF_SetLocked(ChatFrame1,1);
	FCF_SetWindowColor(ChatFrame1, 0.3333, 0, 0.0078); 
	FCF_SetWindowAlpha(ChatFrame1, 0.247);
	ChatFrame_AddMessageGroup(ChatFrame1,  "SYSTEM");
	ChatFrame_AddMessageGroup(ChatFrame1,  "WHISPER");
	ChatFrame_AddMessageGroup(ChatFrame1,  "PARTY");
	ChatFrame_AddMessageGroup(ChatFrame1,  "CREATURE");

	ACUI_CONFIG__ChatPrint("ACUI: Chatframe 2");
	
	ChatFrame2:ClearAllPoints();
	ChatFrame2:SetUserPlaced(1);
	ChatFrame2:SetPoint("TOPLEFT", "UIParent", "TOPLEFT",28,-590);
	ChatFrame2:SetWidth(296);
	ChatFrame2:SetHeight(101);
	FCF_SetWindowName(ChatFrame2, "CombatLog");
	FCF_DockFrame(ChatFrame2);
	FCF_SetChatWindowFontSize(ChatFrame2,12);
	FCF_SetLocked(ChatFrame2,1);
	ChatFrame_AddMessageGroup(ChatFrame2,  "COMBAT_SELF_HITS");
	ChatFrame_AddMessageGroup(ChatFrame2,  "COMBAT_SELF_MISSES");
	ChatFrame_AddMessageGroup(ChatFrame2,  "COMBAT_PET_HITS");
	ChatFrame_AddMessageGroup(ChatFrame2,  "COMBAT_PET_MISSES");
	ChatFrame_AddMessageGroup(ChatFrame2,  "COMBAT_PARTY_HITS");
	ChatFrame_AddMessageGroup(ChatFrame2,  "COMBAT_PARTY_MISSES");
	ChatFrame_AddMessageGroup(ChatFrame2,  "COMBAT_FRIENDLYPLAYER_HITS");
	ChatFrame_AddMessageGroup(ChatFrame2,  "COMBAT_FRIENDLYPLAYER_MISSES");
	ChatFrame_AddMessageGroup(ChatFrame2,  "COMBAT_HOSTILEPLAYER_HITS");
	ChatFrame_AddMessageGroup(ChatFrame2,  "COMBAT_HOSTILEPLAYER_MISSES");
	ChatFrame_AddMessageGroup(ChatFrame2,  "COMBAT_CREATURE_VS_SELF_HITS");
	ChatFrame_AddMessageGroup(ChatFrame2,  "COMBAT_CREATURE_VS_SELF_MISSES");
	ChatFrame_AddMessageGroup(ChatFrame2,  "COMBAT_FRIENDLY_DEATH");
	ChatFrame_AddMessageGroup(ChatFrame2,  "COMBAT_HOSTILE_DEATH");
	ChatFrame_AddMessageGroup(ChatFrame2,  "COMBAT_XP_GAIN");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_SELF_DAMAGE");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_SELF_BUFF");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_PET_DAMAGE");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_PET_BUFF");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_PARTY_DAMAGE");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_FRIENDLYPLAYER_DAMAGE");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_FRIENDLYPLAYER_BUFF");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_HOSTILEPLAYER_DAMAGE");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_HOSTILEPLAYER_BUFF");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_CREATURE_VS_SELF_DAMAGE");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_CREATURE_VS_SELF_BUFF");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_DAMAGESHIELDS_ON_SELF");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_AURA_GONE_SELF");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_BREAK_AURA");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_PERIODIC_SELF_DAMAGE");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_PERIODIC_SELF_BUFFS");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_PERIODIC_CREATURE_DAMAGE");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_PERIODIC_CREATURE_BUFFS");
	ChatFrame_AddMessageGroup(ChatFrame2,  "SPELL_FAILED_LOCALPLAYER");
	ChatFrame_AddMessageGroup(ChatFrame2,  "COMBAT_HONOR_GAIN");

	FCF_SetWindowColor(ChatFrame2, 0, 0.0862, 0.2627); 
	FCF_SetWindowAlpha(ChatFrame2, 0.2784);
	
	ACUI_CONFIG__ChatPrint("ACUI: Chatframe 3");
	
	ChatFrame3:ClearAllPoints();
	ChatFrame3:SetUserPlaced(1);
	ChatFrame3:SetPoint("TOPLEFT", "UIParent", "TOPLEFT",28,-590);
	ChatFrame3:SetWidth(296);
	ChatFrame3:SetHeight(101);
	ChatFrame3:Show();
	FCF_SetWindowName(ChatFrame3, "Tradeskill");
	FCF_DockFrame(ChatFrame3);
	FCF_SetLocked(ChatFrame3,1);
	FCF_SetChatWindowFontSize(ChatFrame3,12);
	ChatFrame_AddMessageGroup(ChatFrame3,  "SKILL");
	ChatFrame_AddMessageGroup(ChatFrame3,  "COMBAT_MISC_INFO");
	ChatFrame_AddMessageGroup(ChatFrame3,  "SPELL_TRADESKILLS");
	ChatFrame_AddMessageGroup(ChatFrame3,  "SPELL_ITEM_ENCHANTMENTS");
	ChatFrame_AddMessageGroup(ChatFrame3,  "COMBAT_FACTION_CHANGE");
	ChatFrame_AddMessageGroup(ChatFrame3,  "MONEY");
	FCF_SetWindowColor(ChatFrame3, 0.2117, 0.0156, 0.2627); 
	FCF_SetWindowAlpha(ChatFrame3, 0.2196);
	
	ACUI_CONFIG__ChatPrint("ACUI: Chatframe 4");
	
	ChatFrame4:ClearAllPoints();
	ChatFrame4:SetUserPlaced(1);
	ChatFrame4:SetPoint("TOPLEFT", "UIParent", "TOPLEFT",28,-327);
	ChatFrame4:SetWidth(296);
	ChatFrame4:SetHeight(121);
	ChatFrame4:Show();
	FCF_SetWindowName(ChatFrame4, "Guildchat");
	FCF_SetChatWindowFontSize(ChatFrame4,12);
	FCF_SetLocked(ChatFrame4,1);
	ChatFrame_AddMessageGroup(ChatFrame4,  "GUILD");
	FCF_SetWindowColor(ChatFrame4, 0,0,0); 
	FCF_SetWindowAlpha(ChatFrame4, 0.247);
		
	ACUI_CONFIG__ChatPrint("ACUI: Chatframe 5");
	
	ChatFrame5:ClearAllPoints();
	ChatFrame5:SetUserPlaced(1);
	ChatFrame5:SetPoint("TOPLEFT", "UIParent", "TOPLEFT",28,-482);
	ChatFrame5:SetWidth(296);
	ChatFrame5:SetHeight(75);
	ChatFrame5:Show();
	FCF_SetWindowName(ChatFrame5, "Global");
	FCF_SetChatWindowFontSize(ChatFrame5,12);
	FCF_SetLocked(ChatFrame5,1);	
	ChatFrame_AddMessageGroup(ChatFrame5,  "SAY"); 
	ChatFrame_AddMessageGroup(ChatFrame5,  "YELL"); 
	ChatFrame_AddMessageGroup(ChatFrame5,  "LOOT");
	ChatFrame_AddMessageGroup(ChatFrame5,  "CHANNEL");
	ChatFrame_AddMessageGroup(ChatFrame5,  "MONEY");
	FCF_SetWindowColor(ChatFrame5, 0,0,0); 
	FCF_SetWindowAlpha(ChatFrame5, 0.247);
	JoinChannelByName("General");
	ChatFrame_AddChannel(ChatFrame5,"General");
	JoinChannelByName("Trade");
	ChatFrame_AddChannel(ChatFrame5,"Trade");
	ChatFrame_AddChannel(ChatFrame5,"Trade - City");
	JoinChannelByName("LocalDefense");
	ChatFrame_AddChannel(ChatFrame5,"LocalDefense");
	JoinChannelByName("LookingForGroup");
	ChatFrame_AddChannel(ChatFrame5,"LookingForGroup");
	JoinChannelByName("GuildRecruitment");
	ChatFrame_AddChannel(ChatFrame5,"GuildRecruitment");
	ChatFrame_AddChannel(ChatFrame5,"GuildRecruitment - City");
	
	-- script LeaveChannelByName("GuildRecruitment - City");

	FCF_SaveDock();
	ACUI_CONFIG__ChatPrint("ACUI: System state reset completed...");
end


-----------------------------------------------------------------------------
-- ACUI reset default configs
------------------------------------------------------------------------------
function ACUI_Config_Upgrade()
	ACUI_CONFIG__ChatPrint("ACUI: Cannot upgrade to 0.6.0 - run newXXXX...");
end
---
--------------------------------------------------------------------------
-- ACUI Event handler
------------------------------------------------------------------------------

function ACUI_Config_OnEvent()
	if( event == "ADDON_LOADED") then
--		if ( myAddOnsFrame_Register ) then
--			-- myAddons Support
--			ACUI_Config["name"] = ACUI_CONFIG_NAME;
--			ACUI_Config["version"] = ACUI_Version;
--			ACUI_Config["author"] = "Arnvid"
--			ACUI_Config["website"] = "http://www.leftoverexiles.com/download/";
--			ACUI_Config["category"] = MYADDONS_CATEGORY_OTHERS;
--			ACUI_Config["frame"] = ACUI_CONFIG_FRAME;
--			ACUI_Config["optionsframe"] = ACUI_CONFIG_OPTIONSFRAME;
--			ACUI_Config["description"] = ACUI_CONFIG_DESC;
--			-- Register the addon in myAddOns
--			if(myAddOnsFrame_Register) then
--				myAddOnsFrame_Register(ACUI_Config, ACUI_Help);
--			end
--		end
	elseif (event == "VARIABLES_LOADED" or event == "UNIT_NAME_UPDATE") then
		if ( (arg1 and event == "UNIT_NAME_UPDATE" and (arg1 == "player")) or (event == "VARIABLES_LOADED")) then
			ACUI_CharName = UnitName("player");
			ACUI_ProfileName1 = ACUI_CharName .. " of " .. GetCVar("RealmName");
			ACUI_ProfileName2 = ACUI_CharName .. " - " .. GetCVar("RealmName");
			ACUI_ProfileName3 = ACUI_CharName .. "|" .. GetCVar("RealmName");
			if ((ACUI_CharName) and (ACUI_CharName ~= UNKNOWNOBJECT)) then
				DEFAULT_CHAT_FRAME:AddMessage( "ACUI: Set profilename " .. ACUI_ProfileName1 .. " ready to start up..." );
				if (ACUI_FirstRun ~= nil) then
					if (ACUI_FirstRun[ACUI_ProfileName1] == nil) then
						ACUI_FirstRun[ACUI_ProfileName1] = {};
						ACUI_FirstRun[ACUI_ProfileName1].firstrun = 1;
						ACUI_FirstRun[ACUI_ProfileName1].configver = ACUI_cfgversion;
						DEFAULT_CHAT_FRAME:AddMessage( "ACUI: Setup default values for configuration." );
					end
				else
					ACUI_FirstRun = {};
					ACUI_FirstRun[ACUI_ProfileName1] = {};
					ACUI_FirstRun[ACUI_ProfileName1].firstrun = 1;
					ACUI_FirstRun[ACUI_ProfileName1].configver = ACUI_cfgversion;
					DEFAULT_CHAT_FRAME:AddMessage( "ACUI: Setup default values for configuration." );
				end
			end
		end
	elseif (event == "PLAYER_ENTERING_WORLD") then
		DEFAULT_CHAT_FRAME:AddMessage( "ACUI: Player entering world - hopefully we are all set up..." );
		if ( ACUI_FirstRun[ACUI_ProfileName1].firstrun == 1 ) then
		  DEFAULT_CHAT_FRAME:AddMessage( "ACUI: Player " .. ACUI_ProfileName1 .. " is loaded for the first time. Please run /acuicfg config .." );
		else
		end
	end
end

------------------------------------------------------------------------------
-- ACUI - /acui command handlers
------------------------------------------------------------------------------
function ACUI_CONFIG__Command(ACUIcommand)
	if (not ACUIcommand) then
	  return;
	end

	local i,j, cmd, param = string.find(ACUIcommand, "^([^ ]+) (.+)$");
	if (not cmd) then cmd = ACUIcommand; end
	if (not cmd) then cmd = ""; end
	if (not param) then param = ""; end
	
	if ( cmd and strlen(cmd) > 0 ) then
		cmd = strlower(cmd);
	end	
	
  if (cmd == "status") then
		if ( ACUI_FirstRun[ACUI_ProfileName1].firstrun == 1 ) then
		  ACUI_CONFIG__ChatPrint("ACUI status for " .. ACUI_ProfileName1 .. " is first run!!"); 
		else
		  ACUI_CONFIG__ChatPrint("ACUI status for " .. ACUI_ProfileName1 .. " is not first run!!"); 
		end
  elseif (cmd == "config") then
    ACUI_CONFIG__ChatPrint("ACUI: Starting config menu...");
    ACUI_FirstRun[ACUI_ProfileName1].firstrun = 0;
  elseif (cmd == "new1024") then
    ACUI_CONFIG__ChatPrint("ACUI: Resetting settings... setting up for 1024x768");
    ACUI_FirstRun[ACUI_ProfileName1].firstrun = 1;
    ACUI_Config_1024();
    ACUI_FirstRun[ACUI_ProfileName1].firstrun = 0;
  elseif (cmd == "new1280") then
    ACUI_CONFIG__ChatPrint("ACUI: Resetting settings... setting up for 1280x1024");
    ACUI_FirstRun[ACUI_ProfileName1].firstrun = 1;
    ACUI_Config_1280();
    ACUI_FirstRun[ACUI_ProfileName1].firstrun = 0;
  elseif (cmd == "upgrade") then
    ACUI_CONFIG__ChatPrint("ACUI: Upgrading settings... (deprecated)");
    -- ACUI_Config_Upgrade();
    ACUI_FirstRun[ACUI_ProfileName1].firstrun = 0;    
  elseif (cmd == "first") then
   	ACUI_CONFIG__ChatPrint("ACUI: Toggling firstrun setting..");
   	if ( ACUI_FirstRun[ACUI_ProfileName1].firstrun == 1 ) then
   		ACUI_FirstRun[ACUI_ProfileName1].firstrun = 0;
   	else
   		ACUI_FirstRun[ACUI_ProfileName1].firstrun = 1;
   	end
  else
		ACUI_CONFIG__ChatPrint("ACUI Configuration.");
		ACUI_CONFIG__ChatPrint("Slash Command Usage|r:");
		ACUI_CONFIG__ChatPrint("\'/acuicfg status|r\'  - show first run status.");
		ACUI_CONFIG__ChatPrint("\'/acuicfg new1280|r\'   - setup ACUI for 1280x1024.");
		ACUI_CONFIG__ChatPrint("\'/acuicfg new1024|r\'   - setup ACUI for 1024x768. (not implemented)..");
--		ACUI_CONFIG__ChatPrint("\'/acuicfg config|r\'  - gui config for defaults.");
  end
end

------------------------------------------------------------------------------
-- ACUI - misc functions.
------------------------------------------------------------------------------

function ACUI_CONFIG__ChatPrint(str)
	if ( DEFAULT_CHAT_FRAME ) then 
		DEFAULT_CHAT_FRAME:AddMessage(str, 1.0, 1.0, 0.0);
	end
end

