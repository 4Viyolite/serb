const types = require("../types")
const taglist = require("./taglist")

const helpers = require("../helpers")

local string_data_type: types.serb_data_type<string> = {
    read = @native function(Buffer: buffer, Cursor: number): (buffer, number, string)
        local Tag = buffer.readu16(Buffer, Cursor)
        assert(
            Tag == taglist.string,
            `serb: Attempted to string-read a non-string value at offset {Cursor}!`
        )
        Cursor += 2
        local StringLength = buffer.readu32(Buffer, Cursor)
        Cursor += 4
        local String = buffer.readstring(Buffer, Cursor, StringLength)
        Cursor += StringLength
        return Buffer, Cursor, String
    end,
    write = @native function(Buffer: buffer, Cursor: number, Value: string): (buffer, number)
        if not helpers.HasSpaceLeft(Buffer, Cursor, 6 + #Value) then
            Buffer = helpers.ExpandBuffer(Buffer, 6 + #Value)
        end
        buffer.writeu16(Buffer, Cursor, taglist.string)
        Cursor += 2
        buffer.writeu32(Buffer, Cursor, #Value)
        Cursor += 4
        buffer.writestring(Buffer, Cursor, Value)
        Cursor += #Value
        return Buffer, Cursor
    end,
}

return table.freeze(string_data_type)
