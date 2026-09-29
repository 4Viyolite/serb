const types = require("../types")
const taglist = require("./taglist")

const helpers = require("../helpers")

local Color3_data_type: types.serb_data_type<Color3> = {
    read = @native function(Buffer: buffer, Cursor: number): (buffer, number, Color3)
        local Tag = buffer.readu16(Buffer, Cursor)
        assert(
            Tag == taglist.Color3,
            `serb: Attempted to Color3-read a non-Color3 value at offset {Cursor}!`
        )
        Cursor += 2
        local COL_R = buffer.readu8(Buffer, Cursor)
        Cursor += 1
        local COL_G = buffer.readu8(Buffer, Cursor)
        Cursor += 1
        local COL_B = buffer.readu8(Buffer, Cursor)
        Cursor += 1
        return Buffer, Cursor, Color3.fromRGB(COL_R, COL_G, COL_B)
    end,
    write = @native function(Buffer: buffer, Cursor: number, Value: Color3): (buffer, number)
        if not helpers.HasSpaceLeft(Buffer, Cursor, 5) then
            Buffer = helpers.ExpandBuffer(Buffer, 5)
        end
        buffer.writeu16(Buffer, Cursor, taglist.Color3)
        Cursor += 2
        buffer.writeu8(Buffer, Cursor, Value.R * 255)
        Cursor += 1
        buffer.writeu8(Buffer, Cursor, Value.G * 255)
        Cursor += 1
        buffer.writeu8(Buffer, Cursor, Value.B * 255)
        Cursor += 1
        return Buffer, Cursor
    end,
}

return table.freeze(Color3_data_type)
