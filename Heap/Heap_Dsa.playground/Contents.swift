import UIKit

var greeting = "Hello, playground"

// Heap Data structure

//A heap is a data structure that is an implementation of the priority queue.

//Note that a priority queue is an abstract data structure. A heap is one of many ways to implement a priority queue. However, people often use the two terms interchangeably. In this course, we will use the term "heap".

//A heap is a container that stores elements, and supports the following operations:



//Add an element in O(logn)
//Remove the minimum element in O(logn)
//Find the minimum element in O(1)


// The ability to find the max/min element in constant time, while only needing logarithmic time to maintain this ability through changes makes a heap an extremely powerful data structure.


// There are multiple ways to implement a heap, although the most popular way is called a binary heap using an array. In the trees and graphs chapter, we saw that binary trees are typically implemented with a Node object.


// A binary heap implements a binary tree, but with only an array. The idea is that each element in the array is a node in the tree. The smallest element in the tree is the root, and the following property is maintained at every node: if A is the parent of B, then A.val <= B.val. Notice that this property directly implies that the root is the smallest element.


// Note :  Another constraint is that the tree must be a complete tree.

// If you're dealing with numbers and you want to deal with the opposite type of heap that your language implements, an easy way to do this is to multiply all numbers by -1.

   //parent(i) = floor((i - 1)/2)
   //left(i)   = 2i + 1
   //right(i)  = 2i + 2




   // for insertion visual representations

//    📊 Visual Example (Min Heap)
//    Let's say you insert 3 into this Min Heap:
//
//    [1, 5, 6, 7]
//    Insert: 3 ➜ [1, 5, 6, 7, 3]
//                 ↑
//              index = 4
//    Parent of index 4 is (4 - 1) / 2 = 1, which is 5.
//
//    Since 3 < 5, we swap them:
//
//    [1, 3, 6, 7, 5]
//    We now check 3 vs 1. No swap needed. Heap is valid.


//    This is how we "bubble up" the element.
//
//    🔍 Step-by-Step Example
//    Let’s say we have a Min Heap, and we’re inserting 2 into this array:
//
//    Index:      0   1   2   3   4
//    elements = [5, 10, 15, 20, 2]
//                     ↑
//                  child = 4
//    Find parent
//    parent = (4 - 1) / 2 = 1, which is 10.
//
//    Compare
//    2 < 10 ⇒ violates Min Heap ⇒ swap 2 and 10
//
//    Now the array is:
//
//
//    [5, 2, 15, 20, 10]
//    Update indices to continue upward
//
//
//    child = parent        // child is now at index 1 (where 2 was moved)
//    parent = (1 - 1) / 2  // parent = 0
//    Compare again
//    2 < 5 ⇒ violates ⇒ swap again
//
//    Now:
//
//    [2, 5, 15, 20, 10]
//    ✅ Heap property is now restored.


//    🔍 Step-by-Step Breakdown:
//    Check if the heap is empty.
//
//                Swap the root (index 0) with the last element.
//
//                Remove the last element (which was the root).
//
//                Restore heap property by moving the new root down the tree.
//
//                📘 Example – Min Heap
//    Initial heap (min-heap, smallest on top):
//
//
//    Index:        0   1   2   3   4
//   Array:       [2, 3, 5, 8, 4]
//   Tree:
//        2
//       / \
//      3   5
//     / \
//    8   4
// 🔧 Step 1: swapAt(0, 4)
// Swap root (2) with last element (4):
//
// Array becomes: [4, 3, 5, 8, 2]
// 🗑️ Step 2: removeLast()
// Remove the last item (2, which was originally root):
//
//
// Array becomes: [4, 3, 5, 8]
// Now, 4 is temporarily at the root, but this may violate heap order. So we must fix the heap.
//
// 🔽 siftDown(from: 0)
//
// private mutating func siftDown(from index: Int) {
//    var parent = index
//    while true {
//        let left = 2 * parent + 1
//        let right = 2 * parent + 2
//        var candidate = parent
//
//        if left < count && areSorted(elements[left], elements[candidate]) {
//            candidate = left
//        }
//        if right < count && areSorted(elements[right], elements[candidate]) {
//            candidate = right
//        }
//        if candidate == parent { return }
//        elements.swapAt(parent, candidate)
//        parent = candidate
//    }
//}
// 📘 Continue the example:
// Array before siftDown:
//
//
//        4
//       / \
//      3   5
//     /
//    8
//  Step 1:
//  parent = 0, left = 1, right = 2
//
//  Compare: elements[1] = 3 and elements[0] = 4
//  ✅ 3 < 4 → candidate = 1
//
//  Swap 4 and 3 → [3, 4, 5, 8]
//
//  New tree:
//
//
//        3
//       / \
//      4   5
//     /
//    8
//   Step 2:
//   parent = 1, left = 3, right = 4
//
//   Compare: elements[3] = 8 and elements[1] = 4
//   ❌ 8 > 4 → No swap
//
//   ✅ Done. Heap is valid again.
//
//   ✅ Final Array:
//
//   [3, 4, 5, 8]




