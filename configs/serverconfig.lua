
--   _______   __ _    ____ 
--   |  ___\ \ / // \  / ___|
--   | |_   \ V // _ \| |    
--   |  _|   | |/ ___ \ |___ 
--   |_|    _|_/_/ _ \_\____|
--   __   _| ___| / |        
--   \ \ / /___ \ | |        
--    \ V / ___) || |        
--     \_/ |____(_)_|                               

FYAC_A = {}

--//Meslek Ayarları//--

FYAC_A.PolisJob = "police"
FYAC_A.SheriffJob = "sheriff"
FYAC_A.Cardealer = "cardealer"
FYAC_A.FBI = "fbi"
FYAC_A.DiscordLog = true
FYAC_A.DiscordFYACWarn      = "https://discord.com/api/webhooks/790666741189574656/79m7ith2SfcntNOcylo9hWK_SQD7VbW20utfEFsNNbj8PfEy2tqKVwixJ0sBQOJxbk5m" -- ETKILESIM LOGLARI FARKLI ODA ACINIZ.
FYAC_A.DiscordFYACPatlama = "https://discord.com/api/webhooks/790666741189574656/79m7ith2SfcntNOcylo9hWK_SQD7VbW20utfEFsNNbj8PfEy2tqKVwixJ0sBQOJxbk5m" -- ETKILESIM LOGLARI FARKLI ODA ACINIZ.
FYAC_A.DiscordFYACObject    = "https://discord.com/api/webhooks/790666909140910140/JOkX6JNwKmmHhcPyjT0sJDlRF9q2AZsA_jCuhY0jDPmWHRCRE3ovHoxT2OOP6iY3cGXu" -- OBJE SPAM LOGLARI (ÖNEMLİ)
FYAC_A.DiscordFYACAraba    = "https://discord.com/api/webhooks/790667016914337793/Vlcl5M075RSp0vaDAV4HSNptZrRIilIJK8yUuWHD6_0jUmEXtuwUCXCQ-rKsz-5glw6s" -- ARABA SPAM LOGLARI (ÖNEMLİ)
FYAC_A.DiscordFYACVehicles       = "https://discord.com/api/webhooks/799243491510583357/o_ayCXto0IbHiQFUVw6dhG-rbfmmXIHB9lRiuEtzXIjyBrVrIFvUyD45Fnu6V9kz841J"-- YASAKLI ARAC CIKARTANI LOGLAR (ÖNEMLİ)
FYAC_A.DiscordFYACNPC   = "https://discord.com/api/webhooks/790667182719107125/PYmSaXFFw_LCXzPU7LwL-tGkMjfkc-0G7Ub5F9-pMiyNgGzjXPm-2tdKf1Nnfaz0IPTB"-- NPC SPAM LOGLARI (ÖNEMLİ)
FYAC_A.DiscordFYACBan       = "https://discord.com/api/webhooks/790666648767561798/UaJpy4C-lDUddLhCICvYgAGSV8MkRDRyliP6D_U58D2UbSCSBOt5wmiFnFTTKujdZzhA"-- GENEL TÜM BANLAR BURDA TOPLANIR!
FYAC_A.DiscordFYACWeapon     = "https://discord.com/api/webhooks/792048971648335882/ChIbdaF4t8T_hwI-nASMo7qpCM_mJGvZrWfVqm_mZDQnAWKkeAEhr5VgqzTeJ0qYG6lA" -- YASAKLI SİLAH LOGLARI
-- # YASAKLI TELEFON KELIMELERI LOGLARI
FYAC_A.DiscordFYACPhone     = "https://discord.com/api/webhooks/804354927895904316/9aqo6UQ8xH1Lq5c6RbgS4kxWADOixXFYju5itP9JIIz_3zlC04D5o6tdCH1ZoaHrvnIB" -- YASAKLI TELEFON KELIMELERI LOGLARI
FYAC_A.DiscordFYACStop = "https://discord.com/api/webhooks/804266388306919444/f1ckCbuUgOFuXmdnBu874WBV-EKqcDS5O7hZ0-yLx_r3rnjGDMVZBtgQwFoVvZ_sTn9W" -- ANTİCHEAT STOPLAMA VEYA / PİNG DÜŞÜKLÜĞÜ LOGLARI


