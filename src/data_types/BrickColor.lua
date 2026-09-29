const types = require("../types")
const taglist = require("./taglist")

const helpers = require("../helpers")

local BrickColor_data_type: types.serb_data_type<BrickColor> = {
    read = @native function(Buffer: buffer, Cursor: number): (buffer, number, BrickColor)
        local Tag = buffer.readu16(Buffer, Cursor)
        assert(Tag == taglist.BrickColor, `serb: Attempted to BrickColor-read a non-BrickColor value at offset {Cursor}!`)
        Cursor += 2
        local BrickColorId = buffer.readu16(Buffer, Cursor)
        Cursor += 2
        return Buffer, Cursor, BrickColor.new(BrickColorId)
    end,
    write = @native function(Buffer: buffer, Cursor: number, Value: BrickColor): (buffer, number)
        if not helpers.HasSpaceLeft(Buffer, Cursor, 4) then
            Buffer = helpers.ExpandBuffer(Buffer, 4)
        end
        buffer.writeu16(Buffer, Cursor, taglist.BrickColor)
        Cursor += 2
        buffer.writeu16(Buffer, Cursor, Value.Number)
        Cursor += 2
        return Buffer, Cursor
    end
}

return table.freeze(BrickColor_data_type)
