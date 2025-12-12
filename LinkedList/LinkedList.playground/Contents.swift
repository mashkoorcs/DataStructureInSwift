import Foundation

class Node {
    var data: Int
    var next: Node?
    
    init(_ data: Int, _ next: Node? = nil) {
        self.data = data
        self.next = next
    }
}

class LinkList {
    private var head: Node?
    
    func addFront(_ data: Int) {
        let newNode = Node(data)
        newNode.next = head
        head = newNode
    }
    
    func getFirst() -> Int? {
        if head == nil {
            return nil
        }
        return head!.data
    }
        
    func addBack(_ data: Int) {
        let newNode = Node(data)
        
        if head == nil {
            head = newNode
            return
        }

        var node = head!
        while(node.next != nil) {
            node = node.next!
        }
        node.next = newNode
    }

    func getLast() -> Int? {
        if head == nil {
            return nil
        }

        var node = head!
        while(node.next != nil) {
            node = node.next!
        }
        return node.data
    }

    func insert(position: Int, data: Int) {
        if position == 0 {
            addFront(data)
            return
        }
            
        let newNode = Node(data)
        var currentNode = head

        for _ in 0..<position - 1{
            currentNode = currentNode?.next!
        }
        newNode.next = currentNode?.next
        currentNode?.next = newNode
    }
    
    func deleteFirst() {
        head = head?.next
    }
    
    func delete(at position: Int) {
        if position == 0 {
            self.deleteFirst()
            return
        }
        
        var nextNode = head
        var previousNode: Node?
        for _ in 0..<position {
            previousNode = nextNode
            nextNode = nextNode?.next
        }
        previousNode?.next = nextNode?.next
    }

    func deleteLast() {
        if head?.next == nil {
            head = nil
            return
        }

        var nextNode = head
        var previousNode: Node?
        while(nextNode?.next != nil) {
            previousNode = nextNode
            nextNode = nextNode?.next
        }
        previousNode?.next = nil
    }
    
    func delete(data: Int) {
        if head == nil { return }
        if head!.data == data {
            head = head?.next
        }
        
        let current = head
        while current?.next != nil {
            if current?.next?.data == data {
                current?.next = current?.next?.next
                return
            }
        }
    }

    var isEmpty: Bool {
        return head == nil
    }
    
    func clear() {
        head = nil
    }

    func printLinkedList() {
        if head == nil {
            print("Empty")
            return
        }
        
        var result = [Int]()
        var node = head
        result.append(node!.data)
        
        while node?.next != nil {
            result.append(node!.next!.data)
            node = node?.next
        }
        
        print(result)
    }
}

let linkedList = LinkList()
linkedList.addFront(3)
linkedList.addFront(2)
linkedList.addFront(1)
linkedList.printLinkedList()

linkedList.getFirst()

linkedList.addBack(4)
linkedList.printLinkedList()

linkedList.getLast()

linkedList.insert(position: 2, data: 5)
linkedList.printLinkedList()

linkedList.deleteFirst()
linkedList.printLinkedList()

linkedList.deleteLast()
linkedList.printLinkedList()

linkedList.delete(at: 1)
linkedList.printLinkedList()

linkedList.deleteLast()
linkedList.printLinkedList()

linkedList.deleteLast()
linkedList.printLinkedList()


