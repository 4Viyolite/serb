return @native function(Buffer: buffer, Cursor: number, ValueSize: number): boolean
    local BufferSize = buffer.len(Buffer)
    if Cursor + ValueSize > BufferSize then
        return false
    end
    return true
end
