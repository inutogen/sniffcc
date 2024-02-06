local args = {...}
--binary = textutils.unserialize("0x"..a..b)
--local hexValue = string.format("%02X", string.byte(byte))
if args[1] == "tonif" then
	local nfp = fs.open(args[2], "r")
	local nif = fs.open(args[3], "wb")
	local done = false
	repeat
		local data = nfp.readLine()
		if data == nil then
			done = true
		else
			local char_table = {}
    		for i = 1, #data do
        		table.insert(char_table, data:sub(i, i))
    		end
			for i=1,#char_table,2 do
				if char_table[i+1] == nil then
					char_table[i+1] = "f"
				end
				binary = textutils.unserialize("0x"..char_table[i]..char_table[i+1])
				nif.write(binary)
			end
			nif.write("\n")
		end
	until done == true
	nfp.close()
	nif.close()
elseif args[1] == "fromnif" then
	local nif = fs.open(args[2], "rb")
	local nfp = fs.open(args[3], "w")
	local done = false
	repeat
		local data = nif.readLine()
		if data == nil then
			done = true
		else
			local char_table = {}
    		for i = 1, #data do
        		table.insert(char_table, data:sub(i, i))
    		end
			for i,v in ipairs(char_table) do
				local hexValue = string.format("%02X", string.byte(v))
				pa, pb = hexValue:sub(1, 1), hexValue:sub(2, 2)
				nfp.write(pa..pb)
			end
			nfp.write("\n")
		end
	until done == true
	nfp.close()
	nif.close()
else
	print("")
end