FYAC_A.BanMessage = "\nFYAC\nTR\n😱 Hile şüphesi nedeniyle uzaklaştırıldın!\nYapımcı : ! Raider#0031"
FYAC_A.PedBan = false -- PED SPAM DURUMUN DA BAN SİSTEMİ CALIŞIR KİŞİYİ BANLAR, WHİTELİST KISMINI DOLDURMADAN ACMANIZ ÖNERİLMEZ.
FYAC_A.TriggerDetection = true -- Kara listeye alınan bir tetikleyiciyi yürütmeye veya aramaya çalışan oyuncuyu tekmeleyin (orijinal tetikleyicilerinizi düzenlemeyi veya gizlemeyi unutmayın), bu tüm yeni başlayan dolandırıcıları / kızakları bulacaktır
FYAC_A.DetectExplosions = true -- Kara listeye alınmış patlamaları (tablolar / kara listeye eklenmiş patlamalar.lua)
FYAC_A.AntiNuke = true -- PATLAMA NESNESI OLUŞTURANI LOGLAR, VE PATLAMA HASARINI KAPATIR
FYAC_A.AntiTaser = true -- Taser engel 
FYAC_A.AntiVehicleSteal = true -- Araç çalma engel 
FYAC_A.YasakliTelefonKelimeleri = {"amk","allah","discord.gg","atg","anticheat","anan","esx","biat","roleplay","server","raider"}
FYAC_A.AntiSpawnPeds = true -- GENEL TÜM PEDLERI YASAKLAR SİLER, SÜREKLİ LOG DÜŞMESINI SİLMESINI ISTEMIYORSANIZ (tables/objewhitelist.lua FYAC_PedWhitelist ) bu kısma nesne kodlarını girin.
FYAC_A.AntiObject = true --- SADECE WHİTELİST OBJELER CIKARTILABİLİR GERİ KALANI SİLİNİR. tables/objewhitelist.lua
FYAC_A.AntiStop = true -- ANTİCHEAT STOPLANMASINI ENGELLER FAKAT HATALI CALIŞMA İHTİMALİ VAR ACMANIZI ÖNERMEYİZ.
FYAC_A.AntiStopMaxPing = 150 -- Anti stop laglı oyuncularda gereksiz banlanma yarattığından belirli bir pingin üstündeki oyuncunun algoritmasını zayıflatıyoruz. Pingi belirleyin.
FYAC_A.AntiStopResetTiming = 5000 -- Hafıza kontrolleri kaç saniyede bir yapılsın? Original: 5000 ( 5 saniye ) tavsiye edilen 5 saniyedir.
FYAC_A.AntiVehicles = true -- // YASAKLI ARAC CIKARTANA CRASH ATSIN MI?
FYAC_A.AntiSpawnVehicles = true -- TÜM ARAÇLARA BELLİ BİR LİMİT KOYAR 5 DAKİKA DA 3 ARAÇ GİBİ GENELDİR LİMİT AŞILIRSA CIKARTILAN ARACI SİLER.
FYAC_A.AntiVehicleSpamCount = 10 -- KAÇ TANE AYNI MODEL ARAÇ ÜST ÜSTE ÇIKARSA SİLMEYE BAŞLASIN.
FYAC_A.AntiSpamEvents = {"annen:raideriSik","fyac:Tokat"}
FYAC_A.CallbackSpamLimit = 5
FYAC_A.CallbackSpamLimitTablo = {
	["esx_policejob:getItemStocks"] = 40,
}
FYAC_A.AntiSpamResetTiming = 5000 -- Anti spam sistemleri ( araba,callback ) kaç saniyede bir hafızasını silsin? Original: 5000 ( 5 saniye ) tavsiye edilen 5 saniyedir.


FYAC_Language = {}
