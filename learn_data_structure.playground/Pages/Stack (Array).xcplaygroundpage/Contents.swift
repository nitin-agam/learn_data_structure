

struct Stack<T>: CustomStringConvertible, TestProtocol {
    
    // array of items
    var items: [T] = []
    
    // to print the formatted description
    var description: String {
        return "---- Stack begin ----\n" +
            items.map({ "\($0)" }).joined(separator: "\n") +
        "\n---- Stack End ----"
    }
    
    mutating func push(_ item: T) {
        self.items.insert(item, at: 0)
    }
    
    @discardableResult
    mutating func pop() -> T? {
        if items.isEmpty { return nil }
        return self.items.removeFirst()
    }
    
    func peek() -> T? {
        return self.items.first
    }
}


var stackString = Stack<String>()
stackString.push("First")
stackString.push("Second")
stackString.push("Third")
stackString.pop()
if let peekItem = stackString.peek() {
    print("Peek Item in Stack: ", peekItem)
}
print(stackString)



var stackInt = Stack<Int>()
stackInt.push(10)
stackInt.push(20)
stackInt.push(30)
stackInt.pop()
if let peekItem = stackInt.peek() {
    print("Peek Item in Stack: ", peekItem)
}
print(stackInt)


