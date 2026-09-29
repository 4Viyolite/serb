const types = require("../types")
const taglist = require("./taglist")

const helpers = require("../helpers")

local boolean_data_type: types.serb_data_type<boolean> = {
    read = @native function(Buffer: buffer, Cursor: number): (buffer, number, boolean)
        local Tag = buffer.readu16(Buffer, Cursor)
        assert(
            Tag == taglist.boolean,
            `serb: Attempted to boolean-read a non-boolean value at offset {Cursor}!`
        )
        Cursor += 2
        local RawBoolean = buffer.readu8(Buffer, Cursor)
        local Boolean = if RawBoolean == 1 then true else false
        Cursor += 1
        return Buffer, Cursor, Boolean
    end,
    write = @native function(Buffer: buffer, Cursor: number, Value: boolean): (buffer, number)
        if not helpers.HasSpaceLeft(Buffer, 3) then
            Buffer = helpers.ExpandBuffer(Buffer, Cursor, 3)
        end
        buffer.writeu16(Buffer, Cursor, taglist.number)
        Cursor += 2
        buffer.writeu8(Buffer, Cursor, if Value then 1 else 0)
        Cursor += 1
        return Buffer, Cursor
    end,
}

return table.freeze(boolean_data_type)
