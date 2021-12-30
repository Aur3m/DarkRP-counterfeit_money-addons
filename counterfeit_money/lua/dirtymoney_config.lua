DDirtyMoney = {}

DDirtyMoney.ResetOnRespawn = true -- Should we reset player's bad money when he respawn ? (if true, we reset, if false, we dont reset)
DDirtyMoney.ResetOnConnect = true -- Should we reset player's bad money when he reconnect ? (if true, we reset, if false, we dont reset)


DDirtyMoney.DropCommand = "/dropbad" -- Use to drop badmoney: example:   /dropbad 5000
DDirtyMoney.AdminCommand = "!dirtyadmin" -- Use it to open the panel

DDirtyMoney.AdminRanks = { -- Ranks allowed to use the admin command
	["superadmin"] = true,
}

DDirtyMoney.TimeAutoSave = 60 -- Time for autosave in seconds (usefull if server crash and you don't reset money when player Connect), set to nil if you don't want to autosave

DDirtyMoney.IsWanted = true -- Should the Launder be searched by Cops if he fail a transaction ?
DDirtyMoney.TimeWanted = 600 -- Time for the research on the player (used only if you use "IsWanted" value)


-- NPC PART

DDirtyMoney.Percentage = 0.75 -- We will will tax this amount to player, so if he want to exchange 100$, he will earn 75$ with a value of 0.75

DDirtyMoney.ColorBackground = Color(0,0,0) -- Color for the background menu
DDirtyMoney.ColorMainText = Color(255,255,255) -- Color for the main text
DDirtyMoney.ColorYesButton = Color(150,255,150) -- Color for the Yes button
DDirtyMoney.ColorNoButton = Color(255,150,150) -- Color for the No button
DDirtyMoney.ColorYesText = Color(255,255,255) -- Color for the Yes text
DDirtyMoney.ColorNoText = Color(255,255,255) -- Color for the No text




-- JOB PART 

DDirtyMoney.LaunderTeam = { -- The teams allowed to use the Monitor
	["Banquier"] = true,
}



DDirtyMoney.ColorJobText = Color(209, 216, 224) -- Color for all the texts
DDirtyMoney.ColorJobMainBackground = Color(30, 55, 153) -- Color for the background
DDirtyMoney.ColorJobMainHeader = Color(12, 36, 97) -- Color for the header background
DDirtyMoney.ColorJobInfoButton = Color(135,206,250) -- Color for the Info Button
DDirtyMoney.ColorJobHeaderBar = Color(235, 47, 6) -- Color for the litle line in the header
 
--[[  Light Theme
DDirtyMoney.ColorJobText = Color(0, 0, 0) -- Color for all the texts
DDirtyMoney.ColorJobMainBackground = Color(255, 255, 240) -- Color for the background
DDirtyMoney.ColorJobMainHeader = Color(245, 245, 220) -- Color for the header background
DDirtyMoney.ColorJobInfoButton = Color(135,206,250) -- Color for the Info Button
DDirtyMoney.ColorJobHeaderBar = Color(255, 0, 0) -- Color for the litle line in the header
--]]


DDirtyMoney.GameEasyTime = 10 -- How much time player have to click all the buttons in the Easy level
DDirtyMoney.GameHalfSafeTime = 6.80 -- How much time player have to click all the buttons in the HalfSafe level
DDirtyMoney.GameRiskyTime = 3.50 -- How much time player have to click all the buttons in the Risky level

DDirtyMoney.GameEasyTax = 0.295 -- How much will we tax when player win the Easy level (If you go upper a value of 1, you will add more money than the initial bet)
DDirtyMoney.GameHalfSafeTax = 0.6 -- How much will we tax when player win the Half-Safe level (If you go upper a value of 1, you will add more money than the initial bet)
DDirtyMoney.GameRiskyTax = 0.9 -- How much will we tax when player win the Risky level (If you go upper a value of 1, you will add more money than the initial bet)