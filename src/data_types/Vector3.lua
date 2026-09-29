const types = require("../types")
const taglist = require("./taglist")

const helpers = require("../helpers")

local Vector3_data_type: types.serb_data_type<Vector3> = {
    read = @native function(Buffer: buffer, Cursor: number): (buffer, number, Vector3)
        local Tag = buffer.readu16(Buffer, Cursor)
        assert(
            Tag == taglist.Vector3,
            `serb: Attempted to Vector3-read a non-Vector3 value at offset {Cursor}!`
        )
        Cursor += 2
        local Vec3_X = buffer.readf64(Buffer, Cursor)
        Cursor += 8
        local Vec3_Y = buffer.readf64(Buffer, Cursor)
        Cursor += 8
        local Vec3_Z = buffer.readf64(Buffer, Cursor)
        Cursor += 8
        return Buffer, Cursor, Vector3.new(Vec3_X, Vec3_Y, Vec3_Z)
    end,
    write = @native function(Buffer: buffer, Cursor: number, Value: Vector3): (buffer, number)
        if not helpers.HasSpaceLeft(Buffer, Cursor, 26) then
            Buffer = helpers.ExpandBuffer(Buffer, 26)
        end
        buffer.writeu16(Buffer, Cursor, taglist.Vector3)
        Cursor += 2
        buffer.writef64(Buffer, Cursor, Value.X)
        Cursor += 8
        buffer.writef64(Buffer, Cursor, Value.Y)
        Cursor += 8
        buffer.writef64(Buffer, Cursor, Value.Z)
        Cursor += 8
        return Buffer, Cursor
    end,
}

return table.freeze(Vector3_data_type)
