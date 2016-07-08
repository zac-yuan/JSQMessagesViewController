
public extension Array {
    public func mapIfTransformedValue<U>(transform:Element->U?) -> [U] {
        var result:[U] = []
        result.reserveCapacity(self.count)
        for element in self {
            if let value = transform(element) {
                result.append(value)
            }
        }
        return result
    }
}