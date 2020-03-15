

struct TwoStackQueue<T>: CustomStringConvertible {
    
    private var leftStack: [T] = []
    private var rightStack: [T] = []
    
    var isEmpty: Bool {
        leftStack.isEmpty && rightStack.isEmpty
    }
    
    var peek: T? {
        leftStack.isEmpty ? rightStack.first : leftStack.last
    }
    
    var description: String {
        
        if isEmpty {
            return "Queue is empty..."
        }
        var allElements: [T] = []
        if leftStack.isEmpty == false {
            allElements.append(contentsOf: leftStack.reversed())
        }
        allElements.append(contentsOf: rightStack)
        
        return "---- Queue start ----\n"
            + allElements.map({"\($0)"}).joined(separator: " -> ")
            + "\n---- Queue End ----"
    }
}

extension TwoStackQueue {
    
    mutating func enqueue(_ element: T) {
        rightStack.append(element)
    }
}

extension TwoStackQueue {
    
    mutating func dequeue() -> T? {
        
        if isEmpty {
            return nil
        }
        
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        
        return leftStack.removeLast()
    }
}

var queue = TwoStackQueue<String>()
print(queue)
queue.dequeue()
queue.enqueue("1")
queue.enqueue("2")
queue.enqueue("3")
queue.dequeue()
queue.enqueue("4")
queue.enqueue("5")
queue.enqueue("6")
queue.dequeue()
print(queue.peek)
print(queue)

