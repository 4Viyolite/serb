const types = require("../types")
const taglist = require("./taglist")

const helpers = require("../helpers")

local number_data_type: types.serb_data_type<number> = {
    read = @native function(Buffer: buffer, Cursor: number): (buffer, number, number)
        local Tag = buffer.readu16(Buffer, Cursor)
        assert(
            Tag == taglist.number,
            `serb: Attempted to number-read a non-number value at offset {Cursor}!`
        )
        Cursor += 2
        local Number = buffer.readf64(Buffer, Cursor)
        Cursor += 8
        return Buffer, Cursor, Number
    end,
    write = @native function(Buffer: buffer, Cursor: number, Value: number): (buffer, number)
        if not helpers.HasSpaceLeft(Buffer, Cursor, 10) then
            Buffer = helpers.ExpandBuffer(Buffer, 10)
        end
        buffer.writeu16(Buffer, Cursor, taglist.number)
        Cursor += 2
        buffer.writef64(Buffer, Cursor, Value)
        Cursor += 8
        return Buffer, Cursor
    end,
}

return table.freeze(number_data_type)
