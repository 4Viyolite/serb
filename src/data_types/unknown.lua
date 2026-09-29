const types = require("../types")
const taglist = require("./taglist")

const string_type = require("./string")
const number_type = require("./number")
const boolean_type = require("./boolean")
const BrickColor_type = require("./BrickColor")
const Color3_type = require("./Color3")
const UDim_type = require("./UDim")
const UDim2_type = require("./UDim2")
const Vector2_type = require("./Vector2")
const Vector3_type = require("./Vector3")
const CFrame_type = require("./CFrame")

local unknown_data_type: types.serb_data_type<unknown> = {
    read = @native @deprecated function(Buffer: buffer, Cursor: number): (buffer, number, unknown)
        local Tag = buffer.readu16(Buffer, Cursor)
        if Tag == taglist.string then
            return string_type.read(Buffer, Cursor)
        elseif Tag == taglist.number then
            return number_type.read(Buffer, Cursor)
        elseif Tag == taglist.boolean then
            return boolean_type.read(Buffer, Cursor)
        elseif Tag == taglist.BrickColor then
            return BrickColor_type.read(Buffer, Cursor)
        elseif Tag == taglist.Color3 then
            return Color3_type.read(Buffer, Cursor)
        elseif Tag == taglist.UDim then
            return UDim_type.read(Buffer, Cursor)
        elseif Tag == taglist.UDim2 then
            return UDim2_type.read(Buffer, Cursor)
        elseif Tag == taglist.Vector2 then
            return Vector2_type.read(Buffer, Cursor)
        elseif Tag == taglist.Vector3 then
            return Vector3_type.read(Buffer, Cursor)
        elseif Tag == taglist.CFrame then
            return CFrame_type.read(Buffer, Cursor)
        else
            error(`serb: Unrecognized data type tag '{Tag}' at offset {Cursor}!`)
        end
    end,
    write = @native @deprecated function(Buffer: buffer, Cursor: number, Value: unknown): (buffer, number)
        local ValueType = typeof(Value)
        if ValueType == "string" then
            return string_type.write(Buffer, Cursor, Value :: string)
        elseif ValueType == "number" then
            return number_type.write(Buffer, Cursor, Value :: number)
        elseif ValueType == "boolean" then
            return boolean_type.write(Buffer, Cursor, Value :: boolean)
        elseif ValueType == "BrickColor" then
            return BrickColor_type.write(Buffer, Cursor, Value :: BrickColor)
        elseif ValueType == "Color3" then
            return Color3_type.write(Buffer, Cursor, Value :: Color3)
        elseif ValueType == "UDim" then
            return UDim_type.write(Buffer, Cursor, Value :: UDim)
        elseif ValueType == "UDim2" then
            return UDim2_type.write(Buffer, Cursor, Value :: UDim2)
        elseif ValueType == "Vector2" then
            return Vector2_type.write(Buffer, Cursor, Value :: Vector2)
        elseif ValueType == "Vector3" then
            return Vector3_type.write(Buffer, Cursor, Value :: Vector3)
        elseif ValueType == "CFrame" then
            return CFrame_type.write(Buffer, Cursor, Value :: CFrame)
        else
            error(
                `serb: Attempted to write an unsupported data type ('{ValueType}') at offset {Cursor}!`
            )
        end
    end,
}

return table.freeze(unknown_data_type)
