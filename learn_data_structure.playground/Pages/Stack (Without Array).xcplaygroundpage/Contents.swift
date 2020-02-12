

// Node class to hold the data
class Node<T>: CustomStringConvertible {
    
    let value: T
    var next: Node?
    
    var description: String {
        guard let next = next else { return "\(value)" }
        return "\(value)\n" + String(describing: next)
    }
    
    init(value: T) {
        self.value = value
    }
}


// Stack  class to hold the all items
class Stack<T>: CustomStringConvertible {
    
    var top: Node<T>?
    
    var description: String {
        guard let top = top else { return "---- Stack is EMPTY ----" }
        return "---- Stack Begin ----\n" + String(describing: top) + "\n---- Stack End ----"
    }
    
    func push(_ value: T) {
        let currentTop = top
        top = Node(value: value)
        top?.next = currentTop
    }
    
    @discardableResult
    func pop() -> T? {
        let currentTop = top
        top = top?.next
        return currentTop?.value
    }
    
    func peek() -> T? {
        return top?.value
    }
}



var stackString = Stack<String>()
stackString.push("First")
if let poppedItem = stackString.pop() {
    print("[\(poppedItem)] is popped from stack.")
}
stackString.push("Second")
stackString.push("Third")
print(stackString)





struct Student {
    let name: String
    let age: Int
}

let alex = Student(name: "Alex Murphy", age: 25)
let smith = Student(name: "Smith John", age: 34)
let rita = Student(name: "Rita Martin", age: 22)

var stackStudent = Stack<Student>()
stackStudent.push(alex)
stackStudent.push(smith)
stackStudent.push(rita)
stackStudent.pop()
print(stackStudent)

