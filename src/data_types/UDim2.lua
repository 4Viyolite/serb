const types = require("../types")
const taglist = require("./taglist")

const helpers = require("../helpers")

local UDim2_data_type: types.serb_data_type<UDim2> = {
    read = @native function(Buffer: buffer, Cursor: number): (buffer, number, UDim2)
        local Tag = buffer.readu16(Buffer, Cursor)
        assert(
            Tag == taglist.UDim,
            `serb: Attempted to UDim-read a non-UDim value at offset {Cursor}!`
        )
        Cursor += 2
        local Scale_X = buffer.readf32(Buffer, Cursor)
        Cursor += 4
        local Offset_X = buffer.readi32(Buffer, Cursor)
        Cursor += 4
        local Scale_Y = buffer.readf32(Buffer, Cursor)
        Cursor += 4
        local Offset_Y = buffer.readi32(Buffer, Cursor)
        Cursor += 4
        return Buffer, Cursor, UDim2.new(Scale_X, Offset_X, Scale_Y, Offset_Y)
    end,
    write = @native function(Buffer: buffer, Cursor: number, Value: UDim2): (buffer, number)
        if not helpers.HasSpaceLeft(Buffer, Cursor, 10) then
            Buffer = helpers.ExpandBuffer(Buffer, 10)
        end
        buffer.writeu16(Buffer, Cursor, taglist.UDim)
        Cursor += 2
        buffer.writef32(Buffer, Cursor, Value.X.Scale)
        Cursor += 4
        buffer.writei32(Buffer, Cursor, Value.X.Offset)
        Cursor += 4
        buffer.writef32(Buffer, Cursor, Value.Y.Scale)
        Cursor += 4
        buffer.writei32(Buffer, Cursor, Value.Y.Offset)
        Cursor += 4
        return Buffer, Cursor
    end,
}

return table.freeze(UDim2_data_type)
