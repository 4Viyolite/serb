const types = require("../types")
const taglist = require("./taglist")

const helpers = require("../helpers")

local UDim_data_type: types.serb_data_type<UDim> = {
    read = @native function(Buffer: buffer, Cursor: number): (buffer, number, UDim)
        local Tag = buffer.readu16(Buffer, Cursor)
        assert(
            Tag == taglist.UDim,
            `serb: Attempted to UDim-read a non-UDim value at offset {Cursor}!`
        )
        Cursor += 2
        local Scale = buffer.readf32(Buffer, Cursor)
        Cursor += 4
        local Offset = buffer.readi32(Buffer, Cursor)
        Cursor += 4
        return Buffer, Cursor, UDim.new(Scale, Offset)
    end,
    write = @native function(Buffer: buffer, Cursor: number, Value: UDim): (buffer, number)
        if not helpers.HasSpaceLeft(Buffer, Cursor, 10) then
            Buffer = helpers.ExpandBuffer(Buffer, 10)
        end
        buffer.writeu16(Buffer, Cursor, taglist.UDim)
        Cursor += 2
        buffer.writef32(Buffer, Cursor, Value.Scale)
        Cursor += 4
        buffer.writei32(Buffer, Cursor, Value.Offset)
        Cursor += 4
        return Buffer, Cursor
    end,
}

return table.freeze(UDim_data_type)