// More generic way for LinkedList
/*
 Step 1: Create the Node class
 
 class Node<T> {
     var value: T
     var next: Node?

     init(value: T) {
         self.value = value
         self.next = nil
     }
 }

 Step 2: Create the LinkedList class
 
 class LinkedList<T> {
     private var head: Node<T>?

     var isEmpty: Bool {
         return head == nil
     }

     // Add new value at the end
     func append(_ value: T) {
         let newNode = Node(value: value)
         if let lastNode = getLastNode() {
             lastNode.next = newNode
         } else {
             head = newNode
         }
     }

     // Helper function to find last node
     private func getLastNode() -> Node<T>? {
         var currentNode = head
         while currentNode?.next != nil {
             currentNode = currentNode?.next
         }
         return currentNode
     }

     // Print all elements
     func printList() {
         var currentNode = head
         while let node = currentNode {
             print(node.value, terminator: " -> ")
             currentNode = node.next
         }
         print("nil")
     }
 
 // Insert at the beginning
 func insertAtHead(_ value: T) {
     let newNode = Node(value: value)
     newNode.next = head
     head = newNode
 }

 // 🗑 Delete a value
 func delete(_ value: T) where T: Equatable {
     var current = head
     var previous: Node<T>?

     while current != nil {
         if current!.value == value {
             if previous == nil {
                 head = current!.next
             } else {
                 previous!.next = current!.next
             }
             return
         }
         previous = current
         current = current!.next
     }
 }

 func toArray() -> [T] {
     var arr: [T] = []
     var current = head
     while let node = current {
         arr.append(node.value)
         current = node.next
     }
     return arr
 }


 }

 Step 3: Try it out in a Swift Playground
 let list = LinkedList<Int>()
 list.append(10)
 list.append(20)
 list.append(30)

 print("Linked List elements:")
 list.printList()

 */


//Example: Using LinkedList as a Queue

/*
 class Queue<T> {
     private var list = LinkedList<T>()

     func enqueue(_ value: T) {
         list.append(value)
     }

     func dequeue() -> T? {
         let arr = list.toArray()
         if let first = arr.first {
             list.delete(first)
             return first
         }
         return nil
     }

     func printQueue() {
         list.printList()
     }
 }

 */

//🧠 What is a Doubly Linked List?
//
//A Doubly Linked List (DLL) is a data structure where each node has:
//
//A value
//
//A reference to the next node
//
//A reference to the previous node
//
//📈 This allows bidirectional traversal — forward and backward.

class DoublyNode<T> {
    var value: T
    var next: DoublyNode?
    weak var previous: DoublyNode?  // weak to avoid strong reference cycles

    init(value: T) {
        self.value = value
    }
}

class DoublyLinkedList<T> {
    private var head: DoublyNode<T>?
    private var tail: DoublyNode<T>?

    var isEmpty: Bool {
        return head == nil
    }

    // Append value to the end
    func append(_ value: T) {
        let newNode = DoublyNode(value: value)
        if let tailNode = tail {
            tailNode.next = newNode
            newNode.previous = tailNode
        } else {
            head = newNode
        }
        tail = newNode
    }

    // Insert value at the head
    func insertAtHead(_ value: T) {
        let newNode = DoublyNode(value: value)
        if let headNode = head {
            newNode.next = headNode
            headNode.previous = newNode
        } else {
            tail = newNode
        }
        head = newNode
    }

    // Print list forward
    func printForward() {
        var current = head
        while let node = current {
            print(node.value, terminator: " <-> ")
            current = node.next
        }
        print("nil")
    }

    // Print list backward
    func printBackward() {
        var current = tail
        while let node = current {
            print(node.value, terminator: " <-> ")
            current = node.previous
        }
        print("nil")
    }
    
    func toArray() -> [T] {
        var arr: [T] = []
        var current = head
        while let node = current {
            arr.append(node.value)
            current = node.next
        }
        return arr
    }

}

extension DoublyLinkedList where T: Equatable {
    func delete(_ value: T) {
        var current = head

        while let node = current {
            if node.value == value {
                let prev = node.previous
                let next = node.next

                if let prev = prev {
                    prev.next = next
                } else {
                    head = next  // deleting head
                }

                if let next = next {
                    next.previous = prev
                } else {
                    tail = prev  // deleting tail
                }

                return
            }
            current = node.next
        }
    }
}



//LRU cache
//🧱 Step 1: Create Node Class
class CacheNode<Key: Hashable, Value> {
    let key: Key
    var value: Value
    var next: CacheNode?
    weak var previous: CacheNode?

