import UIKit

var greeting = "Hello, playground"



//Example 1 Partition Array Such That Maximum Difference Is K
//
//Given an integer array nums and an integer k, split nums into subsequences, where each subsequences' maximum and minimum element is within k of each other. What is the minimum number of subsequences needed?
//
//For example, given nums = [3, 6, 1, 2, 5] and k = 2, the answer is 2. The subsequences are [3, 1, 2] and [6, 5].

 
func partitionArray(_ nums: [Int],_ K: Int) -> Int {
    
    let nums = nums.sorted()
    var x = nums[0]
    var ans = 1 
    
    for i in 1..<nums.count {
        if nums[i] - x > K {
            x = nums[i]
            ans += 1
        }
    }
    return ans
}


//Example 3: 502. IPO

//LeetCode would like to work on some projects to increase its capital before IPO. You are given n projects where the ith
//
//  project has a profit of profits[i] and a minimum capital of capital[i] is needed to start it. Initially, you have w capital. When you finish a project, the profit will be added to your total capital. Return the max capital possible if you are allowed to do up to k projects.

//Priority Queue for solving problem

struct PriorityQueue<T> {
    private var elements: [T]
    private let areSorted: (T, T) -> Bool

    init(sort: @escaping (T, T) -> Bool) {
        self.elements = []
        self.areSorted = sort
    }

    var isEmpty: Bool { elements.isEmpty }
    var count: Int { elements.count }
    func peek() -> T? { elements.first }

    mutating func push(_ value: T) {
        elements.append(value)
        siftUp(from: elements.count - 1)
    }

    mutating func pop() -> T? {
        guard !elements.isEmpty else { return nil }
        elements.swapAt(0, elements.count - 1)
        let value = elements.removeLast()
        siftDown(from: 0)
        return value
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
            let left = parent * 2 + 1
            let right = parent * 2 + 2
            var candidate = parent

            if left < elements.count && areSorted(elements[left], elements[candidate]) {
                candidate = left
            }
            if right < elements.count && areSorted(elements[right], elements[candidate]) {
                candidate = right
            }
            if candidate == parent { return }
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
}

// solution

struct Solution {
    func findMaximizedCapital(_ k: Int, _ w: Int, _ profits: [Int], _ capital: [Int]) -> Int {
        let n = profits.count
        
        // Pair and sort by capital requirement
        var projects = [(capital: Int, profit: Int)]()
        for i in 0..<n {
            projects.append((capital[i], profits[i]))
        }
        projects.sort { $0.capital < $1.capital }
        
        // max heap of profits
        var maxHeap = PriorityQueue<Int>(sort: >)
        
        var availableCapital = w
        var i = 0
        
        for _ in 0..<k {
            // add all projects we can afford
            while i < n && projects[i].capital <= availableCapital {
                maxHeap.push(projects[i].profit)
                i += 1
            }
            
            // no project can be done
            if maxHeap.isEmpty {
                return availableCapital
            }
            
            // pick highest profit
            availableCapital += maxHeap.pop()!
        }
        
        return availableCapital
    }
}




//Example  1481. Least Number of Unique Integers after K Removals
//
//Given an array of integers arr and an integer k, find the least number of unique integers after removing exactly k elements.


class Solution1 {
    func findLeastNumOfUniqueInts(_ arr: [Int], _ k: Int) -> Int {
        var freq: [Int: Int] = [:]
        
        for num in arr {
            freq[num, default: 0] += 1
        }
        
        var freqValue = freq.values.sorted()
        var k = k
        
        for i in 0..<freqValue.count {
            if k >= freqValue[i] {
                k -= freqValue[i]
                freqValue[i] = 0
            } else {
                break
            }
        }
        
        return freqValue.filter { $0 > 0 }.count
    }
}


//Example 5: 881. Boats to Save People

//You are given an array people where people[i] is the weight of the ith person. A boat can hold up to two people, if their weight combined is less than or equal to limit. What is the fewest number of boats you need to carry everyone? Note: no person is heavier than limit.


func numRescueBoats(_ people: [Int], _ limit: Int) -> Int {
       var people = people.sorted()
       var i = 0
       var j = people.count - 1
       var ans = 0
       
       while i <= j {
           if people[i] + people[j] <= limit {
               i += 1
           }
           j -= 1
           ans += 1
       }
       
       return ans
   }


//You have some apples and a basket that can carry up to 5000 units of weight.
//
//Given an integer array weight where weight[i] is the weight of the ith apple, return the maximum number of apples you can put in the basket.

 
func AppleBasket(_ nums:[Int]) -> Int {
    let sortedWeight = nums.sorted()
    var ans = 0 
    var AppleTotalWeight = 0
    
    for w in sortedWeight {
        if w + AppleTotalWeight <= 5000 {
            AppleTotalWeight += w
            ans += 1
        } else {
            break
        }
    }
    return ans
}


 // best time to buy and sell stock 

func maxProfit(_ prices: [Int]) -> Int {
       var minPrice = Int.max
       var maxProfit = 0
       
       for price in prices {
           // Track the minimum price seen so far
           minPrice = min(minPrice, price)
           
           // Track the maximum possible profit at this price
           maxProfit = max(maxProfit, price - minPrice)
       }
       
       return maxProfit
   }
