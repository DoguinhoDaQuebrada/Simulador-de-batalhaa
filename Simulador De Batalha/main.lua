local utils = require("utils")
local player = require("player.player")
local playerActions = require("player.actions")
local colossus = require("colossus.colossus")
local colossusActions = require("colossus.actions")


utils.enableUtf8()


utils.printHeader()


local boss = colossus
local bossActions = colossusActions


utils.printCreature(boss)


playerActions.build()
bossActions.build()


while true do


    print()
    print(string.format("Qual será a próxima ação de %s?", player.name))
    local validPlayerActions = playerActions.getValidActions(player, boss)
    for i, action in pairs(validPlayerActions) do
        print(string.format("%d. %s", i, action.description))
    end
    local chosenIndex = utils.ask()
    local chosenAction = validPlayerActions[chosenIndex]
    local isActionValid = chosenAction ~= nil


    if isActionValid then
        chosenAction.execute(player, boss)
    else
        print(string.format("Sua escolha é inválida. %s perdeu a vez.", player.name))
    end


    if boss.health <= 0 then
        break
    end


    print()
    local validBossActions = bossActions.getValidActions(player, boss)
    local bossAction = validBossActions[math.random(#validBossActions)]
    bossAction.execute(player, boss)

    if player.health <= 0 then
        break
    end
end


if player.health <= 0 then
    print()
    print("---------------------------------------------------------------------")
    print()
    print("😭")
    print(string.format("%s não foi capaz de vencer %s.", player.name, boss.name))
    print("Quem sabe na próxima vez...")
    print()
elseif boss.health <= 0 then
    print()
    print("---------------------------------------------------------------------")
    print()
    print("🥳")
    print(string.format("%s prevaleceu e venceu %s.", player.name, boss.name))
    print("Parabéns!!!")
    print()
end