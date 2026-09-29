local RunService = game:GetService("RunService")
local Used_tags = {}
local Tagged_types = {}

@native
local function get_unique_tag(type_name: string): number
    if RunService:IsServer() then
        if Tagged_types[type_name] then
            local TagValue = script:WaitForChild(type_name) :: NumberValue
            return TagValue.Value
        end
        Tagged_types[type_name] = 0
        local Tag = math.random(1000, 9999)

        while Used_tags[Tag] do
            Tag = math.random(1000, 9999)
            task.wait()
        end

        local TagValue = Instance.new("NumberValue")
        TagValue.Name = type_name
        TagValue.Value = Tag
        TagValue.Parent = script

        return Tag
    else
        local TagValue = script:WaitForChild(type_name) :: NumberValue
        return TagValue.Value
    end
end

return table.freeze({
    string = get_unique_tag("string"),
    number = get_unique_tag("number"),
    boolean = get_unique_tag("boolean"),
    Color3 = get_unique_tag("Color3"),
    BrickColor = get_unique_tag("BrickColor"),
    UDim = get_unique_tag("UDim"),
    UDim2 = get_unique_tag("UDim2"),
    Vector2 = get_unique_tag("Vector2"),
    Vector3 = get_unique_tag("Vector3"),
    CFrame = get_unique_tag("CFrame"),
    array = get_unique_tag("array"),
    dictionary = get_unique_tag("dictionary"),
})
