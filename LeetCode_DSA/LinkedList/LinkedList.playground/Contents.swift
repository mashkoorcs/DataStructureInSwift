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

func hasCycle(_ head: Node?) -> Bool{
    var fast = head
    var slow = head
    
    while slow?.next != nil && fast?.next != nil {
        
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



