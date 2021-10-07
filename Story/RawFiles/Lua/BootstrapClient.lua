local disabledTalents = {}
local firstTime = true
local prevTalentPoints = 0

local SpamCalls = {
    ['updateStatuses'] = true,
    ['update'] = true,
    ['removeTooltip'] = true,
    ['addTooltip'] = true,
    ['removeLabel'] = true,
    ['showFormattedTooltipAfterPos'] = true,
    ['addFormattedTooltip'] = true,
}

local function SniffInvoke(ui, call, ...)
    if SpamCalls[call] then return end
    -- if ui:GetTypeId() ~= 116 then return end
    print("UIInvoke", ui:GetTypeId(), call, ...)
end

local function SniffCall(ui, call, ...)
    if SpamCalls[call] then return end
    -- if ui:GetTypeId() ~= 116 then return end
    print("UICall", ui:GetTypeId(), call, ...)
end

Ext.RegisterListener("UIInvoke", SniffInvoke)
Ext.RegisterListener("UICall", SniffCall)

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true, index
        end
    end

    return false
end

local function UpdateTalents2()
    local ui = Ext.GetBuiltinUI("Public/Game/GUI/characterCreation.swf")
    local ui_char_root = Ext.GetBuiltinUI("Public/Game/GUI/characterCreation.swf"):GetRoot()
    local characterSheet = Ext.GetBuiltinUI("Public/Game/GUI/characterSheet.swf")
    local player = Ext.GetCharacter(characterSheet:GetPlayerHandle())
    --{Количество очков прокачки, Айди таланта, название таланта, имеет ли персонаж талант, возможен ли талант для прокачки}
    local talent_array2 = {1.0, "Ходячий кошмар", player.Stats.TALENT_ItemMovement, true, 2.0, "Механик", player.Stats.TALENT_ItemCreation, true, 3.0, "Гремучая змея", player.Stats.TALENT_Flanking, true, 4.0, "Оппортунист", player.Stats.TALENT_AttackOfOpportunity, true, 5.0, "Убийца", player.Stats.TALENT_Backstab, true, 6.0, "Купи-продай", player.Stats.TALENT_Trade, true, 7.0, "Форточник", player.Stats.TALENT_Lockpick, true, 8.0, "Меткий стрелок", player.Stats.TALENT_ChanceToHitRanged, true, 9.0, "Гладиатор", player.Stats.TALENT_ChanceToHitMelee, true, 10.0, "Военачальник", player.Stats.TALENT_Damage, true, 11.0, "Скороход", player.Stats.TALENT_ActionPoints, true, 12.0, "Розовые щечки", player.Stats.TALENT_ActionPoints2, true, 13.0, "Прирожденный убийца", player.Stats.TALENT_Criticals, true, 14.0, "Несокрушимость", player.Stats.TALENT_IncreasedArmor, true, 15.0, "Дальнозоркость", player.Stats.TALENT_Sight, true, 16.0, "Храброе сердце", player.Stats.TALENT_ResistFear, true, 17.0, "Неваляшка", player.Stats.TALENT_ResistKnockdown, true, 18.0, "Громоотвод", player.Stats.TALENT_ResistStun, true, 19.0, "Митридат", player.Stats.TALENT_ResistPoison, true, 20.0, "Среброуст", player.Stats.TALENT_ResistSilence, true, 21.0, "Живчик", player.Stats.TALENT_ResistDead, true, 22.0, "Грузчик", player.Stats.TALENT_Carry, true, 23.0, "Катапульта", player.Stats.TALENT_Throwing, true, 24.0, "Механик", player.Stats.TALENT_Repair, true, 25.0, "Умник", player.Stats.TALENT_ExpGain, true, 26.0, "Находчивость", player.Stats.TALENT_ExtraStatPoints, true, 27.0, "Мастер на все руки", player.Stats.TALENT_ExtraSkillPoints, true, 28.0, "Моя прелесть", player.Stats.TALENT_Durability, true, 29.0, "Шестое чувство", player.Stats.TALENT_Awareness, true, 30.0, "Воплощение здоровья", player.Stats.TALENT_Vitality, true, 31.0, "Пироман", player.Stats.TALENT_FireSpells, true, 32.0, "Человек дождя", player.Stats.TALENT_WaterSpells, true, 33.0, "Ураган", player.Stats.TALENT_AirSpells, true, 34.0, "Геомантия", player.Stats.TALENT_EarthSpells, true, 35.0, "Очаровашка", player.Stats.TALENT_Charm, true, 36.0, "Устрашитель", player.Stats.TALENT_Intimidate, true, 37.0, "Оратор", player.Stats.TALENT_Reason, true, 38.0, "Избранник фортуны", player.Stats.TALENT_Luck, true, 39.0, "Вожак стаи", player.Stats.TALENT_Initiative, true, 40.0, "Знание моды", player.Stats.TALENT_InventoryAccess, true, 41.0, "Кошачья поступь", player.Stats.TALENT_AvoidDetection, true, 42.0, "Друг животных", player.Stats.TALENT_AnimalEmpathy, true, 43.0, "Мастер побега", player.Stats.TALENT_Escapist, true, 44.0, "Неваляшка", player.Stats.TALENT_StandYourGround, true, 45.0, "Партизан", player.Stats.TALENT_SurpriseAttack, true, 46.0, "Легкий шаг", player.Stats.TALENT_LightStep, true, 47.0, "Ранняя пташка", player.Stats.TALENT_ResurrectToFullHealth, true, 48.0, "Ученый", player.Stats.TALENT_Scientist, true, 49.0, "Стеклянная пушка", player.Stats.TALENT_Raistlin, true, 50.0, "Всезнайка", player.Stats.TALENT_MrKnowItAll, true, 51.0, "Собранность", player.Stats.TALENT_WhatARush, true, 52.0, "Дальнобойность", player.Stats.TALENT_FaroutDude, true, 53.0, "Пиявка", player.Stats.TALENT_Leech, true, 54.0, "Единство со стихиями", player.Stats.TALENT_ElementalAffinity, true, 55.0, "Гурман", player.Stats.TALENT_FiveStarRestaurant, true, 56.0, "Грубиян", player.Stats.TALENT_Bully, true, 57.0, "Проводник стихий", player.Stats.TALENT_ElementalRanger, true, 58.0, "Громоотвод", player.Stats.TALENT_LightningRod, true, 59.0, "Политик", player.Stats.TALENT_Politician, true, 60.0, "Бывалый турист", player.Stats.TALENT_WeatherProof, true, 61.0, "Волк-одиночка", player.Stats.TALENT_LoneWolf, true, 62.0, "Нежить", player.Stats.TALENT_Zombie, true, 63.0, "Демон", player.Stats.TALENT_Demon, true, 64.0, "Ледяной король", player.Stats.TALENT_IceKing, true, 65.0, "Храбрец", player.Stats.TALENT_Courageous, true, 66.0, "Неумолкаемый", player.Stats.TALENT_GoldenMage, true, 67.0, "\"Само пройдет\"", player.Stats.TALENT_WalkItOff, true, 68.0, "Шустрый вор", player.Stats.TALENT_FolkDancer, true, 69.0, "Анаконда", player.Stats.TALENT_SpillNoBlood, true, 70.0, "Вонючка", player.Stats.TALENT_Stench, true, 71.0, "Kickstarter", player.Stats.TALENT_Kickstarter, true, 72.0, "Толстокожий", player.Stats.TALENT_WarriorLoreNaturalArmor, true, 73.0, "Здоровяк", player.Stats.TALENT_WarriorLoreNaturalHealth, true, 74.0, "Стальные нервы", player.Stats.TALENT_WarriorLoreNaturalResistance, true, 75.0, "Собиратель стрел", player.Stats.TALENT_RangerLoreArrowRecover, true, 76.0, "Неуловимый", player.Stats.TALENT_RangerLoreEvasionBonus, true, 77.0, "Быстрая рука", player.Stats.TALENT_RangerLoreRangedAPBonus, true, 78.0, "Любитель ножей", player.Stats.TALENT_RogueLoreDaggerAPBonus, true, 79.0, "Коварная рука", player.Stats.TALENT_RogueLoreDaggerBackStab, true, 80.0, "Быстрые ноги", player.Stats.TALENT_RogueLoreMovementBonus, true, 81.0, "Упрямый", player.Stats.TALENT_RogueLoreHoldResistance, true, 82.0, "Изворотливость", player.Stats.TALENT_NoAttackOfOpportunity, true, 83.0, "Рогатка", player.Stats.TALENT_WarriorLoreGrenadeRange, true, 84.0, "Абсолютная меткость", player.Stats.TALENT_RogueLoreGrenadePrecision, true, 85.0, "Маг", player.Stats.TALENT_WandCharge, true, 86.0, "Мастер уклонения", player.Stats.TALENT_DualWieldingDodging, true, 87.0, "Одаренность", player.Stats.TALENT_Human_Inventive, true, 88.0, "Бережливость", player.Stats.TALENT_Human_Civil, true, 89.0, "Древнее знание", player.Stats.TALENT_Elf_Lore, true, 90.0, "Трупоед", player.Stats.TALENT_Elf_CorpseEating, true, 91.0, "Надежность", player.Stats.TALENT_Dwarf_Sturdy, true, 92.0, "Гномья хитрость", player.Stats.TALENT_Dwarf_Sneaking, true, 93.0, "Утонченность", player.Stats.TALENT_Lizard_Resistance, true, 94.0, "Волшебная песня", player.Stats.TALENT_Lizard_Persuasion, true, 95.0, "Горячая голова", player.Stats.TALENT_Perfectionist, true, 96.0, "Палач", player.Stats.TALENT_Executioner, true, 97.0, "Первозданная магия", player.Stats.TALENT_ViolentMagic, true, 98.0, "Пешка", player.Stats.TALENT_QuickStep, true, 103.0, "Мнемоника", player.Stats.TALENT_Memory, true, 106.0, "Повелитель зверей", player.Stats.TALENT_BeastMaster, true, 107.0, "Живой доспех", player.Stats.TALENT_LivingArmor, true, 108.0, "Садист", player.Stats.TALENT_Torturer, true, 109.0, "Амбидекстр", player.Stats.TALENT_Ambidextrous, true, 110.0, "Нестабильность", player.Stats.TALENT_Unstable, true, 111.0, "Возрождение с доп. здоровьем", player.Stats.TALENT_ResurrectExtraHealth, true, 112.0, "Натуральный проводник", player.Stats.TALENT_NaturalConductor, true, 114.0, "PainDrinker", player.Stats.TALENT_PainDrinker, true, 115.0, "DeathfogResistant", player.Stats.TALENT_DeathfogResistant, true, 116.0, "Sourcerer", player.Stats.TALENT_Sourcerer, true, 117.0, "Rager", player.Stats.TALENT_Rager, true, 118.0, "Элементалист", player.Stats.TALENT_Elementalist, true, 119.0, "Садист", player.Stats.TALENT_Sadist, true, 120.0, "Потасовка", player.Stats.TALENT_Haymaker, true, 121.0, "Гладиатор", player.Stats.TALENT_Gladiator, true, 122.0, "Неукротимый", player.Stats.TALENT_Indomitable, true, 123.0, "WildMag", player.Stats.TALENT_WildMag, true, 124.0, "Паникер", player.Stats.TALENT_Jitterbug, true, 125.0, "Ловец душ", player.Stats.TALENT_Soulcatcher, true, 126.0, "Искусный вор", player.Stats.TALENT_MasterThief, true, 127.0, "Алчный сосуд", player.Stats.TALENT_GreedyVessel, true, 128.0, "Круги магии", player.Stats.TALENT_MagicCycles, true}   
    local tal_con = 0
    local tal_con_con = 0
    local talent_has = false
    local talent_state = 0
    local array_length = #talent_array2
    local counter = 0
    local talent_id = 0
    local hashashas = true
    local indexhas = 0
    local addedTalents = false

    while tal_con < array_length do
        talent_id = talent_array2[tal_con + 1]
        talent_name = talent_array2[tal_con + 2]
        talent_has = talent_array2[tal_con + 3]
        talent_hass = talent_array2[tal_con + 4]

        -- -- --Смена статуса прокачки таланта в зависимости от того есть ли он у персонажа
        -- if talent_has == true then
        --     talent_state = 0
        -- end

        if tostring(player.DisplayName) == "Красный Принц" then
            if talent_id == 93 or talent_id == 94 then
                print(talent_name)
                goto skip_to_next
            end

            indexhas = 0
            while indexhas < 10 do
                ui:SetValue("racialTalentArray", 93.0, indexhas)
                ui:SetValue("racialTalentArray", "Утонченность", indexhas + 1)
                ui:SetValue("racialTalentArray", 94.0, indexhas + 2)
                ui:SetValue("racialTalentArray", "Волшебная песня", indexhas + 3)
                indexhas = indexhas + 4
            end
        end
        
        -- ui:Invoke("addTalent", talent_name, talent_id, talent_state)
        ui:SetValue("talentArray", talent_id, tal_con_con + 1)
        ui:SetValue("talentArray", talent_name, tal_con_con + 2)
        ui:SetValue("talentArray", talent_has, tal_con_con + 3)
        ui:SetValue("talentArray", talent_hass, tal_con_con + 4)

        tal_con_con = tal_con_con + 4
        ::skip_to_next::
        tal_con = tal_con + 4
    end

        -- tal_con = 0
        -- while tal_con < array_length do
        --     talent_name = talent_array[tal_con + 1]
        --     talent_id = talent_array[tal_con + 2]
        --     talent_has = talent_array[tal_con + 3]

        --     --Если у персонажа есть это талант
        --     if talent_has == true then
        --         --Присваиваем ему статус прокаченного таланта и удаляем его из списка отключаемых талантов
        --         talent_state = 0
        --         hashashas, indexhas = has_value(disabledTalents, talent_id)
        --         if hashashas then
        --             disabledTalents[indexhas] = nil
        --         end
        --     else
        --         tal_con_con = 0
        --         while tal_con_con <= 128 do
        --             --Когда находится нужный талант из списка талантов персонажа в добавленном списке
        --             if ui_char_root.stats_mc.talentHolder_mc.list.content_array[tal_con_con].id == talent_id - 1 then
        --                 --Если у персонажа есть очки прокачки талантов
        --                 if tonumber(ui_char_root.stats_mc.pointTexts[3].htmlText) > 0 then
        --                     print("UpdateTalents2", "Есть поинты прокачки", tal_con_con)
        --                     --Если возле таланта стоит кнопка прокачки (плюс)
        --                     if ui_char_root.stats_mc.talentHolder_mc.list.content_array[tal_con_con].plus_mc.visible == true then
        --                         --Ставим таланту статус возможного к прокачке
        --                         talent_name = "<font color=\"#403625\">" .. talent_name .. "</font>"
        --                         talent_state = 2

        --                         --Удаляем талант из списка невозможных к прокачке
        --                         hashashas, indexhas = has_value(disabledTalents, talent_id)
        --                         if hashashas then
        --                             disabledTalents[indexhas] = nil
        --                         end

        --                         break
        --                     --Если кнопка прокачки таланта (плюс) не отоброжается возле таланта
        --                     elseif ui_char_root.stats_mc.talentHolder_mc.list.content_array[tal_con_con].plus_mc.visible == false then
        --                         --Ставим таланту статус невозможного к прокачке
        --                         talent_name = "<font color=\"#C80030\">" .. talent_name .. "</font>"
        --                         talent_state = 3
        --                         --Добавляет талант в список невозможных к прокачке
        --                         disabledTalents_length = #disabledTalents
        --                         hashashas, indexhas = has_value(disabledTalents, talent_id)
        --                         if hashashas == false then
        --                             disabledTalents[disabledTalents_length + 1] = talent_id
        --                         end

        --                         break
        --                     end

        --                 --Если у персонажа нет поинтов прокачки таланта
        --                 else
        --                     --Если текущий талант есть в списке невозможных талантов для прокачки, тогда присваиваю ему статус невозможного
        --                     hashashas, indexhas = has_value(disabledTalents, talent_id)
        --                     if hashashas then
        --                         talent_name = "<font color=\"#C80030\">" .. talent_name .. "</font>"
        --                         talent_state = 3

        --                     --Если текущего таланта нет в списке невозможных талантов, тогда присваиваю ему статус возможного к прокачке
        --                     else
        --                         talent_name = "<font color=\"#403625\">" .. talent_name .. "</font>"
        --                         talent_state = 2
        --                     end
        --                     break
        --                 end
        --                 tal_con_con = tal_con_con + 1
        --             else
        --                 tal_con_con = tal_con_con + 1
        --             end
        --         end
        --     end
            
        --     -- ui:Invoke("addTalent", talent_name, talent_id, talent_state)
        --     ui:SetValue("talent_array", talent_name, tal_con)
        --     ui:SetValue("talent_array", talent_id, tal_con + 1)
        --     ui:SetValue("talent_array", talent_state, tal_con + 2)
        --     tal_con = tal_con + 3
        -- end
