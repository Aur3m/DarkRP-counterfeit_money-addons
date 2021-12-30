-------------------------------------------------------------------
--	Author		= SlownLS, 
--  Edit		= enzoFR60
--  Edit efficace = Deadman, Bordel qu'est-ce qu'il est pas opti ce script ! même pas responsive !
--	Addon 		= Wallet
-------------------------------------------------------------------

Wallet = Wallet or {}

-- true = FR : vous activez. ENG : you activate
-- false = FR : vous desactivez. ENG : you deactivate

Wallet.openmenu = true -- Open Menu Wallet

Wallet.ArgentIllegal = true -- 	information about illegal money

Wallet.DropDirtyCommand = "/dropbad" -- Command to drop dirty money
-- Language config

Wallet.SelectedLanguage = "fr" -- Language you want to use, currently only: English, French.

if (Wallet.SelectedLanguage == "en") then

 Wallet.LanguageHave = "You have"

 Wallet.LanguageSignMoney = "€"

 Wallet.LanguageMoneyIllegal = "illegal money on you."

 Wallet.LanguageMoney = "money on you."

 Wallet.LanguageEnterAmount = "Enter an amount ..."

 Wallet.LanguageDropMoney = "Throw money"

 Wallet.LanguageGiveMoney = "To give money"
 
 Wallet.LanguageWallet = "Wallet"

 Wallet.LanguageDropMoneyDirty = "Drop dirty money"
 Wallet.LanguageGiveMoneyDirty = "Give dirty money"
 
 -- Notif Darkrp and logs
 
 Wallet.LanguageDropMoneyLogs = "to throw away"

 Wallet.LanguageGiveMoneyLogs = "to give"
 
 Wallet.LanguageReceivedLogs = "has received"
 
 Wallet.LanguageAtLogs = " at "
 
 Wallet.LanguageOfLogs = " of "

elseif (Wallet.SelectedLanguage == "fr") then

 Wallet.LanguageHave = "Vous avez"

 Wallet.LanguageSignMoney = "€"

 Wallet.LanguageMoneyIllegal = "d'argent sale sur vous."

 Wallet.LanguageMoney = "d'argent sur vous."

 Wallet.LanguageEnterAmount = "Entrer un montant..."

 Wallet.LanguageDropMoney = "Jeter de l'argent"

 Wallet.LanguageGiveMoney = "Donner de l'argent"

 Wallet.LanguageWallet = "Porte-Monnaie"

 Wallet.LanguageDropMoneyDirty = "Jeter de l'argent sale"
 Wallet.LanguageGiveMoneyDirty = "Donner de l'argent sale"
 
 -- Notif Darkrp et logs
 
 Wallet.LanguageDropMoneyLogs = "a jeter"

 Wallet.LanguageGiveMoneyLogs = "a donner"
 
 Wallet.LanguageReceivedLogs = "à reçu"
 
 Wallet.LanguageAtLogs = " à "
 
 Wallet.LanguageOfLogs = " de "
 
end