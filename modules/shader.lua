
local shaders = {}

return {
    init = function(name)
        initLuaShader(name)
    end,
    create = function(tag, shaderName)
        local tempName = 'shaderTemp-'..tag
        makeLuaSprite(tempName)
        makeGraphic(tempName, screenWidth, screenHeight)
        setSpriteShader(tempName, shaderName)
    end,
    load = function(cam, tag)
        if not shaders[cam] then
            shaders[cam] = {}
        end
        shaders[cam][(#shaders[cam]+1)] = tag
        --debugPrint(shaders)
        local shaderString = ''
        for i, v in pairs(shaders[cam]) do
            shaderString = (shaderString == '' and '' or shaderString ..', ') .. [[new ShaderFilter(game.getLuaObject("]]..'shaderTemp-'..v..[[").shader)]]
        end

        addHaxeLibrary("ShaderFilter", "openfl.filters")
        runHaxeCode([[
			// trace(ShaderFilter);
			game.]]..cam..[[.setFilters([]]..shaderString..[[]);
		]])
    end,
    remove = function(cam, tag)
        for i, v in pairs(shaders[cam]) do
            if v == tag then
                table.remove( shaders[cam], i )
            end
        end
        if luaSpriteExists(tag) then
            removeLuaSprite(tag)
        else
            tag = 'shaderTemp-'..tag
            if luaSpriteExists(tag) then
                removeLuaSprite(tag)
            end
        end

        local shaderString = ''
        for i, v in pairs(shaders[cam]) do
            shaderString = (shaderString == '' and '' or shaderString ..', ') .. [[new ShaderFilter(game.getLuaObject("]]..'shaderTemp-'..v..[[").shader)]]
        end

        addHaxeLibrary("ShaderFilter", "openfl.filters")
        runHaxeCode([[
			// trace(ShaderFilter);
			game.]]..cam..[[.setFilters([]]..shaderString..[[]);
		]])
    end,
    setFloat = function(obj, prop, value)
        if luaSpriteExists(obj) then
            setShaderFloat(obj, prop, value)
        else
            obj = 'shaderTemp-'..obj
            if luaSpriteExists(obj) then
                setShaderFloat(obj, prop, value)
            end
        end
    end,
    setBool = function(obj, prop, value)
        if luaSpriteExists(obj) then
            setShaderBool(obj, prop, value)
        else
            obj = 'shaderTemp-'..obj
            if luaSpriteExists(obj) then
                setShaderBool(obj, prop, value)
            end
        end
    end,
    setInt = function(obj, prop, value)
        if luaSpriteExists(obj) then
            setShaderInt(obj, prop, value)
        else
            obj = 'shaderTemp-'..obj
            if luaSpriteExists(obj) then
                setShaderInt(obj, prop, value)
            end
        end
    end
}