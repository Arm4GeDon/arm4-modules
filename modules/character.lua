local json = require 'mods.modules.dkjson'

function readJson(path)
    local file = io.open(path..".json", "r")
    local contents = file:read("*all")
    file:close()

    local data = json.decode(contents)
    return data
end

data = {}

return {
    data = data,
    create = function(tag, character, x, y, over, playable)
        data[tag] = readJson('mods/characters/'..character)
        local charData = data[tag]

        makeAnimatedLuaSprite(tag, charData.image, x, y)
        for i, v in pairs(charData.animations) do
            if v.indices ~= {} then
                addAnimationByPrefix(tag, v.anim, v.name, v.fps, v.loop)
            else
                strIndices = ''
                for j, b in pairs(v.indices) do
                    if strIndices == '' then
                        strIndices = b
                    else
                        strIndices = strIndices..', '..b
                    end
                end
                if not v.loop then
                    addAnimationByIndices(tag, v.anim, v.name, strIndices, v.loop)
                else
                    addAnimationByIndicesLoop(tag, v.anim, v.name, strIndices, v.loop)
                end
            end
            addOffset(tag, v.anim, v.offsets[1], v.offsets[2])
        end
        setProperty(tag..'.antialiasing', not charData.no_antialiasing)
        if playable then
            setProperty(tag..'.flipX', true)
            setProperty(tag..'.flipX', not data[tag].flip_x)
        else
            setProperty(tag..'.flipX', data[tag].flip_x)
        end
        scaleObject(tag, charData.scale, charData.scale)
        data[tag].noteType = tag
        data[tag].tag = tag
        data[tag].bopRate = 2
        data[tag].holdTimer = 0
        over = (over == 'bf' and 'bfGroup' or over)
        over = (over == 'dad' and 'dadGroup' or over)
        over = (over == 'gf' and 'gfGroup' or over)
        setObjectOrder(tag, getObjectOrder(over)+1)
    end,
    add = function(tag)
        if data[tag] then
            addLuaSprite(tag)
            setProperty(tag..'.offset.x', 0); setProperty(tag..'.offset.y', 0)
            playAnim(tag, 'idle', true)
        end
    end,
    dance = function(tag, curBeat)
        if data[tag] then
            if curBeat % data[tag].bopRate == 0 then
                if data[tag].holdTimer <= 0 then
                    playAnim(tag, 'idle', true)
                end
            end
        end
    end,
    noteHit = function(tag, noteData, noteType)
        if noteType == data[tag].noteType then
            playAnim(tag, getProperty('singAnimations')[noteData+1], true)
            data[tag].holdTimer = data[tag].sing_duration/25
        end
    end,
    updateTimer = function(tag, elapsed)
        if data[tag] then
            if data[tag].holdTimer > 0 then
                data[tag].holdTimer = data[tag].holdTimer - elapsed
            end
        end
    end,
}