import Foundation

struct Heap<T> {
    var elements: [T] = []
    private let areSorted: (T, T) -> Bool

    init(sort: @escaping (T, T) -> Bool) {
        self.areSorted = sort
    }

    var isEmpty: Bool { elements.isEmpty }
    var count: Int { elements.count }
    func peek() -> T? { elements.first }

    mutating func insert(_ value: T) {
        elements.append(value)
        siftUp(from: elements.count - 1)
    }

    mutating func remove() -> T? {
        guard !elements.isEmpty else { return nil }
        elements.swapAt(0, elements.count - 1)
        let item = elements.removeLast()
        siftDown(from: 0)
        return item
    }

    private mutating func siftUp(from index: Int) {
        var child = index
        var parent = (child - 1) / 2
        while child > 0 && areSorted(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = (child - 1) / 2
        }
    }

    private mutating func siftDown(from index: Int) {
        var parent = index
        while true {
            let left = 2 * parent + 1
            let right = 2 * parent + 2
            var candidate = parent

            if left < count && areSorted(elements[left], elements[candidate]) {
                candidate = left
            }
            if right < count && areSorted(elements[right], elements[candidate]) {
                candidate = right
            }
            if candidate == parent { return }
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
}
// MARK: - Solution Using Heap

class Solution {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var frequencyMap: [Int: Int] = [:]
        for num in nums {
            frequencyMap[num, default: 0] += 1
        }

        // Max heap based on frequency (compare first element of tuple)
        var maxHeap = Heap<(Int, Int)>(sort: { $0.0 > $1.0 })

        for (num, freq) in frequencyMap {
            maxHeap.insert((freq, num))
        }

        var result: [Int] = []
        for _ in 0..<k {
            if let top = maxHeap.remove() {
                result.append(top.1)
            }
        }

        return result
    }
}




let solution = Solution()
let result = solution.topKFrequent([1,1,1,2,2,3], 2)
print(result) // Output: [1, 2]




// Problem based on Heap

// Problem 1 --   Last Stone Weight
//You are given an array of integers stones where stones[i] is the weight of the ith  stone. On each turn, we choose the heaviest two stones and smash them together. Suppose the heaviest two stones have weights x and y with x <= y. If x == y, then both stones are destroyed. If x != y, then x is destroyed and y loses x weight. Return the weight of the last remaining stone, or 0 if there are no stones left.


   
func lastStoneWeight(_ stones: [Int]) -> Int {
    var maxHeap = Heap<Int>(sort: >) // Max Heap
    for stone in stones {
        maxHeap.insert(stone)
    }

    while maxHeap.count > 1 {
        let stone1 = maxHeap.remove()!
        let stone2 = maxHeap.remove()!

        if stone1 != stone2 {
            maxHeap.insert(abs(stone1 - stone2))
        }
    }

    return maxHeap.peek() ?? 0
}


 // Example --
   //let result = lastStoneWeight([2,7,4,1,8,1])
     //print(result)  // Output: 1





//Example 2: 2208. Minimum Operations to Halve Array Sum You are given an array nums of positive integers. In one operation, you can choose any number from nums and reduce it to exactly half the number. Return the minimum number of operations to reduce the sum of nums by at least half.


import Foundation

// Custom Max Heap implementation using PriorityQueue
struct MaxHeap<T: Comparable> {
    private var elements: [T] = []
    
    var isEmpty: Bool { elements.isEmpty }
    
    mutating func insert(_ value: T) {
        elements.append(value)
        siftUp(from: elements.count - 1)
    }
    
    mutating func remove() -> T? {
        guard !elements.isEmpty else { return nil }
        elements.swapAt(0, elements.count - 1)
        let removed = elements.removeLast()
        siftDown(from: 0)
        return removed
    }
    
