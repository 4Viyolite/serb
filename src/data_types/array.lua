const types = require("../types")
const taglist = require("./taglist")

const helpers = require("../helpers")
const unknown_type = require("./unknown")

local array_data_type: types.serb_data_type<{ unknown }> = {
    read = @native function(Buffer: buffer, Cursor: number): (buffer, number, { unknown })
        local Tag = buffer.readu16(Buffer, Cursor)
        assert(
            Tag == taglist.array,
            `serb: Attempted to array-read a non-array value at offset {Cursor}!`
        )
        Cursor += 2
        local ArrayLength = buffer.readu16(Buffer, Cursor)
        Cursor += 2
        local Array = table.create(ArrayLength)
        for i = 1, ArrayLength do
            local Value
            Buffer, Cursor, Value = unknown_type.read(Buffer, Cursor)
            Array[i] = Value
        end
        return Buffer, Cursor, Array
    end,
    write = @native function(Buffer: buffer, Cursor: number, Value: { unknown }): (buffer, number)
        if not helpers.HasSpaceLeft(Buffer, Cursor, 4) then
            Buffer = helpers.ExpandBuffer(Buffer, 4)
        end
        buffer.writeu16(Buffer, Cursor, taglist.array)
        Cursor += 2
        buffer.writeu16(Buffer, Cursor, #Value)
        Cursor += 2
        for i = 1, #Value do
            Buffer, Cursor = unknown_type.write(Buffer, Cursor, Value[i])
        end
        return Buffer, Cursor
    end,
}

return table.freeze(array_data_type)
