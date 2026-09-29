return @native function(Buffer: buffer, Amount: number): buffer
    local OldBufferLength = buffer.len(Buffer)
    local NewBuffer = buffer.create(OldBufferLength + Amount)
    buffer.copy(NewBuffer, 0, Buffer, 0)
    return NewBuffer
end