    init(key: Key, value: Value) {
        self.key = key
        self.value = value
    }
}

//🧱 Step 2: Create Doubly Linked List Helper

class DoublyLinkedListt<Key: Hashable, Value> {
    private(set) var head: CacheNode<Key, Value>?
    private(set) var tail: CacheNode<Key, Value>?

    func insertAtHead(_ node: CacheNode<Key, Value>) {
        node.next = head
        node.previous = nil
        head?.previous = node
        head = node

        if tail == nil {
            tail = node
        }
    }

    func moveToHead(_ node: CacheNode<Key, Value>) {
        if head === node { return }

        remove(node)
        insertAtHead(node)
    }

    func remove(_ node: CacheNode<Key, Value>) {
        let prev = node.previous
        let next = node.next

        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }

        if let next = next {
            next.previous = prev
        } else {
            tail = prev
        }

        node.next = nil
        node.previous = nil
    }

    func removeTail() -> CacheNode<Key, Value>? {
        guard let tail = tail else { return nil }
        remove(tail)
        return tail
    }
}

//⚙️ Step 3: Build the LRU Cache Class
class LRUCache<Key: Hashable, Value> {
    private var dict: [Key: CacheNode<Key, Value>] = [:]
    private var list = DoublyLinkedListt<Key, Value>()
    private let capacity: Int

    init(capacity: Int) {
        self.capacity = max(1, capacity)
    }

    func get(_ key: Key) -> Value? {
        guard let node = dict[key] else {
            return nil
        }

        // Move accessed node to head (most recent)
        list.moveToHead(node)
        return node.value
    }

    func put(_ key: Key, _ value: Value) {
        if let node = dict[key] {
            // Update value and move to head
            node.value = value
            list.moveToHead(node)
        } else {
            let newNode = CacheNode(key: key, value: value)
            list.insertAtHead(newNode)
            dict[key] = newNode

            if dict.count > capacity {
                if let removed = list.removeTail() {
                    dict[removed.key] = nil
                }
            }
        }
    }

    func printCacheOrder() {
        var current = list.head
        print("Cache state (most recent -> least): ", terminator: "")
        while let node = current {
            print("[\(node.key):\(node.value)]", terminator: " <-> ")
            current = node.next
        }
        print("nil")
    }
}


//Example 1: Given the head of a linked list with an odd number of nodes head, return the value of the node in the middle.
//
//For example, given a linked list that represents 1 -> 2 -> 3 -> 4 -> 5, return 3.

 
func findMiddle(_ head: Node?) -> Int {
    
    var slow = head
    var fast = head
    
    while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
    }
    return slow?.data ?? -1
    
}

//option2 - - iterative

func getMiddle(_ head: Node?) -> Int {
    guard var head = head else { return -1 }  // handle empty list
    
    var length = 0
    var dummy = head
    
    // 1️⃣ Count length
    while let _ = dummy.next {
        length += 1
        dummy = dummy.next!
    }
    
    // Add 1 because loop counts edges, not nodes
    length += 1
    
    // 2️⃣ Move head to middle
    for _ in 0..<(length / 2) {
        if let next = head.next {
            head = next
        }
    }
    
    // 3️⃣ Return middle value
    return head.data
}


//// Example usage:
//let one = Node(1)
//let two = Node(2)
//let three = Node(3)
//let four = Node(4)
//let five = Node(5)
//
//print(findMiddle(one))  // Output: 3
//




//Given the head of a linked list, determine if the linked list has a cycle.
//
//There is a cycle in a linked list if there is some node in the list that can be reached again by continuously following the next pointer.
//
//
//

func hasCycle(_ head: Node?) -> Bool {
    var fast = head
    var slow = head
    
    while fast != nil && fast?.next != nil {
        
        slow = slow?.next
        fast = fast?.next?.next
        
        if slow === fast {
            return true
        }
    }
    
    return false
 }


   // Example 3: Given the head of a linked list and an integer k, return the kth
 // node from the end.

