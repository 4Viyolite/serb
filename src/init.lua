const string_type = require("@self/data_types/string")
const number_type = require("@self/data_types/number")
const boolean_type = require("@self/data_types/boolean")
const BrickColor_type = require("@self/data_types/BrickColor")
const Color3_type = require("@self/data_types/Color3")
const UDim_type = require("@self/data_types/UDim")
const UDim2_type = require("@self/data_types/UDim2")
const Vector2_type = require("@self/data_types/Vector2")
const Vector3_type = require("@self/data_types/Vector3")
const CFrame_type = require("@self/data_types/CFrame")
const unknown_type = require("@self/data_types/unknown")
const dictionary_type = require("@self/data_types/dictionary")
const array_type = require("@self/data_types/array")

return table.freeze({
    data_types = {
        string_type = string_type,
        number_type = number_type,
        boolean_type = boolean_type,
        BrickColor_type = BrickColor_type,
        Color3_type = Color3_type,
        UDim_type = UDim_type,
        UDim2_type = UDim2_type,
        Vector2_type = Vector2_type,
        Vector3_type = Vector3_type,
        CFrame_type = CFrame_type,
        unknown_type = unknown_type,
        dictionary_type = dictionary_type,
        array_type = array_type,
    },
})
