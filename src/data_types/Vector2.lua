const types = require("../types")
const taglist = require("./taglist")

const helpers = require("../helpers")

local Vector2_data_type: types.serb_data_type<Vector2> = {
    read = @native function(Buffer: buffer, Cursor: number): (buffer, number, Vector2)
        local Tag = buffer.readu16(Buffer, Cursor)
        assert(Tag == taglist.Vector2, `serb: Attempted to Vector2-read a non-Vector2 value at offset {Cursor}!`)
        Cursor += 2
        local Vec2_X = buffer.readf64(Buffer, Cursor)
        Cursor += 8
        local Vec2_Y = buffer.readf64(Buffer, Cursor)
        Cursor += 8
        return Buffer, Cursor, Vector2.new(Vec2_X, Vec2_Y)
    end,
    write = @native function(Buffer: buffer, Cursor: number, Value: Vector2): (buffer, number)
        if not helpers.HasSpaceLeft(Buffer, Cursor, 18) then
            Buffer = helpers.ExpandBuffer(Buffer, 18)
        end
        buffer.writeu16(Buffer, Cursor, taglist.Vector2)
        Cursor += 2
        buffer.writef64(Buffer, Cursor, Value.X)
        Cursor += 8
        buffer.writef64(Buffer, Cursor, Value.Y)
        Cursor += 8
        return Buffer, Cursor
    end
}

return table.freeze(Vector2_data_type)