//For example, given the linked list that represents 1 -> 2 -> 3 -> 4 -> 5 and k = 2, return the node with value 4, as it is the 2nd node from the end.
  
func findKthfromEnd(_ head: Node?,_ k:Int) -> Node? {
    
    var slow = head
    var fast = head
    
    for i in 0..<k {
        fast = fast?.next
    }
    
    while fast != nil {
        fast = fast?.next
        slow = slow?.next
    }
    return slow
}


// Given the head of a sorted linked list, delete all duplicates such that each element appears only once. Return the linked list sorted as well.



func deleteDuplicates(_ head: Node?) -> Node? {
     
    var current = head
    
    
    while current != nil && current?.next != nil {
        
        if current?.data == current?.next?.data {
            current?.next = current?.next?.next
        }
        else {
            current = current?.next
        }
    }
    return head
}

 // for unoredered linkedList , dublicate node removal .......

func deleteDuplicateUnOrdered(_ head: Node?) -> Node? {
    
    var seen = Set<Int>()
    var dummy = Node(0)
    dummy.next = head
    var prev: Node? = dummy
   var current = head
    
     while current != nil {
         if seen.contains(current!.data){
             prev?.next = current?.next
         } else {
             seen.insert(current!.data)
             prev = current
         }
         current = current?.next
        
    }
    
    return dummy.next
}




 // reverse a linked list ios swift

func reversLinkedList(_ head: Node?) -> Node? {
     
    var prev: Node? = nil
    var curr = head
    
    while curr != nil {
        let currNext = curr?.next
        curr?.next = prev
        prev = curr
        curr = currNext
    }
    return prev
}

// recursive approach

func reverseListRecursive(_ head: Node?) -> Node? {
    // Base case: empty list or single node
    guard let head = head, head.next != nil else {
        return head
    }
    
    let newHead = reverseListRecursive(head.next)
    head.next?.next = head
    head.next = nil
    
    return newHead
}

// swap node in parallel
//Given the head of a linked list, swap every pair of nodes. For example, given a linked list 1 -> 2 -> 3 -> 4 -> 5 -> 6, return a linked list 2 -> 1 -> 4 -> 3 -> 6 -> 5.

func SwapLinkedListNode(_ head: Node?) -> Node? {
    var dummy = Node(0)
    dummy.next = head
    var prev: Node? = dummy
    
    while prev?.next != nil && prev?.next?.next != nil {
        
        let first = prev?.next
        let second = prev?.next?.next
        
        // Swapping
        first?.next = second?.next
        second?.next = first
        
        prev?.next = second
        
        // Move prev two nodes ahead
        prev = first
        
    }
   
    return dummy.next
}


  // recursive implementation of swap node -- Above solutions

func swapPairs(_ head: Node?) -> Node? {
    // Base case: 0 or 1 node, no swapping
    guard let first = head, let second = head?.next else {
        return head
    }
    
    // Swap
    first.next = swapPairs(second.next)  // Recursively swap the rest
    second.next = first                  // Point second to first
    
    // Now second is the new head of this swapped pair
    return second
}


//Given the head of a singly linked list and two integers left and right where left <= right, reverse the nodes of the list from position left to position right, and return the reversed list. (NEED TO UNDERSATAND THE SOLUTION)

func reverseBetween(_ head: Node?, _ left: Int, _ right: Int) -> Node? {
    if head == nil || left == right {
        return head
    }
    
    let dummy = Node(0)
    dummy.next = head
    var prev: Node? = dummy
    
    // 1. Move `prev` to the node just before `left`
    for _ in 0..<(left - 1) {
        prev = prev?.next
    }
    
    // 2. Start reversing the sublist
    let start = prev?.next
    var then = start?.next
    
    for _ in 0..<(right - left) {
        start?.next = then?.next
        then?.next = prev?.next
        prev?.next = then
        then = start?.next
    }
    
    return dummy.next
}



//
