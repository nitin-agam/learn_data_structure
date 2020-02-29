
// ***************** Doubly Linked List *********************

class Node<T>: CustomStringConvertible, Equatable {
    
    var value: T
    var next: Node<T>?
    weak var prev: Node<T>?
    
    // required conforms to CustomStringConvertible
    var description: String {
        guard let next = next else { return "\(value)" }
        return "\(value) -> " + String(describing: next)
    }
    
    init(_ value: T, prev: Node<T>?, next: Node<T>?) {
        self.value = value
        self.prev = prev
        self.next = next
    }
    
    // required conforms to Equatable
    static func ==(lhs: Node, rhs: Node) -> Bool {
        return lhs.next == rhs.next
    }
}


class DoublyLinkedList<T>: CustomStringConvertible {
    
    var head: Node<T>? = nil
    var tail: Node<T>? = nil
    
    var isEmpty: Bool {
        head == nil
    }
    
    // required conforms to CustomStringConvertible
    var description: String {
        guard let head = head else { return "Empty List !!!" }
        return String(describing: head)
    }
    
    init() {
        head = nil
        tail = head
    }
    
    func deleteAll() {
        head = nil
        tail = nil
    }
}


// common operations
extension DoublyLinkedList {
    
    var first: Node<T>? {
        head
    }
    
    var last: Node<T>? {
        tail
    }
    
    // to access a node using subscript opetion i.e. [index]
    subscript(index: Int) -> Node<T>? {
        node(at: index)
    }
    
    // get all the values in forward direction
    var forwardValues: [T]? {
        if isEmpty { return nil }
        var values: [T] = []
        var currentNode = head
        while currentNode != nil {
            values.append(currentNode!.value)
            currentNode = currentNode?.next
        }
        return values
    }
    
    // get all the values in backward direction
    var backwardValues: [T]? {
        if let tailNode = tail {
            var values: [T] = []
            var previousNode = tailNode
            repeat {
                values.append(previousNode.value)
                if let previous = previousNode.prev {
                    previousNode = previous
                }
            } while previousNode.prev != nil
            return values
        }
        return nil
    }
    
    // get a node from a specific position
    func node(at index: Int) -> Node<T>? {
        
        // if list is empty then return nil
        if isEmpty { return nil }
        
        if index >= 0 {
            var currentNode = head
            var currentIndex = 0
            while currentNode != nil && currentIndex < index {
                currentNode = currentNode?.next
                currentIndex += 1
            }
            return currentNode
        }
        return nil
    }
    
    func length() -> Int {
        var currentNode = head
        var length = 0
        while currentNode != nil {
            length += 1
            currentNode = currentNode?.next
        }
        return length
    }
}

// insertion operations
extension DoublyLinkedList {
    
    // insert a value at start
    func push(_ value: T) {
        if isEmpty {
            head = Node(value, prev: nil, next: nil)
            tail = head
        } else {
            let newNode = Node(value, prev: nil, next: head)
            head?.prev = newNode
            head = newNode
        }
    }
    
    // insert a value at end
    func append(_ value: T) {
        let newNode = Node(value, prev: nil, next: nil)
        if let tail = tail {
            newNode.prev = tail
            tail.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }
    
    // insert a value after at given index
    func insert(after index: Int, value: T) -> Bool {
        if let node = node(at: index) {
            
            if node == tail {
                append(value)
                return true
            }
            
            let newNode = Node(value, prev: node, next: node.next)
            if let oldNextNode = node.next {
                node.next = newNode
                oldNextNode.prev = newNode
                return true
            }
        }
        return false
    }
}

// deletion operations
extension DoublyLinkedList {
    
    // remove the first element of the list
    @discardableResult
    func pop() -> T? {
        defer {
            head = head?.next
            head?.prev = nil
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    // remove the last element of the list
    @discardableResult
    func deleteLast() -> T? {
        guard var tailNode = tail, var headNode = head else { return nil }
        defer {
            if tailNode == headNode {
                tail = nil
                head = nil
            } else if let prev = tailNode.prev {
                tail = prev
                tail?.next = nil
            }
        }
        return tailNode.value
    }
    
    // remove an element from a specific position
    func remove(at index: Int) -> T? {
        if let node = self.node(at: index) {
            
            if node == head {
                return pop()
            }
            
            if node == tail {
                return deleteLast()
            }
            
            defer {
                let prev = node.prev
                let next = node.next
                prev?.next = node.next
                next?.prev = node.prev
            }
            return node.value
        }
        return nil
    }
}


var stringList = DoublyLinkedList<String>()
stringList.push("one")
stringList.push("two")
stringList.push("three")
stringList.append("four")
stringList.insert(after: 2, value: "five")
stringList.pop()
print(stringList)

