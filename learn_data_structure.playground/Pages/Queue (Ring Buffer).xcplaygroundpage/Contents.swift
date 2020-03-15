

struct RingBufferQueue<T>: CustomStringConvertible {
    
    private var elements: [T?]
    private var front = -1
    private var rear = -1
    
    init(count: Int) {
        elements = Array(repeating: nil, count: count)
    }
    
    var isEmpty: Bool {
        front == -1 && rear == -1
    }
    
    var isFull: Bool {
        ((rear + 1) % elements.count) == front
    }
    
    var description: String {
        if isEmpty { return "Queue is empty..." }
        return "---- Queue start ----\n"
            + elements.map({String(describing: "\($0)")}).joined(separator: " -> ")
            + "\n---- Queue End ----\n"
    }
    
    var peek: T? {
        if isEmpty { return nil }
        return elements[front]
    }
}

extension RingBufferQueue {
    
    // to enqueue an element
    mutating func enqueue(_ element: T) -> Bool {
        
        // if queue is empty
        if front == -1 && rear == -1 {
            front = 0
            rear = 0
            elements[rear] = element
            return true
        }
        
        if isFull {
            print("QUEUE IS FULL")
            return false
        }
        
        rear = (rear + 1) % elements.count
        elements[rear] = element
        return true
    }
}

extension RingBufferQueue {
    
    // to dequeue an element
    mutating func dequeue() -> T? {
        
        if isEmpty {
            print("QUEUE IS EMPTY")
            return nil
        }
        
        // if queue has only single element
        if front == rear {
            defer {
                elements[front] = nil
                front = -1
                rear = -1
            }
            return elements[front]
        }
        
        defer {
            elements[front] = nil
            front = (front + 1) % elements.count
        }
        return elements[front]
    }
}




var queue = RingBufferQueue<String>(count: 10)
queue.enqueue("1")
queue.enqueue("2")
queue.enqueue("3")
queue.enqueue("4")
queue.enqueue("5")
if let dequeuedElement = queue.dequeue() {
    print("Dequeued Element: \(dequeuedElement)")
}
queue.enqueue("6")
if let dequeuedElement = queue.dequeue() {
    print("Dequeued Element: \(dequeuedElement)")
}
if let dequeuedElement = queue.dequeue() {
    print("Dequeued Element: \(dequeuedElement)")
}
queue.enqueue("7")
queue.enqueue("8")
queue.enqueue("9")
queue.dequeue()
print(queue)
print(queue.peek)




