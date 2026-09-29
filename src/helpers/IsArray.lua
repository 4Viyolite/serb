return function(PossibleArray: { [any]: any }): boolean
    local IsAnArray = true
    local PairAmount = 0
    for Index, _ in pairs(PossibleArray) do
        PairAmount += 1
        if typeof(Index) ~= "number" then
            IsAnArray = false
            break
        end
        task.wait()
    end
    if PairAmount == 0 then
        IsAnArray = true
    end
    return IsAnArray
end
