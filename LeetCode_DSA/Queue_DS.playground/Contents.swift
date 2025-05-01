import UIKit

var greeting = "Hello, playground"
  

// --------Queue Data structure ----------------------

class Queue<T> {
    private var elements = [T]()
    
    func enqueue(_ value: T) {
        elements.append(value)
    }
    
    func dequeue() -> T? {
        return elements.isEmpty ? nil : elements.removeFirst()
    }
    
    func peek() -> T? {
        return elements.first
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
}

 

 //----------queue USING LinkedLIST

class Node<T> {
    var value: T
    var next: Node?
    
    init(_ value: T) {
        self.value = value
    }
}

class Queues<T> {
    private var head: Node<T>?
    private var tail: Node<T>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    func enqueue(_ value: T) {
        let newNode = Node(value)
        if let tailNode = tail {
            tailNode.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }
    
    func dequeue() -> T? {
        guard let headNode = head else {
            return nil
        }
        head = headNode.next
        if head == nil {
            tail = nil
        }
        return headNode.value
    }
    
    func peek() -> T? {
        return head?.value
    }
}


  // ------------------------------********************Problem********************************-------------

//Implement the RecentCounter class. It should support ping(int t), which records a call at time t, and then returns an integer representing the number of calls that have happened in the range [t - 3000, t]. Calls to ping will have increasing t.


class RecentCounter {
    private var queue: [Int]
    
    init() {
        queue = []
    }
    
    func ping(_ t: Int) -> Int {
        queue.append(t)
        
        // Remove all pings older than t - 3000
        while let first = queue.first, first < t - 3000 {
            queue.removeFirst()
        }
        
        return queue.count
    }
}

 // problem 2
 // Given a stream of integers and a window size, calculate the moving average of all integers in the sliding window.

//Implement the MovingAverage class:
//
//MovingAverage(int size) Initializes the object with the size of the window size.
//double next(int val) Returns the moving average of the last size values of the stream.






class MovingAverage {
    private var queue: [Int]
    private var size: Int
    private var sum: Double
    
    init(_ size: Int) {
        self.queue = []
        self.size = size
        self.sum = 0.0
    }
    
    func next(_ val: Int) -> Double {
        queue.append(val)
        sum += Double(val)
        
        // If window is too big, remove oldest
        if queue.count > size {
            let removed = queue.removeFirst()
            sum -= Double(removed)
        }
        
        return sum / Double(queue.count)
    }
}






 

//What's a Circular Queue?
//A normal queue (with an array) can get stuck even when space is available!
//
//To fix that, Circular Queue reuses empty slots by wrapping around to the beginning!
//
// How it works:
//Fixed-size array.
//
//Use two pointers: front and rear.
//
//When rear reaches end, it wraps to beginning (using modulo %).
//
//Avoid memory shifting.
//
//👉 Efficient O(1) enqueue and dequeue!

class CircularQueue<T> {
    private var queue: [T?]
    private var head: Int
    private var tail: Int
    private var size: Int
    private var capacity: Int

    init(_ capacity: Int) {
        self.capacity = capacity
        self.queue = Array(repeating: nil, count: capacity)
        self.head = 0
        self.tail = 0
        self.size = 0
    }
    
    var isEmpty: Bool {
        return size == 0
    }
    
    var isFull: Bool {
        return size == capacity
    }
    
    func enqueue(_ value: T) -> Bool {
        if isFull {
            return false
        }
        queue[tail] = value
        tail = (tail + 1) % capacity
        size += 1
        return true
    }
    
    func dequeue() -> T? {
        if isEmpty {
            return nil
        }
        let value = queue[head]
        queue[head] = nil
        head = (head + 1) % capacity
        size -= 1
        return value
    }
    
    func peek() -> T? {
        if isEmpty {
            return nil
        }
        return queue[head]
    }
}

//📚 Quick Example:

let queue = CircularQueue<Int>(3)

queue.enqueue(1) // true
queue.enqueue(2) // true
queue.enqueue(3) // true
queue.enqueue(4) // false (full)

queue.dequeue() // 1
queue.enqueue(4) // true (wraps around to front)

print(queue.peek()!) // 2
//🌟 Notice how it reuses space without shifting anything!


//Queue using Two Stacks
//🧠 Problem:
//Build a queue using two stacks!
//
//Idea:
//
//Stack1 is for input.
//
//Stack2 is for output.
//
//When you dequeue, if Stack2 is empty, move everything from Stack1 to Stack2 (reverses order).
//
//

//✍️ Swift Code for Queue using Two Stacks:

class QueueUsingStacks<T> {
    private var inputStack = [T]()
    private var outputStack = [T]()
    
    func enqueue(_ value: T) {
        inputStack.append(value)
    }
    
    func dequeue() -> T? {
        if outputStack.isEmpty {
            while let element = inputStack.popLast() {
                outputStack.append(element)
            }
        }
        return outputStack.popLast()
    }
    
