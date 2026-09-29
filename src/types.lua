export type serb_data_type<T> = {
    read: (Buffer: buffer, Cursor: number) -> (buffer, number, T),
    write: (Buffer: buffer, Cursor: number, Value: T) -> (buffer, number),
}

return table.freeze({})
