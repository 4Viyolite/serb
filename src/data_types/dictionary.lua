const types = require("../types")
const taglist = require("./taglist")

const helpers = require("../helpers")
const unknown_type = require("./unknown")
const array_type = require("./array")

local dictionary_data_type: types.serb_data_type<{ [unknown]: unknown }> = {
    read = @native function(Buffer: buffer, Cursor: number): (buffer, number, { [unknown]: unknown })
        local Tag = buffer.readu16(Buffer, Cursor)
        assert(
            Tag == taglist.dictionary,
            `serb: Attempted to dictionary-read a non-dictionary value at offset {Cursor}!`
        )
        Cursor += 2
        local PairAmount = buffer.readu16(Buffer, Cursor)
        Cursor += 2
        local Dictionary = {}
        for _ = 1, PairAmount do
            local Key, Val
            Buffer, Cursor, Key = unknown_type.read(Buffer, Cursor)
            Buffer, Cursor, Val = unknown_type.read(Buffer, Cursor)
            Dictionary[Key] = Val
        end
        return Buffer, Cursor, Dictionary
    end,
    write = @native function(
        Buffer: buffer,
        Cursor: number,
        Value: { [unknown]: unknown }
    ): (buffer, number)
        if not helpers.HasSpaceLeft(Buffer, Cursor, 4) then
            Buffer = helpers.ExpandBuffer(Buffer, 4)
        end
        if helpers.IsArray(Value) then
            return array_type.write(Buffer, Cursor, Value :: { unknown })
        end
        buffer.writeu16(Buffer, Cursor, taglist.dictionary)
        Cursor += 2
        local PairAmount = 0
        -- selene: allow(multiple_statements)
        for _ in Value do
            PairAmount += 1
        end
        buffer.writeu16(Buffer, Cursor, PairAmount)
        Cursor += 2
        for Key, Val in Value do
            Buffer, Cursor = unknown_type.write(Buffer, Cursor, Key)
            Buffer, Cursor = unknown_type.write(Buffer, Cursor, Val)
        end
        return Buffer, Cursor
    end,
}

return table.freeze(dictionary_data_type)
