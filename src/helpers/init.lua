local Helpers: {
    [string]: (...any) -> ...any,
} = {}

for _, Helper in ipairs(script:GetChildren()) do
    if Helper:IsA("ModuleScript") then
        Helpers[Helper.Name] = (require)(Helper)
    end
end

return table.freeze(Helpers)