end

local function UpdateTalents()
    local ui = Ext.GetBuiltinUI("Public/Game/GUI/characterSheet.swf")
    local ui_char_root = Ext.GetBuiltinUI("Public/Game/GUI/characterSheet.swf"):GetRoot()
    local ui_root = Ext.GetBuiltinUI("Public/Game/GUI/playerInfo.swf"):GetRoot() 
    local player = Ext.GetCharacter(ui:GetPlayerHandle())
    local talent_array = {"Ходячий кошмар", 1.0, player.Stats.TALENT_ItemMovement, "Механик", 2.0, player.Stats.TALENT_ItemCreation,"Гремучая змея", 3.0, player.Stats.TALENT_Flanking, "Оппортунист", 4.0, player.Stats.TALENT_AttackOfOpportunity, "Убийца",5.0,player.Stats.TALENT_Backstab,"Купи-продай",6.0,player.Stats.TALENT_Trade,"Форточник",7.0,player.Stats.TALENT_Lockpick,"Меткий стрелок",8.0,player.Stats.TALENT_ChanceToHitRanged,"Гладиатор",9.0,player.Stats.TALENT_ChanceToHitMelee,"Военачальник",10.0,player.Stats.TALENT_Damage,"Скороход",11.0,player.Stats.TALENT_ActionPoints,"Розовые щечки",12.0,player.Stats.TALENT_ActionPoints2,"Прирожденный убийца",13.0,player.Stats.TALENT_Criticals,"Несокрушимость",14.0,player.Stats.TALENT_IncreasedArmor,"Дальнозоркость",15.0,player.Stats.TALENT_Sight,"Храброе сердце",16.0,player.Stats.TALENT_ResistFear,"Неваляшка",17.0,player.Stats.TALENT_ResistKnockdown,"Громоотвод",18.0,player.Stats.TALENT_ResistStun,"Митридат",19.0,player.Stats.TALENT_ResistPoison,"Среброуст",20.0,player.Stats.TALENT_ResistSilence,"Живчик",21,player.Stats.TALENT_ResistDead, "Грузчик", 22, player.Stats.TALENT_Carry, "Катапульта", 23, player.Stats.TALENT_Throwing, "Механик", 24, player.Stats.TALENT_Repair, "Умник", 25, player.Stats.TALENT_ExpGain, "Находчивость", 26, player.Stats.TALENT_ExtraStatPoints, "Мастер на все руки", 27, player.Stats.TALENT_ExtraSkillPoints, "Моя прелесть", 28,player.Stats.TALENT_Durability, "Шестое чувство", 29,player.Stats.TALENT_Awareness, "Воплощение здоровья", 30,player.Stats.TALENT_Vitality, "Пироман", 31,player.Stats.TALENT_FireSpells, "Человек дождя", 32, player.Stats.TALENT_WaterSpells, "Ураган", 33, player.Stats.TALENT_AirSpells, "Геомантия", 34, player.Stats.TALENT_EarthSpells, "Очаровашка", 35, player.Stats.TALENT_Charm, "Устрашитель", 36, player.Stats.TALENT_Intimidate, "Оратор", 37, player.Stats.TALENT_Reason, "Избранник фортуны", 38, player.Stats.TALENT_Luck, "Вожак стаи", 39, player.Stats.TALENT_Initiative, "Знание моды", 40, player.Stats.TALENT_InventoryAccess, "Кошачья поступь", 41, player.Stats.TALENT_AvoidDetection, "Друг животных", 42, player.Stats.TALENT_AnimalEmpathy, "Мастер побега", 43, player.Stats.TALENT_Escapist, "Неваляшка", 44, player.Stats.TALENT_StandYourGround, "Партизан", 45, player.Stats.TALENT_SurpriseAttack, "Легкий шаг", 46, player.Stats.TALENT_LightStep, "Ранняя пташка", 47, player.Stats.TALENT_ResurrectToFullHealth, "Ученый", 48, player.Stats.TALENT_Scientist, "Стеклянная пушка", 49, player.Stats.TALENT_Raistlin, "Всезнайка", 50, player.Stats.TALENT_MrKnowItAll, "Собранность", 51, player.Stats.TALENT_WhatARush, "Дальнобойность", 52, player.Stats.TALENT_FaroutDude, "Пиявка", 53, player.Stats.TALENT_Leech, "Единство со стихиями", 54, player.Stats.TALENT_ElementalAffinity, "Гурман", 55, player.Stats.TALENT_FiveStarRestaurant, "Грубиян", 56, player.Stats.TALENT_Bully, "Проводник стихий", 57, player.Stats.TALENT_ElementalRanger, "Громоотвод", 58, player.Stats.TALENT_LightningRod, "Политик", 59, player.Stats.TALENT_Politician, "Бывалый турист", 60, player.Stats.TALENT_WeatherProof, "Волк-одиночка", 61, player.Stats.TALENT_LoneWolf, "Нежить", 62, player.Stats.TALENT_Zombie, "Демон", 63, player.Stats.TALENT_Demon, "Ледяной король", 64, player.Stats.TALENT_IceKing, "Храбрец", 65, player.Stats.TALENT_Courageous, "Неумолкаемый", 66, player.Stats.TALENT_GoldenMage, "\"Само пройдет\"", 67, player.Stats.TALENT_WalkItOff, "Шустрый вор", 68, player.Stats.TALENT_FolkDancer, "Анаконда", 69, player.Stats.TALENT_SpillNoBlood, "Вонючка", 70, player.Stats.TALENT_Stench, "Kickstarter", 71, player.Stats.TALENT_Kickstarter, "Толстокожий", 72, player.Stats.TALENT_WarriorLoreNaturalArmor, "Здоровяк", 73, player.Stats.TALENT_WarriorLoreNaturalHealth, "Стальные нервы", 74, player.Stats.TALENT_WarriorLoreNaturalResistance, "Собиратель стрел", 75, player.Stats.TALENT_RangerLoreArrowRecover, "Неуловимый", 76, player.Stats.TALENT_RangerLoreEvasionBonus, "Быстрая рука", 77, player.Stats.TALENT_RangerLoreRangedAPBonus, "Любитель ножей", 78, player.Stats.TALENT_RogueLoreDaggerAPBonus, "Коварная рука", 79, player.Stats.TALENT_RogueLoreDaggerBackStab, "Быстрые ноги", 80.0, player.Stats.TALENT_RogueLoreMovementBonus, "Упрямый", 81.0, player.Stats.TALENT_RogueLoreHoldResistance, "Изворотливость", 82.0, player.Stats.TALENT_NoAttackOfOpportunity, "Рогатка", 83, player.Stats.TALENT_WarriorLoreGrenadeRange, "Абсолютная меткость", 84, player.Stats.TALENT_RogueLoreGrenadePrecision, "Маг", 85, player.Stats.TALENT_WandCharge, "Мастер уклонения", 86, player.Stats.TALENT_DualWieldingDodging, "Одаренность", 87, player.Stats.TALENT_Human_Inventive, "Бережливость", 88, player.Stats.TALENT_Human_Civil, "Древнее знание", 89, player.Stats.TALENT_Elf_Lore, "Трупоед", 90, player.Stats.TALENT_Elf_CorpseEating, "Надежность", 91, player.Stats.TALENT_Dwarf_Sturdy, "Гномья хитрость", 92, player.Stats.TALENT_Dwarf_Sneaking, "Утонченность", 93, player.Stats.TALENT_Lizard_Resistance, "Волшебная песня", 94, player.Stats.TALENT_Lizard_Persuasion, "Горячая голова", 95, player.Stats.TALENT_Perfectionist, "Палач", 96, player.Stats.TALENT_Executioner, "Первозданная магия", 97, player.Stats.TALENT_ViolentMagic, "Пешка", 98, player.Stats.TALENT_QuickStep, "Поцелуй паука", 99, player.Stats.TALENT_Quest_SpidersKiss_Str, "Поцелуй паука", 100, player.Stats.TALENT_Quest_SpidersKiss_Int, "Поцелуй паука", 101, player.Stats.TALENT_Quest_SpidersKiss_Per, "Поцелуй паука", 102, player.Stats.TALENT_Quest_SpidersKiss_Null, "Мнемоника", 103, player.Stats.TALENT_Memory,"Секреты торговли", 104, player.Stats.TALENT_Quest_TradeSecrets, "Благословение лесов", 105, player.Stats.TALENT_Quest_GhostTree, "Повелитель зверей", 106, player.Stats.TALENT_BeastMaster, "Живой доспех", 107, player.Stats.TALENT_LivingArmor, "Садист", 108, player.Stats.TALENT_Torturer, "Амбидекстр", 109, player.Stats.TALENT_Ambidextrous, "Нестабильность", 110, player.Stats.TALENT_Unstable, "Возрождение с доп. здоровьем", 111, player.Stats.TALENT_ResurrectExtraHealth, "Натуральный проводник", 112, player.Stats.TALENT_NaturalConductor, "Глубокие корни", 113, player.Stats.TALENT_Quest_Rooted, "PainDrinker", 114, player.Stats.TALENT_PainDrinker, "DeathfogResistant", 115, player.Stats.TALENT_DeathfogResistant, "Sourcerer", 116, player.Stats.TALENT_Sourcerer, "Rager", 117, player.Stats.TALENT_Rager, "Элементалист", 118, player.Stats.TALENT_Elementalist, "Садист", 119, player.Stats.TALENT_Sadist, "Потасовка", 120, player.Stats.TALENT_Haymaker, "Гладиатор", 121, player.Stats.TALENT_Gladiator, "Неукротимый", 122, player.Stats.TALENT_Indomitable, "WildMag", 123, player.Stats.TALENT_WildMag, "Паникер", 124, player.Stats.TALENT_Jitterbug, "Ловец душ", 125, player.Stats.TALENT_Soulcatcher, "Искусный вор", 126, player.Stats.TALENT_MasterThief, "Алчный сосуд", 127, player.Stats.TALENT_GreedyVessel, "Круги магии", 128, player.Stats.TALENT_MagicCycles}
    local notAcceptebleTalents = {"Нежить", 62, player.Stats.TALENT_Zombie, "Одаренность", 87, player.Stats.TALENT_Human_Inventive, "Бережливость", 88, player.Stats.TALENT_Human_Civil, "Древнее знание", 89, player.Stats.TALENT_Elf_Lore, "Трупоед", 90, player.Stats.TALENT_Elf_CorpseEating, "Надежность", 91, player.Stats.TALENT_Dwarf_Sturdy, "Гномья хитрость", 92, player.Stats.TALENT_Dwarf_Sneaking, "Утонченность", 93, player.Stats.TALENT_Lizard_Resistance, "Волшебная песня", 94, player.Stats.TALENT_Lizard_Persuasion, "Поцелуй паука", 99, player.Stats.TALENT_Quest_SpidersKiss_Str, "Поцелуй паука", 100, player.Stats.TALENT_Quest_SpidersKiss_Int, "Поцелуй паука", 101, player.Stats.TALENT_Quest_SpidersKiss_Per, "Поцелуй паука", 102, player.Stats.TALENT_Quest_SpidersKiss_Null, "Секреты торговли", 104, player.Stats.TALENT_Quest_TradeSecrets, "Благословение лесов", 105, player.Stats.TALENT_Quest_GhostTree, "Глубокие корни", 113, player.Stats.TALENT_Quest_Rooted}
    local tal_con = 0
    local tal_con_con = 0
    local talent_has = false
    local talent_state = 0
    local array_length = #talent_array
    local disabledTalents_length = 0
    local talent_id = 0
    local hashashas = true
    local indexhas = 0
    local addedTalents = false
    local prevTalentPoints = 0
    local notAccepteble_bool = false
    local notAccepteble_index = 0
    local originTalentName = ""

    disabledTalents = {}

    while tal_con < array_length do
        talent_name = talent_array[tal_con + 1]
        talent_id = talent_array[tal_con + 2]
        talent_has = talent_array[tal_con + 3]

        -- --Смена статуса прокачки таланта в зависимости от того есть ли он у персонажа
        if talent_has == true then
            talent_state = 0
        end
        
        -- ui:Invoke("addTalent", talent_name, talent_id, talent_state)
        ui:SetValue("talent_array", talent_name, tal_con)
        ui:SetValue("talent_array", talent_id, tal_con + 1)
        ui:SetValue("talent_array", talent_state, tal_con + 2)
        tal_con = tal_con + 3
    end

    tal_con = 0
    while tal_con < array_length do
        talent_name = talent_array[tal_con + 1]
        talent_id = talent_array[tal_con + 2]
        talent_has = talent_array[tal_con + 3]

        originTalentName = talent_name

        --Если у персонажа есть это талант
        if talent_has == true then
            --Присваиваем ему статус прокаченного таланта и удаляем его из списка отключаемых талантов
            talent_state = 0
            hashashas, indexhas = has_value(disabledTalents, talent_id)
            if hashashas then
                disabledTalents[indexhas] = nil
            end
        else
            tal_con_con = 0
            while tal_con_con <= 128 do
                --Когда находится нужный талант из списка талантов персонажа в добавленном списке
                if ui_char_root.stats_mc.talentHolder_mc.list.content_array[tal_con_con].id == talent_id - 1 then
                    --Если у персонажа есть очки прокачки талантов
                    if tonumber(ui_char_root.stats_mc.pointTexts[3].htmlText) > 0 then
                        --Если возле таланта стоит кнопка прокачки (плюс)
                        if ui_char_root.stats_mc.talentHolder_mc.list.content_array[tal_con_con].plus_mc.visible == true then
                            --Ставим таланту статус возможного к прокачке
                            talent_name = "<font color=\"#403625\">" .. talent_name .. "</font>"
                            talent_state = 2

                            --Удаляем талант из списка невозможных к прокачке
                            hashashas, indexhas = has_value(disabledTalents, talent_id)
                            if hashashas then
                                disabledTalents[indexhas] = nil
                            end
                            break
                        --Если кнопка прокачки таланта (плюс) не отоброжается возле таланта
                        elseif ui_char_root.stats_mc.talentHolder_mc.list.content_array[tal_con_con].plus_mc.visible == false then
                            --Ставим таланту статус невозможного к прокачке
                            talent_name = "<font color=\"#C80030\">" .. talent_name .. "</font>"
                            talent_state = 3
                            --Добавляет талант в список невозможных к прокачке
                            disabledTalents_length = #disabledTalents
                            hashashas, indexhas = has_value(disabledTalents, talent_id)
                            if hashashas == false then
                                disabledTalents[disabledTalents_length + 1] = talent_id
                            end

                            break
                        end

                    --Если у персонажа нет поинтов прокачки таланта
                    else
                        --Если текущий талант есть в списке невозможных талантов для прокачки, тогда присваиваю ему статус невозможного
                        hashashas, indexhas = has_value(disabledTalents, talent_id)
                        if hashashas then
                            talent_name = "<font color=\"#C80030\">" .. talent_name .. "</font>"
                            talent_state = 3

                        --Если текущего таланта нет в списке невозможных талантов, тогда присваиваю ему статус возможного к прокачке
                        else
                            talent_name = "<font color=\"#403625\">" .. talent_name .. "</font>"
                            talent_state = 2
                        end
                        break
                    end
                    tal_con_con = tal_con_con + 1
                else
                    tal_con_con = tal_con_con + 1
                end
            end

            notAccepteble_bool, notAccepteble_index = has_value(notAcceptebleTalents, talent_id)
            if notAccepteble_bool then
                talent_name = "<font color=\"#02708B\">" .. originTalentName .. "</font>"
                talent_state = 4
            end
        end
        
        -- ui:Invoke("addTalent", talent_name, talent_id, talent_state)
        ui:SetValue("talent_array", talent_name, tal_con)
        ui:SetValue("talent_array", talent_id, tal_con + 1)
        ui:SetValue("talent_array", talent_state, tal_con + 2)
        tal_con = tal_con + 3
    end
