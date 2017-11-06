-- Important: You must have a keybinding in order to use this functionality
-- Important: Put this file as a .lua into the (*nix: ~/.config/mpv/scripts/) (Windows: %AppData%\Roaming\mpv\scripts\) (MacOS: *I do not know where this folder is, let me "Zilarrezko" know*) folder


-- Note: To set a keybinding through the input.conf, edit the input.conf file in the (*nix: ~/.config/mpv/) (Windows: %AppData%\Roaming\mpv\) folder.
--       If there is no file there, make one
--       Next, put "g script-binding JumpToPrompt" on a new line, where 'g' is the key you press to start the script, change how you'd like

local Time = ""
local TakingInput = false

function InitiateKeybindings()
	mp.add_forced_key_binding("0", "JumpTo_Key_0", AddToJumpTime0)
	mp.add_forced_key_binding("1", "JumpTo_Key_1", AddToJumpTime1)
	mp.add_forced_key_binding("2", "JumpTo_Key_2", AddToJumpTime2)
	mp.add_forced_key_binding("3", "JumpTo_Key_3", AddToJumpTime3)
	mp.add_forced_key_binding("4", "JumpTo_Key_4", AddToJumpTime4)
	mp.add_forced_key_binding("5", "JumpTo_Key_5", AddToJumpTime5)
	mp.add_forced_key_binding("6", "JumpTo_Key_6", AddToJumpTime6)
	mp.add_forced_key_binding("7", "JumpTo_Key_7", AddToJumpTime7)
	mp.add_forced_key_binding("8", "JumpTo_Key_8", AddToJumpTime8)
	mp.add_forced_key_binding("9", "JumpTo_Key_9", AddToJumpTime9)
	mp.add_forced_key_binding("KP0", "JumpTo_Key_num0", AddToJumpTime0)
	mp.add_forced_key_binding("KP1", "JumpTo_Key_num1", AddToJumpTime1)
	mp.add_forced_key_binding("KP2", "JumpTo_Key_num2", AddToJumpTime2)
	mp.add_forced_key_binding("KP3", "JumpTo_Key_num3", AddToJumpTime3)
	mp.add_forced_key_binding("KP4", "JumpTo_Key_num4", AddToJumpTime4)
	mp.add_forced_key_binding("KP5", "JumpTo_Key_num5", AddToJumpTime5)
	mp.add_forced_key_binding("KP6", "JumpTo_Key_num6", AddToJumpTime6)
	mp.add_forced_key_binding("KP7", "JumpTo_Key_num7", AddToJumpTime7)
	mp.add_forced_key_binding("KP8", "JumpTo_Key_num8", AddToJumpTime8)
	mp.add_forced_key_binding("KP9", "JumpTo_Key_num9", AddToJumpTime9)
	mp.add_forced_key_binding("enter", "JumpTo", JumpTo)
end

function RemoveKeybindings()
	mp.remove_key_binding("JumpTo_Key_0")
	mp.remove_key_binding("JumpTo_Key_1")
	mp.remove_key_binding("JumpTo_Key_2")
	mp.remove_key_binding("JumpTo_Key_3")
	mp.remove_key_binding("JumpTo_Key_4")
	mp.remove_key_binding("JumpTo_Key_5")
	mp.remove_key_binding("JumpTo_Key_6")
	mp.remove_key_binding("JumpTo_Key_7")
	mp.remove_key_binding("JumpTo_Key_8")
	mp.remove_key_binding("JumpTo_Key_9")
	mp.remove_key_binding("JumpTo_Key_num0")
	mp.remove_key_binding("JumpTo_Key_num1")
	mp.remove_key_binding("JumpTo_Key_num2")
	mp.remove_key_binding("JumpTo_Key_num3")
	mp.remove_key_binding("JumpTo_Key_num4")
	mp.remove_key_binding("JumpTo_Key_num5")
	mp.remove_key_binding("JumpTo_Key_num6")
	mp.remove_key_binding("JumpTo_Key_num7")
	mp.remove_key_binding("JumpTo_Key_num8")
	mp.remove_key_binding("JumpTo_Key_num9")
	mp.remove_key_binding("JumpTo")
end

function AddToJumpTime(Number)	
	-- 9  10 11 12  13  14  15  16
	-- 0  0  :  0   0   :   0   0
	
	-- Note: Yes, you can specify 99 minutes and 99 seconds
	Time = Time:sub(1, 8)  .. Time:sub(10, 10) .. Time:sub(10)
	Time = Time:sub(1, 9)  .. Time:sub(12, 12) .. Time:sub(11)
	Time = Time:sub(1, 11) .. Time:sub(13, 13) .. Time:sub(13)
	Time = Time:sub(1, 12) .. Time:sub(15, 15) .. Time:sub(14)
	Time = Time:sub(1, 14) .. Time:sub(16, 16) .. Time:sub(16)
	Time = Time:sub(1, 15) .. tostring(Number)

	mp.command("show-text \"" .. Time .. "\" 1800000")
end

function AddToJumpTime0() AddToJumpTime(0) end
function AddToJumpTime1() AddToJumpTime(1) end
function AddToJumpTime2() AddToJumpTime(2) end
function AddToJumpTime3() AddToJumpTime(3) end
function AddToJumpTime4() AddToJumpTime(4) end
function AddToJumpTime5() AddToJumpTime(5) end
function AddToJumpTime6() AddToJumpTime(6) end
function AddToJumpTime7() AddToJumpTime(7) end
function AddToJumpTime8() AddToJumpTime(8) end
function AddToJumpTime9() AddToJumpTime(9) end

function JumpTo()
	RemoveKeybindings()
	
	TakingInput = not TakingInput

	local Hours = tonumber(Time:sub(9, 10))
	local Minutes = tonumber(Time:sub(12, 13))
	local Seconds = tonumber(Time:sub(15, 16))
	
	local CombinedTime = Hours*3600 + Minutes*60 + Seconds
	
	local VideoDuration = mp.get_property("duration")
	
	if VideoDuration then
		if CombinedTime <= tonumber(VideoDuration) then
			mp.command("seek ".. CombinedTime .." absolute")
			mp.command("show-text \"" .. Time .. "\" 100")
		else
			mp.command("show-text \"Reqested Timestamp > Video Duration\" 1000")
		end
	else
		mp.command("show-text \"How did you get here? You shouldn't be here...\" 1000")
	end
end

function StartJumpPrompt()
	if not TakingInput then
		local VideoDuration = mp.get_property("duration")
		
		if VideoDuration then
			Time = "JumpTo: 00:00:00"
			
			InitiateKeybindings()
			
			mp.command("show-text \"" .. Time .. "\" 1800000")
		
			TakingInput = not TakingInput
		else
			mp.command("show-text \"Cannot jump in this video\" 1000")
		end
	else
		RemoveKeybindings()
		
		mp.command("show-text \"\" 1")
		
		TakingInput = not TakingInput
	end
end

-- Note: In case you would like to make a key binding through here and not input.conf, 
--       change nil to '[key]' where [key] is a key you can press on the keyboard i.e. 'g' or 'r'
mp.add_forced_key_binding(nil, "JumpToPrompt", StartJumpPrompt)