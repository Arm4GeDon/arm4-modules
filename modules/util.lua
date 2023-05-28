--[[
    LOTS OF FUCTIONS THAT YOU COULD NEED!!!

    SOME OF THEM ARE PRETTY USELESS BUT I HOPE 
    YOU CAN FIND A GOOD USE ON THEM!!!
]]

function rgbToHex(array)
  return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end
return {
    firstToUpper = function(str)
        return (str:gsub("^%l", string.upper))
    end,

    containsSubstring = function(str, substr)
        return string.find(str, substr) ~= nil
    end,

    padString = function(str, length, char)
        local padding = length - #str
        if padding > 0 then
          local repeatCount = math.floor(padding / #char)
          local remainder = padding % #char
          str = str .. char:rep(repeatCount) .. char:sub(1, remainder)
        end
        return str
    end,

    capitalizeWords = function(str)
        local words = {}
        for word in str:gmatch("%w+") do
            words[#words + 1] = word:sub(1,1):upper() .. word:sub(2)
        end
        return table.concat(words, " ")
    end,

    reverseString = function(str)
        local reversed = ""
        for i = #str, 1, -1 do
          reversed = reversed .. str:sub(i, i)
        end
        return reversed
    end,

    replaceLetter = function(str, from, to)
        return str.gsub(str, from, to)
    end,

    setWindowTitle = function(str)
        setPropertyFromClass('lime.app.Application','current.window.title', str)
    end,

    makeWindow = function(title, msg)
        addHaxeLibrary("Application", "lime.app")
        runHaxeCode([[
            Application.current.window.alert("]]..msg..[[", "]]..title..[[");
        ]])
        addHaxeLibrary('Application', 'lime.app')
        runHaxeCode("Application.current.window.focus();")
    end,

    makeNotification = function(title, desc)
        os.execute([[ powershell -Command "& {$ErrorActionPreference = 'Stop';$title = ]] ..  [[']] .. desc .. [[']] .. [[;[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null;$template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText01);$toastXml = [xml] $template.GetXml();$toastXml.GetElementsByTagName('text').AppendChild($toastXml.CreateTextNode($title)) > $null;$xml = New-Object Windows.Data.Xml.Dom.XmlDocument;$xml.LoadXml($toastXml.OuterXml);$toast = [Windows.UI.Notifications.ToastNotification]::new($xml);$toast.Tag = 'Test1';$toast.Group = 'Test2';$toast.ExpirationTime = [DateTimeOffset]::Now.AddSeconds(5);$notifier = [Windows.UI.Notifications.ToastNotificationManager]:]].. [[:CreateToastNotifier(']] .. title  .. [[');]].. [[$notifier.Show($toast);}"]] )
        addHaxeLibrary('Application', 'lime.app')
        runHaxeCode("Application.current.window.focus();")
    end,

    opponentNoteSkin = function(path, strumPath)

        local texture = path
        local strumTex = strumPath

        if checkFileExists('images/'..path..'.png', false) and checkFileExists('images/'..path..'.xml', false) then
            for i = 0, 3 do setPropertyFromGroup('opponentStrums', i, 'texture', strumTex) end
            for i = 0, getProperty('unspawnNotes.length') - 1 do
                if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
                    if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' then
                        setPropertyFromGroup('unspawnNotes', i, 'texture', texture)
                    end
                end
            end
        end
    end,

    playerNoteSkin = function(path, strumPath)

        local texture = path
        local strumTex = strumPath

        if checkFileExists('images/'..path..'.png', false) and checkFileExists('images/'..path..'.xml', false) then
          if checkFileExists('images/'..strumPath..'.png', false) and checkFileExists('images/'..strumPath..'.xml', false) then
            for i = 0, 3 do setPropertyFromGroup('playerStrums', i, 'texture', strumTex) end
          end
            for i = 0, getProperty('unspawnNotes.length') - 1 do
                if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
                    if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' then
                        setPropertyFromGroup('unspawnNotes', i, 'texture', texture)
                    end
                end
            end
        end
    end,

    rgbToHex = function(array)
      return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
    end,

    hexToRgb = function(hex_string)
        local hex = hex_string:gsub("#", "") -- remove the '#' character if present
        local r, g, b = hex:sub(1, 2), hex:sub(3, 4), hex:sub(5, 6)
        r, g, b = tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
        return string.format("%d,%d,%d", r, g, b)
    end,

    getIconColor = function(chr)
        local chr = chr or "boyfriend"
        return rgbToHex(getProperty(chr .. ".healthColorArray"))
    end,

    uniqueElements = function(t)
        local result = {}
        local seen = {}
        for i = 1, #t do
          if not seen[t[i]] then
            table.insert(result, t[i])
            seen[t[i]] = true
          end
        end
        return result
    end,

    replaceVowels = function(str, replaceChar)
        local result = ""
        local vowels = {["a"] = true, ["e"] = true, ["i"] = true, ["o"] = true, ["u"] = true}
        for i = 1, #str do
          local char = str:sub(i, i)
          if vowels[char:lower()] then
            result = result .. replaceChar
          else
            result = result .. char
          end
        end
        return result
    end,

    getMedian = function(t)
        local n = #t
        table.sort(t)
        if n % 2 == 0 then
          return (t[n/2] + t[n/2+1])/2
        else
          return t[(n+1)/2]
        end
    end,

    lerp = function(a, b, ratio)
        return a + ratio * (b - a);
    end,

    distance = function(x1, y1, x2, y2)
        return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
    end,

    midpoint = function(a, b)
        return (a + b) / 2
    end,

    randomString = function(length)
        local charset = {}
        for i = 48, 57 do table.insert(charset, string.char(i)) end -- digits
        for i = 65, 90 do table.insert(charset, string.char(i)) end -- uppercase letters
        for i = 97, 122 do table.insert(charset, string.char(i)) end -- lowercase letters
        
        math.randomseed(os.time())
        local result = {}
        for i = 1, length do
          local randomIndex = math.random(1, #charset)
          table.insert(result, charset[randomIndex])
        end
        
        return table.concat(result)
    end,

    getRandomElement = function(table)
        local index = math.random(1, #table)
        return table[index]
    end,

    intersect = function(a, b)
        local result = {}
        for i = 1, #a do
          for j = 1, #b do
            if a[i] == b[j] then
              table.insert(result, a[i])
              break
            end
          end
        end
        return result
    end,

    mode = function(arr)
        local counts = {}
        for i = 1, #arr do
          local value = arr[i]
          if counts[value] == nil then
            counts[value] = 1
          else
            counts[value] = counts[value] + 1
          end
        end
        
        local max_count = 0
        local mode_value = nil
        for value, count in pairs(counts) do
          if count > max_count then
            max_count = count
            mode_value = value
          end
        end
        
        return mode_value
    end,

    shuffleString = function(s)
        local chars = {}
        for c in s:gmatch"." do
            table.insert(chars, c)
        end
        for i = #chars, 2, -1 do
            local j = math.random(i)
            chars[i], chars[j] = chars[j], chars[i]
        end
        return table.concat(chars)
    end,

    freezeFor = function(seconds)
        local start = os.clock()
        while os.clock() - start < seconds do end
    end,

    remapToRange = function(value, old_min, old_max, new_min, new_max)
        local old_range = old_max - old_min
        local new_range = new_max - new_min
        local normalized_value = (value - old_min) / old_range
        return new_min + (normalized_value * new_range)
    end,

    countCharacters = function(str)
        local charCount = {}
        for i = 1, #str do
          local char = string.sub(str, i, i)
          if charCount[char] then
            charCount[char] = charCount[char] + 1
          else
            charCount[char] = 1
          end
        end
        return charCount
    end,
      
    removePath = function(path)
      local filename = string.match(path, "[^/]+$")
      return filename
    end,

    removeExtension = function(filename)
      local name = string.gsub(filename, "%..*$", "")
      return name
    end,

    setVar = function(varName, value)
      runHaxeCode([[
        setVar(']]..varName..[[');
      ]])
      setProperty(varName, value)
    end,
    
    mouseOverlaps = function(object_name)
      return runHaxeCode("game.modchartSprites.get('"..object_name.."').pixelsOverlapPoint(FlxG.mouse.getPositionInCameraView(game.modchartSprites.get('"..object_name.."').cameras[0]), 0xff, game.modchartSprites.get('"..object_name.."').cameras[0]);")
    end,

    setXY = function(tag, x, y)
      setProperty(tag..'.x', x)
      setProperty(tag..'.y', y)
    end,

    getXY = function(tag)
      return {x = getProperty(tag..'.x'), y = getProperty(tag..'.y')}
    end,

    getMidInt = function(num1, num2)
      return (num1 + num2) / 2
    end,

    saveScreenshot = function(path, x, y, width, height)
      addHaxeLibrary("Application", "lime.app")
      addHaxeLibrary("Rectangle", "lime.math")
      addHaxeLibrary("File", "sys.io")
      return runHaxeCode([[
          var img = Application.current.window.readPixels(new Rectangle(]]..(x or 0)..[[, ]]..(y or 0)..[[, ]]..(width or screenWidth)..[[, ]]..(height or screenHeight)..[[));
          File.saveBytes("]]..path..[[", img.encode());
          return true;
      ]])
    end,

    makeHaxeCam = function(camName)
      addHaxeLibrary("FlxCamera", "flixel")
      runHaxeCode(
          camName..[[ = new FlxCamera();
          ]]..camName..[[.bgColor = 0x00000000;
          FlxG.cameras.add(]]..camName..[[,false);
      ]])
    end,

    makeLuaAlphabet = function(tag, text, x, y, bold)
      runHaxeCode([[
        if (game.modchartSprites.exists(']]..tag..[['))
        {
          game.modchartSprites.get(']]..tag..[[').destroy();
        }
      
        textThingy = new Alphabet(0, 0, ']]..text..[[', ]]..tostring(bold)..[[);
        textThingy.cameras = [game.camHUD];
        game.add(textThingy);
        game.modchartSprites.set(']]..tag..[[', textThingy);
      
        textThingy.x += ]]..tostring(x)..[[;
        textThingy.y += ]]..tostring(y)..[[;
      
        textThingy.members.x += ]]..tostring(x)..[[;
        textThingy.members.y += ]]..tostring(y)..[[;
      ]])
      setScrollFactor(tag, 1, 1)
    end
    

}
