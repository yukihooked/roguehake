-- Made by YUKINO (@ifeq on Discord) and Zyu (@eyekeem on Discord), releasing this opensource for anyone to use after 3 years
-- This cheat was made to be a legit cheat, and undetectable for banning
-- I don't know if MacSploit supports, or if Rogue Lineage updated their structure after 3 years
-- If anyone wants to maintain it, it's probably the best legit cheat for Rogue Lineage

if game.PlaceId == 3541987450 or game.PlaceId == 5208655184 then
    local start = os.clock()
    do
        makefolder("roguehake")
        makefolder("roguehake\\configs")
        for i = 1, 3 do
            if not isfile("roguehake\\configs\\slot"..tostring(i)..".sex") then
                writefile("roguehake\\configs\\slot"..tostring(i)..".sex", "")
            end
        end
    end
    
    -- Services
    local cas = game:GetService("ContextActionService")
    local vim = game:GetService("VirtualInputManager")
    local rps = game:GetService("ReplicatedStorage")
    local uis = game:GetService("UserInputService")
    local cs = game:GetService("CollectionService")
    local tps = game:GetService("TeleportService")
    local sui = game:GetService("StarterGui")
    local rs = game:GetService("RunService")
    local lit = game:GetService("Lighting")
    local plrs = game:GetService("Players")
    local deb = game:GetService("Debris")
    local ws = game:GetService("Workspace")
    local cg = game:GetService("CoreGui")
    
    -- Local
    local plr = plrs.LocalPlayer
    local mouse = plr:GetMouse()
    
    local flagged_chats = {'clipped','banned'}
    local hidden_folder = Instance.new("Folder", game.CoreGui)
    local area_markers = ws:WaitForChild("AreaMarkers")
    local area_data = require(rps:WaitForChild("Info"):WaitForChild("AreaData"))
    local live_folder = ws:WaitForChild("Live")
    local headers = {["content-type"] = "application/json"}
    
    local last_area_restore = nil
    local ingredient_folder = nil
    local active_observe = nil
    local old_hastag = nil
    local old_find_first_child = nil
    local old_destroy = nil
    local hooked_connections = {}
    
    -- Global Tables
    local game_client = {}
    local library = {}
    local utility = {}
    local shared = {
        drawing_containers = {
            menu = {},
            notification = {},
            esp = {},
        },
        connections = {},
        hidden_connections = {},
        pointers = {},
        theme = {
            inline = Color3.fromRGB(3, 3, 3),
            dark = Color3.fromRGB(24, 24, 24),
            text = Color3.fromRGB(155, 155, 155),
            section = Color3.fromRGB(60, 60, 60),
            accent = Color3.fromRGB(255, 0, 0), -- 155, 39, 222
        },
        accents = {},
        moveKeys = {
            ["Movement"] = {
                ["Up"] = "Up",
                ["Down"] = "Down"
            },
            ["Action"] = {
                ["Left"] = "Left",
                ["Right"] = "Right"
            }
        },
        allowedKeyCodes = {"Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M","One","Two","Three","Four","Five","Six","Seveen","Eight","Nine","0","Insert","Tab","Home","End","LeftAlt","LeftControl","LeftShift","RightAlt","RightControl","RightShift","CapsLock","Return","Up","Down","Left","Right"},
        allowedInputTypes = {"MouseButton1","MouseButton2","MouseButton3"},
        shortenedInputs = {
            -- Control Keys
            ["LeftControl"] = 'left control',
            ["RightControl"] = 'right control',
            ["LeftShift"] = 'left shift',
            ["RightShift"] = 'right shift',
    
            -- Numberbar
            ["Backquote"] = "grave",
            ["Tilde"] = "~",
            ["At"] = "@",
            ["Hash"] = "#",
            ["Dollar"] = "$",
            ["Percent"] = "%",
            ["Caret"] = "^",
            ["Ampersand"] = "&",
            ["Asterisk"] = "*",
            ["LeftParenthesis"] = "(",
            ["RightParenthesis"] = ")",
    
            ["Underscore"] = '_',
            ["Minus"] = '-',
            ["Plus"] = '+',
            ["Period"] = '.',
            ["Slash"] = '/',
            ["BackSlash"] = '\\',
            ["Question"] = '?',
    
            -- Super
            ["PageUp"] = "pgup",
            ["PageDown"] = "pgdwn",
    
            -- Keyboard
            ["Comma"] = ",",
            ["Period"] = ".",
            ["Semicolon"] = ",",
            ["Colon"] = ":",
            ["GreaterThan"] = ">",
            ["LessThan"] = "<",
            ["LeftBracket"] = "[",
            ["RightBracket"] = "]",
            ["LeftCurly"] = "{",
            ["RightCurly"] = "}",
            ["Pipe"] = "|",
    
            -- Numberpad
            ["NumLock"] = "num lock",
            ["KeypadNine"] = "num 9",
            ["KeypadEight"] = "num 8",
            ["KeypadSeven"] = "num 7",
            ["KeypadSix"] = "num 6",
            ["KeypadFive"] = "num 5",
            ["KeypadFour"] = "num 4",
            ["KeypadThree"] = "num 3",
            ["KeypadTwo"] = "num 2",
            ["KeypadOne"] = "num 1",
            ["KeypadZero"] = "num 0",
            
            ["KeypadMultiply"] = "num multiply",
            ["KeypadDivide"] = "num divide",
            ["KeypadPeriod"] = "num decimal",
            ["KeypadPlus"] = "num plus",
            ["KeypadMinus"] = "num sub",
            ["KeypadEnter"] = "num enter",
            ["KeypadEquals"] = "num equals",
            
            -- Mouse
            ["MouseButton1"] = 'mouse1',
            ["MouseButton2"] = 'mouse2',
            ["MouseButton3"] = 'mouse3',
        },   
        colors = {Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 100, 0), Color3.fromRGB(255, 200, 0), Color3.fromRGB(210, 255, 0), Color3.fromRGB(110, 255, 0), Color3.fromRGB(10, 255, 0), Color3.fromRGB(0, 255, 90), Color3.fromRGB(0, 255, 190), Color3.fromRGB(0, 220, 255), Color3.fromRGB(0, 120, 255), Color3.fromRGB(0, 20, 255), Color3.fromRGB(80, 0, 255), Color3.fromRGB(180, 0, 255), Color3.fromRGB(255, 0, 230), Color3.fromRGB(255, 0, 130), Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 0, 0)},
        toggleKey = {Enum.KeyCode.Home, true},
        unloadKey = {Enum.KeyCode.End, true},
        saveKey = {Enum.KeyCode.PageUp, true},
        loadKey = {Enum.KeyCode.PageDown, true},
        windowActive = true,
        notifications = {},
    }
    local cheat_client = {
        config = {
            no_stun = false, -- Combat Chunk
            anti_confusion = false,
            --fish_dodge = false,
            perflora_teleport = false,
            --anti_dsage = false,
            --active_cast = false,
            armis_aimbot = false,
            inferi_aimbot = false,
            cele_aimbot = false,
    
            player_esp = true, -- Visual Chunk
            player_box = true,
            player_health = true,
            player_name = true,
            player_tags = true,
            player_intent = true,
            player_range = 2000,
            
            player_chams = false,
            player_chams_fill = false,
            player_chams_pulse = false,
            player_chams_occluded = false,
            --player_healthview = false,
            --player_hv_range = 80,
    
            trinket_esp = true,
            trinket_range = 1000,
            
            fallion_esp = false,
            npc_esp = false,
    
            ore_esp = false,
            ore_range = 1000,
            
            ingredient_esp = false,
            ingredient_range = 500,
    
            no_fog = false,
            no_blindness = false,
            no_blur = false,
            no_sanity = false,
            fullbright = false,
            change_time = false,
            clock_time = 12,
    
            anti_eat = false, -- Exploits Chunk
            no_insane = false,
            no_injury = false,
            --no_frost = false,
            --anti_vampirism = false,
            observe = true,
    
            flight = false, -- Movement Chunk
            flight_speed = 100,
    
            
            auto_bard = false, -- Automation Chunk
            --bard_stack = false,
            hide_bard = false,
            anti_afk = false,
            auto_trinket = false,
            auto_ingredient = false,
            auto_bag = false,
            bag_range = 10,
            
            
            -- World Chunk
            no_fall = false,
            no_killbrick = false,
            freecam = false,
    
             -- Misc Chunk
            double_jump = false,
            the_soul = false,
            ignore_danger = false,
            roblox_chat = false,
            unhide_players = false,
            gate_anti_backfire = false,
            
            -- Network Chunk
            lag_server = false,
    
        },
        stuns = { -- Some of these don't need to be here, but only here cause of zyu
            ManaStop = true,
            Sprinting = true,
            Action = true,
            NoJump = true,
            HeavyAttack = true,
            LightAttack = true,
            NoJump = true,
            ForwardDash = true,
            RecentDash = true,
            ClimbCoolDown = true,
            NoDam = true,
            NoDash = true,
            Casting = true,
            BeingExecuted = true,
            IsClimbing = true,
            Blocking = true,
            NoControl = true,
            MustSprint = true,
            AttackExcept = true,
            Poisoned = true,
            BarrierCD = true,
            TimeStop = true,
            TimeStopped = true,
            JumpCool = true,
            Danger = true,
        },
        mental_injuries = {
            Hallucinations = true,
            PsychoInjury = true,
            AttackExcept = true,
            Whispering = true,
            Quivering = true,
            NoControl = true,
            Careless = true,
            Maniacal = true,
            Fearful = true
        },
        physical_injuries = { -- Removed Knocked, Unconscious because if you spoof it then it will brick ur client
            BrokenLeg = false,
            BrokenRib = false,
            BrokenArm = false,
        },
        valid_projectiles = {
            'FlowerProjectile',
        },
    --[[
        class_identifiers = { -- This ESP recalculates this every frame which is annoying and probably takes away from frames
            ["[oni]"] = {"Demon Step","Axe Kick","Demon Flip"},
            ["[dsage]"] = {"Lightning Drop", "Lightning Elbow"},
            ["[illu]"] = {"Dominus","Intermissum","Globus","Claritum","Custos","Observe"},
            ["[druid]"] = {"Verdien","Fon Vitae","Perflora","Floresco","Life Sense", "Poison Soul"},
            ["[necro]"] = {"Inferi","Reditus","Ligans","Furantur","Secare","Command Monsters","Howler"} ,
            ["[spy]"] = {"The Wraith","The Shadow","The Soul","Elegant Slash", "Needle's Eye", "Interrogation", "Acrobat", "RapierTraining"},
            ["[bard]"] = {"Joyous Dance","Sweet Soothing","Song of Lethargy"},
            ["[faceless]"] = {"Shadow Fan","Ethereal Strike"},
            ["[shinobi]"] = {"Grapple","Shadowrush","Resurrection"},
            ["[slayer]"] = {"Wing Soar","Thunder Spear Crash","Dragon Awakening"},
            ["[fisher]"] = {"Harpoon","Skewer","Hunter's Focus"},
            ["[deep]"] = {"Deep Sacrifice","Leviathan Plunge","Chain Pull", "PrinceBlessing"},
            ["[sigil]"] = {"Charged Blow","Hyper Body","White Flame Charge"},
            ["[wraith]"] = {"Dark Flame Burst","Dark Eruption"},
            ["[smith]"] = {"Remote Smithing","Grindstone"},
            ["[ronin]"] = {"Calm Mind","Swallow Reversal","Triple Slash","Blade Flash","Flowing Counter"},
            ["[abyss]"] = {"Abyssal Scream","Wrathful Leap"},
        },
    --]]
        trinket_colors = {
            none = {ZIndex = 1,Color = Color3.fromRGB(40, 40, 40)}, -- Gray
            common = {ZIndex = 2,Color = Color3.fromRGB(189, 97, 29)}, -- Brown
            rare = {ZIndex = 3,Color = Color3.fromRGB(60, 150, 150)}, -- Blue
            artifact = {ZIndex = 4,Color = Color3.fromRGB(160, 100, 160)}, -- Purple
            mythic = {ZIndex = 5,Color = Color3.fromRGB(255, 0, 80)}, -- Red
        },
        custom_flight_functions = {
            ["IsKeyDown"] = uis.IsKeyDown,
            ["GetFocusedTextBox"] = uis.GetFocusedTextBox,
        },
        ingredient_identifiers = {
            ["3293218896"] = "Desert Mist",
            ["2773353559"] = "Blood Thorn",
            ["2960178471"] = "Snowscroom",
            ["2577691737"] = "Lava Flower",
            ["2618765559"] = "Glow Scroom",
            ["2575167210"] = "Moss Plant",
            ["2620905234"] = "Scroom",
            ["2766925289"] = "Trote",
            ["2766925320"] = "Polar Plant",
            ["2766802713"] = "Periashroom",
            ["2766802766"] = "Strange Tentacle",
            ["2766925228"] = "Tellbloom",
            ["2766802731"] = "Dire Flower",   
            ["2573998175"] = "Freeleaf",
            ["2766925214"] = "Crown Flower",
            ["3215371492"] = "Potato",
            ["2766925304"] = "Vile Seed",
            ["3049345298"] = "Zombie Scroom",
            ["2766802752"] = "Orcher Leaf",
            ["2766925267"] = "Creely",
            ["2889328388"] = "Ice Jar",
            ["3049928758"] = "Canewood",
            ["3049556532"] = "Acorn Light",
            ["2766925245"] = "Uncanny Tentacle",
            ["9858299042"] = "Evoflower",
        },
        blacklisted_ingredients = {
            [Vector3.new(1987.31, 177.64, 1080.92)] = true,
            [Vector3.new(2511.75, 198.985, -442.45)] = true,
            [Vector3.new(2510.07, 199.709, -518.071)] = true,
            [Vector3.new(2512.57, 199.709, -518.321)] = true,
            [Vector3.new(2511.57, 199.709, -517.071)] = true,
            [Vector3.new(2438.07, 199.709, -466.071)] = true,
            [Vector3.new(2439.07, 199.709, -467.321)] = true,
            [Vector3.new(2439.57, 199.709, -465.071)] = true,
        },
        artifacts = {"Rift Gem", "Lannis's Amulet", "Amulet of the White King", "Scroll of Fimbulvetr", "Scroll of Percutiens", "Scroll of Hoppa", "Scroll of Snarvindur", "Scroll of Manus Dei", "Spider Cloak", "Night Stone", "Philosophers Stone", "Howler Friend", "Phoenix Down", "Azael Horn","Mysterious Artifact","Fairfrozen"},
        mod_list = {
            117075515, -- // epotomy
            117092117, -- // zv_l
            218915876, -- // fun135090
            147287757, -- // sethpremecy
            1992980412, -- // DrDokieHead
            2352320475, -- // DrDSage
            1923314177, -- // DrTableHead
            1315267418, -- // Morqam
            1929945985, -- // DrDokieFace
            29656, -- // mam
            3408465701, -- // cantostyle
            272525488, -- // BurningDumpsterFire
            360905811, -- // aaRoks1234
            309149657, -- // Ra_ymond
            2758900605, -- // radicalpipelayer
            2052324682, -- // pentchann
            1220344444, -- // BlueRedGreenBRG
            1099784, -- // Doctor5
            1090716399, -- // Rindyrsil
            1754748220, -- // BlenzSr
            78504910, -- // shadoworth101
            364994040, -- // Grimiore
            96218539, -- // AvailableEnergetic
            434535742, -- // Masmixel
            19044993, -- // FrazoraX
            411595307, -- // ReEvolu
            1490237662, -- // detestdoot
            1255256325, -- // Grand_Archives
            1306981979, -- // kylenuts
            20469570, -- // vezplaw
            71662791, -- // thiari
            77196836, -- // XeroNavy
            28177302, -- // Midnight_zz
            8835343, -- // blutreefrog
            88193330, -- // sabyism
            83785067, -- // killer67564564643
            2542030529, -- // Brathruzas
            1395488551, -- // ArabicRiftgem
            274304909, -- // redemtions
            2441088083, -- // cornagedotxyz
            177436599, -- // tommychongthe2nd
            64992045, -- // bluetetraninja
            1866587913, -- // WipeMePleaseOk
            1586650903, -- // stummycapalot
            1085890137, -- // babymouthy
            143241422, -- // Noblesman
            1014826936, -- // p0vd
            1657035, -- // lucman27
            2259720861, -- // HateBored
            338544906, -- // drypth
            399618581, -- // Almedris
            73062, -- // Adonis
            167825083, -- // melonbeard
            110153256, -- // Gizen_K
            266800563, -- // Lazureos
            1216700054, -- // KittyTheYeeter
            3314396480, -- // HugeEcuadorianMan
            3292692379, -- // cookiesoda221
            1427798376, -- // Agamatsu
            3987760783, -- // lncourages
            2910073695, -- // Aekezanole
            1626803537, -- // Shadiphx
            1311587059, -- // RagoozersLeftSock
            3006409955, -- // Bismuullah
            2485656647, -- // z_rolled
            1255256325, -- // panchikorox
            2228891194, -- // Rivai_Ackermann
            2243463821, -- // Rivaihuh
            2252396915, -- // magicverdien
            1989789343, -- // tayissecy
        },
    
        connections = {},
        window_active = true,
    }
    
    -- Encrypt Module
    do
        local BitBuffer
    
        do -- Bit Buffer Module
            BitBuffer = {}
    
            local NumberToBase64; local Base64ToNumber; do
                NumberToBase64 = {}
                Base64ToNumber = {}
                local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
                for i = 1, #chars do
                    local ch = chars:sub(i, i)
                    NumberToBase64[i-1] = ch
                    Base64ToNumber[ch] = i-1
                end
            end
    
            local PowerOfTwo; do
                PowerOfTwo = {}
                for i = 0, 64 do
                    PowerOfTwo[i] = 2^i
                end
            end
    
            local BrickColorToNumber; local NumberToBrickColor; do
                BrickColorToNumber = {}
                NumberToBrickColor = {}
                for i = 0, 63 do
                    local color = BrickColor.palette(i)
                    BrickColorToNumber[color.Number] = i
                    NumberToBrickColor[i] = color
                end
            end
    
            local floor,insert = math.floor, table.insert
            function ToBase(n, b)
                n = floor(n)
                if not b or b == 10 then return tostring(n) end
                local digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                local t = {}
                local sign = ""
                if n < 0 then
                    sign = "-"
                    n = -n
                end
                repeat
                    local d = (n % b) + 1
                    n = floor(n / b)
                    insert(t, 1, digits:sub(d, d))
                until n == 0
                return sign..table.concat(t, "")
            end
    
            function BitBuffer.Create()
                local this = {}
    
                -- Tracking
                local mBitPtr = 0
                local mBitBuffer = {}
    
                function this:ResetPtr()
                    mBitPtr = 0
                end
                function this:Reset()
                    mBitBuffer = {}
                    mBitPtr = 0
                end
    
                -- Set debugging on
                local mDebug = false
                function this:SetDebug(state)
                    mDebug = state
                end
    
                -- Read / Write to a string
                function this:FromString(str)
                    this:Reset()
                    for i = 1, #str do
                        local ch = str:sub(i, i):byte()
                        for i = 1, 8 do
                            mBitPtr = mBitPtr + 1
                            mBitBuffer[mBitPtr] = ch % 2
                            ch = math.floor(ch / 2)
                        end
                    end
                    mBitPtr = 0
                end
                function this:ToString()
                    local str = ""
                    local accum = 0
                    local pow = 0
                    for i = 1, math.ceil((#mBitBuffer) / 8)*8 do
                        accum = accum + PowerOfTwo[pow]*(mBitBuffer[i] or 0)
                        pow = pow + 1
                        if pow >= 8 then
                            str = str..string.char(accum)
                            accum = 0
                            pow = 0
                        end
                    end
                    return str
                end
    
                -- Read / Write to base64
                function this:FromBase64(str)
                    this:Reset()
                    for i = 1, #str do
                        local ch = Base64ToNumber[str:sub(i, i)]
                        assert(ch, "Bad character: 0x"..ToBase(str:sub(i, i):byte(), 16))
                        for i = 1, 6 do
                            mBitPtr = mBitPtr + 1
                            mBitBuffer[mBitPtr] = ch % 2
                            ch = math.floor(ch / 2)
                        end
                        assert(ch == 0, "Character value 0x"..ToBase(Base64ToNumber[str:sub(i, i)], 16).." too large")
                    end
                    this:ResetPtr()
                end
                function this:ToBase64()
                    local strtab = {}
                    local accum = 0
                    local pow = 0
                    for i = 1, math.ceil((#mBitBuffer) / 6)*6 do
                        accum = accum + PowerOfTwo[pow]*(mBitBuffer[i] or 0)
                        pow = pow + 1
                        if pow >= 6 then
                            table.insert(strtab, NumberToBase64[accum])
                            accum = 0
                            pow = 0
                        end
                    end
                    return table.concat(strtab)
                end	
    
                -- Dump
                function this:Dump()
                    local str = ""
                    local str2 = ""
                    local accum = 0
                    local pow = 0
                    for i = 1, math.ceil((#mBitBuffer) / 8)*8 do
                        str2 = str2..(mBitBuffer[i] or 0)
                        accum = accum + PowerOfTwo[pow]*(mBitBuffer[i] or 0)
                        --print(pow..": +"..PowerOfTwo[pow].."*["..(mBitBuffer[i] or 0).."] -> "..accum)
                        pow = pow + 1
                        if pow >= 8 then
                            str2 = str2.." "
                            str = str.."0x"..ToBase(accum, 16).." "
                            accum = 0
                            pow = 0
                        end
                    end
                end
    
                -- Read / Write a bit
                local function writeBit(v)
                    mBitPtr = mBitPtr + 1
                    mBitBuffer[mBitPtr] = v
                end
                local function readBit(v)
                    mBitPtr = mBitPtr + 1
                    return mBitBuffer[mBitPtr]
                end
    
                -- Read / Write an unsigned number
                function this:WriteUnsigned(w, value, printoff)
                    assert(w, "Bad arguments to BitBuffer::WriteUnsigned (Missing BitWidth)")
                    assert(value, "Bad arguments to BitBuffer::WriteUnsigned (Missing Value)")
                    assert(value >= 0, "Negative value to BitBuffer::WriteUnsigned")
                    assert(math.floor(value) == value, "Non-integer value to BitBuffer::WriteUnsigned")
                    if mDebug and not printoff then
                        print("WriteUnsigned["..w.."]:", value)
                    end
                    -- Store LSB first
                    for i = 1, w do
                        writeBit(value % 2)
                        value = math.floor(value / 2)
                    end
                    assert(value == 0, "Value "..tostring(value).." has width greater than "..w.."bits")
                end 
                function this:ReadUnsigned(w, printoff)
                    local value = 0
                    for i = 1, w do
                        value = value + readBit() * PowerOfTwo[i-1]
                    end
                    return value
                end
    
                -- Read / Write a signed number
                function this:WriteSigned(w, value)
                    assert(w and value, "Bad arguments to BitBuffer::WriteSigned (Did you forget a bitWidth?)")
                    assert(math.floor(value) == value, "Non-integer value to BitBuffer::WriteSigned")
                    -- Write sign
                    if value < 0 then
                        writeBit(1)
                        value = -value
                    else
                        writeBit(0)
                    end
                    -- Write value
                    this:WriteUnsigned(w-1, value, true)
                end
                function this:ReadSigned(w)
                    -- Read sign
                    local sign = (-1)^readBit()
                    -- Read value
                    local value = this:ReadUnsigned(w-1, true)
                    if mDebug then
                        print("ReadSigned["..w.."]:", sign*value)
                    end
                    return sign*value
                end
    
                -- Read / Write a string. May contain embedded nulls (string.char(0))
                function this:WriteString(s)
                    -- First check if it's a 7 or 8 bit width of string
                    local bitWidth = 7
                    for i = 1, #s do
                        if s:sub(i, i):byte() > 127 then
                            bitWidth = 8
                            break
                        end
                    end
    
                    -- Write the bit width flag
                    if bitWidth == 7 then
                        this:WriteBool(false)
                    else
                        this:WriteBool(true) -- wide chars
                    end
    
                    -- Now write out the string, terminated with "0x10, 0b0"
                    -- 0x10 is encoded as "0x10, 0b1"
                    for i = 1, #s do
                        local ch = s:sub(i, i):byte()
                        if ch == 0x10 then
                            this:WriteUnsigned(bitWidth, 0x10)
                            this:WriteBool(true)
                        else
                            this:WriteUnsigned(bitWidth, ch)
                        end
                    end
    
                    -- Write terminator
                    this:WriteUnsigned(bitWidth, 0x10)
                    this:WriteBool(false)
                end
                function this:ReadString()
                    -- Get bit width
                    local bitWidth;
                    if this:ReadBool() then
                        bitWidth = 8
                    else
                        bitWidth = 7
                    end
    
                    -- Loop
                    local str = ""
                    while true do
                        local ch = this:ReadUnsigned(bitWidth)
                        if ch == 0x10 then
                            local flag = this:ReadBool()
                            if flag then
                                str = str..string.char(0x10)
                            else
                                break
                            end
                        else
                            str = str..string.char(ch)
                        end
                    end
                    return str
                end
    
                -- Read / Write a bool
                function this:WriteBool(v)
                    if v then
                        this:WriteUnsigned(1, 1, true)
                    else
                        this:WriteUnsigned(1, 0, true)
                    end
                end
                function this:ReadBool()
                    local v = (this:ReadUnsigned(1, true) == 1)
                    return v
                end
    
                -- Read / Write a floating point number with |wfrac| fraction part
                -- bits, |wexp| exponent part bits, and one sign bit.
                function this:WriteFloat(wfrac, wexp, f)
                    assert(wfrac and wexp and f)
    
                    -- Sign
                    local sign = 1
                    if f < 0 then
                        f = -f
                        sign = -1
                    end
    
                    -- Decompose
                    local mantissa, exponent = math.frexp(f)
                    if exponent == 0 and mantissa == 0 then
                        this:WriteUnsigned(wfrac + wexp + 1, 0)
                        return
                    else
                        mantissa = ((mantissa - 0.5)/0.5 * PowerOfTwo[wfrac])
                    end
    
                    -- Write sign
                    if sign == -1 then
                        this:WriteBool(true)
                    else
                        this:WriteBool(false)
                    end
    
                    -- Write mantissa
                    mantissa = math.floor(mantissa + 0.5) -- Not really correct, should round up/down based on the parity of |wexp|
                    this:WriteUnsigned(wfrac, mantissa)
    
                    -- Write exponent
                    local maxExp = PowerOfTwo[wexp-1]-1
                    if exponent > maxExp then
                        exponent = maxExp
                    end
                    if exponent < -maxExp then
                        exponent = -maxExp
                    end
                    this:WriteSigned(wexp, exponent)	
                end
                function this:ReadFloat(wfrac, wexp)
                    assert(wfrac and wexp)
    
                    -- Read sign
                    local sign = 1
                    if this:ReadBool() then
                        sign = -1
                    end
    
                    -- Read mantissa
                    local mantissa = this:ReadUnsigned(wfrac)
    
                    -- Read exponent
                    local exponent = this:ReadSigned(wexp)
                    if exponent == 0 and mantissa == 0 then
                        return 0
                    end
    
                    -- Convert mantissa
                    mantissa = mantissa / PowerOfTwo[wfrac] * 0.5 + 0.5
    
                    -- Output
                    return sign * math.ldexp(mantissa, exponent)
                end
    
                -- Read / Write single precision floating point
                function this:WriteFloat32(f)
                    this:WriteFloat(23, 8, f)
                end
                function this:ReadFloat32()
                    return this:ReadFloat(23, 8)
                end
    
                -- Read / Write double precision floating point
                function this:WriteFloat64(f)
                    this:WriteFloat(52, 11, f)
                end
                function this:ReadFloat64()
                    return this:ReadFloat(52, 11)
                end
    
                -- Read / Write a BrickColor
                function this:WriteBrickColor(b)
                    local pnum = BrickColorToNumber[b.Number]
                    if not pnum then
                        warn("Attempt to serialize non-pallete BrickColor `"..tostring(b).."` (#"..b.Number.."), using Light Stone Grey instead.")
                        pnum = BrickColorToNumber[BrickColor.new(1032).Number]
                    end
                    this:WriteUnsigned(6, pnum)
                end
                function this:ReadBrickColor()
                    return NumberToBrickColor[this:ReadUnsigned(6)]
                end
    
                -- Read / Write a rotation as a 64bit value.
                local function round(n)
                    return math.floor(n + 0.5)
                end
                function this:WriteRotation(cf)
                    local lookVector = cf.lookVector
                    local azumith = math.atan2(-lookVector.X, -lookVector.Z)
                    local ybase = (lookVector.X^2 + lookVector.Z^2)^0.5
                    local elevation = math.atan2(lookVector.Y, ybase)
                    local withoutRoll = CFrame.new(cf.p) * CFrame.Angles(0, azumith, 0) * CFrame.Angles(elevation, 0, 0)
                    local x, y, z = (withoutRoll:inverse()*cf):toEulerAnglesXYZ()
                    local roll = z
                    -- Atan2 -> in the range [-pi, pi] 
                    azumith   = round((azumith   /  math.pi   ) * (2^21-1))
                    roll      = round((roll      /  math.pi   ) * (2^20-1))
                    elevation = round((elevation / (math.pi/2)) * (2^20-1))
                    --
                    this:WriteSigned(22, azumith)
                    this:WriteSigned(21, roll)
                    this:WriteSigned(21, elevation)
                end
                function this:ReadRotation()
                    local azumith   = this:ReadSigned(22)
                    local roll      = this:ReadSigned(21)
                    local elevation = this:ReadSigned(21)
                    --
                    azumith =    math.pi    * (azumith / (2^21-1))
                    roll =       math.pi    * (roll    / (2^20-1))
                    elevation = (math.pi/2) * (elevation / (2^20-1))
                    --
                    local rot = CFrame.Angles(0, azumith, 0)
                    rot = rot * CFrame.Angles(elevation, 0, 0)
                    rot = rot * CFrame.Angles(0, 0, roll)
                    --
                    return rot
                end
    
                return this
            end
    
        end
    
        local TypeIntegerLength = 3
        local IntegerLength = 10
    
        local function TypeToId(Type)
            if Type == "Integer" then
                return 1
            elseif Type == "NegInteger" then
                return 2
            elseif Type == "Number" then
                return 3
            elseif Type == "String" then
                return 4
            elseif Type == "Boolean" then
                return 5
            elseif Type == "Table" then
                return 6
            end
            return 0
        end
    
        local function IdToType(Type)
            if Type == 1 then
                return "Integer"
            elseif Type == 2 then
                return "NegInteger"
            elseif Type == 3 then
                return "Number"
            elseif Type == 4 then
                return "String"
            elseif Type == 5 then
                return "Boolean"
            elseif Type == 6 then
                return "Table"
            end
        end
    
        local function IsInt(Number)
            local Decimal = string.find(tostring(Number),"%.")
            if Decimal then
                return false
            else
                return true
            end
        end
    
        local function log(Base,Number)
            return math.log(Number)/math.log(Base)
        end
    
        local function GetMaxBitsInt(Table)
            local Max = 0
            for Key,Value in pairs(Table) do
                if type(Value) == "number" then
                    Value = math.abs(Value)
                    if IsInt(Value) and Value > 0 then
                        local Bits = math.ceil(log(2,Value + 1))
                        if Bits > Max then Max = Bits end
                    end
                end
                
                if type(Key) == "number" then
                    Key = math.abs(Key)
                    if IsInt(Key) and Key > 0 then
                        local Bits = math.ceil(log(2,Key + 1))
                        if Bits > Max then Max = Bits end
                    end
                end
            end
            return Max*2
        end
    
        local function GetTableLength(Table)
            local Total = 0
            for _,_ in pairs(Table) do
                Total = Total + 1
            end
            return Total
        end
    
        local function GetType(Key)
            local Type = type(Key) 
            if Type == "number" then
                if IsInt(Key) then
                    if Key < 0 then
                        return "NegInteger"
                    end
                    return "Integer"
                else
                    return "Number"
                end
            else
                return Type
            end
        end
    
        local function GetAllType(Table)
            local Type
            for Key,_ in pairs(Table) do
                if not Type then 
                    Type = GetType(Key)
                end
                if type(Key) ~= Type then
                    local NewType = GetType(Key)
                    if NewType ~= Type then
                        return nil
                    end
                end
            end	
            if Type == "Number" then
                return "Number"
            elseif Type == "Integer" then
                return "Integer"
            elseif Type == "NegInteger" then
                return "NegInteger"
            else
                return "String"
            end
        end
    
        local crypt = {}
        function crypt:encode(Table,UseBase64)
            local AllType = GetAllType(Table)
            local Buffer = BitBuffer.Create()
            if UseBase64 == true then
                Buffer:WriteBool(true)
            else
                Buffer:WriteBool(false)
            end
            Buffer:WriteUnsigned(IntegerLength,GetTableLength(Table))
            
            local function WriteFloat(Number)
                if UseBase64 == true then
                    Buffer:WriteFloat64(Number)
                else
                    Buffer:WriteFloat32(Number)
                end
            end
            Buffer:WriteUnsigned(TypeIntegerLength,TypeToId(AllType))
            local MaxBits = GetMaxBitsInt(Table)
            Buffer:WriteUnsigned(IntegerLength,MaxBits)
            
            local function WriteKey(Key,AllowAllSame)
                if not (AllowAllSame == true and AllType) then
                    Buffer:WriteUnsigned(TypeIntegerLength,Key)
                elseif AllowAllSame == false then
                    Buffer:WriteUnsigned(TypeIntegerLength,Key)
                end
            end
            
            for Key,Value in pairs(Table) do
                if type(Key) == "string" then
                    WriteKey(TypeToId("String"),true)
                    Buffer:WriteString(Key)
                elseif type(Key) == "number" and IsInt(Key) then
                    if Key >= 0 then
                        WriteKey(TypeToId("Integer"),true)
                        Buffer:WriteUnsigned(MaxBits,Key)
                    else
                        WriteKey(TypeToId("NegInteger"),true)
                        Buffer:WriteSigned(MaxBits*2,Key)
                    end
                elseif type(Key) == "number" then
                    WriteKey(TypeToId("Number"),true)
                    WriteFloat(Key)
                end
                
                if type(Value) == "boolean" then
                    WriteKey(TypeToId("Boolean"))
                    Buffer:WriteBool(Value)
                elseif type(Value) == "number" then
                    if IsInt(Value) then
                        if Value < 0 then
                            WriteKey(TypeToId("NegInteger"))
                            Buffer:WriteSigned(MaxBits*2,Value)
                        else
                            WriteKey(TypeToId("Integer"))
                            Buffer:WriteUnsigned(MaxBits,Value)
                        end
                    else
                        WriteKey(TypeToId("Number"))
                        WriteFloat(Value)
                    end
                elseif type(Value) == "table" then
                    WriteKey(TypeToId("Table"))
                    Buffer:WriteString(crypt:encode(Value,UseBase64))
                elseif type(Value) == "string" then
                    WriteKey(TypeToId("String"))
                    Buffer:WriteString(tostring(Value))
                end
            end
            return Buffer:ToBase64()
        end
    
        function crypt:decode(BinaryString)
            local Buffer = BitBuffer.Create()
            Buffer:FromBase64(BinaryString)
            local Table = {}
            local UseBase64 = Buffer:ReadBool()
            local function ReadFloat()
                if UseBase64 == true then
                    return Buffer:ReadFloat64()
                else
                    return Buffer:ReadFloat32()
                end
            end
            local Length = Buffer:ReadUnsigned(IntegerLength)
            local AllType = Buffer:ReadUnsigned(TypeIntegerLength)
            local MaxBits = Buffer:ReadUnsigned(IntegerLength)
            if AllType == 0 then AllType = nil end
            
            for i = 1, Length do
                local KeyType,Key = AllType or Buffer:ReadUnsigned(TypeIntegerLength)
                
                local KeyRealType = IdToType(KeyType)
                if KeyRealType == "Integer" then
                    Key = Buffer:ReadUnsigned(MaxBits)
                elseif KeyRealType == "NegInteger" then
                    Key = Buffer:ReadSigned(MaxBits*2)
                elseif KeyRealType == "Number" then
                    Key = ReadFloat()
                elseif KeyRealType == "String" then
                    Key = Buffer:ReadString()
                end
                
                local ValueType,Value = Buffer:ReadUnsigned(TypeIntegerLength)
                local ValueRealType = IdToType(ValueType)
                if ValueRealType == "String" then
                    Value = Buffer:ReadString()
                elseif ValueRealType == "Boolean" then
                    Value = Buffer:ReadBool()
                elseif ValueRealType == "Number" then
                    Value = ReadFloat()
                elseif ValueRealType == "Integer" then
                    Value = Buffer:ReadUnsigned(MaxBits)
                elseif ValueRealType == "NegInteger" then
                    Value = Buffer:ReadSigned((MaxBits * 2))
                elseif ValueRealType == "Table" then
                    Value = crypt:decode(Buffer:ReadString())
                elseif ValueRealType == "Color3" then
                    Value = Color3.new(ReadFloat(),ReadFloat(),ReadFloat())
                elseif ValueRealType == "CFrame" then
                    Value = CFrame.new(ReadFloat(),ReadFloat(),ReadFloat()) * Buffer:ReadRotation()
                elseif ValueRealType == "BrickColor" then
                    Value = Buffer:ReadBrickColor()
                elseif ValueRealType == "UDim2" then
                    Value = UDim2.new(ReadFloat(),ReadFloat(),ReadFloat(),ReadFloat())
                elseif ValueRealType == "UDim" then
                    Value = UDim.new(ReadFloat(),ReadFloat())
                elseif ValueRealType == "Region3" then
                    Value = Region3.new(Vector3.new(ReadFloat(),ReadFloat(),ReadFloat()),Vector3.new(ReadFloat(),ReadFloat(),ReadFloat()))
                elseif ValueRealType == "Region3int16" then
                    Value = Region3int16.new(Vector3int16.new(ReadFloat(),ReadFloat(),ReadFloat()),Vector3int16.new(ReadFloat(),ReadFloat(),ReadFloat()))
                elseif ValueRealType == "Vector3" then
                    Value = Vector3.new(ReadFloat(Value.X),ReadFloat(Value.Y),ReadFloat(Value.Z))
                elseif ValueRealType == "Vector2" then
                    Value = Vector2.new(ReadFloat(Value.X),ReadFloat(Value.Y))
                elseif ValueRealType == "EnumItem" then
                    Value = Enum[Buffer:ReadString()][Buffer:ReadString()]
                elseif ValueRealType == "Enums" then
                    Value = Enum[Buffer:ReadString()]
                elseif ValueRealType == "Enum" then
                    Value = Enum
                elseif ValueRealType == "Ray" then
                    Value = Ray.new(Vector3.new(ReadFloat(),ReadFloat(),ReadFloat()),Vector3.new(ReadFloat(),ReadFloat(),ReadFloat()))
                elseif ValueRealType == "Axes" then
                    local X,Y,Z = Buffer:ReadBool(),Buffer:ReadBool(),Buffer:ReadBool()
                    Value = Axes.new(X == true and Enum.Axis.X,Y == true and Enum.Axis.Y,Z == true and Enum.Axis.Z)
                elseif ValueRealType == "Faces" then
                    local Front,Back,Left,Right,Top,Bottom = Buffer:ReadBool(),Buffer:ReadBool(),Buffer:ReadBool(),Buffer:ReadBool(),Buffer:ReadBool(),Buffer:ReadBool()
                    Value = Faces.new(Front == true and Enum.NormalId.Front,Back == true and Enum.NormalId.Back,Left == true and Enum.NormalId.Left,Right == true and Enum.NormalId.Right,Top == true and Enum.NormalId.Top,Bottom == true and Enum.NormalId.Bottom)
                elseif ValueRealType == "ColorSequence" then
                    local Points = crypt:decode(Buffer:ReadString())
                    Value = ColorSequence.new(Points[1].Value,Points[2].Value)
                elseif ValueRealType == "ColorSequenceKeypoint" then
                    Value = ColorSequenceKeypoint.new(ReadFloat(),Color3.new(ReadFloat(),ReadFloat(),ReadFloat()))
                elseif ValueRealType == "NumberRange" then
                    Value = NumberRange.new(ReadFloat(),ReadFloat())
                elseif ValueRealType == "NumberSequence" then
                    Value = NumberSequence.new(crypt:decode(Buffer:ReadString()))
                elseif ValueRealType == "NumberSequenceKeypoint" then	
                    Value = NumberSequenceKeypoint.new(ReadFloat(),ReadFloat(),ReadFloat())
                end
                Table[Key] = Value
            end
            return Table
        end
    
        shared.crypt = crypt
    end
    
    -- Utility Functions
    do
        function utility:Create(instanceType, instanceProperties, container)
            local instance = Drawing.new(instanceType)
            local parent
            --
            if instanceProperties["Parent"] or instanceProperties["parent"] then
                parent = instanceProperties["Parent"] or instanceProperties["parent"]
                --
                instanceProperties["parent"] = nil
                instanceProperties["Parent"] = nil
            end
            --
            for property, value in pairs(instanceProperties) do
                if property and value then
                    if property == "Size" or property == "Size" then
                        if instanceType == "Text" then
                            instance.Size = value
                        else
                            local xSize = (value.X.Scale * ((parent and parent.Size) or ws.CurrentCamera.ViewportSize).X) + value.X.Offset
                            local ySize = (value.Y.Scale * ((parent and parent.Size) or ws.CurrentCamera.ViewportSize).Y) + value.Y.Offset
                            --
                            instance.Size = Vector2.new(xSize, ySize)
                        end
                    elseif property == "Position" or property == "position" then
                        if instanceType == "Text" then
                            local xPosition = ((((parent and parent.Position) or Vector2.new(0, 0)).X) + (value.X.Scale * ((typeof(parent.Size) == "number" and parent.TextBounds) or parent.Size).X)) + value.X.Offset
                            local yPosition = ((((parent and parent.Position) or Vector2.new(0, 0)).Y) + (value.Y.Scale * ((typeof(parent.Size) == "number" and parent.TextBounds) or parent.Size).Y)) + value.Y.Offset
                            --
                            instance.Position = Vector2.new(xPosition, yPosition)
                        else
                            local xPosition = ((((parent and parent.Position) or Vector2.new(0, 0)).X) + value.X.Scale * ((parent and parent.Size) or ws.CurrentCamera.ViewportSize).X) + value.X.Offset
                            local yPosition = ((((parent and parent.Position) or Vector2.new(0, 0)).Y) + value.Y.Scale * ((parent and parent.Size) or ws.CurrentCamera.ViewportSize).Y) + value.Y.Offset
                            --
                            instance.Position = Vector2.new(xPosition, yPosition)
                        end
                    elseif property == "Color" or property == "color" then
                        if typeof(value) == "string" then
                            instance["Color"] = shared.theme[value]
                            --
                            if value == "accent" then
                                shared.accents[#shared.accents + 1] = instance
                            end
                        else
                            instance[property] = value
                        end
                    else
                        instance[property] = value
                    end
                end
            end
            --
            shared.drawing_containers[container][#shared.drawing_containers[container] + 1] = instance
            --
            return instance
        end
    
        function utility:Update(instance, instanceProperty, instanceValue, instanceParent)
            if instanceProperty == "Size" or instanceProperty == "Size" then
                local xSize = (instanceValue.X.Scale * ((instanceParent and instanceParent.Size) or ws.CurrentCamera.ViewportSize).X) + instanceValue.X.Offset
                local ySize = (instanceValue.Y.Scale * ((instanceParent and instanceParent.Size) or ws.CurrentCamera.ViewportSize).Y) + instanceValue.Y.Offset
                --
                instance.Size = Vector2.new(xSize, ySize)
            elseif instanceProperty == "Position" or instanceProperty == "position" then
                    local xPosition = ((((instanceParent and instanceParent.Position) or Vector2.new(0, 0)).X) + (instanceValue.X.Scale * ((typeof(instanceParent.Size) == "number" and instanceParent.TextBounds) or instanceParent.Size).X)) + instanceValue.X.Offset
                    local yPosition = ((((instanceParent and instanceParent.Position) or Vector2.new(0, 0)).Y) + (instanceValue.Y.Scale * ((typeof(instanceParent.Size) == "number" and instanceParent.TextBounds) or instanceParent.Size).Y)) + instanceValue.Y.Offset
                    --
                    instance.Position = Vector2.new(xPosition, yPosition)
            elseif instanceProperty == "Color" or instanceProperty == "color" then
                if typeof(instanceValue) == "string" then
                    instance.Color = shared.theme[instanceValue]
                    --
                    if instanceValue == "accent" then
                        shared.accents[#shared.accents + 1] = instance
                    else
                        if table.find(shared.accents, instance) then
                            table.remove(shared.accents, table.find(shared.accents, instance))
                        end
                    end
                else
                    instance.Color = instanceValue
                end
            end
        end
    
        function utility:Connection(connectionType, connectionCallback)
            local connection = connectionType:Connect(connectionCallback)
            shared.connections[#shared.connections + 1] = connection
            --
            return connection
        end
    
        function utility:RemoveConnection(connection)
            for index, con in pairs(shared.connections) do
                if con == connection then
                    shared.connections[index] = nil
                    con:Disconnect()
                end
            end
            --
            for index, con in pairs(shared.hidden_connections) do
                if con == connection then
                    shared.hidden_connections[index] = nil
                    con:Disconnect()
                end
            end
        end
    
        function utility:Lerp(instance, instanceTo, instanceTime)
            local currentTime = 0
            local currentIndex = {}
            local connection
            --
            for i,v in pairs(instanceTo) do
                currentIndex[i] = instance[i]
            end
            --
            local function lerp()
                for i,v in pairs(instanceTo) do
                    instance[i] = ((v - currentIndex[i]) * currentTime / instanceTime) + currentIndex[i]
                end
            end
            --
            connection = rs.RenderStepped:Connect(function(delta)
                if currentTime < instanceTime then
                    currentTime = currentTime + delta
                    lerp()
                else
                    connection:Disconnect()
                end
            end)
        end
    
        function utility:Unload()
            for i,v in pairs(shared.connections) do
                v:Disconnect()
            end
            --
            for i,v in pairs(shared.drawing_containers) do
                for _,k in pairs(v) do
                    k:Remove()
                end
            end
            --
            table.clear(shared.drawing_containers)
            shared.drawing_containers = nil
            shared.connections = nil
            --
            cas:UnbindAction("DisableArrowKeys")
            cas:UnbindAction("FreecamKeyboard")
            --
            table.clear(shared)
            utility = nil
            library = nil
            shared = nil
            --
            for _,ScreenGui in pairs(game:GetService("CoreGui"):GetChildren()) do
                if ScreenGui:FindFirstChild("Toggle") and ScreenGui:FindFirstChild('SaveInstance') then
                    ScreenGui.Enabled = false        
                end
            end
            --
            plr.PlayerGui:FindFirstChild("Chat").Frame.ChatBarParentFrame.Position = UDim2.new(0, 0, 0, 0)
            plr.PlayerGui:FindFirstChild("Chat").Frame.ChatChannelParentFrame.Position = UDim2.new(0, 0, 0, 0)
            plr.PlayerGui:FindFirstChild("Chat").Frame.ChatChannelParentFrame.Size = UDim2.new(0, 0, 0, 0)
            --
            if game.PlaceId ~= 3541987450 then
                for i,v in next, game.Workspace.Map:GetChildren() do
                    if v:FindFirstChild("TouchInterest") and v.Name ~= "Fire" and v.Name ~= "OrderField" and v.Name ~= "SolanBall" and v.Name ~= "SolansGate"  and v.Name ~= "BaalField" and v.Name ~= "Elevator" and v.Name ~= "MageField" and v.Name ~= "TeleportIn" and v.Name ~= "TeleportOut" then
                        v.CanTouch = true
                    end
                end
            end
            --
            for i,v in pairs(plrs:GetPlayers()) do
                if v.Character then
                    if v.Backpack:FindFirstChild('Jack') or v.Character:FindFirstChild('Jack') then
                        v:SetAttribute('Hidden',true)
                    end
                end
            end
            LPH_NO_VIRTUALIZE(function()
              if old_hastag then
                  hookfunction(cs.HasTag, old_hastag)
              end
              --
              if old_find_first_child then
                  hookfunction(game.FindFirstChild, old_find_first_child)
              end
              --
              if old_destroy then
                  hookfunction(ws.Destroy, old_destroy)
              end
            end)
            --
            if plr.Character then
                ws.CurrentCamera.CameraSubject = plr.Character
                ws.CurrentCamera.CameraType = Enum.CameraType.Custom
                active_observe = nil
            end
            --
            if plr.PlayerGui:FindFirstChild("BardGui") then
                plr.PlayerGui:FindFirstChild("BardGui").Enabled = true
            end
            --
            lit:WaitForChild("Blindness").Enabled = true
            lit:WaitForChild("Blur").Enabled = true
            --
            if cheat_client.restore_ambience then
                cheat_client:restore_ambience()
            end
            --
            hidden_folder:Destroy()
            --
            table.clear(cheat_client)
            cheat_client = nil
        end
    
        function utility:Toggle()
            shared.toggleKey[2] = not shared.toggleKey[2]
            --
            for index, drawing in pairs(shared.drawing_containers["menu"]) do
                if getmetatable(drawing).__type == "Text" then
                    utility:Lerp(drawing, {Transparency = shared.toggleKey[2] and 1 or 0}, 0.15)
                else
                    utility:Lerp(drawing, {Transparency = shared.toggleKey[2] and 1 or 0}, 0.25)
                end
            end
        end
    
        function utility:ChangeAccent(accentColor)
            shared.theme.accent = accentColor
            --
            for index, drawing in pairs(shared.accents) do
                drawing.Color = shared.theme.accent
            end
        end
    
        function utility:Object(type, properties)
            local object = Instance.new(type)
            for i,v in next, properties do
                object[i] = v
            end
            return object
        end
    
        function utility:GetCamera()
            return ws.CurrentCamera
        end
        
        function utility:LeftClick()
            local Table = {
            	[1] = 9,
            	[2] = 0 .. math.random(84857926137421,50000000000000)
            }
            plr.Character.CharacterHandler.Remotes.LeftClick:FireServer(Table)
        end
    
        function utility:ForceRejoin()
            tps:Teleport(game.PlaceId, plr, game.JobId)
        end
        
        function utility:Serverhop()
            local RAMAccount = loadstring(game:HttpGet'https://raw.githubusercontent.com/ic3w0lf22/Roblox-Account-Manager/master/RAMAccount.lua')()
            local MyAccount = RAMAccount.new(plr.Name)
            
            local function unblockAll()
            	if MyAccount then
            		local Response = syn.request({
            			Url = "http://localhost:7963//UnblockEveryone?Account="..game.Players.LocalPlayer.Name,
            			Method = "GET"
            		})
            	end
            end
            
            local function blockPlayer(Player)
            	if MyAccount then
            		local Response = syn.request({
            			Url = "http://localhost:7963/BlockUser?Account="..game:GetService("Players").LocalPlayer.Name.."&UserId="..tostring(game:GetService("Players"):GetUserIdFromNameAsync(Player.Name)),
            			Method = "GET"
            		})
            
                    if tostring(Response.Body) == [[{"success":true}]] then
                    elseif
                    tostring(Response.Body) == [[{"success":false}]] then
                        unblockAll()
                    end
            	end
            end
            
            if game:GetService("Players"):GetChildren()[2] then
                local blockTarget = game:GetService("Players"):GetChildren()[2]
                blockPlayer(blockTarget)
                task.wait(1)
                plr:Kick("\nServerhopping, blocking "..blockTarget.Name)
                task.wait()
                game:GetService("TeleportService"):Teleport(3016661674)
            else
                plr:Kick("\nServerhopping")
                task.wait()
                game:GetService("TeleportService"):Teleport(3016661674)
            end
        end
    
        function utility:SaveConfig()
            local data = {}
            for key, pointer in next, shared.pointers do
                if key == "config_slot" then -- Skip the slot
                    continue
                end
    
                data[key] = pointer:Get()
            end
    
            local encrypted_data = shared.crypt:encode(data)
            local current_slot = shared.pointers["config_slot"]:Get()
            writefile("roguehake\\configs\\"..current_slot, encrypted_data)
            if library and library.Notify then
                library:Notify("Successfully saved config to roguehake\\configs\\"..current_slot, shared.theme.accent) -- 155, 39, 222
            end
        end
    
        function utility:LoadConfig()
            local current_slot = shared.pointers["config_slot"]:Get()
            local encrypted_data = readfile("roguehake\\configs\\"..current_slot, encrypted_data)
            if encrypted_data ~= "" then
                local data = shared.crypt:decode(encrypted_data)
                for key, pointer in next, shared.pointers do
                    if key == "config_slot" then -- Skip the slot
                        continue
                    end
                    pointer:Set(data[key])
                end
                
                if library and library.Notify then
                    library:Notify("Successfully loaded config roguehake\\configs\\"..current_slot, shared.theme.accent) -- 155, 39, 222
                end
            end
        end
    
        function utility:IsHoveringFrame(frame)
            local mouse_location = uis:GetMouseLocation()
    
            local x1 = frame.AbsolutePosition.X
            local y1 = frame.AbsolutePosition.Y
            local x2 = x1 + frame.AbsoluteSize.X
            local y2 = y1 + frame.AbsoluteSize.Y
    
            return (mouse_location.X >= x1 and mouse_location.Y - 36 >= y1 and mouse_location.X <= x2 and mouse_location.Y - 36 <= y2)
        end
    
        function utility:Instance(class_name, properties)
            local object = Instance.new(class_name)
    
            for i,v in next, properties do
                object[i] = v
            end
    
            return object
        end
    end
    
    -- Library Functions
    do
        function library:Window(windowProperties)
            -- // Variables
            local window = {
                current = nil,
                currentindex = 1,
                content = {},
                pages = {}
            }
            local windowProperties = windowProperties or {}
            --
            local windowName = windowProperties.name or windowProperties.Name or "New Window"
            -- // Functions
            function window:Movement(moveAction, moveDirection)
                if moveAction == "Movement" then
                    window.content[window.currentindex]:Turn(false)
                    --
                    if window.content[moveDirection == "Down" and window.currentindex + 1 or window.currentindex - 1] then
                        window.currentindex = moveDirection == "Down" and window.currentindex + 1 or window.currentindex - 1
                    else
                        window.currentindex = moveDirection == "Down" and 1 or #window.content
                    end
                    --
                    window.content[window.currentindex]:Turn(true)
                else
                    window.content[window.currentindex]:Action(moveDirection)
                end
            end
            --
            function window:ChangeKeys(keyType, moveDirection, newKey)
                for i,v in pairs(shared.moveKeys[keyType]) do
                    if tostring(v) == tostring(moveDirection) then
                        shared.moveKeys[keyType][i] = nil
                        shared.moveKeys[keyType][newKey] = moveDirection
                    end
                end
            end
            -- // Main
            local windowFrame = utility:Create("Square", {
                Visible = true,
                Filled = true,
                Thickness = 0,
                Color = shared.theme.inline,
                Size = UDim2.new(0, 280, 0, 19),
                Position = UDim2.new(0, 50, 0, 80)
            }, "menu")
            --
            local windowInline = utility:Create("Square", {
                Parent = windowFrame,
                Visible = true,
                Filled = true,
                Thickness = 0,
                Color = shared.theme.dark,
                Size = UDim2.new(1, -2, 1, -4),
                Position = UDim2.new(0, 1, 0, 3)
            }, "menu")
            --
            local windowAccent = utility:Create("Square", {
                Parent = windowFrame,
                Visible = true,
                Filled = true,
                Thickness = 0,
                Color = "accent",
                Size = UDim2.new(1, 0, 0, 2),
                Position = UDim2.new(0, 0, 0, 0)
            }, "menu")
            --
            local windowText = utility:Create("Text", {
                Parent = windowAccent,
                Visible = true,
                Text = windowName,
                Center = true,
                Outline = true,
                Font = 2,
                Color = shared.theme.text,
                Size = 13,
                Position = UDim2.new(0.5, 0, 0, 3)
            }, "menu")
            -- // Connections
            utility:Connection(uis.InputBegan, function(Input)
                if shared.toggleKey[2] and Input.KeyCode then
                    if shared.moveKeys["Movement"][Input.KeyCode.Name] then
                        window:Movement("Movement", shared.moveKeys["Movement"][Input.KeyCode.Name])
                    elseif shared.moveKeys["Action"][Input.KeyCode.Name] then
                        window:Movement("Action", shared.moveKeys["Action"][Input.KeyCode.Name])
                    end
                end
                
                if Input.KeyCode == shared.toggleKey[1] then
                    utility:Toggle()
                elseif Input.KeyCode == shared.unloadKey[1] then
                    utility:Unload()
                elseif Input.KeyCode == shared.saveKey[1] then
                    utility:SaveConfig()
                    return
                elseif Input.KeyCode == shared.loadKey[1] then
                    utility:LoadConfig()
                end
            end)
            -- // Nested Functions
            function window:ChangeName(newName)
                windowText.Text = newName
            end
            --
            function window:Refresh()
                window.content = {}
                local contentCount = 0
                --
                for index, page in pairs(window.pages) do
                    page:Position(19 + (contentCount * 17))
                    window.content[#window.content + 1] = page
                    contentCount = contentCount + 1
                    --
                    if page.open then
                        for index, section in pairs(page.sections) do
                            section:Position(19 + (contentCount * 17))
                            contentCount = contentCount + 1
                            --
                            for index, content in pairs(section.content) do
                                content:Position(19 + (contentCount * 17))
                                if not content.noaction then
                                    window.content[#window.content + 1] = content
                                end
                                contentCount = contentCount + 1
                            end
                        end
                    end
                end
                --
                utility:Update(windowFrame, "Size", UDim2.new(0, 280, 0, 23 + (contentCount * 17)))
                utility:Update(windowInline, "Size", UDim2.new(1, -2, 1, -4), windowFrame)
            end
            --
            function window:Page(pageProperties)
                -- // Variables
                local page = {open = false, sections = {}}
                local pageProperties = pageProperties or {}
                --
                local pageName = pageProperties.name or pageProperties.Name or "New Page"
                -- // Functions
                -- // Main
                local pageText = utility:Create("Text", {
                    Parent = windowFrame,
                    Visible = true,
                    Text = "[+] "..pageName,
                    Outline = true,
                    Font = 2,
                    Color = (#window.content == 0 and shared.theme.accent or shared.theme.text),
                    Size = 13,
                    Position = UDim2.new(0, 5, 0, 19 + ((#window.content) * 17))
                }, "menu")
                -- // Nested Functions
                function page:Turn(state)
                    if state then
                        utility:Update(pageText, "Color", "accent")
                    else
                        utility:Update(pageText, "Color", "text")
                    end
                end
                --
                function page:Position(yAxis)
                    utility:Update(page.text, "Position", UDim2.new(0, 5, 0, yAxis), windowFrame)
                end
                --
                function page:Open(state, externalOpen)
                    if not externalOpen then
                        local ind = 0
                        for index, other_page in pairs(window.pages) do
                            if other_page == page then
                                ind = index
                            else
                                if other_page.open then
                                    other_page:Open(false, true)
                                end
                            end
                        end
                        --
                        window.currentindex = ind
                    end
                    --
                    page.open = state
                    pageText.Text = (page.open and "[-] " or "[+] ") .. pageName
                    --
                    for index, section in pairs(page.sections) do
                        section:Open(page.open)
                    end
                    --
                    window:Refresh()
                end
                --
                function page:Action(action)
                    if action == "Enter" then
                        page:Open(not page.open)
                    elseif action == "Right" and not page.open then
                        page:Open(true)
                    elseif action == "Left" and page.open then
                        page:Open(false)
                    end
                end
                --
                function page:Section(sectionProperties)
                    -- // Variables
                    local section = {content = {}}
                    local sectionProperties = sectionProperties or {}
                    --
                    local sectionName = sectionProperties.name or sectionProperties.Name or "New Section"
                    -- // Functions
                    -- // Main
                    local sectionText = utility:Create("Text", {
                        Visible = false,
                        Text = "["..sectionName.."]",
                        Outline = true,
                        Font = 2,
                        Color = shared.theme.section,
                        Size = 13
                    }, "menu")
                    -- // Nested Functions
                    function section:Open(state)
                        section.text.Visible = state
                        --
                        for index, content in pairs(section.content) do
                            content:Open(state)
                        end
                    end
                    --
                    function section:Position(yAxis)
                        utility:Update(section.text, "Position", UDim2.new(0, 22, 0, yAxis), windowFrame)
                    end
                    --
                    function section:Label(labelProperties)
                        -- // Variables
                        local label = {noaction = true}
                        local labelProperties = labelProperties or {}
                        --
                        local labelName = labelProperties.name or labelProperties.Name or "New Label"
                        local labelPointer = labelProperties.pointer or labelProperties.Pointer or labelProperties.flag or labelProperties.Flag or nil
                        -- // Functions
                        -- // Main
                        local labelText = utility:Create("Text", {
                            Visible = false,
                            Text = labelName,
                            Outline = true,
                            Font = 2,
                            Color = shared.theme.text,
                            Size = 13
                        }, "menu")
                        -- // Nested Functions
                        function label:Turn(state)
                            if state then
                                utility:Update(label.text, "Color", "accent")
                            else
                                utility:Update(label.text, "Color", "text")
                            end
                        end
                        --
                        function label:Position(yAxis)
                            utility:Update(label.text, "Position", UDim2.new(0, 22, 0, yAxis), windowFrame)
                        end
                        --
                        function label:Open(state)
                            label.text.Visible = state
                        end
                        --
                        function label:Action(action)
                        end
                        -- // Returning + Other
                        label.name = labelName
                        label.text = labelText
                        --
                        section.content[#section.content + 1] = label
                        --
                        if labelPointer then
                            local pointer = {}
                            --
                            function pointer:Get()
                                return label.name
                            end
                            --
                            function pointer:Set(value)
                                if typeof(value) == "string" then
                                    label.name = value
                                    label.text.Text = value
                                end
                            end
                            --
                            shared.pointers[labelPointer] = pointer
                        end
                        return label
                    end
                    --
                    function section:Button(buttonProperties)
                        -- // Variables
                        local button = {}
                        local buttonProperties = buttonProperties or {}
                        --
                        local buttonName = buttonProperties.name or buttonProperties.Name or "New Button"
                        local buttonConfirm = buttonProperties.confirm or buttonProperties.Confirm or false
                        local buttonCallback = buttonProperties.callback or buttonProperties.Callback or buttonProperties.CallBack or buttonProperties.callBack or function() end
                        -- // Functions
                        -- // Main
                        local buttonText = utility:Create("Text", {
                            Visible = false,
                            Text = buttonName,
                            Outline = true,
                            Font = 2,
                            Color = shared.theme.text,
                            Size = 13
                        }, "menu")
                        -- // Nested Functions
                        function button:Turn(state)
                            if state then
                                utility:Update(button.text, "Color", "accent")
                            else
                                utility:Update(button.text, "Color", "text")
                            end
                        end
                        --
                        function button:Position(yAxis)
                            utility:Update(button.text, "Position", UDim2.new(0, 22, 0, yAxis), windowFrame)
                        end
                        --
                        function button:Open(state)
                            button.text.Visible = state
                        end
                        --
                        function button:Action(action)
                            if buttonConfirm and button.text.Text ~= "confirm?" then
                                button.text.Text = "confirm?"
                                task.delay(3, function()
                                    if button.text.Text == "confirm?" then
                                        button.text.Text = buttonName
                                    end
                                end)
                                return
                            end
                            --
                            button.text.Text = "<"..buttonName..">"
                            --
                            buttonCallback()
                            --
                            wait(0.2)
                            button.text.Text = buttonName
                        end
                        -- // Returning + Other
                        button.name = buttonName
                        button.text = buttonText
                        --
                        section.content[#section.content + 1] = button
                        --
                        return button
                    end
                    --
                    function section:Toggle(toggleProperties)
                        local toggle = {}
                        local toggleProperties = toggleProperties or {}
                        --
                        local toggleName = toggleProperties.name or toggleProperties.Name or "New Toggle"
                        local toggleDefault = toggleProperties.default or toggleProperties.Default or toggleProperties.def or toggleProperties.Def or false
                        local togglePointer = toggleProperties.pointer or toggleProperties.Pointer or toggleProperties.flag or toggleProperties.Flag or nil
                        local toggleCallback = toggleProperties.callback or toggleProperties.Callback or toggleProperties.CallBack or toggleProperties.callBack or function() end
                        -- // Functions
                        -- // Main
                        local toggleText = utility:Create("Text", {
                            Visible = false,
                            Text = toggleName .. " -> " .. (toggleDefault and "ON" or "OFF"),
                            Outline = true,
                            Font = 2,
                            Color = shared.theme.text,
                            Size = 13
                        }, "menu")
                        -- // Nested Functions
                        function toggle:Turn(state)
                            if state then
                                utility:Update(toggle.text, "Color", "accent")
                            else
                                utility:Update(toggle.text, "Color", "text")
                            end
                        end
                        --
                        function toggle:Position(yAxis)
                            utility:Update(toggle.text, "Position", UDim2.new(0, 22, 0, yAxis), windowFrame)
                        end
                        --
                        function toggle:Open(state)
                            toggle.text.Visible = state
                        end
                        --
                        function toggle:Action(action)
                            toggle.current = not toggle.current
                            toggle.text.Text = toggle.name .. " -> " .. (toggle.current and "ON" or "OFF")
                            --
                            toggleCallback(toggle.current)
                        end
                        -- // Returning + Other
                        toggle.name = toggleName
                        toggle.text = toggleText
                        toggle.current = toggleDefault
                        --
                        section.content[#section.content + 1] = toggle
                        --
                        if togglePointer then
                            local pointer = {}
                            --
                            function pointer:Get()
                                return toggle.current
                            end
                            --
                            function pointer:Set(value)
                                toggle.current = value
                                toggle.text.Text = toggle.name .. " -> " .. (toggle.current and "ON" or "OFF")
                                --
                                toggleCallback(toggle.current)
                            end
                            --
                            shared.pointers[togglePointer] = pointer
                        end
                        --
                        return toggle
                    end
                    --
                    function section:Slider(sliderProperties)
                        local slider = {}
                        local sliderProperties = sliderProperties or {}
                        --
                        local sliderName = sliderProperties.name or sliderProperties.Name or "New Toggle"
                        local sliderDefault = sliderProperties.default or sliderProperties.Default or sliderProperties.def or sliderProperties.Def or 1
                        local sliderMax = sliderProperties.max or sliderProperties.Max or sliderProperties.maximum or sliderProperties.Maximum or 10
                        local sliderMin = sliderProperties.min or sliderProperties.Min or sliderProperties.minimum or sliderProperties.Minimum or 1
                        local sliderTick = sliderProperties.tick or sliderProperties.Tick or sliderProperties.decimals or sliderProperties.Decimals or 1
                        local sliderPointer = sliderProperties.pointer or sliderProperties.Pointer or sliderProperties.flag or sliderProperties.Flag or nil
                        local sliderCallback = sliderProperties.callback or sliderProperties.Callback or sliderProperties.CallBack or sliderProperties.callBack or function() end
                        -- // Functions
                        -- // Main
                        local sliderText = utility:Create("Text", {
                            Visible = false,
                            Text = sliderName .. " -> " .. "<" .. tostring(sliderDefault) .. "/" .. tostring(sliderMax) .. ">",
                            Outline = true,
                            Font = 2,
                            Color = shared.theme.text,
                            Size = 13
                        }, "menu")
                        -- // Nested Functions
                        function slider:Turn(state)
                            if state then
                                utility:Update(slider.text, "Color", "accent")
                            else
                                utility:Update(slider.text, "Color", "text")
                            end
                        end
                        --
                        function slider:Position(yAxis)
                            utility:Update(slider.text, "Position", UDim2.new(0, 22, 0, yAxis), windowFrame)
                        end
                        --
                        function slider:Open(state)
                            slider.text.Visible = state
                        end
                        --
                        function slider:Action(action)
                            slider.current = math.clamp(action == "Left" and (slider.current - slider.tick) or (slider.current + slider.tick), slider.min, slider.max)
                            slider.text.Text = sliderName .. " -> " .. "<" .. tostring(slider.current) .. "/" .. tostring(slider.max) .. ">"
                            --
                            sliderCallback(slider.current)
                        end
                        -- // Returning + Other
                        slider.name = sliderName
                        slider.text = sliderText
                        slider.current = sliderDefault
                        slider.max = sliderMax
                        slider.min = sliderMin
                        slider.tick = sliderTick
                        --
                        section.content[#section.content + 1] = slider
                        --
                        if sliderPointer then
                            local pointer = {}
                            --
                            function pointer:Get()
                                return slider.current
                            end
                            --
                            function pointer:Set(value)
                                slider.current = value
                                slider.text.Text = sliderName .. " -> " .. "<" .. tostring(slider.current) .. "/" .. tostring(slider.max) .. ">"
                                --
                                sliderCallback(slider.current)
                            end
                            --
                            shared.pointers[sliderPointer] = pointer
                        end
                        --
                        return slider
                    end
                    --
                    function section:List(listProperties)
                        local list = {}
                        local listProperties = listProperties or {}
                        --
                        local listName = listProperties.name or listProperties.Name or "New List"
                        local listEnter = listProperties.enter or listProperties.Enter or listProperties.comfirm or listProperties.Comfirm or false
                        local listDefault = listProperties.default or listProperties.Default or listProperties.def or listProperties.Def or 1
                        local listOptions = listProperties.options or listProperties.Options or {"Option 1", "Option 2", "Option 3"}
                        local listPointer = listProperties.pointer or listProperties.Pointer or listProperties.flag or listProperties.Flag or nil
                        local listCallback = listProperties.callback or listProperties.Callback or listProperties.CallBack or listProperties.callBack or function() end
                        -- // Functions
                        -- // Main
                        local listText = utility:Create("Text", {
                            Visible = false,
                            Text = listName .. " -> " .. tostring(listOptions[listDefault]),
                            Outline = true,
                            Font = 2,
                            Color = shared.theme.text,
                            Size = 13
                        }, "menu")
                        -- // Nested Functions
                        function list:Turn(state)
                            if state then
                                utility:Update(list.text, "Color", "accent")
                            else
                                utility:Update(list.text, "Color", "text")
                            end
                        end
                        --
                        function list:Position(yAxis)
                            utility:Update(list.text, "Position", UDim2.new(0, 22, 0, yAxis), windowFrame)
                        end
                        --
                        function list:Open(state)
                            list.text.Visible = state
                        end
                        --
                        function list:Action(action)
                            if (listEnter and action == "Enter") then
                                listCallback(list.options[list.current])
                            else
                                list.current = ((list.options[action == "Left" and list.current - 1 or list.current + 1]) and (action == "Left" and list.current - 1 or list.current + 1)) or (action == "Left" and #list.options or 1)
                                --
                                list.text.Text = listName .. " -> " .. tostring(list.options[list.current])
                                --
                                if not listEnter then
                                    listCallback(list.options[list.current])
                                end
                            end
                        end
                        -- // Returning + Other
                        if listPointer then
                            local pointer = {}
                            --
                            function pointer:Get(cfg)
                                if cfg then
                                    return list.current
                                else
                                    return list.options[list.current]
                                end
                            end
                            --
                            function pointer:Set(value)
                                if typeof(value) == "number" and list.options[value] then
                                    list.current = value
                                    --
                                    list.text.Text = listName .. " -> " .. tostring(list.options[list.current])
                                    --
                                    if not listEnter then
                                        listCallback(list.options[list.current])
                                    end
                                end
                            end
                            --
                            shared.pointers[listPointer] = pointer
                        end
                        --
                        list.name = listName
                        list.text = listText
                        list.current = listDefault
                        list.options = listOptions
                        --
                        section.content[#section.content + 1] = list
                        --
                        return list
                    end
                    --
                    function section:MultiList(multiListProperties)
                        local multiList = {}
                        local multiListProperties = multiListProperties or {}
                        --
                        local multiListName = multiListProperties.name or multiListProperties.Name or "New Toggle"
                        local multiListDefault = multiListProperties.default or multiListProperties.Default or multiListProperties.def or multiListProperties.Def or 1
                        local multiListOptions = multiListProperties.options or multiListProperties.Options or {{"Option 1", false}, {"Option 2", false}, {"Option 3", false}}
                        local multiListPointer = multiListProperties.pointer or multiListProperties.Pointer or multiListProperties.flag or multiListProperties.Flag or nil
                        local multiListCallback = multiListProperties.callback or multiListProperties.Callback or multiListProperties.CallBack or multiListProperties.callBack or function() end
                        -- // Functions
                        -- // Main
                        local multiListText = utility:Create("Text", {
                            Visible = false,
                            Text = multiListName .. " -> " .. "<" .. (multiListOptions[multiListDefault] and (tostring(multiListOptions[multiListDefault][1]) .. ":" .. ((multiListOptions[multiListDefault][2]) and "ON" or "OFF")) or "Nil") .. ">",
                            Outline = true,
                            Font = 2,
                            Color = shared.theme.text,
                            Size = 13
                        }, "menu")
                        -- // Nested Functions
                        function multiList:Turn(state)
                            if state then
                                utility:Update(multiList.text, "Color", "accent")
                            else
                                utility:Update(multiList.text, "Color", "text")
                            end
                        end
                        --
                        function multiList:Position(yAxis)
                            utility:Update(multiList.text, "Position", UDim2.new(0, 22, 0, yAxis), windowFrame)
                        end
                        --
                        function multiList:Open(state)
                            multiList.text.Visible = state
                        end
                        --
                        function multiList:Action(action)
                            if action == "Enter" then
                                multiList.options[multiList.current][2] = not multiList.options[multiList.current][2]
                                --
                                multiList.text.Text = multiList.name .. " -> " .. "<" .. tostring(multiList.options[multiList.current][1]) .. ":" .. (multiList.options[multiList.current][2] and "ON" or "OFF") .. ">"
                                --
                                multiListCallback(multiList.options)
                            else
                                multiList.current = ((multiList.options[action == "Left" and multiList.current - 1 or multiList.current + 1]) and (action == "Left" and multiList.current - 1 or multiList.current + 1)) or (action == "Left" and #multiList.options or 1)
                                --
                                multiList.text.Text = multiList.name .. " -> " .. "<" .. tostring(multiList.options[multiList.current][1]) .. ":" .. (multiList.options[multiList.current][2] and "ON" or "OFF") .. ">"
                                --
                                multiListCallback(multiList.options)
                            end
                        end
                        -- // Returning + Other
                        if multiListPointer then
                            local pointer = {}
                            --
                            function pointer:Get()
                                return list.options
                            end
                            --
                            function pointer:Set(value)
                                if value[multiList.current] then
                                    multiList.options = value
                                    --
                                    multiList.text.Text = multiList.name .. " -> " .. "<" .. tostring(multiList.options[multiList.current][1]) .. ":" .. (multiList.options[multiList.current][2] and "ON" or "OFF") .. ">"
                                    --
                                    multiListCallback(multiList.options)
                                end
                            end
                            --
                            shared.pointers[multiListPointer] = pointer
                        end
                        --
                        multiList.name = multiListName
                        multiList.text = multiListText
                        multiList.current = multiListDefault
                        multiList.options = multiListOptions
                        --
                        section.content[#section.content + 1] = multiList
                        --
                        return multiList
                    end
                    --
                    function section:PlayerList(playerListProperties)
                        local playerList = {}
                        local playerListProperties = playerListProperties or {}
                        --
                        local playerListName = playerListProperties.name or playerListProperties.Name or "New Toggle"
                        local playerListEnter = playerListProperties.enter or playerListProperties.Enter or playerListProperties.comfirm or playerListProperties.Comfirm or false
                        local playerListCallback = playerListProperties.callback or playerListProperties.Callback or playerListProperties.CallBack or playerListProperties.callBack or function() end
                        local playerListOptions = {}
                        -- // Functions
                        for index, player in pairs(plrs:GetPlayers()) do
                            if player ~= plr then
                                playerListOptions[#playerListOptions + 1] = player
                            end
                        end
                        --
                        utility:Connection(plrs.PlayerAdded, function(player)
                            if player ~= plr then
                                if not table.find(playerList.options, player) then
                                    playerList.options[#playerList.options + 1] = player
                                end
                                --
                                if #playerList.options == 1 then
                                    playerList.current = 1
                                    --
                                    playerList.text.Text = playerList.name .. " -> " .. "<" .. tostring(playerList.options[playerList.current].Name) .. ">"
                                    --
                                    if not playerListEnter then
                                        playerListCallback(tostring(playerList.options[playerList.current]))
                                    end
                                end
                            end
                        end)
                        --
                        utility:Connection(plrs.PlayerRemoving, function(player)
                            if player ~= plr then
                                local index = table.find(playerList.options, player)
                                local current = playerList.current
                                local current_plr = playerList.options[current]
                                --
                                if index then
                                    table.remove(playerList.options, index)
                                end
                                --
                                if #playerList.options == 0 then
                                    playerList.text.Text = playerList.name .. " -> " .. "<Nil>"
                                else
                                    local oldCurrent = playerList.current
                                    --
                                    if index and playerList.options[playerList.current] ~= current_plr and table.find(playerList.options, current_plr) then
                                        playerList.current = table.find(playerList.options, current_plr)
                                    end
                                    --
                                    playerList.text.Text = playerList.name .. " -> " .. "<" .. tostring(playerList.options[playerList.current].Name) .. ">"
                                    --
                                    if not playerListEnter then
                                        if oldCurrent ~= playerList.current then
                                            playerListCallback(tostring(playerList.options[playerList.current]))
                                        end
                                    end
                                end
                            end
                        end)
                        
                        -- // Main
                        local playerListText = utility:Create("Text", {
                            Visible = false,
                            Text = playerListName .. " -> " .. "<" .. (#playerListOptions >= 1 and tostring(playerListOptions[1].Name) or "Nil") .. ">",
                            Outline = true,
                            Font = 2,
                            Color = shared.theme.text,
                            Size = 13
                        }, "menu")
                        -- // Nested Functions
                        function playerList:Turn(state)
                            if state then
                                utility:Update(playerList.text, "Color", "accent")
                            else
                                utility:Update(playerList.text, "Color", "text")
                            end
                        end
                        --
                        function playerList:Position(yAxis)
                            utility:Update(playerList.text, "Position", UDim2.new(0, 22, 0, yAxis), windowFrame)
                        end
                        --
                        function playerList:Open(state)
                            playerList.text.Visible = state
                        end
                        --
                        function playerList:Action(action)
                            if (playerListEnter and action == "Enter") then
                                if #playerList.options >= 1 then
                                    playerListCallback(tostring(playerList.options[playerList.current]))
                                end
                            else
                                if #playerList.options >= 1 then
                                    local oldCurrent = playerList.current
                                    --
                                    playerList.current = ((playerList.options[action == "Left" and playerList.current - 1 or playerList.current + 1]) and (action == "Left" and playerList.current - 1 or playerList.current + 1)) or (action == "Left" and #playerList.options or 1)
                                    --
                                    playerList.text.Text = playerList.name .. " -> " .. "<" .. tostring(playerList.options[playerList.current].Name) .. ">"
                                    --
                                    if not playerListEnter then
                                        if oldCurrent ~= playerList.current then
                                            playerListCallback(tostring(playerList.options[playerList.current]))
                                        end
                                    end
                                end
                            end
                        end
                        -- // Returning + Other
                        playerList.name = playerListName
                        playerList.text = playerListText
                        playerList.current = 1
                        playerList.options = playerListOptions
                        --
                        section.content[#section.content + 1] = playerList
                        --
                        return playerList
                    end
                    --
                    function section:Keybind(keybindProperties)
                        -- // Variables
                        local keybind = {}
                        local keybindProperties = keybindProperties or {}
                        --
                        local keybindName = keybindProperties.name or keybindProperties.Name or "New Keybind"
                        local keybindDefault = keybindProperties.default or keybindProperties.Default or keybindProperties.def or keybindProperties.Def or Enum.KeyCode.B
                        local keybindInputs = keybindProperties.inputs or keybindProperties.Inputs or true
                        local keybindPointer = keybindProperties.pointer or keybindProperties.Pointer or keybindProperties.flag or keybindProperties.Flag or nil
                        local keybindCallback = keybindProperties.callback or keybindProperties.Callback or keybindProperties.CallBack or keybindProperties.callBack or function() end
                        -- // Functions
                        function keybind:Shorten(string)
                            for i,v in pairs(shared.shortenedInputs) do
                                string = string.gsub(string, i, v)
                            end
                            --
                            return string
                        end
                        --
                        function keybind:Change(input)
                            input = input or "..."
                            local inputTable = {}
                            --
                            if input.EnumType then
                                if input.EnumType == Enum.KeyCode or input.EnumType == Enum.UserInputType then
                                    if table.find(shared.allowedKeyCodes, input.Name) or table.find(shared.allowedInputTypes, input.Name) then
                                        inputTable = {input.EnumType == Enum.KeyCode and "KeyCode" or "UserInputType", input.Name}
                                        --
                                        keybind.current = inputTable
                                        keybind.text.Text = keybindName .. " -> " .. "<" .. (#keybind.current > 0 and keybind:Shorten(keybind.current[2]) or "...") .. ">"
                                        --
                                        return true
                                    end
                                end
                            end
                            --
                            return false
                        end
                        -- // Main
                        local keybindText = utility:Create("Text", {
                            Visible = false,
                            Text = keybindName .. " -> " .. "<" .. "..." .. ">",
                            Outline = true,
                            Font = 2,
                            Color = shared.theme.text,
                            Size = 13
                        }, "menu")
                        -- // Nested Functions
                        function keybind:Turn(state)
                            if state then
                                utility:Update(keybind.text, "Color", "accent")
                            else
                                utility:Update(keybind.text, "Color", "text")
                            end
                        end
                        --
                        function keybind:Position(yAxis)
                            utility:Update(keybind.text, "Position", UDim2.new(0, 22, 0, yAxis), windowFrame)
                        end
                        --
                        function keybind:Open(state)
                            keybind.text.Visible = state
                        end
                        --
                        function keybind:Action(action)
                            if not keybind.selecting then
                                keybind.text.Text = keybindName .. " -> " .. "<" .. "..." .. ">"
                                --
                                keybind.selecting = true
                                --
                                local connection
                                connection = utility:Connection(uis.InputBegan, function(Input)
                                    if connection then
                                        local inputProcessed = keybind:Change(Input.KeyCode.Name ~= "Unknown" and Input.KeyCode or (keybind.inputs and Input.UserInputType))
                                        --
                                        if inputProcessed then
                                            wait()
                                            keybind.selecting = false
                                            --
                                            utility:RemoveConnection(connection)
                                            keybindCallback(Enum[keybind.current[1]][keybind.current[2]])
                                        end
                                    end
                                end)
                            end
                        end
                        -- // Returning + Other
                        if keybindPointer then
                            local pointer = {}
                            --
                            function pointer:Get(cfg)
                                if cfg then
                                    return keybind.current
                                else
                                    return Enum[keybind.current[1]][keybind.current[2]]
                                end
                            end
                            --
                            function pointer:Set(value)
                                if value[1] and value[2] then
                                    local inputProcessed = keybind:Change(Enum[value[1]][value[2]])
                                    --
                                    if inputProcessed then
                                        keybindCallback(Enum[keybind.current[1]][keybind.current[2]])
                                    end
                                end
                            end
                            --
                            shared.pointers[keybindPointer] = pointer
                        end
                        --
                        keybind.name = keybindName
                        keybind.text = keybindText
                        keybind.current = {}
                        keybind.inputs = keybindInputs
                        keybind.selecting = false
                        --
                        keybind:Change(keybindDefault)
                        --
                        section.content[#section.content + 1] = keybind
                        --
                        return keybind
                    end
                    --
                    function section:ColorList(colorListProperties)
                        local colorList = {}
                        local colorListProperties = colorListProperties or {}
                        --
                        local colorListName = colorListProperties.name or colorListProperties.Name or "New Toggle"
                        local colorListDefault = colorListProperties.default or colorListProperties.Default or colorListProperties.def or colorListProperties.Def or 1
                        local colorListPointer = colorListProperties.pointer or colorListProperties.Pointer or colorListProperties.flag or colorListProperties.Flag or nil
                        local colorListCallback = colorListProperties.callback or colorListProperties.Callback or colorListProperties.CallBack or colorListProperties.callBack or function() end
                        -- // Functions
                        -- // Main
                        --
                        local colorListText = utility:Create("Text", {
                            Visible = false,
                            Text = colorListName .. " -> " .. "<   >",
                            Outline = true,
                            Font = 2,
                            Color = shared.theme.text,
                            Size = 13
                        }, "menu")
                        --
                        local colorListColor = utility:Create("Square", {
                            Visible = false,
                            Filled = true,
                            Thickness = 0,
                            Color = shared.colors[colorListDefault],
                            Size = UDim2.new(0, 17, 0, 9),
                        }, "menu")
                        -- // Nested Functions
                        function colorList:Turn(state)
                            if state then
                                utility:Update(colorList.text, "Color", "accent")
                            else
                                utility:Update(colorList.text, "Color", "text")
                            end
                        end
                        --
                        function colorList:Position(yAxis)
                            utility:Update(colorList.text, "Position", UDim2.new(0, 22, 0, yAxis), windowFrame)
                            utility:Update(colorList.color, "Position", UDim2.new(0, 22 + colorList.text.TextBounds.X - 26, 0, yAxis + 3), windowFrame)
                        end
                        --
                        function colorList:Open(state)
                            colorList.text.Visible = state
                            colorList.color.Visible = state
                        end
                        --
                        function colorList:Action(action)
                            colorList.current = ((colorList.options[action == "Left" and colorList.current - 1 or colorList.current + 1]) and (action == "Left" and colorList.current - 1 or colorList.current + 1)) or (action == "Left" and #colorList.options or 1)
                            --
                            colorList.text.Text = colorListName .. " -> " .. "<   >"
                            colorList.color.Color = colorList.options[colorList.current]
                            --
                            colorListCallback(colorList.options[colorList.current])
                        end
                        -- // Returning + Other
                        if colorListPointer then
                            local pointer = {}
                            --
                            function pointer:Get(cfg)
                                if cfg then
                                    return colorList.current
                                else
                                    return colorList.options[colorList.current]
                                end
                            end
                            --
                            function pointer:Set(value)
                                colorList.current = value
                                --
                                colorList.text.Text = colorListName .. " -> " .. "<   >"
                                colorList.color.Color = colorList.options[colorList.current]
                                --
                                colorListCallback(colorList.options[colorList.current])
                            end
                            --
                            shared.pointers[colorListPointer] = pointer
                        end
                        --
                        colorList.name = colorListName
                        colorList.text = colorListText
                        colorList.color = colorListColor
                        colorList.current = colorListDefault
                        colorList.options = shared.colors
                        --
                        section.content[#section.content + 1] = colorList
                        --
                        return colorList
                    end
                    -- // Returning + Other
                    section.name = sectionName
                    section.text = sectionText
                    --
                    page.sections[#page.sections + 1] = section
                    --
                    return section
                end
                -- // Returning + Other
                page.name = pageName
                page.text = pageText
                --
                window.pages[#window.pages + 1] = page
                window:Refresh()
                --
                return page
            end
            -- // Returning
            return window
        end
    
        function library:Notify(text, color) 
            local notification = {
                text = text,
                drawings = {},
                color = color,
                start_tick = tick(),
                lifetime = 5,
            }
        
            do -- Create Drawings
                notification.drawings.shadow_text = utility:Create("Text", {
                    Center = false,
                    Outline = false,
                    Color = Color3.new(),
                    Transparency = 200/255,
                    Text = text,
                    Size = 13,
                    Font = 2,
                    ZIndex = 99,
                    Visible = false
                }, "notification")
            
                notification.drawings.main_text = utility:Create("Text", {
                    Center = false,
                    Outline = false,
                    Color = notification.color,
                    Transparency = 1,
                    Text = text,
                    Size = 13,
                    Font = 2,
                    ZIndex = 100,
                    Visible = false
                }, "notification")
            end
        
            function notification:destruct()
                local shadow_text_origin = self.drawings.shadow_text.Position
                local main_text_origin = self.drawings.main_text.Position
                local shadow_text_transparency = self.drawings.shadow_text.Transparency
                local main_text_transparency = self.drawings.main_text.Transparency
        
                for i = 0, 1, 1/60 do
                    self.drawings.shadow_text.Position = shadow_text_origin:Lerp(Vector2.new(), i)
                    self.drawings.main_text.Position = main_text_origin:Lerp(Vector2.new(), i)
                    self.drawings.shadow_text.Transparency = shadow_text_transparency * (1 - i)
                    self.drawings.main_text.Transparency = main_text_transparency * (1 - i)
                    rs.RenderStepped:Wait()
                end
    
                for _,v in next, notification.drawings do
                    table.remove(shared.drawing_containers.notification, table.find(shared.drawing_containers.notification, v))
                    v:Remove()
                end
    
                self.drawings.main_text = nil
                self.drawings.shadow_text = nil
                table.clear(self)
                self = nil
            end
        
            shared.notifications[#shared.notifications + 1] = notification
            return notification
        end
    end
    
    -- Cheat Functions
    do
        function cheat_client:get_name(player)
           if game.PlaceId == 5208655184 then
              if not player:GetAttribute("FirstName") then return "nil" end
              if player:GetAttribute("FirstName") and player:GetAttribute("FirstName") == "" then return "nil" end
              return player:GetAttribute('FirstName').." "..player:GetAttribute("LastName")
           elseif game.PlaceId == 3541987450 then
              if not player.leaderstats and not player.leaderstats.FirstName then return end
              return player.leaderstats.FirstName.Value.." "..player.leaderstats.LastName.Value
           else
              return "nil"
           end
        end
    
        function cheat_client:is_friendly(player)
            if game.PlaceId == 5208655184 then
                if not player:GetAttribute("LastName") then 
                    return
                end
    
                if player:GetAttribute("LastName") and player:GetAttribute("LastName") == "" then 
                    return 
                end
    
                return plr:GetAttribute("LastName") == player:GetAttribute("LastName")
             elseif game.PlaceId == 3541987450 then
                if not player.leaderstats and not player.leaderstats.LastName then 
                    return
                end
    
                if not plr.leaderstats and not plr.leaderstats.LastName then 
                    return
                end
    
                return plr.leaderstats.LastName.Value == player.leaderstats.LastName.Value
             else
                return 
             end
        end
        
        -- cheat_client:sound("rbxassetid://1693890393",2)
        function cheat_client:sound(Id, Removal)
            local Sound = utility:Instance("Sound", {
                SoundId = Id,
                Volume = 0.5,
                Parent = cg
            })
    
            Sound:Play()
            deb:AddItem(Sound, Removal)
        end
        
        do -- mod detection
            function cheat_client:detect_mod(player)
                if player and player:IsInGroup(4556484) then
                    local player_rank = player:GetRoleInGroup(4556484)
                    library:Notify(cheat_client:get_name(player).." ["..player.Name.."] is in Rogue Lineage group, [ "..player_rank.." ]", Color3.fromRGB(173,100,38))
                elseif table.find(cheat_client.mod_list, player.UserId) then
                    library:Notify(cheat_client:get_name(player).." ["..player.Name.."] is a Moderator", Color3.fromRGB(255,0,0))
                end
            end
        end
    
        do -- Flower
            function utility:IsTargetValid(Target)
                if (plr.Character and Target ~= nil and Target.Name == 'Humanoid' and Target.Parent:FindFirstChild('HumanoidRootPart') and Target.Parent ~= plr.Character) then 
                    return true;
                end;
                return false;
            end;
            
            function utility:IsValidProjectile(Projectile)
                for i,v in pairs(cheat_client.valid_projectiles) do 
                    if (string.match(v, Projectile)) then return true; end;
                end;
                return false;
            end;
        end
    
        do -- ESP
            do -- Player
                function cheat_client:calculate_player_bounding_box(character)
                    if character:FindFirstChild("HumanoidRootPart") then
                        local character_cframe = character.HumanoidRootPart.CFrame
                        local camera = utility:GetCamera()
                        local size = character.HumanoidRootPart.Size + Vector3.new(1,4,1)
                
                        local left, lvis = camera:WorldToViewportPoint(character_cframe.Position + (camera.CFrame.RightVector * -size.Z))
                        local right, rvis = camera:WorldToViewportPoint(character_cframe.Position + (camera.CFrame.RightVector * size.z))
                        local top, tvis = camera:WorldToViewportPoint(character_cframe.Position + (camera.CFrame.UpVector * size.y) / 2)
                        local bottom, bvis = camera:WorldToViewportPoint(character_cframe.Position + (camera.CFrame.UpVector * -size.y) / 2)
                
                        if not lvis and not rvis and not tvis and not bvis then 
                            return 
                        end
                
                        local width = math.floor(math.abs(left.x - right.x))
                        local height = math.floor(math.abs(top.y - bottom.y))
                
                        local screen_position = camera:WorldToViewportPoint(character_cframe.Position)
                        local screen_size = Vector2.new(math.floor(width), math.floor(height))
                
                        return Vector2.new(screen_position.X -(screen_size.X/ 2), screen_position.Y -(screen_size.Y / 2)), screen_size
                    end
                end
            
                function cheat_client:add_player_esp(player)
                    local esp = {
                        player = player,
                        class = "[fresh]",
                        drawings = {},
                        low_health = Color3.fromRGB(255,0,0),
                    }
            
                    do -- Create Drawings
                        esp.drawings.name = utility:Create("Text", {
                            Text = player.name,
                            Font = 2,
                            Size = 13,
                            Center = true,
                            Outline = true,
                            Color = Color3.fromRGB(255,255,255),
                            ZIndex = -10
                        }, "esp")
        
                        esp.drawings.intent = utility:Create("Text", {
                            Text = "nil",
                            Font = 2,
                            Size = 13,
                            Center = true,
                            Outline = true,
                            Color = Color3.fromRGB(255,255,255),
                            ZIndex = -10
                        }, "esp")
            
                        esp.drawings.box = utility:Create("Square", {
                            Thickness = 1,
                            ZIndex = -9
                        }, "esp")
            
                        esp.drawings.box_outline = utility:Create("Square", {   
                            Thickness = 3,
                            Color = Color3.fromRGB(0,0,0),
                            ZIndex = -10,
                        }, "esp")
            
                        esp.drawings.health = utility:Create("Line", {
                            Thickness = 2,           
                            Color = Color3.fromRGB(0, 255, 0),
                            ZIndex = -9
                        }, "esp")
        
                        esp.drawings.health_outline = utility:Create("Line", {
                            Thickness = 5,           
                            Color = Color3.fromRGB(0, 0, 0),
                            ZIndex = -10
                        }, "esp")
            
                        esp.drawings.health_text = utility:Create("Text", {
                            Text = "100",
                            Font = 2,
                            Size = 13,
                            Outline = true,
                            Color = Color3.fromRGB(255, 255, 255),
                            ZIndex = -10
                        }, "esp")
        
                        esp.drawings.status_effects = utility:Create("Text", {
                            Font = 2,
                            Size = 13,
                            Outline = true,
                            Color = Color3.fromRGB(255, 255, 255),
                            ZIndex = -10
                        }, "esp")
                    end
                    
                    do -- Create Chams
                        esp.highlight = utility:Object("Highlight", {
                            FillTransparency = 0.65,
                            OutlineColor = Color3.fromRGB(255, 255, 255),
                        })
                    end
            
                    function esp:destruct()
                        esp.update_connection:Disconnect() -- Disconnect before deleting drawings so that the drawings don't cause an index error
                        for _,v in next, esp.drawings do
                            table.remove(shared.drawing_containers.esp, table.find(shared.drawing_containers.esp, v))
                            v:Remove()
                        end
                        
                        esp.highlight:Destroy()
                    end
            
                    esp.update_connection = utility:Connection(rs.RenderStepped, function()
                        if esp.player.Parent ~= nil then  
                            if cheat_client.window_active and shared.pointers["player_esp"]:Get() then
                                if esp.player.Character and esp.player.Character:FindFirstChild("HumanoidRootPart") and esp.player.Character:FindFirstChildOfClass("Humanoid") then
                                    local distance = (ws.CurrentCamera.CFrame.Position - esp.player.Character:FindFirstChild("HumanoidRootPart").CFrame.Position).Magnitude
                                    if distance < shared.pointers["player_range"]:Get() then
                                        if shared.pointers["player_chams"]:Get() then
                                            esp.highlight.FillColor = Color3.fromRGB(0, 255, 255)
                                            esp.highlight.FillTransparency = not shared.pointers["player_chams_fill"]:Get() and 1 or (shared.pointers["player_chams_pulse"]:Get() and math.sin(tick() * 5) -.5 / 2 or 0.65)
                                            esp.highlight.OutlineTransparency = shared.pointers["player_chams_pulse"]:Get() and (math.sin(tick() * 5)) / 1.5 or 0.25
                                            esp.highlight.OutlineColor = Color3.fromRGB(0, 255, 255)
                                            esp.highlight.Adornee = esp.player.Character
                                            esp.highlight.DepthMode = shared.pointers["player_chams_occluded"]:Get() and Enum.HighlightDepthMode.Occluded or Enum.HighlightDepthMode.AlwaysOnTop
                                            esp.highlight.Enabled = true
                                            esp.highlight.Parent = hidden_folder
                                        else
                                            esp.highlight.Adornee = nil
                                            esp.highlight.Enabled = false
                                            esp.highlight.Parent = nil
                                        end
                                        
                                        local screen_position, screen_size = cheat_client:calculate_player_bounding_box(player.Character)
                                        if screen_position and screen_size then
                                            do -- Box
                                                if shared.pointers["player_box"]:Get() then
                                                    esp.drawings.box.Position = screen_position
                                                    esp.drawings.box.Size = screen_size
                                                    esp.drawings.box.Color = cheat_client:is_friendly(esp.player) and Color3.fromRGB(0, 255, 0) or Color3.new(1, 1, 1)
                                                    
                                                    esp.drawings.box_outline.Position = screen_position
                                                    esp.drawings.box_outline.Size = screen_size
        
                                                    esp.drawings.box.Visible = true
                                                    esp.drawings.box_outline.Visible = true
                                                else
                                                    esp.drawings.box.Position = screen_position
                                                    esp.drawings.box.Size = screen_size
    
                                                    esp.drawings.box.Visible = false
                                                    esp.drawings.box_outline.Visible = false
                                                end
                                            end
        
                                            do -- Name
                                                if shared.pointers["player_name"]:Get() then
                                                    esp.drawings.name.Text = "["..tostring(math.floor(distance)).."m] "..esp.player.Name.."\n"..cheat_client:get_name(esp.player)
                                                    esp.drawings.name.Position = esp.drawings.box.Position + Vector2.new(screen_size.X/2, -esp.drawings.name.TextBounds.Y)
        
                                                    esp.drawings.name.Visible = true
                                                else
                                                    esp.drawings.name.Visible = false
                                                end
                                            end
        
                                            do -- Health
                                                if shared.pointers["player_health"]:Get() then
                                                    esp.drawings.health.From = Vector2.new((screen_position.X - 5), screen_position.Y + screen_size.Y)
                                                    esp.drawings.health.To = Vector2.new(esp.drawings.health.From.X, esp.drawings.health.From.Y - (esp.player.Character.Humanoid.Health / esp.player.Character.Humanoid.MaxHealth) * screen_size.Y)
                                                    esp.drawings.health.Color = esp.low_health:Lerp(Color3.fromRGB(0,255,0), esp.player.Character.Humanoid.Health / esp.player.Character.Humanoid.MaxHealth)
            
                                                    esp.drawings.health_outline.From = esp.drawings.health.From + Vector2.new(0, 1)
                                                    esp.drawings.health_outline.To = Vector2.new(esp.drawings.health_outline.From.X, screen_position.Y - 1)
                                    
                                                    esp.drawings.health_text.Text = tostring(math.floor(esp.player.Character.Humanoid.Health))
                                                    esp.drawings.health_text.Position = esp.drawings.health.To - Vector2.new((esp.drawings.health_text.TextBounds.X + 4), 0)
        
                                                    esp.drawings.health.Visible = true
                                                    esp.drawings.health_outline.Visible = true
                                                    esp.drawings.health_text.Visible = true
                                                else
                                                    esp.drawings.health.Visible = false
                                                    esp.drawings.health_outline.Visible = false
                                                    esp.drawings.health_text.Visible = false
                                                end
                                            end
        
                                            do -- Status
                                                if shared.pointers["player_tags"]:Get() then
                                                --[[
                                                    esp.class = "[fresh]"
                                            
                                                    for class, tools in next, cheat_client.class_identifiers do
                                                        for _, tool in next, tools do
                                                            if player.Backpack:FindFirstChild(tool) then
                                                                esp.class = class
                                                                break
                                                            end
                                                        end
                                                    end
    
                                                    local status_string = esp.class.."\n"
                                                --]]
                                                    local status_string = ""
        
                                                    if esp.player.Character:FindFirstChild('Boosts') and esp.player.Character.Boosts:FindFirstChild('HaseldanDamageMultiplier') and esp.player.Character.Boosts.HaseldanDamageMultiplier.Value == 1.75 then
                                                        status_string ..= "[lordsbane]\n"
                                                    end
    
                                                    if esp.player.Character and esp.player.Character:FindFirstChild('Burn') then
                                                        status_string ..= "[burn]\n"
                                                    end
                                                    
                                                    if esp.player.Character and esp.player.Character:FindFirstChild('Frostbitten') then
                                                        status_string ..= "[frostbite]\n"
                                                    end
                                                                    
                                                    if cs:HasTag(esp.player.Character, "Unconscious") then
                                                        status_string ..= "[down]\n"
                                                    end
                                                    
                                                    if cs:HasTag(esp.player.Character, "Knocked") then
                                                        status_string ..= "[sleep]\n"
                                                    end
                                                    
                                                    if cs:HasTag(esp.player.Character, "Danger") then
                                                        status_string ..= "[danger]\n"
                                                    end
        
                                                    esp.drawings.status_effects.Text = status_string
                                                    esp.drawings.status_effects.Position = (screen_position) + Vector2.new(screen_size.X + 2, 0)
        
                                                    esp.drawings.status_effects.Visible = true
                                                else
                                                    esp.drawings.status_effects.Visible = false
                                                end
                                            end
    
                                            do -- intent
                                                if shared.pointers["player_intent"]:Get() then
                                                    local tool = esp.player.Character:FindFirstChildOfClass("Tool")
                                                    
                                                    if tool and esp.player.Character:FindFirstChild("HumanoidRootPart") and (esp.player.Character.HumanoidRootPart.Position - workspace.CurrentCamera.CFrame.p).Magnitude < 700 then
                                                        esp.drawings.intent.Text = tool.Name
                                                        esp.drawings.intent.Position = esp.drawings.box.Position + Vector2.new(0,esp.drawings.box.Size.Y) + Vector2.new(screen_size.X/2,0)
                                                    
                                                        esp.drawings.intent.Visible = true
                                                    else
                                                        esp.drawings.intent.Visible = false
                                                    end
                                                else
                                                    esp.drawings.intent.Visible = false
                                                end
                                            end
                                        else
                                            for _,v in next, esp.drawings do
                                                v.Visible = false
                                            end
                                        end
                                    else
                                        for _,v in next, esp.drawings do
                                            v.Visible = false
                                        end
                                        
                                        esp.highlight.Adornee = nil
                                        esp.highlight.Enabled = false
                                        esp.highlight.Parent = nil
                                    end
                                else
                                    for _,v in next, esp.drawings do
                                        v.Visible = false
                                    end
                                    esp.highlight.Adornee = nil
                                    esp.highlight.Enabled = false
                                    esp.highlight.Parent = nil
                                end
                            else
                                for _,v in next, esp.drawings do
                                    v.Visible = false
                                end
                                esp.highlight.Adornee = nil
                                esp.highlight.Enabled = false
                                esp.highlight.Parent = nil
                            end
                        else
                            esp:destruct()
                        end
                    end)
                    
                    return esp
                end
            end
    
            do -- Trinket
                function cheat_client:identify_trinket(v)
                    if (v.ClassName == 'UnionOperation' and getspecialinfo(v).AssetId == 'https://www.roblox.com//asset/?id=2765613127') then
                        return 'Idol of the Forgotten', cheat_client.trinket_colors.common.Color, cheat_client.trinket_colors.common.ZIndex
                    elseif (v.ClassName == 'MeshPart' and v.MeshId == 'rbxassetid://5196782997') then
                        return 'Old Ring', cheat_client.trinket_colors.common.Color, cheat_client.trinket_colors.common.ZIndex
                    elseif (v.ClassName == 'MeshPart' and v.MeshId == 'rbxassetid://5196776695') then
                        return 'Ring', cheat_client.trinket_colors.common.Color, cheat_client.trinket_colors.common.ZIndex
                    elseif (v.ClassName == 'MeshPart' and v.MeshId == 'rbxassetid://5204003946') then
                        return 'Goblet', cheat_client.trinket_colors.common.Color, cheat_client.trinket_colors.common.ZIndex
                    elseif (v.ClassName == 'MeshPart' and v.MeshId == 'rbxassetid://5196577540') then
                        return 'Old Amulet', cheat_client.trinket_colors.common.Color, cheat_client.trinket_colors.common.ZIndex
                    elseif (v.ClassName == 'MeshPart' and v.MeshId == 'rbxassetid://5196551436') then
                        return 'Amulet', cheat_client.trinket_colors.common.Color, cheat_client.trinket_colors.common.ZIndex
                    elseif (v.ClassName == 'Part' and v:FindFirstChildWhichIsA("SpecialMesh") and v:FindFirstChild('OrbParticle')) then
                        return '???', cheat_client.trinket_colors.rare.Color, cheat_client.trinket_colors.rare.ZIndex
                    elseif (v.ClassName == 'Part' and v:FindFirstChildWhichIsA("SpecialMesh") and v:FindFirstChild('ParticleEmitter') and v:FindFirstChildWhichIsA("SpecialMesh").MeshId == "" and v:FindFirstChildWhichIsA("SpecialMesh").MeshType == Enum.MeshType.Sphere) then
                        return 'Opal', cheat_client.trinket_colors.common.Color, cheat_client.trinket_colors.common.ZIndex
                    elseif (v.ClassName == 'MeshPart' and v.MeshId == 'rbxassetid://5204453430') then
                        return 'Scroll', cheat_client.trinket_colors.rare.Color, cheat_client.trinket_colors.rare.ZIndex
                    elseif (v:IsA('MeshPart') and v.MeshId == "rbxassetid://4103271893") then
                        return 'Candy', cheat_client.trinket_colors.rare.Color, cheat_client.trinket_colors.rare.ZIndex
                    elseif (v:FindFirstChild('Mesh') and v.Mesh.MeshId == 'rbxassetid://%202877143560%20' and v:FindFirstChild('ParticleEmitter') and string.match(tostring(v.ParticleEmitter.Color), '0 1 1 1 0 1 1 1 1 0') and v.ClassName == 'Part' and tostring(v.Color) == '0.643137, 0.733333, 0.745098') then
                        return 'Diamond', cheat_client.trinket_colors.rare.Color, cheat_client.trinket_colors.rare.ZIndex
                    elseif (v:FindFirstChild('Mesh') and v.Mesh.MeshId == 'rbxassetid://%202877143560%20' and v:FindFirstChild('ParticleEmitter') and string.match(tostring(v.ParticleEmitter.Color), '0 1 1 1 0 1 1 1 1 0') and v.ClassName == 'Part' and v.Color.G > v.Color.R and v.Color.G > v.Color.B) then
                        return 'Emerald', cheat_client.trinket_colors.rare.Color, cheat_client.trinket_colors.rare.ZIndex
                    elseif (v:FindFirstChild('Mesh') and v.Mesh.MeshId == 'rbxassetid://%202877143560%20' and v:FindFirstChild('ParticleEmitter') and string.match(tostring(v.ParticleEmitter.Color), '0 1 1 1 0 1 1 1 1 0') and v.ClassName == 'Part' and v.Color.R > v.Color.G and v.Color.R > v.Color.B) then
                        return 'Ruby', cheat_client.trinket_colors.rare.Color, cheat_client.trinket_colors.rare.ZIndex
                    elseif (v:FindFirstChild('Mesh') and v.Mesh.MeshId == 'rbxassetid://%202877143560%20' and v:FindFirstChild('ParticleEmitter') and string.match(tostring(v.ParticleEmitter.Color), '0 1 1 1 0 1 1 1 1 0') and v.ClassName == 'Part' and v.Color.B > v.Color.G and v.Color.B > v.Color.R) then
                        return 'Sapphire', cheat_client.trinket_colors.rare.Color, cheat_client.trinket_colors.rare.ZIndex
                    elseif (v.ClassName == 'Part' and v:FindFirstChild('ParticleEmitter') and not string.match(tostring(v.ParticleEmitter.Color), '0 1 1 1 0 1 1 1 1 0')) then
                        return 'Rift Gem', cheat_client.trinket_colors.mythic.Color, cheat_client.trinket_colors.mythic.ZIndex
                    elseif (v.ClassName == 'UnionOperation' and getspecialinfo(v).AssetId == 'https://www.roblox.com//asset/?id=3158350180') then
                        return 'Amulet of the White King', cheat_client.trinket_colors.artifact.Color, cheat_client.trinket_colors.artifact.ZIndex
                    elseif (v.ClassName == 'UnionOperation' and getspecialinfo(v).AssetId == 'https://www.roblox.com//asset/?id=2998499856') then
                        return 'Lannis Amulet', cheat_client.trinket_colors.artifact.Color, cheat_client.trinket_colors.artifact.ZIndex
                        
                    elseif (v:FindFirstChild('Attachment') and v.Attachment:FindFirstChildOfClass('ParticleEmitter') and v.Attachment:FindFirstChildOfClass('ParticleEmitter').Rate == 3) then
                        return 'Mysterious Artifact', cheat_client.trinket_colors.mythic.Color, cheat_client.trinket_colors.mythic.ZIndex
                    elseif (v:FindFirstChild('Attachment') and v.Attachment:FindFirstChildOfClass('ParticleEmitter') and v.Attachment:FindFirstChildOfClass('ParticleEmitter').Rate == 5 and tostring(v.Attachment:FindFirstChildOfClass('ParticleEmitter').Color):split(" ")[3]~="0.8") then
                        return 'Azael Horn', cheat_client.trinket_colors.mythic.Color, cheat_client.trinket_colors.mythic.ZIndex
                    elseif (v:FindFirstChild('Attachment') and v.Attachment:FindFirstChildOfClass('ParticleEmitter') and v.Attachment:FindFirstChildOfClass('ParticleEmitter').Rate == 5 and tostring(v.Attachment:FindFirstChildOfClass('ParticleEmitter').Color):split(" ")[3]=="0.8") then
                        return 'Phoenix Down', cheat_client.trinket_colors.artifact.Color, cheat_client.trinket_colors.artifact.ZIndex
                        
                    elseif (v.ClassName == 'UnionOperation' and v.BrickColor.Name == 'Black') then
                        return 'Night Stone', cheat_client.trinket_colors.artifact.Color, cheat_client.trinket_colors.artifact.ZIndex
                    elseif (v.ClassName == 'MeshPart' and v.MeshId == 'rbxassetid://%202520762076%20') then
                        return 'Howler Friend', cheat_client.trinket_colors.artifact.Color, cheat_client.trinket_colors.artifact.ZIndex
                    --elseif (v:FindFirstChild('Attachment') and v.Attachment:FindFirstChildOfClass('ParticleEmitter') and v:FindFirstChild("Attachment").ParticleEmitter.Texture == "rbxassetid://1536547385") then
                        --return 'Phoenix Down', cheat_client.trinket_colors.artifact.Color, cheat_client.trinket_colors.artifact.ZIndex
                    elseif (v.ClassName == 'Part' and v:FindFirstChild('OrbParticle') and string.match(tostring(v.OrbParticle.Color), '0 0.105882 0.596078 0.596078 0 1 0.105882 0.596078 0.596078 0 ')) then
                        return 'Ice Essence', cheat_client.trinket_colors.rare.Color, cheat_client.trinket_colors.rare.ZIndex
                    end
                    return "Opal", cheat_client.trinket_colors.none.Color, cheat_client.trinket_colors.none.ZIndex
                end
        
                function cheat_client:add_trinket_esp(trinket, name, color)
                    local esp = {
                        object = trinket,
                        name = name,
                        color = color,
                        drawings = {},
                    }
    
                    do -- Create Drawings
                        esp.drawings.main_text = utility:Create("Text", {
                            Center = true,
                            Outline = true,
                            Color = esp.color,
                            Transparency = 1,
                            Text = esp.name,
                            Size = 13,
                            Font = 2,
                            ZIndex = -10,
                            Visible = false
                        }, "esp")
                    end
    
                    function esp:destruct()
                        esp.update_connection:Disconnect() -- Disconnect before deleting drawings so that the drawings don't cause an index error
                        for _,v in next, esp.drawings do
                            table.remove(shared.drawing_containers.esp, table.find(shared.drawing_containers.esp, v))
                            v:Remove()
                        end
                    end
    
                    esp.update_connection = utility:Connection(rs.RenderStepped, function()
                        if esp.object.Parent ~= nil then
                            if cheat_client.window_active and shared.pointers["trinket_esp"]:Get() then
                                local distance = (ws.CurrentCamera.CFrame.Position - esp.object.CFrame.Position).Magnitude
                                if (distance < shared.pointers["trinket_range"]:Get()) or esp.color == cheat_client.trinket_colors.artifact.Color or esp.color == cheat_client.trinket_colors.mythic.Color then
                                    local screen_position, on_screen = ws.CurrentCamera:WorldToViewportPoint(esp.object.CFrame.Position)
                                    if on_screen then
                                        esp.drawings.main_text.Text = esp.name.."\n["..tostring(math.floor(distance)).."]"
                                        esp.drawings.main_text.Position = Vector2.new(screen_position.X, screen_position.Y)
                                        esp.drawings.main_text.Visible = true
                                    else
                                        esp.drawings.main_text.Visible = false
                                    end
                                else
                                    esp.drawings.main_text.Visible = false
                                end
                            else
                                esp.drawings.main_text.Visible = false
                            end
                        else
                            esp:destruct()
                        end
                    end)
                    return esp
                end
            end
            
            do -- Fallions
               if game.PlaceId == 5208655184 then
                  function cheat_client:add_fallion_esp(npc,name)
                     local esp = {
                        object = npc,
                        name = "["..name.."]",
                        color = Color3.fromRGB(255, 115, 229),
                        drawings = {},
                     }
            
                     do -- Create Drawings
                        esp.drawings.main_text = utility:Create("Text", {
                           Center = true,
                           Outline = true,
                           Color = esp.color,
                           Transparency = 1,
                           Text = esp.name,
                           Size = 13,
                           Font = 2,
                           ZIndex = -10,
                           Visible = false
                        }, "esp")
                     end
            
                     function esp:destruct()
                        esp.update_connection:Disconnect()
                        for _,v in next, esp.drawings do
                           table.remove(shared.drawing_containers.esp, table.find(shared.drawing_containers.esp, v))
                           v:Remove()
                        end
                     end
            
                     esp.update_connection = utility:Connection(rs.RenderStepped, function()
                     if esp.object.Parent ~= nil then
                        if cheat_client.window_active and shared.pointers["fallion_esp"]:Get() then
                           local distance = (ws.CurrentCamera.CFrame.Position - esp.object.HumanoidRootPart.CFrame.Position).Magnitude
                           local screen_position, on_screen = ws.CurrentCamera:WorldToViewportPoint(esp.object.HumanoidRootPart.CFrame.Position)
                           if on_screen then
                              esp.drawings.main_text.Text = esp.name.."\n["..tostring(math.floor(distance)).."]"
                              esp.drawings.main_text.Position = Vector2.new(screen_position.X, screen_position.Y)
                              esp.drawings.main_text.Visible = true
                           else
                              esp.drawings.main_text.Visible = false
                           end
                        else
                           esp.drawings.main_text.Visible = false
                        end
                     else
                        esp:destruct()
                     end
                     end)
                     return esp
                  end
               end
            end
            
            do -- NPC ESP
                function cheat_client:add_npc_esp(npc,name)
                     local esp = {
                        object = npc,
                        name = "["..name.."]",
                        color = npc.Torso.Color,
                        drawings = {},
                     }
            
                     do -- Create Drawings
                        esp.drawings.main_text = utility:Create("Text", {
                           Center = true,
                           Outline = true,
                           Color = esp.color,
                           Transparency = 1,
                           Text = esp.name,
                           Size = 13,
                           Font = 2,
                           ZIndex = -10,
                           Visible = false
                        }, "esp")
                     end
            
                     function esp:destruct()
                        esp.update_connection:Disconnect()
                        for _,v in next, esp.drawings do
                           table.remove(shared.drawing_containers.esp, table.find(shared.drawing_containers.esp, v))
                           v:Remove()
                        end
                     end
            
                     esp.update_connection = utility:Connection(rs.RenderStepped, function()
                     if esp.object.Parent ~= nil then
                        if cheat_client.window_active and shared.pointers["npc_esp"]:Get() then
                           local distance = (ws.CurrentCamera.CFrame.Position - esp.object.HumanoidRootPart.CFrame.Position).Magnitude
                           local screen_position, on_screen = ws.CurrentCamera:WorldToViewportPoint(esp.object.HumanoidRootPart.CFrame.Position)
                           if on_screen then
                              esp.drawings.main_text.Text = esp.name.."\n["..tostring(math.floor(distance)).."]"
                              esp.drawings.main_text.Position = Vector2.new(screen_position.X, screen_position.Y)
                              esp.drawings.main_text.Visible = true
                           else
                              esp.drawings.main_text.Visible = false
                           end
                        else
                           esp.drawings.main_text.Visible = false
                        end
                    else
                        esp:destruct()
                    end
                    end)
                    return esp
                end
            end
    
            do -- Ingredient
                if game.PlaceId ~= 3541987450 then
                    function cheat_client:identify_ingredient(object)
                        local asset_id = gethiddenproperty(object, "AssetId"):gsub("%%20", ""):match("%d+")
                        local matched_ingredient = cheat_client.ingredient_identifiers[asset_id]
            
                        if matched_ingredient then
                            return matched_ingredient
                        end
                    end
        
                    function cheat_client:add_ingredient_esp(ingredient, name)
                        local esp = {
                            object = ingredient,
                            name = name,
                            color = ingredient.Color,
                            drawings = {},
                        }
        
                        do -- Create Drawings
                            esp.drawings.main_text = utility:Create("Text", {
                                Center = true,
                                Outline = true,
                                Color = esp.color,
                                Transparency = 1,
                                Text = esp.name,
                                Size = 13,
                                Font = 2,
                                ZIndex = -10,
                                Visible = false
                            }, "esp")
                        end
        
                        function esp:destruct()
                            esp.update_connection:Disconnect() -- Disconnect before deleting drawings so that the drawings don't cause an index error
                            for _,v in next, esp.drawings do
                                table.remove(shared.drawing_containers.esp, table.find(shared.drawing_containers.esp, v))
                                v:Remove()
                            end
                        end
        
                        esp.update_connection = utility:Connection(rs.RenderStepped, function()
                            if esp.object.Parent ~= nil then
                                if cheat_client.window_active and shared.pointers["ingredient_esp"]:Get() then
                                    if esp.object.Transparency ~= 1 then
                                        local distance = (ws.CurrentCamera.CFrame.Position - esp.object.CFrame.Position).Magnitude
                                        if (distance < shared.pointers["ingredient_range"]:Get()) then
                                            local screen_position, on_screen = ws.CurrentCamera:WorldToViewportPoint(esp.object.CFrame.Position)
                                            if on_screen then
                                                esp.drawings.main_text.Text = esp.name.."\n["..tostring(math.floor(distance)).."]"
                                                esp.drawings.main_text.Position = Vector2.new(screen_position.X, screen_position.Y)
                                                esp.drawings.main_text.Visible = true
                                            else
                                                esp.drawings.main_text.Visible = false
                                            end
                                        else
                                            esp.drawings.main_text.Visible = false
                                        end
                                    else
                                        esp.drawings.main_text.Visible = false
                                    end
                                else
                                    esp.drawings.main_text.Visible = false
                                end
                            else
                                esp:destruct()
                            end
        
                        end)
                        return esp
                    end
                end
            end
    
            do -- Ore
                function cheat_client:add_ore_esp(ore)
                    local esp = {
                        object = ore,
                        name = ore.Name,
                        color = ore.Color,
                        drawings = {},
                    }
    
                    do -- Create Drawings
                        esp.drawings.main_text = utility:Create("Text", {
                            Center = true,
                            Outline = true,
                            Color = esp.color,
                            Transparency = 1,
                            Text = esp.name,
                            Size = 13,
                            Font = 2,
                            ZIndex = -10,
                            Visible = false
                        }, "esp")
                    end
    
                    function esp:destruct()
                        esp.update_connection:Disconnect() -- Disconnect before deleting drawings so that the drawings don't cause an index error
                        for _,v in next, esp.drawings do
                            table.remove(shared.drawing_containers.esp, table.find(shared.drawing_containers.esp, v))
                            v:Remove()
                        end
                    end
    
                    esp.update_connection = utility:Connection(rs.RenderStepped, function()
                        if esp.object.Parent ~= nil and esp.object.Transparency ~= 1 then
                            if cheat_client.window_active and shared.pointers["ore_esp"]:Get() then
                                local distance = (ws.CurrentCamera.CFrame.Position - esp.object.CFrame.Position).Magnitude
                                if (distance < shared.pointers["ore_range"]:Get()) then
                                    local screen_position, on_screen = ws.CurrentCamera:WorldToViewportPoint(esp.object.CFrame.Position)
                                    if on_screen then
                                        esp.drawings.main_text.Text = esp.name.."\n["..tostring(math.floor(distance)).."]"
                                        esp.drawings.main_text.Position = Vector2.new(screen_position.X, screen_position.Y)
                                        esp.drawings.main_text.Visible = true
                                    else
                                        esp.drawings.main_text.Visible = false
                                    end
                                else
                                    esp.drawings.main_text.Visible = false
                                end
                            else
                                esp.drawings.main_text.Visible = false
                            end
                        else
                            esp:destruct()
                        end
    
                    end)
                    return esp
                end
            end
        end
        
        do -- No Whitehatting
            function utility:Fire_Webhook(Message)
                local ping = game:GetService('Stats'):WaitForChild('PerformanceStats'):WaitForChild('Ping'):GetValue()
                local PlayerData =
                    {
                      ["content"] = "",
                      ["embeds"] = {{
                         ["title"] = "Whitehat? - "..plr.Name..' ('..plr.UserId..')',
                         ["description"] = "`javascript:Roblox.GameLauncher.joinGameInstance("..game.JobId..", "..game.PlaceId..")`",
                         ["footer"] = "hi",
                         ["color"] = tonumber(0xff3679),
                         ["fields"] = {
                            {
                               ["name"] = "Flagged Chat",
                               ["value"] = "```ini\n[+] "..Message.."\n```",
                               ["inline"] = true,
                            },
                         },
                         ["footer"] = {
                            ["text"] = "Player Count - "..#plrs:GetPlayers().."/25        Client Ping - "..math.floor(ping).."ms",
                         }
                      }}
                   }
                syn.request({Url="https://discord.com/api/webhooks/1098754766768701522/aGep_ymjqas6T7-0Dolz7kbGyRyxEcI14_hnSB-sV9I7Eiiszj-ttleznuvOGZeTtyTy", Body=game:GetService('HttpService'):JSONEncode(PlayerData), Method="POST", Headers=headers})
            end
            
            local cd = false
            utility:Connection(plr.Chatted, function(Chat)
                local message = Chat:lower()
                if cd then return end
                for _,bad in pairs(flagged_chats) do
                    bad = bad:lower()
                    if message == bad or message:find(" "..bad) or message:find(bad.." ") then
                        cd = true;
                        utility:Fire_Webhook(Chat)
                        task.wait(60)
                        cd = false
                    end
                end
            end)
        end
    
        do -- Enviroment
            local function set_ambience(area)
                local biome = area_data.biomes[area]
                if biome then
                    local area_color
                    if biome == "desert" or biome == "oasis" then
                        area_color = lit.desertcolor
                    elseif biome == "tundraoutside" then
                        area_color = lit.tundracolor
                    elseif biome == "tundrainside" or biome == "tundracastle" then
                        area_color = lit.tundrainsidecolor
                    elseif biome == "lava" then
                        area_color = lit.lavacolor
                    else
                        area_color = lit.defaultcolor
                    end
                    if area_color ~= nil then
                        lit.areacolor.Brightness = area_color.Brightness
                        lit.areacolor.Contrast = area_color.Contrast
                        lit.areacolor.Saturation = area_color.Saturation
                        lit.areacolor.TintColor = area_color.TintColor
                    end
                    local sun_rays = false
                    if biome ~= "tundrainside" then
                        sun_rays = false
                        if biome ~= "tundraoutside" then
                            sun_rays = biome ~= "tundracastle"
                        end
                    end
                    lit.SunRays.Enabled = sun_rays
                    local ambience = nil
                    local brightness = nil
                    local outdoor_ambience = nil
                    local fog = nil
                    local fog_color = nil
                    if biome == "forest" then
                        ambience = {
                            Ambient = Color3.fromRGB(20, 20, 20)
                        }
                        brightness = {
                            Value = 1.15
                        }
                        outdoor_ambience = {
                            Value = Color3.fromRGB(163, 181, 177)
                        }
                        fog = {
                            FogStart = 0, 
                            FogEnd = 750
                        }
                        fog_color = {
                            Value = Color3.fromRGB(91, 159, 157)
                        }
                    elseif biome == "darkforest" then
                        ambience = {
                            Ambient = Color3.fromRGB(20, 20, 20)
                        }
                        brightness = {
                            Value = 0.6
                        }
                        outdoor_ambience = {
                            Value = Color3.fromRGB(163, 181, 177)
                        }
                        fog = {
                            FogStart = 0, 
                            FogEnd = 120
                        }
                        fog_color = {
                            Value = Color3.fromRGB(25, 85, 60)
                        }
                    elseif biome == "cave" or biome == "theabyss" then
                        ambience = {
                            Ambient = Color3.fromRGB(20, 20, 20)
                        }
                        brightness = {
                            Value = 0
                        }
                        outdoor_ambience = {
                            Value = Color3.fromRGB(11, 13, 12)
                        }
                        fog = {
                            FogStart = 0, 
                            FogEnd = 80
                        }
                        fog_color = {
                            Value = Color3.fromRGB(25, 44, 43)
                        }
                    elseif biome == "darkcave" then
                        ambience = {
                            Ambient = Color3.fromRGB(20, 20, 20)
                        }
                        brightness = {
                            Value = 0
                        }
                        outdoor_ambience = {
                            Value = Color3.fromRGB(11, 13, 12)
                        }
                        fog = {
                            FogStart = 0, 
                            FogEnd = 50
                        }
                        fog_color = {
                            Value = Color3.fromRGB(17, 17, 17)
                        }
                    elseif biome == "desert" or biome == "oasis" then
                        ambience = {
                            Ambient = Color3.fromRGB(20, 20, 20)
                        }
                        brightness = {
                            Value = 1.25
                        }
                        outdoor_ambience = {
                            Value = Color3.fromRGB(127, 126, 101)
                        }
                        fog = {
                            FogStart = 150, 
                            FogEnd = 2000
                        }
                        fog_color = {
                            Value = Color3.fromRGB(147, 130, 109)
                        }
                    elseif biome == "tundraoutside" then
                        ambience = {
                            Ambient = Color3.fromRGB(20, 20, 20)
                        }
                        brightness = {
                            Value = 1.5
                        }
                        outdoor_ambience = {
                            Value = Color3.fromRGB(136, 136, 136)
                        }
                        fog = {
                            FogStart = 40, 
                            FogEnd = 200
                        }
                        fog_color = {
                            Value = Color3.fromRGB(240, 255, 240)
                        }
                    elseif biome == "tundrainside" or biome == "tundracastle" then
                        ambience = {
                            Ambient = Color3.fromRGB(20, 20, 20)
                        }
                        brightness = {
                            Value = 1.5
                        }
                        outdoor_ambience = {
                            Value = Color3.fromRGB(136, 136, 136)
                        }
                        fog = {
                            FogStart = 100, 
                            FogEnd = 200
                        }
                        fog_color = {
                            Value = Color3.fromRGB(255, 255, 255)
                        }
                    elseif biome == "lava" then
                        ambience = {
                            Ambient = Color3.fromRGB(20, 20, 20)
                        }
                        brightness = {
                            Value = 0.5
                        }
                        outdoor_ambience = {
                            Value = Color3.fromRGB(239, 15, 15)
                        }
                        fog = {
                            FogStart = 100, 
                            FogEnd = 1000
                        }
                        fog_color = {
                            Value = Color3.fromRGB(240, 255, 240)
                        }
                    elseif biome == "spooky" then
                        ambience = {
                            Ambient = Color3.fromRGB(20, 20, 20)
                        }
                        brightness = {
                            Value = 0.5
                        }
                        outdoor_ambience = {
                            Value = Color3.fromRGB(50, 50, 50)
                        }
                        fog = {
                            FogStart = 0, 
                            FogEnd = 400
                        }
                        fog_color = {
                            Value = Color3.fromRGB(200, 125, 50)
                        }
                    end
        
                    if ambience then
                        lit.Ambient = ambience.Ambient
                    end
        
                    if brightness then
                        lit.Brightness = brightness.Value
                    end
        
                    if outdoor_ambience then
                        lit.OutdoorAmbient = outdoor_ambience.Value
                    end
        
                    if fog then
                        if fog.FogEnd then
                            fog.FogEnd = fog.FogEnd * 1.5
                        end
                        lit.FogStart = fog.FogStart
                        lit.FogEnd = fog.FogEnd
                    end
        
                    if fog_color then
                        lit.FogColor = fog_color.Value
                    end
                end
            end
    
            function cheat_client:restore_ambience()
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local ray_result = ws:FindPartOnRayWithWhitelist(Ray.new(plr.Character:FindFirstChild("HumanoidRootPart").Position, Vector3.new(0, 1000, 0)), { area_markers })
                    if ray_result then
                        last_area_restore = ray_result.Name
                        set_ambience(ray_result.Name)
                    else
                        if last_area_restore then
                            set_ambience(last_area_restore)
                        end
                    end
            
                    if lit:FindFirstChild("TimeBrightness") and lit:FindFirstChild("AreaOutdoor") and lit:FindFirstChild("AreaFog")  then
                        local time_brightness = lit.TimeBrightness.Value
                        local area_outdoor = lit.AreaOutdoor.Value
                        local area_fog = lit.AreaFog.Value
                        local color_shift = 0.4 + time_brightness * 0.6
                        lit.Brightness = time_brightness * lit.AreaBrightness.Value
                        lit.OutdoorAmbient = Color3.new(area_outdoor.r * color_shift, area_outdoor.g * color_shift, area_outdoor.b * color_shift)
                        lit.FogColor = Color3.new(area_fog.r * color_shift, area_fog.g * color_shift, area_fog.b * color_shift)
                    end
                end
            end
        end
    end
    
    -- UI
    do
        local window = library:Window({name = "sexhack"})
    
        do -- Combat
            local page_combat = window:Page({name = "combat"})
            local section_settings = page_combat:Section({name = "combat settings"})
    
            local no_stun_toggle = section_settings:Toggle({name = "no stun", default = cheat_client.config.no_stun, pointer = "no_stun"})
            --local active_cast_toggle = section_settings:Toggle({name = "active cast", default = cheat_client.config.active_cast, pointer = "active_cast"})
            local anti_hystericus_toggle = section_settings:Toggle({name = "no confusion", default = cheat_client.config.anti_confusion, pointer = "anti_hystericus"})
            --local anti_dsage_toggle = section_settings:Toggle({name = "no mana stop", default = cheat_client.config.anti_dsage, pointer = "anti_dsage"})
            --local infinite_dodge_toggle = section_settings:Toggle({name = "infinite fischeran dodge", default = cheat_client.config.fish_dodge, pointer = "fisch_dodge"})
            local perflora_teleport_toggle = section_settings:Toggle({name = "perflora teleport", default = cheat_client.config.perflora_teleport, pointer = "perflora_teleport"})
    
            section_settings:Label({name = "--"})
    
            local snap_cele_aimbot_toggle = section_settings:Toggle({name = "snap celeritas aimbot", default = cheat_client.config.cele_aimbot, pointer = "cele_aimbot"})
            local inferi_aimbot_toggle = section_settings:Toggle({name = "inferi aimbot", default = cheat_client.config.inferi_aimbot, pointer = "inferi_aimbot"})
            local armis_aimbot_toggle = section_settings:Toggle({name = "armis aimbot", default = cheat_client.config.armis_aimbot, pointer = "armis_aimbot"})
        end
    
        do -- Visuals
            local page_visuals = window:Page({name = "visuals"})
            local section_settings = page_visuals:Section({name = "visual settings"})
    
            do -- Player
                local player_toggle = section_settings:Toggle({name = "player esp", default = cheat_client.config.player_esp, pointer = "player_esp"})
                local player_name_toggle = section_settings:Toggle({name = "name", default = cheat_client.config.player_name, pointer = "player_name"})
                local player_box_toggle = section_settings:Toggle({name = "box", default = cheat_client.config.player_box, pointer = "player_box"})
                local player_health_toggle = section_settings:Toggle({name = "health", default = cheat_client.config.player_health, pointer = "player_health"})
                local player_tags_toggle = section_settings:Toggle({name = "tags", default = cheat_client.config.player_tags, pointer = "player_tags"})
                local player_intent_toggle = section_settings:Toggle({name = "intent", default = cheat_client.config.player_intent, pointer = "player_intent"})
                local player_range_slider = section_settings:Slider({name = "range", default = cheat_client.config.player_range, max = 9000, min = 0, tick = 100, pointer = "player_range"})
                
                section_settings:Label({name = "--"})
                
                -- Chams
                local player_chams_toggle = section_settings:Toggle({name = "player chams", default = cheat_client.config.player_chams, pointer = "player_chams"})
                local player_chams_fill_toggle = section_settings:Toggle({name = "chams filled", default = cheat_client.config.player_chams_fill, pointer = "player_chams_fill"})
                local player_chams_pulse_toggle = section_settings:Toggle({name = "chams pulse", default = cheat_client.config.player_chams_pulse, pointer = "player_chams_pulse"})
                local player_chams_occluded_toggle = section_settings:Toggle({name = "chams occluded", default = cheat_client.config.player_chams_occluded, pointer = "player_chams_occluded"})
                
                --local player_hv_toggle = section_settings:Toggle({name = "player healthview", default = cheat_client.config.player_healthview, pointer = "player_healthview"})
                --local player_hv_slider = section_settings:Slider({name = "range", default = cheat_client.config.player_hv_range, max = 300, min = 0, tick = 10, pointer = "player_hv_range"})
            end
    
            section_settings:Label({name = "--"})
    
            do -- Trinket
                local trinket_toggle = section_settings:Toggle({name = "trinket esp", default = cheat_client.config.trinket_esp, pointer = "trinket_esp"})
                local trinket_range_slider = section_settings:Slider({name = "range", default = cheat_client.config.trinket_range, max = 2000, min = 0, tick = 100, pointer = "trinket_range"})
            end
    
            section_settings:Label({name = "--"})
            
            do -- NPC Esp
                local fallion_toggle = section_settings:Toggle({name = "fallion esp", default = cheat_client.config.fallion_esp, pointer = "fallion_esp"})
                local npc_esp_toggle = section_settings:Toggle({name = "npc esp", default = cheat_client.config.npc_esp, pointer = "npc_esp"})
            end
            
            section_settings:Label({name = "--"})
    
            do -- Ingredient
                local ingredient_toggle = section_settings:Toggle({name = "ingredient esp", default = cheat_client.config.ingredient_esp, pointer = "ingredient_esp"})
                local ingredient_range_slider = section_settings:Slider({name = "range", default = cheat_client.config.ingredient_range, max = 2000, min = 0, tick = 100, pointer = "ingredient_range"})
            end
    
            section_settings:Label({name = "--"})
    
            do -- Ore
                local ore_toggle = section_settings:Toggle({name = "ore esp", default = cheat_client.config.ore_esp, pointer = "ore_esp"})
                local ore_range_slider = section_settings:Slider({name = "range", default = cheat_client.config.ore_range, max = 12000, min = 0, tick = 1000, pointer = "ore_range"})
            end
    
            section_settings:Label({name = "--"})
    
            do -- Enviroment
                local fullbright_toggle = section_settings:Toggle({name = "fullbright", default = cheat_client.config.fullbright, pointer = "fullbright", callback = function(state)
                    if state then
                        lit.Ambient = Color3.new(.8, .8, .8)
                        lit.OutdoorAmbient = Color3.new(.8, .8, .8)
                        lit.FogColor = Color3.fromRGB(254, 254, 254)
                        lit.FogEnd = 100000
                        lit.FogStart = 50
                    else
                        cheat_client:restore_ambience()
                    end
                end})
                local clock_toggle = section_settings:Toggle({name = "change time", default = cheat_client.config.change_time, pointer = "change_time", callback = function(state)
                    if state then
                        lit.ClockTime = shared.pointers["clock_time"] and shared.pointers["clock_time"]:Get()
                    end
                end})
                local clock_time_slider = section_settings:Slider({name = "time", default = cheat_client.config.clock_time, max = 24, min = 1, tick = 1, pointer = "clock_time"})
                local no_blindness_toggle = section_settings:Toggle({name = "no blindness", default = cheat_client.config.no_blindness, pointer = "no_blindness", callback = function(state)
                    if state then
                        lit:WaitForChild("Blindness").Enabled = false
                    else
                        lit:WaitForChild("Blindness").Enabled = true
                    end
                end})
                local no_blur_toggle = section_settings:Toggle({name = "no blur", default = cheat_client.config.no_blur, pointer = "no_blur", callback = function(state)
                    if state then
                        lit:WaitForChild("Blur").Enabled = false
                    else
                        lit:WaitForChild("Blur").Enabled = true
                    end
                end})
                local no_sanity_toggle = section_settings:Toggle({name = "no sanity", default = cheat_client.config.no_sanity, pointer = "no_sanity", callback = function(state)
                    if state then
                        lit:WaitForChild("Sanity").Enabled = false
                    else
                        lit:WaitForChild("Sanity").Enabled = true
                    end
                end})
            end
        end
    
        do -- Exploits 
            local page_exploits = window:Page({name = "exploits"})
            local section_settings = page_exploits:Section({name = "exploits settings"})
    
            do -- character
                --local no_curse_toggle = section_settings:Toggle({name = "no curse", default = cheat_client.config.no_curse, pointer = "no_curse"})
                --local anti_eat_toggle = section_settings:Toggle({name = "anti eat", default = cheat_client.config.anti_eat, pointer = "anti_eat"})
                --local no_frostbite_toggle = section_settings:Toggle({name = "no frostbite", default = cheat_client.config.no_frost, pointer = "no_frost"})
                local no_insane_toggle = section_settings:Toggle({name = "no insane", default = cheat_client.config.no_insane, pointer = "no_insanity"})
                local no_injury_toggle = section_settings:Toggle({name = "no injury", default = cheat_client.config.no_injury, pointer = "no_injury"})
                --local anti_vampirism_toggle = section_settings:Toggle({name = "anti vampirism", default = cheat_client.config.anti_vampirism, pointer = "anti_vampirism"})
    
                section_settings:Label({name = "--"})
    
                local reset_button = section_settings:Button({name = "reset", confirm = true, callback = function()
                    if plr.Character then
                        plr.Character.Humanoid.Health = 0;
                    end
                end})
            end
    
            section_settings:Label({name = "--"})
    
            do -- observe
                local observe_toggle = section_settings:Toggle({name = "observe", default = cheat_client.config.observe, pointer = "observe", callback = function(state)
                    if not state then
                        if plr.Character then
                            ws.CurrentCamera.CameraSubject = plr.Character
                            active_observe = nil
                        end
                    end
                end})
            end
        end
    
        do -- Movement
            local page_movement = window:Page({name = "movement"})
            local section_settings = page_movement:Section({name = "movement settings"})
    
            local flight_toggle = section_settings:Toggle({name = "flight", default = cheat_client.config.flight, pointer = "flight"})
            local flight_speed_slider = section_settings:Slider({name = "speed", default = cheat_client.config.flight_speed, max = 200, min = 0, tick = 50, pointer = "flight_speed"})
            -- CERESIAN FLY
        end
    
        do -- Automation 
            local page_automation = window:Page({name = "automation"})
            local section_settings = page_automation:Section({name = "automation settings"})
            
            local auto_bard_toggle = section_settings:Toggle({name = "auto bard", default = cheat_client.config.auto_bard, pointer = "auto_bard"})
            --local bard_stack_toggle = section_settings:Toggle({name = "bard stack", default = cheat_client.config.bard_stack, pointer = "bard_stack"})
            local hide_bard_toggle = section_settings:Toggle({name = "hide bard", default = cheat_client.config.hide_bard, pointer = "hide_bard"})
    
            section_settings:Label({name = "--"})
    
            local anti_afk_toggle = section_settings:Toggle({name = "anti afk", default = cheat_client.config.anti_afk, callback = function(state)
                for _, connection in next, getconnections(plr.Idled) do
                    if state then 
                        connection:Disable()
                    else 
                        connection:Enable()
                    end
                end
            end})
            local day_farm_toggle = section_settings:Toggle({name = "day farm", default = false, cheat_client.config.day_farm, pointer = "day_farm"})
            local day_farm_range_slider = section_settings:Slider({Name = "range", Min = 50, Max = 1000, default = 500, tick = 50, pointer = "day_farm_range"})
    
            section_settings:Label({name = "--"})
            
            local auto_trinket_toggle = section_settings:Toggle({name = "auto trinket", default = cheat_client.config.auto_trinket, pointer = "auto_trinket"})
            local auto_ingredient_toggle = section_settings:Toggle({name = "auto ingredient", default = cheat_client.config.auto_ingredient, pointer = "auto_ingredient"})
            local auto_bag_toggle = section_settings:Toggle({name = "auto bag", default = cheat_client.config.auto_bag, pointer = "auto_bag"})
            local bag_range_slider = section_settings:Slider({Name = "range", min = 1, max = 30, default = 15, tick = 1, pointer = "bag_range"})
            
            section_settings:Label({name = "--"})
            
            local loop_gain_orderly_toggle = section_settings:Toggle({name = "loop gain orderly", default = nil, pointer = "loop_orderly"})
            local auto_train_climb_toggle = section_settings:Toggle({name = "train climb", default = nil, pointer = "train_climb"})
        end
        
        do -- World
            local page_world = window:Page({name = "world"})
            local section_settings = page_world:Section({name = "world settings"})
                
            local freecam_toggle = section_settings:Toggle({name = "freecam", default = cheat_client.config.freecam, pointer = "freecam", callback = function(state)
                local camera = utility:GetCamera()
                if plr.character then
                    local humanoid, torso = plr.Character:FindFirstChildOfClass("Humanoid"), plr.Character:FindFirstChild("Torso")
            
                    if humanoid and torso then
                        if state then
                            camera.CameraType = Enum.CameraType.Scriptable
                            StartCapture()
                        else
                            camera.CameraType = Enum.CameraType.Custom
                            StopCapture()
                            camera.CameraSubject = humanoid
                        end
                    end
                end
            end})
            local freecam_speed_slider = section_settings:Slider({name = "freecam speed", default = cheat_client.config.freecam_speed, max = 12, min = 0, tick = 1, pointer = "freecam_speed"})
            
            section_settings:Label({name = "--"})
            
            local no_kill_bricks_toggle = section_settings:Toggle({name = "no kill bricks", default = cheat_client.config.no_killbrick, pointer = "no_killbrick", callback = function(state)
                if state then
                    for i,v in next, game.Workspace.Map:GetChildren() do
                        if v:FindFirstChild("TouchInterest") and v.Name ~= "Fire" and v.Name ~= "OrderField" and v.Name ~= "SolanBall" and v.Name ~= "SolansGate"  and v.Name ~= "BaalField" and v.Name ~= "Elevator" and v.Name ~= "MageField" and v.Name ~= "TeleportIn" and v.Name ~= "TeleportOut" then
                            v.CanTouch = false
                        end
                    end
                else
                    for i,v in next, game.Workspace.Map:GetChildren() do
                        if v:FindFirstChild("TouchInterest") and v.Name ~= "Fire" and v.Name ~= "OrderField" and v.Name ~= "SolanBall" and v.Name ~= "SolansGate"  and v.Name ~= "BaalField" and v.Name ~= "Elevator" and v.Name ~= "MageField" and v.Name ~= "TeleportIn" and v.Name ~= "TeleportOut" then
                            v.CanTouch = true
                        end
                    end
                end
            end})
            if game.PlaceId == 5208655184 then
                local no_fall_damage_toggle = section_settings:Toggle({name = "no fall damage", default = cheat_client.config.no_fall, pointer = "no_fall"})
            end
        end
        
        do -- ps (Private Server)
            local page_ps = window:Page({name = "private server"})
            local section_settings = page_ps:Section({name = "ps servers"})
            
            local _555985b2 = section_settings:Button({name = "555985b2", confirm = true, callback = function()
                if cs:HasTag(plr.Character, "Danger") and not shared.pointers["ignore_danger"]:Get() then
                    while cs:HasTag(plr.Character, "Danger") do
                        rs.Heartbeat:Wait()
                        if not cs:HasTag(plr.Character, "Danger") or shared.pointers["ignore_danger"]:Get() then
                            break
                        end
                    end
                end
                game:GetService("ReplicatedStorage").Requests.JoinPrivateServer:FireServer("555985b2")
            end})
            
            local _3cb81d2e = section_settings:Button({name = "3cb81d2e", confirm = true, callback = function()
                if cs:HasTag(plr.Character, "Danger") and not shared.pointers["ignore_danger"]:Get() then
                    while cs:HasTag(plr.Character, "Danger") do
                        rs.Heartbeat:Wait()
                        if not cs:HasTag(plr.Character, "Danger") or shared.pointers["ignore_danger"]:Get() then
                            break
                        end
                    end
                end
                game:GetService("ReplicatedStorage").Requests.JoinPrivateServer:FireServer("3cb81d2e")
            end})
            
            local _14f4f6a3 = section_settings:Button({name = "14f4f6a3", confirm = true, callback = function()
                if cs:HasTag(plr.Character, "Danger") and not shared.pointers["ignore_danger"]:Get() then
                    while cs:HasTag(plr.Character, "Danger") do
                        rs.Heartbeat:Wait()
                        if not cs:HasTag(plr.Character, "Danger") or shared.pointers["ignore_danger"]:Get() then
                            break
                        end
                    end
                end
                game:GetService("ReplicatedStorage").Requests.JoinPrivateServer:FireServer("14f4f6a3")
            end})
        end
        
        do -- Network
            local page_network = window:Page({name = "network"})
            local section_settings = page_network:Section({name = "network settings"})
            
            local lag_server_toggle = section_settings:Toggle({name = "lag server", default = cheat_client.config.lag_server, pointer = "lag_server"})
        end
        
        do -- Misc
            local page_misc = window:Page({name = "misc"})
            local section_settings = page_misc:Section({name = "misc settings"})
    
            local the_soul_toggle = section_settings:Toggle({name = "spoof the soul", default = cheat_client.config.the_soul, pointer = "spoof_the_soul"})
            local double_jump_toggle = section_settings:Toggle({name = "spoof double jump", default = cheat_client.config.double_jump, pointer = "spoof_acrobat"})
    
            section_settings:Label({name = "--"})
            
            local copy_leaderboard_button = section_settings:Button({name = "copy leaderboard", callback = function()
                local result = ""
                
                for _, player in next, plrs:GetPlayers() do
                    result ..= cheat_client:get_name(player).."    ["..player.Name.."]  https://www.roblox.com/users/"..tostring(player.UserId).."/profile\n"
                end
    
                setclipboard(result)
            end})
            local log_button = section_settings:Button({name = "shutdown client", confirm = true, callback = function()
                if cs:HasTag(plr.Character, "Danger") and not shared.pointers["ignore_danger"]:Get() then
                    while cs:HasTag(plr.Character, "Danger") do
                        rs.Heartbeat:Wait()
                        if not cs:HasTag(plr.Character, "Danger") or shared.pointers["ignore_danger"]:Get() then
                            break
                        end
                    end
                end
    
                game:GetService("Players").LocalPlayer:Kick("Shutdown")
                game:Shutdown();
            end})
            local serverhop_button = section_settings:Button({name = "serverhop", confirm = true, callback = function()
                if cs:HasTag(plr.Character, "Danger") and not shared.pointers["ignore_danger"]:Get() then
                    while cs:HasTag(plr.Character, "Danger") do
                        rs.Heartbeat:Wait()
                        if not cs:HasTag(plr.Character, "Danger") or shared.pointers["ignore_danger"]:Get() then
                            break
                        end
                    end
                end
                
                utility:Serverhop()
            end})
            local ignore_danger_toggle = section_settings:Toggle({name = "ignore danger", default = cheat_client.config.ignore_danger, pointer = "ignore_danger"})
            
            section_settings:Label({name = "--"})
    
            local roblox_chat_toggle = section_settings:Toggle({name = "roblox chat", default = cheat_client.config.roblox_chat, callback = function(state)
                local Chat = plr.PlayerGui:FindFirstChild("Chat");
                Chat.Frame.ChatChannelParentFrame.Visible = state
                Chat.Frame.ChatChannelParentFrame.Size = UDim2.new(1, 0, 1, -46)
                Chat.Frame.ChatChannelParentFrame.Position = UDim2.new(0, 0, 0, 2)
                Chat.Frame.ChatBarParentFrame.Position = UDim2.new(0, 0, 1, -42)
                if not state then
                    Chat.Frame.ChatBarParentFrame.Position = UDim2.new(0, 0, 0, 0)
                    Chat.Frame.ChatChannelParentFrame.Position = UDim2.new(0, 0, 0, 0)
                    Chat.Frame.ChatChannelParentFrame.Size = UDim2.new(0, 0, 0, 0)
                end
            end})
            local unhide_player_toggle = section_settings:Toggle({name = "unhide players", default = cheat_client.config.unhide_players, callback = function(state)
                for i,v in pairs(game.Players:GetPlayers()) do
                    if v:GetAttribute('Hidden','true') then
                        v:SetAttribute('Hidden',false)
                    end
                end
                if not state then
                    for i,v in pairs(game.Players:GetPlayers()) do
                        if v.Character then
                            if v.Backpack:FindFirstChild('Jack') or v.Character:FindFirstChild('Jack') then
                                v:SetAttribute('Hidden',true)
                            end
                        end
                    end
                end
            end})
            
            local gate_anti_toggle = section_settings:Toggle({name = "gate anti backfire", default = cheat_client.config.gate_anti_backfire, pointer = "gate_anti_backfire"})
            
            section_settings:Label({name = "--"})
    
            local inventory_value = section_settings:Label({name = "", pointer = "inventory_value"})
            local rune_value = section_settings:Label({name = "", pointer = "rune_check"})
            local players_value = section_settings:Label({name = "players: "..#plrs:GetPlayers(), pointer = "plrs_server"})
        end
    
        do -- ui
            local page_ui = window:Page({name = "ui"})
            local section_settings = page_ui:Section({name = "ui settings"})
            
            local white_accent = section_settings:Button({name = "white accent", callback = function()
                utility:ChangeAccent(Color3.fromRGB(255,255,255))
            end})
            local blue_accent = section_settings:Button({name = "blue accent", callback = function()
                utility:ChangeAccent(Color3.fromRGB(105, 215, 255))
            end})
            local orange_accent = section_settings:Button({name = "purple accent", callback = function()
                utility:ChangeAccent(Color3.fromRGB(155, 39, 222))
            end})
            local pink_accent = section_settings:Button({name = "pink accent", callback = function()
                utility:ChangeAccent(Color3.fromRGB(255, 140, 236))
            end})
            local green_accent = section_settings:Button({name = "green accent", callback = function()
                utility:ChangeAccent(Color3.fromRGB(0,255,0))
            end})
            local red_accent = section_settings:Button({name = "orange accent", callback = function()
                utility:ChangeAccent(Color3.fromRGB(255, 175, 25))
            end})
            local white_accent = section_settings:Button({name = "default accent", callback = function()
                utility:ChangeAccent(Color3.fromRGB(255, 0, 0))
            end})
        end
        
        do -- Config
            local page_misc = window:Page({name = "config"})
            local section_settings = page_misc:Section({name = "config settings"})
    
            local save_config_button = section_settings:Button({name = "save config", confirm = true, callback = function()
                utility:SaveConfig()
            end})
            local load_config_button = section_settings:Button({name = "load config", callback = function()
                utility:LoadConfig(shared.pointers["config_slot"]:Get())
            end})
            local config_slot_list = section_settings:List({name = "config slot", options = {"slot1.sex", "slot2.sex", "slot3.sex"}, default = 1, pointer = "config_slot"})
            
            section_settings:Label({name = "--"})
            
            local discord_join_button = section_settings:Button({name = "join discord", callback = function()
                local json = {
                    ["cmd"] = "INVITE_BROWSER",
                    ["args"] = {
                    ["code"] = "tu9JKPqbNR"
                },
                    ["nonce"] = 'a'
                }
                
                local a = syn.request({
                    Url = 'http://127.0.0.1:6463/rpc?v=1',
                    Method = 'POST',
                    Headers = {
                    ['Content-Type'] = 'application/json',
                    ['Origin'] = 'https://discord.com'
                },
                Body = game:GetService('HttpService'):JSONEncode(json)}).Body
            end})
        end
    end
    
    -- Hooks
    do
        do -- Collection Hooks
          LPH_NO_VIRTUALIZE(function()
            old_hastag = hookfunction(cs.HasTag, function(self, object, tag)
                if not checkcaller() then
                    if object == plr.Character then
                        if tag == "Acrobat" and shared.pointers["spoof_acrobat"]:Get() then
                            return true
                        elseif tag == "The Soul" and shared.pointers["spoof_the_soul"]:Get() then
                            return true
                        elseif tag == "BrokenLeg" and shared.pointers["no_injury"]:Get() then
                            return false
                        elseif tag == "BrokenArm" and shared.pointers["no_injury"]:Get() then
                            return false
                        elseif tag == "Armless" and shared.pointers["no_injury"]:Get() then
                            return false
                        end
                    end
                end
                return old_hastag(self, object, tag)
            end)
          end)
        end
    
        do -- Anti Cheat Hooks
          LPH_NO_VIRTUALIZE(function()
            old_destroy = hookfunction(ws.Destroy, function(Self) -- Character Handler Destructor
                if not checkcaller() then
                    if tostring(Self) == "CharacterHandler" then 
                        return
                    end
                end
                
                return old_destroy(Self)
            end)
            
            local Metatable = getrawmetatable(game)
            local OldIndex = Metatable.__index
            
            setreadonly(Metatable, false)
            
            Metatable.__index = newcclosure(function(Self, Index)
                if tostring(Self) == "Stats" and tostring(Index) == "DataSendKbps" and not checkcaller() then
                    return (math.random(1,5))
                end
                return OldIndex(Self, Index)
            end)
            
            setreadonly(Metatable, true)
    
            for _,v in pairs(getconnections(game:GetService("ScriptContext").Error)) do
                v:Disable()
            end
          end)
        end
    end
    
    -- Init
    do
        do -- Network
          task.spawn(function()
            while true do
              task.wait()

              if shared and shared.pointers["lag_server"]:Get() then
                task.wait(0.6)

                game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge)

                local function getmaxvalue(val)
                    local mainvalueifonetable = 499999
                    if type(val) ~= "number" then
                        return nil
                    end
                    local calculateperfectval = (mainvalueifonetable/(val+2))
                    return calculateperfectval
                end
                
                local function bomb(tableincrease, tries)
                    local maintable = {}
                    local spammedtable = {}
                    
                    table.insert(spammedtable, {})
                    z = spammedtable[1]
                    
                    for i = 1, tableincrease do
                        local tableins = {}
                        table.insert(z, tableins)
                        z = tableins
                    end
                    
                    local calculatemax = getmaxvalue(tableincrease)
                    local maximum
                    
                    if calculatemax then
                        maximum = calculatemax
                    else
                        maximum = 999999
                    end
                    
                    for i = 1, maximum do
                        table.insert(maintable, spammedtable)
                    end
                    
                    for i = 1, tries do
                        game.RobloxReplicatedStorage.SetPlayerBlockList:FireServer(maintable)
                    end
                end
                
                bomb(250, 3)
              end
            end
          end)
        end

        do -- Disable Input Keys
            cas:BindActionAtPriority("DisableInputKeys", function()
                return Enum.ContextActionResult.Sink
            end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Up, Enum.KeyCode.Down, Enum.KeyCode.Left, Enum.KeyCode.Right, Enum.KeyCode.PageUp, Enum.KeyCode.PageDown)
        end
        
        do -- No Fall Damage & Anti Gate Backfire
            if game.PlaceId ~= 3541987450 then
              LPH_NO_VIRTUALIZE(function()
                local o;
                o = hookfunction(Instance.new("RemoteEvent").FireServer, function(Event, ...)
                	local args = {...}
                	if shared and shared.pointers["no_fall"]:Get() and plr.Character and plr.Character:FindFirstChild'CharacterHandler' and plr.Character.CharacterHandler:FindFirstChild('Remotes') and Event.Parent == plr.Character.CharacterHandler.Remotes then
                		if #args == 2 and typeof(args[2]) == "table" then
                			return nil
                		end
                	end

                	if shared and shared.pointers["gate_anti_backfire"]:Get() and tostring(Event):match("RightClick") then
                        if plr.Character then
                            if plr.Character:FindFirstChild('Gate') then
                                local artifacts_folder = plr.Character:FindFirstChild("Artifacts")
                                if artifacts_folder and artifacts_folder:FindFirstChild("PhilosophersStone") then
                                    return Event:FireServer(...)
                                end
                                
                                local mana_instance = plr.Character:FindFirstChild('Mana')
                                if mana_instance then
                                    local mana_value = mana_instance.Value;
                                    
                                    if (mana_value > 75 and mana_value < 80) or not game:GetService('CollectionService'):HasTag(plr.Character,'Danger') and plr.Character:FindFirstChild("AzaelHorn") then
                                        return Event:FireServer(...)
                                    end
                                    
                                  return
                              end
                          end
                      end
                  end

                	return o(Event, ...)
                end)
              end)
            end
        end
        
        do -- Flight
            utility:Connection(rs.RenderStepped, function()
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("FakeHumanoid",true) then
                    local camCFrame = workspace.CurrentCamera.CFrame
                    local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
                    
                    if shared.pointers["flight"]:Get() then
                        if not cheat_client.custom_flight_functions["GetFocusedTextBox"](uis) then
                            local eVector = Vector3.new()
                            local rVector, lVector, uVector = camCFrame.RightVector, camCFrame.LookVector, camCFrame.UpVector
                            if cheat_client.custom_flight_functions["IsKeyDown"](uis, "W") then
                                eVector = eVector + lVector
                            end
                            if cheat_client.custom_flight_functions["IsKeyDown"](uis, "S") then
                                eVector = eVector - lVector
                            end
                            if cheat_client.custom_flight_functions["IsKeyDown"](uis, "D") then
                                eVector = eVector + rVector
                            end
                            if cheat_client.custom_flight_functions["IsKeyDown"](uis, "A") then
                                eVector = eVector - rVector
                            end
                            if cheat_client.custom_flight_functions["IsKeyDown"](uis, "Space") then
                                eVector = eVector + uVector
                            end
                            if cheat_client.custom_flight_functions["IsKeyDown"](uis, "LeftShift") then
                                eVector = eVector - uVector
                            end
                            if eVector.Unit.X == eVector.Unit.X then
                                rootPart.AssemblyLinearVelocity  = eVector.Unit * shared.pointers["flight_speed"]:Get()
                            end
                            rootPart.Anchored = eVector == Vector3.new()
                        end
                    else
                        rootPart.Anchored = false
                    end
                end
            end)
        end
    
        do -- Init Character
            if plr.Character then
                local boosts = plr.Character:WaitForChild("Boosts")
                
                --[[
                -- Frostbite
                if plr.Character:FindFirstChild('Frostbitten') and shared.pointers["no_frost"]:Get() then
                    plr.Character.Frostbitten:Destroy()
                end
    
                -- Anti Eat
                if plr.Character:FindFirstChild('BeingEaten') and shared.pointers["anti_eat"]:Get() then
                    plr.Character.BeingEaten:Destroy()
                end
    
                -- Anti DSage
                if plr.Character:FindFirstChild('ManaStop') and shared.pointers["anti_dsage"]:Get() then
                    plr.Character.ManaStop:Destroy()
                end
                --]]
    
                -- Anti Hystericus
                if plr.Character:FindFirstChild('Confused') and shared.pointers["anti_hystericus"]:Get() then
                    plr.Character.Confused:Destroy()
                end
    
                -- Physical Injury
                for _,v in pairs(plr.Character:GetChildren()) do
                    if v.Name == "BrokenLeg" or v.Name == "BrokenRib" or v.Name == "BrokenArm" and shared.pointers["no_injury"]:Get() then
                        v:Destroy()
                    end
                end
    
                -- Mental Injury
                for _,v in pairs(plr.Character:GetChildren()) do
                    if v.Name == "PsychoInjury" or v.Name == "Hallucinations" or v.Name == "AttackExcept" or v.Name == "Whispering" or v.Name == "Quivering" or v.Name == "NoControl" or v.Name == "Careless" or v.Name == "Maniacal" or v.Name == "Fearful" and shared.pointers["no_insanity"]:Get() then
                        v:Destroy()
                    end
                end
        
                utility:Connection(plr.Character.ChildAdded, function(obj)
                    --[[
                    -- Active Cast
                    if obj.Name == 'ActiveCast' and shared.pointers["active_cast"]:Get() then
                        task.wait()
                        obj:Destroy()
                        return
                    end
        
                    -- Frostbite
                    if obj.Name == "Frostbitten" and shared.pointers["no_frost"]:Get() then
                        task.wait()
                        obj:Destroy()
                        return
                    end
    
                    -- Curse
                    if obj.Name == "CurseMP" and shared.pointers["no_curse"]:Get() then
                        task.wait()
                        obj:Destroy()
                        return
                    end
    
                    -- Anti Eat
                    if obj.Name == "BeingEaten" and shared.pointers["anti_eat"]:Get() then
                        task.wait()
                        obj:Destroy()
                        return
                    end  
        
                    -- Anti DSage
                    if obj.Name == 'ManaStop' and shared.pointers["anti_dsage"]:Get() then
                        task.wait()
                        obj:Destroy()
                        return
                    end
                    --]]
    
                    -- Anti Hystericus
                    if obj.Name == 'Confused' and shared.pointers["anti_hystericus"]:Get() then
                        task.wait()
                        obj:Destroy()
                        return
                    end
        
                    -- Physical Injury
                    if cheat_client.physical_injuries[obj.Name] and shared.pointers["no_injury"]:Get() then
                        task.wait()
                        obj:Destroy()
                        return
                    end
    
                    -- Mental Injury
                    if cheat_client.mental_injuries[obj.Name] and shared.pointers["no_insanity"]:Get() then
                        task.wait()
                        obj:Destroy()
                        return
                    end
        
                    -- No Stun
                    if cheat_client.stuns[obj.Name] and shared.pointers["no_stun"]:Get() then
                        task.wait()
                        obj:Destroy()
                        return
                    end
                end)
        
                utility:Connection(boosts.ChildAdded, function(obj)
                    --[[
                    if obj.Name == "MusicianBuff" and shared.pointers["bard_stack"]:Get() and obj.Value ~= "Symphony of Horses" and obj.Value ~= "Song of Lethargy" then
                        task.wait()
                        obj:Destroy()
                        return
                    end
                    --]]
        
                    if obj.Name == "SpeedBoost" and shared.pointers["no_stun"]:Get()  then
                        task.wait()
                        obj:Destroy()
                        return
                    end
                end)
            end
        end
    
        do -- Init ESP
            do -- Player
                for _,v in next, plrs:GetPlayers() do
                    if v ~= plr then
                        task.spawn(cheat_client.add_player_esp, cheat_client, v)
                    end
                end
                --[[
                if shared.pointers["player_healthview"]:Get() then
                       for _,v in pairs(workspace.Live:GetChildren()) do
                        if v ~= plr.Character then
                            local z = v:FindFirstChildWhichIsA("Humanoid")
                            if z then
                                z.HealthDisplayType = Enum.HumanoidHealthDisplayType.DisplayWhenDamaged
                                if v:FindFirstChild("MonsterInfo") then
                                    z.NameDisplayDistance = 0
                                end
                                z.HealthDisplayDistance = 80 -- shared.pointers["player_hv_range"]:Get()
                                z.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Subject
                            end
                        end
                    end
                    utility:Connection(workspace.Live.ChildAdded, function(ch)
                        if ch ~= plr.Character then
                            local z = ch:WaitForChild("Humanoid",3)
                            if z then
                                z.HealthDisplayType = Enum.HumanoidHealthDisplayType.DisplayWhenDamaged
                                if ch:FindFirstChild("MonsterInfo") then
                                    z.NameDisplayDistance = 0
                                end
                                z.HealthDisplayDistance = 80 -- shared.pointers["player_hv_range"]:Get()
                                z.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Subject
                            end
                        end
                    end)
                end
                --]]
            end
    
            do -- Trinket
                for _, object in next, ws:GetChildren() do
                    if object.Name == "Part" and object:FindFirstChild("ID") then
                        local trinket_name, trinket_color, trinket_zindex = cheat_client:identify_trinket(object)
                        cheat_client:add_trinket_esp(object, trinket_name, trinket_color, trinket_zindex)
                    end
                end
            end
    
            do -- Fallion
                for _,object in next, ws.NPCs:GetChildren() do
                    if object.Name == "Fallion" then
                        cheat_client:add_fallion_esp(object,object.Name)
                    end
                end
            end
            
            do -- NPC Esp
                for _, object in next, ws.NPCs:GetChildren() do
                    if object:FindFirstChild('Pants') and object:FindFirstChild('Humanoid') and object:FindFirstChild('Torso') then
                        cheat_client:add_npc_esp(object,object.Name)
                    end
                end
            end
            
            do -- Ingredient
                if game.PlaceId ~= 3541987450 then
                    for index, instance in next, ws:GetChildren() do
                        if ingredient_folder then 
                            break
                        end
            
                        if instance.ClassName == "Folder" then
                            for index, ingredient in next, instance:GetChildren() do
                                if ingredient.ClassName == "UnionOperation" and ingredient:FindFirstChild("ClickDetector") and ingredient:FindFirstChild("Blacklist") then
                                    ingredient_folder = instance
                                    break
                                end
                            end
                        end
                    end
        
                    if ingredient_folder then
                        for _,object in next, ingredient_folder:GetChildren() do
                            local ingredient_name = cheat_client:identify_ingredient(object)
                            cheat_client:add_ingredient_esp(object, ingredient_name)
                        end
                    end
                end
            end
    
            do -- Ore
                for _,object in next, ws.Ores:GetChildren() do
                    if object.Transparency == 0 then
                        cheat_client:add_ore_esp(object)
                    end
                end
            end
        end
    
        do -- Init Bard
            if plr.PlayerGui:FindFirstChild("BardGui") then
                utility:Connection(plr.PlayerGui.BardGui.ChildAdded, function(child)
                    if shared.pointers["auto_bard"]:Get() then
                        if child:IsA("ImageButton") and child.Name == "Button" then
                            if shared.pointers["hide_bard"]:Get() then
                                plr.PlayerGui.BardGui.Enabled = false
                            else
                                child.Parent.Enabled = true
                            end
                            task.wait(.9 + ((math.random(3, 11) / 100)))
                            firesignal(child.MouseButton1Click)
                        end
                    end
                end)
            end
        end
    
        do -- Init Illu Checker
            for _, player in next, plrs:GetPlayers() do
                if player.Character and player:FindFirstChild("Backpack") then
    
                    local observe_tool = player.Backpack:FindFirstChild("Observe") or player.Character:FindFirstChild("Observe")
    
                    if observe_tool then 
                        if (library ~= nil and library.Notify) then
                            library:Notify(cheat_client:get_name(player).." ["..player.Name.."] is an illusionist", Color3.fromRGB(5,139,252))
    
                            utility:Connection(observe_tool:WaitForChild("Script"):WaitForChild('NameVal').Changed, function(value)
                                local target_player = plrs:FindFirstChild(value)
                                if not target_player then
                                    library:Notify(cheat_client:get_name(player).." has stopped observing", Color3.fromRGB(255,0,0))
                                else
                                    if target_player.Name == plr.Name then
                                        library:Notify(cheat_client:get_name(player).." IS OBSERVING YOU", Color3.fromRGB(255,0,0))
                                    else
                                        library:Notify(cheat_client:get_name(player).." is observing "..cheat_client:get_name(target_player), Color3.fromRGB(5,139,252))
                                    end
                                end
                            end)
                        end
                    else
                        local waiting_connection 
                        waiting_connection = utility:Connection(player.Backpack.ChildAdded, function(child)
                            if child.Name == "Observe" then
                                waiting_connection:Disconnect()
                                observe_tool = child
                                utility:Connection(observe_tool:WaitForChild("Script"):WaitForChild('NameVal').Changed, function(value)
                                    local target_player = plrs:FindFirstChild(value)
                                    if not target_player then
                                        library:Notify(cheat_client:get_name(player).." has stopped observing", Color3.fromRGB(255,0,0))
                                    else
                                        if target_player.Name == plr.Name then
                                            library:Notify(cheat_client:get_name(player).." IS OBSERVING YOU", Color3.fromRGB(255,0,0))
                                        else
                                            library:Notify(cheat_client:get_name(player).." is observing "..cheat_client:get_name(target_player), Color3.fromRGB(5,139,252))
                                        end
                                    end
                                end)
                            end
                        end)
                    end
                end
    
                utility:Connection(player.CharacterAdded, function(character)
                    task.wait(3)
                    local observe_tool = player.Backpack:FindFirstChild("Observe") or character:FindFirstChild("Observe")
    
                    if observe_tool then 
                        if (library ~= nil and library.Notify) then
                            library:Notify(cheat_client:get_name(player).." ["..player.Name.."] is an illusionist", Color3.fromRGB(5,139,252))
    
                            utility:Connection(observe_tool:WaitForChild("Script"):WaitForChild('NameVal').Changed, function(value)
                                local target_player = plrs:FindFirstChild(value)
                                if not target_player then
                                    library:Notify(cheat_client:get_name(player).." has stopped observing", Color3.fromRGB(255,0,0))
                                else
                                    if target_player.Name == plr.Name then
                                        library:Notify(cheat_client:get_name(player).." IS OBSERVING YOU", Color3.fromRGB(255,0,0))
                                    else
                                        library:Notify(cheat_client:get_name(player).." is observing "..cheat_client:get_name(target_player), Color3.fromRGB(5,139,252))
                                    end
                                end
                            end)
                        end
                    else
                        local waiting_connection 
                        waiting_connection = utility:Connection(player.Backpack.ChildAdded, function(child)
                            if child.Name == "Observe" then
                                waiting_connection:Disconnect()
                                observe_tool = child
                                utility:Connection(observe_tool:WaitForChild("Script"):WaitForChild('NameVal').Changed, function(value)
                                    local target_player = plrs:FindFirstChild(value)
                                    if not target_player then
                                        library:Notify(cheat_client:get_name(player).." has stopped observing", Color3.fromRGB(255,0,0))
                                    else
                                        if target_player.Name == plr.Name then
                                            library:Notify(cheat_client:get_name(player).." IS OBSERVING YOU", Color3.fromRGB(255,0,0))
                                        else
                                            library:Notify(cheat_client:get_name(player).." is observing "..cheat_client:get_name(target_player), Color3.fromRGB(5,139,252))
                                        end
                                    end
                                end)
                            end
                        end)
                    end
                end)
            end
        end
        
        do -- Init Artifact Checker
            for _, player in pairs(plrs:GetPlayers()) do
                if player.Character then
                    if (library ~= nil and library.Notify) then
                        for i,v in pairs(player.Backpack:GetChildren()) do
                            if table.find(cheat_client.artifacts, v.Name) then
                                library:Notify(cheat_client:get_name(player).." ["..player.Name.."] has a "..v.Name, Color3.fromRGB(255,0,179))
                            end
                        end
                        utility:Connection(player.Backpack.ChildAdded, function(child)
                                if table.find(cheat_client.artifacts, child.Name) then
                                    library:Notify(cheat_client:get_name(player).." ["..player.Name.."] has a "..child.Name, Color3.fromRGB(255,0,179))
                                end
                            end)
                        utility:Connection(player.CharacterAdded, function(character)
                            for _,v in pairs(player.Backpack:GetChildren()) do
                                if table.find(cheat_client.artifacts, v.Name) then
                                    library:Notify(cheat_client:get_name(player).." ["..player.Name.."] has a "..v.Name, Color3.fromRGB(255,0,179))
                                end
                            end
                            utility:Connection(player.Backpack.ChildAdded, function(child)
                                if table.find(cheat_client.artifacts, child.Name) then
                                    library:Notify(cheat_client:get_name(player).." ["..player.Name.."] has a "..child.Name, Color3.fromRGB(255,0,179))
                                end
                            end)
                        end)
                    end
                end
            end
        end
    
        do -- Mod detection
            for _, player in next, plrs:GetPlayers() do
                task.spawn(cheat_client.detect_mod, cheat_client, player)
            end
        end
    end
    
    -- Connections
    do
        do -- Player ESP
            utility:Connection(plrs.PlayerAdded, function(player)
                task.spawn(cheat_client.add_player_esp, cheat_client, player)
            end)
        end
    
        do -- Trinket ESP
            utility:Connection(ws.ChildAdded, function(object)
                if object.Name == "Part" and object:FindFirstChild("ID") then
                    local trinket_name, trinket_color, trinket_zindex = cheat_client:identify_trinket(object)
                    cheat_client:add_trinket_esp(object, trinket_name, trinket_color, trinket_zindex)
                end
            end)
        end
    
        do -- Ingredient ESP
            if game.PlaceId ~= 3541987450 then
                if ingredient_folder then
                    utility:Connection(ingredient_folder.ChildAdded, function(object)
                        local ingredient_name = cheat_client:identify_ingredient(object)
                        cheat_client:add_ingredient_esp(object, ingredient_name)
                    end)
                end
            end
        end
    
        do -- Ore ESP
            utility:Connection(ws.Ores.ChildAdded, function(object)
                if object.Transparency == 0 then
                    cheat_client:add_ore_esp(object)
                end
            end)
        end
    
        do -- Character
            utility:Connection(plr.CharacterAdded, function(char)
                local boosts = char:WaitForChild("Boosts")
                
                utility:Connection(plr.Character.ChildAdded, function(obj)
                    --[[
                    -- Active Cast
                    if obj.Name == 'ActiveCast' and shared.pointers["active_cast"]:Get() then
                        task.wait()
                        obj:Destroy()
                        return
                    end
        
                    -- Frostbite
                    if plr.Character:FindFirstChild('Frostbitten') and shared.pointers["no_frost"]:Get() then
                        plr.Character.Frostbitten:Destroy()
                    end
                    if obj.Name == "Frostbitten" and shared.pointers["no_frost"]:Get() then
                        task.wait()
                        obj:Destroy()
                        return
                    end
    
                    -- Curse
                    if obj.Name == "CurseMP" and shared.pointers["no_curse"]:Get() then
                        task.wait()
                        obj:Destroy()
                        return
                    end
    
                    -- Anti Eat
                    if obj.Name == "BeingEaten" and shared.pointers["anti_eat"]:Get() then
                        task.wait()
                        obj:Destroy()
                        return
                    end
                        
                    -- Anti DSage
                    if obj.Name == 'ManaStop' and shared.pointers["anti_dsage"]:Get() then
                        task.wait()
                        obj:Destroy()
                        return
                    end
                    --]]
    
                    -- Anti Hystericus
                    if obj.Name == 'Confused' and shared.pointers["anti_hystericus"]:Get() then
                        task.wait()
                        obj:Destroy()
                        return
                    end
        
                    -- Physical Injury
                    if cheat_client.mental_injuries[obj.Name] and shared.pointers["no_injury"]:Get() then
                        task.wait()
                        obj:Destroy()
                        return
                    end
    
                    -- Mental Injury
                    if cheat_client.mental_injuries[obj.Name] and shared.pointers["no_insanity"]:Get() then
                        task.wait()
                        obj:Destroy()
                        return
                    end
        
                    -- No Stun
                    if cheat_client.stuns[obj.Name] and shared.pointers["no_stun"]:Get() then
                        task.wait()
                        obj:Destroy()
                        return
                    end
                end)
        
                utility:Connection(boosts.ChildAdded, function(obj)
                    --[[
                    if obj.Name == "MusicianBuff" and shared.pointers["bard_stack"]:Get() and obj.Value ~= "Symphony of Horses" and obj.Value ~= "Song of Lethargy" then
                        task.wait()
                        obj:Destroy()
                        return
                    end
                    --]]
        
                    if obj.Name == "SpeedBoost" and shared.pointers["no_stun"]:Get()  then
                        task.wait()
                        obj:Destroy()
                        return
                    end
                end)
            end)
        end
    
        do -- Bard
            utility:Connection(plr.PlayerGui.ChildAdded, function(child)
                if child.Name == "BardGui" then
                    utility:Connection(child.ChildAdded, function(child)
                        if shared.pointers["auto_bard"]:Get() then
                            if child:IsA("ImageButton") and child.Name == "Button" then
                                if shared.pointers["hide_bard"]:Get() then
                                    plr.PlayerGui.BardGui.Enabled = false
                                else
                                    child.Parent.Enabled = true
                                end
                                task.wait(.9 + ((math.random(3, 11) / 100)))
                                firesignal(child.MouseButton1Click)
                            end
                        end
                    end)
                end
            end)
        end
    
        do -- Observe
            if game.PlaceId == 3541987450 then
                workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                if plr.PlayerGui and plr.PlayerGui:FindFirstChild('LeaderboardGui') then
                    plr.PlayerGui.LeaderboardGui.Enabled = true
                    utility:Connection(plr.PlayerGui.LeaderboardGui:GetPropertyChangedSignal("Enabled"), function()
                        plr.PlayerGui.LeaderboardGui.Enabled = true;
                    end)
                end
            end
                
            local leaderboard_frame = plr:WaitForChild("PlayerGui", 9e9):WaitForChild("LeaderboardGui", 9e9):WaitForChild("MainFrame", 9e9):WaitForChild("ScrollingFrame", 9e9)
            local current_observe = nil
    
            utility:Connection(uis.InputBegan, function(input, proccessed)
                if proccessed then
                    return
                end
    
                if not shared.pointers["observe"]:Get() then
                    if plr.Character then
                        ws.CurrentCamera.CameraSubject = plr.Character
                        active_observe = nil
                        return
                    end
                end
    
                if input.UserInputType == Enum.UserInputType.MouseButton3 then
                    if game.PlaceId == 3541987450 then
                        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                    end
                    current_observe = nil
    
                    if utility:IsHoveringFrame(leaderboard_frame) then
                        for _,v in next, leaderboard_frame:GetChildren() do
                            if utility:IsHoveringFrame(v) then
                                local text = v.Text:gsub("\226\128\142", "")
                                local player = plrs:FindFirstChild(text)
                                current_observe = player ~= nil and player or nil
                                break
                            end
                        end
                    end
    
                    if current_observe ~= nil then
                        if current_observe ~= active_observe then
                            if current_observe.Character then
                                ws.CurrentCamera.CameraSubject = current_observe.Character
                                active_observe = current_observe
                            else
                                library:Notify(cheat_client:get_name(current_observe).." ["..current_observe.Name.."] does not have a character", Color3.fromRGB(5, 252, 120))
                                if plr.Character then
                                    ws.CurrentCamera.CameraSubject = plr.Character
                                    active_observe = nil
                                end
                            end
                        else 
                            if plr.Character then
                                ws.CurrentCamera.CameraSubject = plr.Character
                                active_observe = nil
                            end
                        end
                    else
                        if plr.Character then
                            ws.CurrentCamera.CameraSubject = plr.Character
                            active_observe = nil
                        end
                    end
                end
            end)
        end
    
        do -- Rendering Handler
            utility:Connection(uis.WindowFocused, function() 
                cheat_client.window_active = true
            end)
        
            utility:Connection(uis.WindowFocusReleased, function() 
                cheat_client.window_active = false
            end)
        end
    
        do -- Notification Updater
            utility:Connection(rs.RenderStepped, function()
                local count = #shared.notifications
                local removed_first = false
            
                for i = 1, count do
                    local current_tick = tick()
                    local notification = shared.notifications[i]
                    if notification then
                        if current_tick - notification.start_tick > notification.lifetime then
                            task.spawn(notification.destruct, notification)
                            table.remove(shared.notifications, i)
                        elseif count > 10 and not removed_first then
                            removed_first = true
                            local first = table.remove(shared.notifications, 1)
                            task.spawn(first.destruct, first)
                        else
                            local previous_notification = shared.notifications[i - 1]
                            local basePosition
                            if previous_notification then
                                basePosition = Vector2.new(16, previous_notification.drawings.main_text.Position.y + previous_notification.drawings.main_text.TextBounds.y + 1)
                            else
                                basePosition = Vector2.new(16, 40)
                            end
            
                            notification.drawings.shadow_text.Position = basePosition + Vector2.new(1, 1)
                            notification.drawings.main_text.Position = basePosition
                            notification.drawings.shadow_text.Visible = true
                            notification.drawings.main_text.Visible = true
                        end
                    end
                end
            end)
        end
    
        do -- Illusionist Checker
            utility:Connection(plrs.PlayerAdded, function(player)
                if player.Character and player:FindFirstChild("Backpack") then
    
                    local observe_tool = player.Backpack:FindFirstChild("Observe") or player.Character:FindFirstChild("Observe")
    
                    if observe_tool then 
                        if (library ~= nil and library.Notify) then
                            library:Notify(cheat_client:get_name(player).." ["..player.Name.."] is an illusionist", Color3.fromRGB(5,139,252))
    
                            utility:Connection(observe_tool:WaitForChild("Script"):WaitForChild('NameVal').Changed, function(value)
                                local target_player = plrs:FindFirstChild(value)
                                if not target_player then
                                    library:Notify(cheat_client:get_name(player).." has stopped observing", Color3.fromRGB(255,0,0))
                                else
                                    if target_player.Name == plr.Name then
                                        library:Notify(cheat_client:get_name(player).." IS OBSERVING YOU", Color3.fromRGB(255,0,0))
                                    else
                                        library:Notify(cheat_client:get_name(player).." is observing "..cheat_client:get_name(target_player), Color3.fromRGB(5,139,252))
                                    end
                                end
                            end)
                        end
                    else
                        local waiting_connection 
                        waiting_connection = utility:Connect(player.Backpack.ChildAdded, function(child)
                            if child.Name == "Observe" then
                                waiting_connection:Disconnect()
                                observe_tool = child
                                
                                if (library ~= nil and library.Notify) then
                                    library:Notify(cheat_client:get_name(player).." ["..player.Name.."] is an illusionist", Color3.fromRGB(5,139,252))
                                end
    
                                utility:Connection(observe_tool:WaitForChild("Script"):WaitForChild('NameVal').Changed, function(value)
                                    local target_player = plrs:FindFirstChild(value)
                                    if not target_player then
                                        library:Notify(cheat_client:get_name(player).." has stopped observing", Color3.fromRGB(255,0,0))
                                    else
                                        if target_player.Name == plr.Name then
                                            library:Notify(cheat_client:get_name(player).." IS OBSERVING YOU", Color3.fromRGB(255,0,0))
                                        else
                                            library:Notify(cheat_client:get_name(player).." is observing "..cheat_client:get_name(target_player), Color3.fromRGB(5,139,252))
                                        end
                                    end
                                end)
                            end
                        end)
                    end
                end
    
                utility:Connection(player.CharacterAdded, function(character)
                    task.wait(3)
                    local observe_tool = player.Backpack:FindFirstChild("Observe") or character:FindFirstChild("Observe")
    
                    if observe_tool then 
                        if (library ~= nil and library.Notify) then
                            library:Notify(cheat_client:get_name(player).." ["..player.Name.."] is an illusionist", Color3.fromRGB(5,139,252))
    
                            utility:Connection(observe_tool:WaitForChild("Script"):WaitForChild('NameVal').Changed, function(value)
                                local target_player = plrs:FindFirstChild(value)
                                if not target_player then
                                    library:Notify(cheat_client:get_name(player).." has stopped observing", Color3.fromRGB(255,0,0))
                                else
                                    if target_player.Name == plr.Name then
                                        library:Notify(cheat_client:get_name(player).." IS OBSERVING YOU", Color3.fromRGB(255,0,0))
                                    else
                                        library:Notify(cheat_client:get_name(player).." is observing "..cheat_client:get_name(target_player), Color3.fromRGB(5,139,252))
                                    end
                                end
                            end)
                        end
                    else
                        local waiting_connection 
                        waiting_connection = utility:Connection(player.Backpack.ChildAdded, function(child)
                            if child.Name == "Observe" then
                                waiting_connection:Disconnect()
                                observe_tool = child
                                utility:Connection(observe_tool:WaitForChild("Script"):WaitForChild('NameVal').Changed, function(value)
                                    local target_player = plrs:FindFirstChild(value)
                                    if not target_player then
                                        library:Notify(cheat_client:get_name(player).." has stopped observing", Color3.fromRGB(255,0,0))
                                    else
                                        if target_player.Name == plr.Name then
                                            library:Notify(cheat_client:get_name(player).." IS OBSERVING YOU", Color3.fromRGB(255,0,0))
                                        else
                                            library:Notify(cheat_client:get_name(player).." is observing "..cheat_client:get_name(target_player), Color3.fromRGB(5,139,252))
                                        end
                                    end
                                end)
                            end
                        end)
                    end
                end)
            end)
        end
        
        do -- Combat log checker
            utility:Connection(plrs.PlayerRemoving, function(player)
                if player.Character and cs:HasTag(player.Character,'Danger') then
                    if (library ~= nil and library.Notify) then
                        library:Notify(cheat_client:get_name(player).." ["..player.Name.."] combat logged", Color3.fromRGB(5,139,252))
                    end
                end
            end)
        end
        
        do -- Artifact Checker
            utility:Connection(plrs.PlayerAdded, function(player)
                if (library ~= nil and library.Notify) then
                    utility:Connection(player.CharacterAdded, function(character)
                        task.wait(3)
                        for _,v in pairs(player.Backpack:GetChildren()) do
                            if table.find(cheat_client.artifacts, v.Name) then
                                library:Notify(cheat_client:get_name(player).." ["..player.Name.."] has a "..v.Name, Color3.fromRGB(255,0,179))
                            end
                        end
                        utility:Connection(player.Backpack.ChildAdded, function(child)
                            if table.find(cheat_client.artifacts, child.Name) then
                                library:Notify(cheat_client:get_name(player).." ["..player.Name.."] has a "..child.Name, Color3.fromRGB(255,0,179))
                            end
                        end)
                    end)
                end
            end)
        end
    
        do -- Mod Detection
            utility:Connection(plrs.PlayerAdded, function(player)
                task.spawn(cheat_client.detect_mod, cheat_client, player)
            end)
        end
    
        do -- Day Farm
            local time_elapsed = 0
            utility:Connection(rs.Heartbeat, function(delta_time)
                if shared.pointers["day_farm"]:Get() then
                    time_elapsed += delta_time
                    if time_elapsed >= 1 then
                        time_elapsed = 0
                        
                        for _,player in next, plrs:GetPlayers() do
                            if player == plr then
                                continue
                            end
    
                            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local position = player.Character:FindFirstChild("HumanoidRootPart").Position
                                if plr:DistanceFromCharacter(position) < shared.pointers["day_farm_range"]:Get() then
                                    if cs:HasTag(plr.Character, "Danger") then
                                        -- notify
                                        while cs:HasTag(plr.Character, "Danger") do
                                            task.wait()
                                            if not cs:HasTag(plr.Character, "Danger") then
                                                break
                                            end
                                        end
                                    end
    
                                    plr.Character:Destroy()
                                    plr:Kick("too close to player [".. player.Name.."]")
                                    utility:Unload()
                                end
                            end
                        end
                    end
                end
            end)
        end
    
        do -- Inventory Value
            local function get_inventory_value() -- This is from Underware
                local inventory_value = 0
    
                local backpack_children = plr.Backpack:GetChildren()
    
                for index = 1, #backpack_children do
                    local backpack_child = backpack_children[index]
                    local silver_value = backpack_child:FindFirstChild("SilverValue")
    
                    if silver_value then 
                        inventory_value = inventory_value + silver_value.Value
                    end
                end
                
                return inventory_value
            end 
    
            local time_elapsed = 0
            utility:Connection(rs.Heartbeat, function(delta_time)
                time_elapsed += delta_time
                if time_elapsed >= 1 then
                    time_elapsed = 0
                    shared.pointers["inventory_value"]:Set("inventory value: " .. get_inventory_value())
                end
            end)
        end
        
        do -- Rune Checker
            function rune_check()
                if plr.Character then
                    runes = 0;
                    
                    for i,v in pairs(plr.Character:GetChildren()) do
                        if v.Name:find("RuneArm") then
                            for i2,v2 in pairs(v:GetDescendants()) do
                                if v2:IsA('Decal') and v2.Transparency == 0 then
                                    runes = runes + 1;
                                end
                            end
                        end
                    end
                    return "runes: "..runes.."/18" or "N/A";
                end
            end
            
            local time_elapsed = 0
            utility:Connection(rs.Heartbeat, function(delta_time)
                time_elapsed += delta_time
                if time_elapsed >= 1 then
                    time_elapsed = 0
                    shared.pointers["rune_check"]:Set(rune_check())
                end
            end)
        end
    
        do -- Server size check
            utility:Connection(plrs.PlayerAdded, function(player)
                shared.pointers["plrs_server"]:Set("players: "..#plrs:GetPlayers())
            end)
            
            utility:Connection(plrs.PlayerRemoving, function(player)
                shared.pointers["plrs_server"]:Set("players: "..#plrs:GetPlayers())
            end)
        end
        
        do -- Fullbright
            utility:Connection(lit:GetPropertyChangedSignal("Ambient"), function()
                if shared.pointers["fullbright"]:Get() then
                    lit.Ambient = Color3.new(.5, .5, .5)
                    lit.OutdoorAmbient = Color3.new(.5, .5, .5)
                else
                    cheat_client:restore_ambience()
                end
            end)
    
            utility:Connection(lit:GetPropertyChangedSignal("FogEnd"), function()
                if shared.pointers["fullbright"]:Get() then
                    lit.FogColor = Color3.fromRGB(254, 254, 254)
                    lit.FogEnd = 100000
                    lit.FogStart = 50
                else
                    cheat_client:restore_ambience()
                end
            end)
        end
    
        do -- Clock Time
            utility:Connection(lit:GetPropertyChangedSignal("ClockTime"), function()
                if shared.pointers["change_time"]:Get() then
                    lit.ClockTime = shared.pointers["clock_time"]:Get()
                end
            end)
        end
    
        do -- Trinket Autopickup
            local trinkets = {}
            
            for _,object in next, ws:GetChildren() do
                if object.Name == "Part" and object:FindFirstChild("ID") then
                    table.insert(trinkets, object)
                end
            end
    
            utility:Connection(ws.ChildAdded, function(object)
                if object.Name == "Part" and object:FindFirstChild("ID") then
                    table.insert(trinkets, object)
                end
            end)
    
            utility:Connection(rs.Heartbeat, function(delta_time)
                if shared.pointers["auto_trinket"]:Get() then
                    if plr.Character then
                        for _,object in next, trinkets do
                            local click_detector =  object:FindFirstChild("ClickDetector", true)
                            local dist = 9e9
                            if click_detector then
                                dist = object:FindFirstChild("ClickDetector", true).MaxActivationDistance - 2
                            end
                            if click_detector and (plr:DistanceFromCharacter(object.CFrame.Position) < dist) then
                                fireclickdetector(click_detector)
                            end
                        end
                    end
                end
            end)
        end
    
        do -- Ingredient Autopickup
            if game.PlaceId ~= 3541987450 then
                if ingredient_folder then
                    local ingredients = {}
        
                    for _,object in next, ingredient_folder:GetChildren() do
                        if not cheat_client.blacklisted_ingredients[object.Position] then
                            table.insert(ingredients, object)
                        end
                    end
        
                    utility:Connection(ingredient_folder.ChildAdded, function(object)
                        if not cheat_client.blacklisted_ingredients[object.Position] then
                            table.insert(ingredients, object)
                        end
                    end)
        
                    utility:Connection(rs.Heartbeat, function(delta_time)
                        if shared.pointers["auto_ingredient"]:Get() then
                            if plr.Character then
                                for _,object in next, ingredients do
                                    local click_detector =  object:FindFirstChild("ClickDetector")
                                    if click_detector and (plr:DistanceFromCharacter(object.CFrame.Position) < click_detector.MaxActivationDistance - 2) then
                                        fireclickdetector(click_detector)
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end
    
        do -- Bag Autopickup
            local bags = {}
    
            for _,object in next, ws.Thrown:GetChildren() do
                if object.Name:find("Bag") then
                    table.insert(bags, object)
                end
            end
    
            utility:Connection(ws.Thrown.ChildAdded, function(object)
                if object.Name:find("Bag") then
                    table.insert(bags, object)
                end
            end)
    
            utility:Connection(rs.Heartbeat, function(delta_time)
                if shared.pointers["auto_bag"]:Get() then
                    if plr.Character then
                        for _,object in next, bags do
                            if ((object.CFrame.Position - plr.Character.PrimaryPart.CFrame.Position).Magnitude <= shared.pointers["bag_range"]:Get()) then
                                firetouchinterest(plr.Character["Right Leg"], object, 0)
                                firetouchinterest(plr.Character["Right Leg"], object, 1)
                            end
                        end
                    end
                end
            end)
        end
    
        do -- Perflora Teleport
            utility:Connection(workspace.Thrown.ChildAdded, function(Child)
                if (typeof(Child) == 'Instance' and utility:IsValidProjectile(Child.Name)) then 
                    local con;
                    con = utility:Connection(rs.RenderStepped, function()
                        if shared.pointers["perflora_teleport"]:Get() then
                            if (utility:IsTargetValid(workspace.CurrentCamera.CameraSubject) == false or Child == nil or Child.Parent == nil) then con:Disconnect(); end;
                            Child.Position = workspace.CurrentCamera.CameraSubject.Parent.HumanoidRootPart.Position;
                        end
                    end)
                end;
            end)
        end
    
        do -- Aimbot
            local getmouse = game.ReplicatedStorage.Requests.GetMouse;
            local function GetClosest()
                local Closest = 175;
                local plrClose;
                for i,v in next, workspace.Live:GetChildren() do
                    if plr.Character and v ~= plr.Character and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position-mouse.Hit.p).magnitude < Closest then
                        Closest = (v.HumanoidRootPart.Position-mouse.Hit.p).magnitude;
                        plrClose = v;
                    end
                end
                if plrClose then
                    return plrClose.HumanoidRootPart;
                end
                return nil;
            end
    
            do -- Snap Celeritas Aimbot
                getmouse.OnClientInvoke = function()
                    local Closest = GetClosest();
                    if plr.Character and plr.Character:FindFirstChild("Celeritas") and Closest and shared.pointers["cele_aimbot"]:Get() then
                        local tab = {}
                        tab.Hit = Closest.CFrame
                        tab.Target = Closest
                        tab.UnitRay = Ray.new(plr.Character.HumanoidRootPart.CFrame.p,((Closest.CFrame.p-plr.Character.HumanoidRootPart.CFrame.p).Unit))
                        tab.X = mouse.X
                        tab.Y = mouse.Y
                        return tab
                    end
                    local tab = {}
                    tab.Hit = mouse.Hit
                    tab.Target = mouse.Target
                    tab.UnitRay = mouse.UnitRay
                    tab.X = mouse.X
                    tab.Y = mouse.Y
                    return tab
                end
            end
    
            do -- Inferi Aimbot
                getmouse.OnClientInvoke = function()
                    local Closest = GetClosest();
                    if plr.Character and plr.Character:FindFirstChild("Inferi") and Closest and shared.pointers["inferi_aimbot"]:Get() then
                        local tab = {}
                        tab.Hit = Closest.CFrame
                        tab.Target = Closest
                        tab.UnitRay = Ray.new(plr.Character.HumanoidRootPart.CFrame.p,((Closest.CFrame.p-plr.Character.HumanoidRootPart.CFrame.p).Unit))
                        tab.X = mouse.X
                        tab.Y = mouse.Y
                        return tab
                    end
    
                    local tab = {}
                    tab.Hit = mouse.Hit
                    tab.Target = mouse.Target
                    tab.UnitRay = mouse.UnitRay
                    tab.X = mouse.X
                    tab.Y = mouse.Y
                    return tab
                end
            end
    
            do -- Armis Aimbot
                getmouse.OnClientInvoke = function()
                    local Closest = GetClosest();
                    if plr.Character and plr.Character:FindFirstChild("Armis") and Closest and shared.pointers["armis_aimbot"]:Get() then
                        local tab = {}
                        tab.Hit = Closest.CFrame
                        tab.Target = Closest
                        tab.UnitRay = Ray.new(plr.Character.HumanoidRootPart.CFrame.p,((Closest.CFrame.p-plr.Character.HumanoidRootPart.CFrame.p).Unit))
                        tab.X = mouse.X
                        tab.Y = mouse.Y
                        return tab
                    end
                    local tab = {}
                    tab.Hit = mouse.Hit
                    tab.Target = mouse.Target
                    tab.UnitRay = mouse.UnitRay
                    tab.X = mouse.X
                    tab.Y = mouse.Y
                    return tab
                end
            end
        end
    
        do -- freecam
            local empty_vector = Vector3.new(0, 0, 0)
    
            local move_position = Vector2.new(0, 0)
            local move_direction = empty_vector
    
            local last_right_button_down = Vector2.new(0, 0)
            local right_mouse_button_down = false
    
            local keys_down = {}
            
            local enum_keycode = Enum.KeyCode
            local zoom_keycode = enum_keycode.Z
    
            local mouse_movement = Enum.UserInputType.MouseMovement
            local mouse_button_2 = Enum.UserInputType.MouseButton2
            
            local begin_state = Enum.UserInputState.Begin
            local end_state = Enum.UserInputState.End
    
            local lock_current_position = Enum.MouseBehavior.LockCurrentPosition
            local default_mouse = Enum.MouseBehavior.Default
    
            local camera = utility:GetCamera()
            local camera_scriptable = Enum.CameraType.Scriptable
            local camera_custom = Enum.CameraType.Custom
    
            local move_keys = {
                [enum_keycode.D] = Vector3.new(1, 0, 0),
                [enum_keycode.A] = Vector3.new(-1, 0, 0),
                [enum_keycode.S] = Vector3.new(0, 0, 1),
                [enum_keycode.W] = Vector3.new(0, 0, -1),
                [enum_keycode.E] = Vector3.new(0, 1, 0),
                [enum_keycode.Q] = Vector3.new(0, -1, 0)
            }
    
            utility:Connection(uis.InputChanged, function(input)
                if input.UserInputType == mouse_movement then
                    move_position = move_position + Vector2.new(input.Delta.X, input.Delta.Y)
                end
            end)
    
            local keyboard = {
              W = 0,
              A = 0,
              S = 0,
              D = 0,
              E = 0,
              Q = 0,
              U = 0,
              H = 0,
              J = 0,
              K = 0,
              I = 0,
              Y = 0,
              Up = 0,
              Down = 0,
              LeftShift = 0,
              RightShift = 0,
    	      }
            
            local function Keypress(action, state, input)
              keyboard[input.KeyCode.Name] = state == Enum.UserInputState.Begin and 1 or 0
              return Enum.ContextActionResult.Sink
            end

            function StartCapture()
              cas:BindActionAtPriority("FreecamKeyboard", Keypress, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.W, Enum.KeyCode.U,Enum.KeyCode.A, Enum.KeyCode.H,Enum.KeyCode.S, Enum.KeyCode.J,Enum.KeyCode.D, Enum.KeyCode.K, Enum.KeyCode.E, Enum.KeyCode.I,Enum.KeyCode.Q, Enum.KeyCode.Y,Enum.KeyCode.Up, Enum.KeyCode.Down)
    	      end
    
            local function Zero(t)
              for k, v in pairs(t) do
                t[k] = v*0
              end
            end
    	
            function StopCapture()
              navSpeed = 1
              Zero(keyboard)
              cas:UnbindAction("FreecamKeyboard")
            end
    
            local function calculate_movement()
                local new_movement = empty_vector
                
                for index, value in next, keys_down do
                    new_movement = new_movement + (move_keys[index] or empty_vector)
                end
                
                return new_movement
            end
    
            local function input_register(input)
                local key_code = input.KeyCode
    
                if move_keys[key_code] then
                    if input.UserInputState == begin_state then
                        keys_down[key_code] = true
                    elseif input.UserInputState == end_state then
                        keys_down[key_code] = nil
                    end
                else
                    if input.UserInputState == begin_state and shared and shared.pointers["freecam"]:Get() then
                        if input.UserInputType == mouse_button_2 then
                            right_mouse_button_down = true
                            last_right_button_down = Vector2.new(mouse.X, mouse.Y)
                            uis.MouseBehavior = lock_current_position
                        end
                    else
                        if input.UserInputType == mouse_button_2 and shared and shared.pointers["freecam"]:Get() then
                            right_mouse_button_down = false
                            uis.MouseBehavior = default_mouse
                        end
                    end
                end
            end
    
            utility:Connection(mouse.WheelForward, function()
                camera.CoordinateFrame = camera.CoordinateFrame * CFrame.new(0, 0, -5)
            end)
    
            utility:Connection(mouse.WheelBackward, function()
                camera.CoordinateFrame = camera.CoordinateFrame * CFrame.new(0, 0, 5)
            end)
    
            uis.InputBegan:Connect(input_register)
            uis.InputEnded:Connect(input_register)
    
            utility:Connection(rs.Heartbeat, function()
                if shared and shared.pointers["freecam"]:Get() then
                    camera.CoordinateFrame = CFrame.new(camera.CoordinateFrame.Position) * CFrame.fromEulerAnglesYXZ(-move_position.Y / 300, -move_position.X / 300, 0) * CFrame.new(calculate_movement() * shared.pointers["freecam_speed"]:Get())
                    
                    if right_mouse_button_down then
                        local mouse_position = Vector2.new(mouse.X, mouse.Y)
    
                        uis.MouseBehavior = lock_current_position
                        move_position = move_position - (last_right_button_down - mouse_position)
                        last_right_button_down = mouse_position
                    end
                end
            end)
        end
    
        do -- Train Climb
            coroutine.wrap(function()
                while task.wait(.1) do
                    if shared and shared.pointers["train_climb"]:Get() then
                        if plr.Character and plr.Character:FindFirstChild("Mana") then
                            vim:SendKeyEvent(true, "G", false, game)
                            wait(.1 + (game:GetService('Stats'):WaitForChild('PerformanceStats'):WaitForChild('Ping'):GetValue() / 900))
                            repeat wait() until not plr.Character:FindFirstChild("Charge")
                            vim:SendKeyEvent(false, "G", false, game)
                            repeat
                                vim:SendKeyEvent(true, "Space", false, game) 
                                wait() 
                                vim:SendKeyEvent(false, "Space", false, game)
                            until plr.Character.Mana.Value == 0
                        end
                    end
                end
            end)()
        end
        
        do -- Loop Gain Orderly
            while task.wait(0.6) do
                if plr.Character and plr.Backpack:FindFirstChild('Tespian Elixir') and shared and shared.pointers["loop_orderly"]:Get() then
                    plr.Character.Humanoid:EquipTool(plr.Backpack["Tespian Elixir"])
                    task.wait(0.1)

                    plr.Character["Tespian Elixir"].RemoteEvent:FireServer(plr.Character.HumanoidRootPart.CFrame,"Part","Self")
                    task.wait(1.5)

                    plr.Character:BreakJoints()

                    repeat 
                      task.wait()
                    until plr.Character:FindFirstChild("Immortal")
                end
            end
        end
    end
end
