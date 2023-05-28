
function call(funcName, args)
    callScript('mods/scripts/neocam', funcName, args)
end

return {
    set = function(property, value)
        setGlobalFromScript('mods/scripts/neocam', property, value)
    end,
    --[[
    get = function(property)
        return getGlobalFromScript('mods/scripts/neocam', property)
    end,
    ]]

    set_target = function(tag, x, y)
        call('set_target', {tag, x, y})
    end,
    focus = function(tag, duration, ease, lock)
        call('focus', {tag, duration, ease, lock})
    end,
    snap_target = function(tag)
        call('snap_target', {tag})
    end,
    bump = function(camera, amount)
        call('bump', {camera, amount})
    end,
    zoom = function(camera, amount, duration, ease)
        call('zoom', {camera, amount, duration, ease})
    end,
    snap_zoom = function(camera, amount)
        call('snap_zoom', {camera, amount})
    end
}