end

local function OnCharacterSelected(call)
    local ui = Ext.GetBuiltinUI("Public/Game/GUI/characterSheet.swf")
    local uii = Ext.GetBuiltinUI("Public/Game/GUI/characterSheet.swf"):GetRoot()

    local debil = ""
    debil = uii.stats_mc.tabTitle_txt.htmlText
    
    uii.stats_mc.ClickTab(3)
    uii.stats_mc.ClickTab(3)

    if debil == "БОЕВЫЕ УМЕНИЯ" then
        uii.stats_mc.ClickTab(1)
    elseif debil == "МИРНЫЕ УМЕНИЯ" then
        uii.stats_mc.ClickTab(2)
    elseif debil == "КАЧЕСТВА" then
        uii.stats_mc.ClickTab(0)
        print("КАЧЕСТВА")
    elseif debil == "ТЕГИ" then
        uii.stats_mc.ClickTab(4)
        print("ТЕГИ")
    elseif debil == "ТАЛАНТЫ" then
        uii.stats_mc.ClickTab(3)
        print("ТАЛАНТЫ")
    end
end

local function test()
    local ui_root = Ext.GetBuiltinUI("Public/Game/GUI/playerInfo.swf"):GetRoot() 
    local player1 = ui_root.player_array[0].characterHandle
    local player2 = ui_root.player_array[1].characterHandle
    local player3 = ui_root.player_array[2].characterHandle
    local infoArray = {4.0, player1, 1.0, 5.0, player1, 12829378.0, 6.0, player1, 1.0, 7.0, player1, 5221857.0, 4.0, player2, 1.0, 5.0, player2, 12829378.0, 6.0, player2, 1.0, 7.0, player2, 5221857.0, 12.0, player2, false, 0.0, true, 4.0, 4.0, player3, 1.0, 5.0, player3, 12829378.0, 6.0, player3, 1.0, 7.0, player3, 5221857.0, 12.0, player3, false, 0.0, true, 10.0}   
    local tal_con = 0
    local tal_con_con = 0
    local talent_has = false
    local talent_state = 0
    local array_length = #infoArray
    local talent_id = 0
    local hashashas = true
    local indexhas = 0
    local addedTalents = false
end

Ext.RegisterUINameInvokeListener("updateArraySystem", UpdateTalents)
Ext.RegisterUINameInvokeListener("updateArraySystem", UpdateTalents, "After")
Ext.RegisterUINameInvokeListener("selectCharacter", OnCharacterSelected)

Ext.RegisterUINameInvokeListener("updateTalents", UpdateTalents2)

--Добавить очко таланта
--Сработал updateArraySystem
--После этого провести операции с талантами
--Убрать очко таланта
--Сработал updateArraySystem
--Провести операции с талантами при имеющемся списке отключенных талантов
