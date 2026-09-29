const types = require("../types")
const taglist = require("./taglist")

const helpers = require("../helpers")

local CFrame_data_type: types.serb_data_type<CFrame> = {
    read = @native function(Buffer: buffer, Cursor: number): (buffer, number, CFrame)
        local Tag = buffer.readu16(Buffer, Cursor)
        assert(
            Tag == taglist.CFrame,
            `serb: Attempted to CFrame-read a non-CFrame value at offset {Cursor}!`
        )
        Cursor += 2
        local CF_X = buffer.readf64(Buffer, Cursor)
        Cursor += 8
        local CF_Y = buffer.readf64(Buffer, Cursor)
        Cursor += 8
        local CF_Z = buffer.readf64(Buffer, Cursor)
        Cursor += 8
        local CF_RVec_X = buffer.readf32(Buffer, Cursor)
        Cursor += 8
        local CF_RVec_Y = buffer.readf32(Buffer, Cursor)
        Cursor += 8
        local CF_RVec_Z = buffer.readf32(Buffer, Cursor)
        Cursor += 8
        local CF_UpVec_X = buffer.readf32(Buffer, Cursor)
        Cursor += 8
        local CF_UpVec_Y = buffer.readf32(Buffer, Cursor)
        Cursor += 8
        local CF_UpVec_Z = buffer.readf32(Buffer, Cursor)
        Cursor += 8
        local CF_LVec_NX = buffer.readf32(Buffer, Cursor)
        Cursor += 8
        local CF_LVec_NY = buffer.readf32(Buffer, Cursor)
        Cursor += 8
        local CF_LVec_NZ = buffer.readf32(Buffer, Cursor)
        Cursor += 8
        return Buffer,
            Cursor,
            CFrame.new(
                CF_X,
                CF_Y,
                CF_Z,
                CF_RVec_X,
                CF_RVec_Y,
                CF_RVec_Z,
                CF_UpVec_X,
                CF_UpVec_Y,
                CF_UpVec_Z,
                CF_LVec_NX,
                CF_LVec_NY,
                CF_LVec_NZ
            )
    end,
    write = @native function(Buffer: buffer, Cursor: number, Value: CFrame): (buffer, number)
        if not helpers.HasSpaceLeft(Buffer, Cursor, 98) then
            Buffer = helpers.ExpandBuffer(Buffer, 98)
        end
        buffer.writeu16(Buffer, Cursor, taglist.CFrame)
        Cursor += 2
        buffer.writef64(Buffer, Cursor, Value.Position.X)
        Cursor += 8
        buffer.writef64(Buffer, Cursor, Value.Position.Y)
        Cursor += 8
        buffer.writef64(Buffer, Cursor, Value.Position.Z)
        Cursor += 8
        buffer.writef32(Buffer, Cursor, Value.RightVector.X)
        Cursor += 8
        buffer.writef32(Buffer, Cursor, Value.RightVector.Y)
        Cursor += 8
        buffer.writef32(Buffer, Cursor, Value.RightVector.Z)
        Cursor += 8
        buffer.writef32(Buffer, Cursor, Value.UpVector.X)
        Cursor += 8
        buffer.writef32(Buffer, Cursor, Value.UpVector.Y)
        Cursor += 8
        buffer.writef32(Buffer, Cursor, Value.UpVector.Z)
        Cursor += 8
        buffer.writef32(Buffer, Cursor, -Value.LookVector.X)
        Cursor += 8
        buffer.writef32(Buffer, Cursor, -Value.LookVector.Y)
        Cursor += 8
        buffer.writef32(Buffer, Cursor, -Value.LookVector.Z)
        Cursor += 8
        return Buffer, Cursor
    end,
}

return table.freeze(CFrame_data_type)