    func peek() -> T? {
        if outputStack.isEmpty {
            while let element = inputStack.popLast() {
                outputStack.append(element)
            }
        }
        return outputStack.last
    }
    
    var isEmpty: Bool {
        return inputStack.isEmpty && outputStack.isEmpty
    }
}

 // 📚 Quick Example:

let queues = QueueUsingStacks<Int>()

queues.enqueue(10)
queues.enqueue(20)
queues.enqueue(30)

print(queues.dequeue()!) // 10
print(queues.peek()!)    // 20
queues.enqueue(40)
print(queues.dequeue()!) // 20

//🔥 Summary:
//
//Concept    Key Idea
//Circular Queue    Wrap around a fixed-size array using % modulo
//Queue with Two Stacks    Stack1 input, Stack2 output

// 📦 Time Complexity:

//Operation    Circular Queue    Two-Stacks Queue
//Enqueue    O(1)    Amortized O(1)
//Dequeue    O(1)    Amortized O(1)



//✍️ How to use Deque in Swift?
//First, install Swift Collections package (if needed):
//
//In Xcode > File > Swift Packages > Add Package Dependency
//
//URL: https://github.com/apple/swift-collections
//


//import DequeModule   //import needed

//var deque = Deque<Int>()
//
//// Insert at rear
//deque.append(1)
//deque.append(2)
//
//// Insert at front
//deque.prepend(0)
//
//// Now deque = [0, 1, 2]
//
//// Remove from front
//let front = deque.popFirst() // 0
//
//// Remove from rear
//let back = deque.popLast() // 2
//
//print(deque) // [1]


//Given an array nums and an integer k,
//find the maximum value in every sliding window of size k.
//
//Example:
//
//Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
//Output: [3,3,5,5,6,7]


//func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
//    var deque = Deque<Int>() // Deque to store indices
//    var result = [Int]()
//    
//    for i in 0..<nums.count {
//        // 1. Remove indices out of window
//        if let first = deque.first, first <= i - k {
//            deque.popFirst()
//        }
//        
//        // 2. Remove smaller values from back
//        while let last = deque.last, nums[last] < nums[i] {
//            deque.popLast()
//        }
//        
//        // 3. Add current index
//        deque.append(i)
//        
//        // 4. If window is ready (i >= k-1), add to result
//        if i >= k - 1 {
//            if let first = deque.first {
//                result.append(nums[first])
//            }
//        }
//    }
//    
//    return result
//}

// ✍️ Swift Code: Simple Linked List Deque
 
class Node1<T> {
    var value: T
    var next: Node1?
    weak var prev: Node1? // weak to avoid memory cycle
    
    init(_ value: T) {
        self.value = value
    }
}

class LinkedListDeque<T> {
    private var head: Node1<T>?
    private var tail: Node1<T>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    func pushFront(_ value: T) {
        let newNode = Node1(value)
        newNode.next = head
        head?.prev = newNode
        head = newNode
        if tail == nil {
            tail = head
        }
    }
    
    func pushBack(_ value: T) {
        let newNode = Node1(value)
        newNode.prev = tail
        tail?.next = newNode
        tail = newNode
        if head == nil {
            head = tail
        }
    }
    
    func popFront() -> T? {
        guard let h = head else { return nil }
        head = h.next
        head?.prev = nil
        if head == nil {
            tail = nil
        }
        return h.value
    }
    
    func popBack() -> T? {
        guard let t = tail else { return nil }
        tail = t.prev
        tail?.next = nil
        if tail == nil {
            head = nil
        }
        return t.value
    }
    
    func peekFront() -> T? {
        return head?.value
    }
    
    func peekBack() -> T? {
        return tail?.value
    }
}

 // circulurDeque

class MyCircularDeque {
    private var deque: [Int]
    private var capacity: Int
    
    init(_ k: Int) {
        self.capacity = k
        self.deque = []
    }
    
    func insertFront(_ value: Int) -> Bool {
        if isFull() {
            return false
        }
        deque.insert(value, at: 0)
        return true
    }
    
    func insertLast(_ value: Int) -> Bool {
        if isFull() {
            return false
        }
        deque.append(value)
        return true
    }
    
    func deleteFront() -> Bool {
        if isEmpty() {
            return false
        }
        deque.removeFirst()
        return true
    }
    
    func deleteLast() -> Bool {
        if isEmpty() {
            return false
        }
        deque.removeLast()
        return true
    }
    
    func getFront() -> Int {
        return isEmpty() ? -1 : deque.first!
    }
    
    func getRear() -> Int {
        return isEmpty() ? -1 : deque.last!
    }
    
    func isEmpty() -> Bool {
        return deque.isEmpty
    }
    
    func isFull() -> Bool {
        return deque.count == capacity
    }
}

let deque2 = MyCircularDeque(3)

deque2.insertLast(1) // true
deque2.insertLast(2) // true
deque2.insertFront(3) // true
deque2.insertFront(4) // false, full
deque2.getRear() // 2
deque2.isFull() // true
deque2.deleteLast() // true
deque2.insertFront(4) // true
deque2.getFront() // 4