    private mutating func siftUp(from index: Int) {
        var child = index
        var parent = (child - 1) / 2
        while child > 0 && elements[child] > elements[parent] {
            elements.swapAt(child, parent)
            child = parent
            parent = (child - 1) / 2
        }
    }
    
    private mutating func siftDown(from index: Int) {
        var parent = index
        while true {
            let left = 2 * parent + 1
            let right = 2 * parent + 2
            var candidate = parent
            if left < elements.count && elements[left] > elements[candidate] {
                candidate = left
            }
            if right < elements.count && elements[right] > elements[candidate] {
                candidate = right
            }
            if candidate == parent { return }
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
}

func halveArray(_ nums: [Int]) -> Int {
    var heap = MaxHeap<Double>()
    var totalSum: Double = 0
    
    for num in nums {
        let doubleVal = Double(num)
        totalSum += doubleVal
        heap.insert(doubleVal)
    }
    
    var reducedSum = 0.0
    var operations = 0
    let target = totalSum / 2.0
    
    while reducedSum < target {
        if let maxVal = heap.remove() {
            let half = maxVal / 2.0
            reducedSum += half
            heap.insert(half)
            operations += 1
        }
    }
    
    return operations
}

//exapmple
//let result = halveArray([5, 19, 8, 1])
//print(result) // Output: 3


// Alternative solutions

import Foundation

func halfArray(_ nums: [Int]) -> Int {
    // Convert all elements to Double and negate for max-heap behavior
    var heap = nums.map { -Double($0) }
    var target = heap.reduce(0, +) / -2.0  // sum(nums) / 2
    var operations = 0

    // Use Swift's heapify equivalent: sort descending
    heap.sort()

    while target > 0 {
        operations += 1

        // Remove the largest (most negative value, because max-heap is simulated with negatives)
        let largest = heap.removeFirst()
        let halved = largest / 2

        target += halved  // since largest is negative, halved is less negative → adds value
        insertHeap(&heap, halved)  // insert and maintain heap
    }

    return operations
}

// Insertion helper to maintain max-heap behavior using array (sorted descending)
func insertHeap(_ heap: inout [Double], _ value: Double) {
    // Binary insertion to keep array sorted (descending order)
    var left = 0, right = heap.count
    while left < right {
        let mid = (left + right) / 2
        if heap[mid] < value {
            right = mid
        } else {
            left = mid + 1
        }
    }
    heap.insert(value, at: left)
}



// PROBLEM 2

//You are given a 0-indexed integer array piles, where piles[i] represents the number of stones in the ith pile, and an integer k. You should apply the following operation exactly k times:

//Choose any piles[i] and remove floor(piles[i] / 2) stones from it.
//Notice that you can apply the operation on the same pile more than once.
//
//Return the minimum possible total number of stones remaining after applying the k operations.
//
//floor(x) is the largest integer that is smaller than or equal to x (i.e., rounds x down).
//
//please provide detail explanation in swift ios
//



func minStoneSum(_ piles: [Int], _ k: Int) -> Int {
    var heap = MaxHeap<Int>()
    
    // Step 1: Insert all piles into max heap
    for pile in piles {
        heap.insert(pile)
    }
    
    // Step 2: Perform k operations
    for _ in 0..<k {
        if let largest = heap.remove() {
            let reduced = largest - largest / 2  // same as ceil(largest / 2)
            heap.insert(reduced)
        }
    }
    
    // Step 3: Sum remaining stones
    var total = 0
    while let val = heap.remove() {
        total += val
    }
    return total
}



// HEAP PROBLEM

//You have some number of sticks with positive integer lengths. These lengths are given as an array sticks, where sticks[i] is the length of the ith stick.
//
//You can connect any two sticks of lengths x and y into one stick by paying a cost of x + y. You must connect all the sticks until there is only one stick remaining.
//
//Return the minimum cost of connecting all the given sticks into one stick in this way.
//

//Example 1:
//
//Input: sticks = [2,4,3]
//Output: 14
//Explanation: You start with sticks = [2,4,3].
//1. Combine sticks 2 and 3 for a cost of 2 + 3 = 5. Now you have sticks = [5,4].
//2. Combine sticks 5 and 4 for a cost of 5 + 4 = 9. Now you have sticks = [9].
//There is only one stick left, so you are done. The total cost is 5 + 9 = 14.




// MARK: - Minimum cost function
/// Returns the minimum total cost to connect all sticks into one.
/// If `sticks.count <= 1` returns 0.
func minCostToConnectSticks(_ sticks: [Int]) -> Int {
    guard sticks.count > 1 else { return 0 }
    
    // Min-heap for integers
    var minHeap = Heap<Int> { $0 < $1 }
    for s in sticks { minHeap.insert(s) }
    
    var totalCost = 0
    while minHeap.count > 1 {
        // pop two smallest
        guard let a = minHeap.remove(), let b = minHeap.remove() else { break }
        let merged = a + b
        totalCost += merged
        minHeap.insert(merged)
    }
    return totalCost
}

// Example usage:
//let sticks1 = [2, 4, 3]
//print(minCostToConnectSticks(sticks1)) // prints 14
//
//let sticks2 = [1, 8, 3, 5]
//print(minCostToConnectSticks(sticks2)) // prints 30
//



// Heap Example problem


//Given an integer array nums and an integer k, return the k most frequent elements. It is guaranteed that the answer is unique.
//please provide solution in swift

func topKElements(_ nums:[Int],_ k: Int) -> [Int]{
    
    var frequencyMap: [Int: Int] = [:]
    
    for num in nums {
        frequencyMap[num, default: 0] += 1
    }
    var minHeap = Heap<(Int,Int)>(sort: {$0.0 < $1.0})
    
    for (num,freq) in frequencyMap {
        minHeap.insert((freq,num))
        if minHeap.count>k {
            _ = minHeap.remove()
        }
    }
    
    var result:[Int] = []
    
    while let top = minHeap.remove(){
        result.append(top.1)
    }
    return result
}

// Example usage:
//let nums = [1,1,1,2,2,3]
//let k = 2
//print(topKFrequent(nums, k)) // Output: [2, 1] (order can vary)








// To be understand Heap sort and Heapify

// ✅ What is Heap Sort?
// Heap Sort is a popular comparison-based sorting algorithm that uses a binary heap data structure to sort elements in-place and with good time complexity.
//
//  It has:
//  Time complexity: O(n log n) for all cases (best, average, worst)
//  Space complexity: O(1) (in-place sort)
//  Not stable (doesn’t preserve order of equal elements)




  
    //Here’s a simplified in-place heap sort in Swift:


func heapSort(_ array: inout [Int]) {
    // Step 1: Build Max Heap
    func heapify(_ array: inout [Int], _ count: Int, _ i: Int) {
        var largest = i
        let left = 2 * i + 1
        let right = 2 * i + 2
        
        if left < count && array[left] > array[largest] {
            largest = left
        }
        if right < count && array[right] > array[largest] {
            largest = right
        }
        if largest != i {
            array.swapAt(i, largest)
            heapify(&array, count, largest)
        }
    }
    
    let count = array.count
    
    // Build Max Heap from bottom up
    for i in stride(from: count / 2 - 1, through: 0, by: -1) {
        heapify(&array, count, i)
    }
    
    // Extract max one by one and rebuild heap
    for i in stride(from: count - 1, to: 0, by: -1) {
        array.swapAt(0, i)
        heapify(&array, i, 0)
    }
}



///🔧 Example Usage:

 var numbers = [3, 1, 4, 2]
 heapSort(&numbers)
 print(numbers) // [1, 2, 3, 4]


  // 📌 Swift Implementation: Heap Sort (Using Max Heap)

 func heapSort2(_ array: inout [Int]) {
     let n = array.count

     // Step 1: Build Max Heap
     for i in stride(from: n / 2 - 1, through: 0, by: -1) {
         heapify(&array, n, i)
     }

     // Step 2: One by one extract elements
     for i in stride(from: n - 1, through: 1, by: -1) {
         array.swapAt(0, i) // Move current root to end
         heapify(&array, i, 0) // Rebuild heap for reduced array
     }
 }

// Helper function to maintain heap property
 func heapify(_ array: inout [Int], _ heapSize: Int, _ rootIndex: Int) {
     var largest = rootIndex
     let left = 2 * rootIndex + 1
     let right = 2 * rootIndex + 2

     // If left child exists and is greater than root
     if left < heapSize && array[left] > array[largest] {
         largest = left
     }

     // If right child exists and is greater than largest so far
     if right < heapSize && array[right] > array[largest] {
         largest = right
     }

     // If largest is not root, swap and heapify the affected subtree
     if largest != rootIndex {
         array.swapAt(rootIndex, largest)
         heapify(&array, heapSize, largest)
     }
}


     
