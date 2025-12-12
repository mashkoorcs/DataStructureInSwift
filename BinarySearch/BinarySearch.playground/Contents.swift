import UIKit

var greeting = "Hello, playground"



//Binary search is a search algorithm that runs in O(logn)
//
//O(logn) in the worst case, where n is the size of the search space. For binary search to work, your search space usually needs to be sorted. Binary search trees, which we looked at in the trees and graphs chapter, are based on binary search.
//
//Normally, binary search is done on an array of sorted elements, but you can use binary search in more creative ways, as we'll see in an upcoming article. For now, we'll just talk about sorted arrays of numbers.
//
//If you have a sorted array arr and an element x, then in O(logn) time and O(1)
//O(1) space, binary search can:
//
//Find the index of x if it is in arr
//Find the first or the last index in which x can be inserted to maintain being sorted otherwise


//This is how binary search is implemented:
//
//Declare left = 0 and right = arr.length - 1. These variables represent the inclusive bounds of the current search space at any given time. Initially, we consider the entire array.
//While left <= right:
//Calculate the middle of the current search space, mid = (left + right) // 2 (floor division)
//  Check arr[mid]. There are 3 possibilities:
//    If arr[mid] = x, then the element has been found, return.
//    If arr[mid] > x, then halve the search space by doing right = mid - 1.
//    If arr[mid] < x, then halve the search space by doing left = mid + 1.
//    If you get to this point without arr[mid] = x, then the search was unsuccessful. The left pointer will be at the index where x would need to be inserted to maintain arr being sorted.
//
//Because the search space is halved at every iteration, binary search's worst-case time complexity is
//O(logn). This makes it an extremely powerful algorithm as logarithmic time is very fast compared to linear time.




// -- Binary Search Algorithm -------------//

func binarySearch(_ nums:[Int], target: Int) -> Int {
    var left = 0
    var right = nums.count-1
    
    while left < right {
        let mid = left + (right -  left)/2
        
        if nums[mid] == target {
            return mid
        }
        else if  nums[mid] < target {
              left = mid + 1
        } else {
              right = mid - 1
        }
    }
    return -1
}

// Example
//let numbers = [1, 3, 5, 7, 9, 11]
//print(binarySearch(numbers, target: 7))  // Output: 3 (index)
//print(binarySearch(numbers, target: 2))  // Output: -1 (not found)



// Recursive call for BINARY SEARCH

func binarySearchRecursive(_ nums: [Int], target: Int, left: Int, right: Int) -> Int {
    if left > right { return -1 }
    
    let mid = left + (right - left) / 2
    
    if nums[mid] == target {
        return mid
    } else if nums[mid] < target {
        return binarySearchRecursive(nums, target: target, left: mid + 1, right: right)
    } else {
        return binarySearchRecursive(nums, target: target, left: left, right: mid - 1)
    }
}

// Example
//let arr = [2, 4, 6, 8, 10]
//print(binarySearchRecursive(arr, target: 8, left: 0, right: arr.count - 1)) // Output: 3





//🔹 4. Using Swift’s Built-in Functions
//Swift’s Array has a binarySearch equivalent using firstIndex(where:) combined with binarySearch via Collection.binarySearch from Swift Algorithms package.
//But by default, you can simulate binary search for insertion:
//

extension Array where Element: Comparable {
    func binarySearch(_ target: Element) -> Int? {
        var left = 0
        var right = count - 1
        
        while left <= right {
            let mid = left + (right - left) / 2
            if self[mid] == target {
                return mid
            } else if self[mid] < target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return nil
    }
}

// Example
let sortedArray = [1, 4, 6, 9, 13]
print(sortedArray.binarySearch(9) ?? -1)  // Output: 3



//🔹 First Occurrence

func firstOccurrence(_ nums: [Int], _ target: Int) -> Int {
    var left = 0, right = nums.count - 1
    var answer = -1
    
    while left <= right {
        let mid = left + (right - left) / 2
        if nums[mid] == target {
            answer = mid          // candidate answer
            right = mid - 1       // keep looking left
        } else if nums[mid] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return answer
}



//🔹 Last Occurrence

func lastOccurrence(_ nums: [Int], _ target: Int) -> Int {
    var left = 0, right = nums.count - 1
    var answer = -1
    
    while left <= right {
        let mid = left + (right - left) / 2
        if nums[mid] == target {
            answer = mid          // candidate answer
            left = mid + 1        // keep looking right
        } else if nums[mid] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return answer
}



//3️⃣ Search Insert Position (Lower Bound)
//If the target isn’t found, sometimes you need the index where it should be inserted.

func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    var left = 0, right = nums.count
    
    while left < right {
        let mid = left + (right - left) / 2
        if nums[mid] < target {
            left = mid + 1
        } else {
            right = mid   // shrink towards left
        }
    }
    return left
}


//4️⃣ Condition-Based Binary Search (Not Just Arrays)
//Binary search isn’t only for arrays!
//You can binary search on:
//
//Answer space (e.g., "minimum time to finish jobs")
//
//Ranges (like "find smallest x such that condition(x) is true")


func binarySearchCondition(_ low: Int, _ high: Int, condition: (Int) -> Bool) -> Int {
    var left = low, right = high
    var answer = -1
    
    while left <= right {
        let mid = left + (right - left) / 2
        if condition(mid) {
            answer = mid
            right = mid - 1   // try smaller
        } else {
            left = mid + 1
        }
    }
    return answer
}


//Example  Search a 2D Matrix
//
//Write an efficient algorithm that searches for a value target in an m x n integer matrix matrix. Integers in each row are sorted from left to right. The first integer of each row is greater than the last integer of the previous row.

func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
    
    let m = matrix.count
    let n = matrix[0].count
    
    var left = 0 
    var right = m*n-1
    
    while left <= right {
        let mid = (left+right)/2
        let row = mid/n
        let col = mid%n
        
        let num = matrix[row][col]
        
        if num == target {
            return true
        }
        if num < target {
            left = mid + 1
        } else {
            right = mid-1
        }
    }
    return false
}


// Example 3: 2300. Successful Pairs of Spells and Potions

//You are given two positive integer arrays spells and potions, where spells[i] represents the strength of the ith
//spell and potions[j] represents the strength of the jth potion. You are also given an integer success. A spell and potion pair is considered successful if the product of their strengths is at least success. For each spell, find how many potions it can pair with to be successful. Return an integer array where the ith element is the answer for the ith spell.

func successFullPairs(_ spells: [Int],_ potions: [Int], _ success: Int) -> [Int] {
    
    func binarySearch(_ arr: [Int],_ target: Double) -> Int {
        
        var left = 0 
        var right = arr.count
        
        while left < right {
          let mid = (left+right)/2
            if arr[mid] <= right {
                right = mid
            } else {
                left = mid+1
            }
        }
        return left
    }
    
    
    var sortedPotions = potions.sorted()
    let m = potions.count
    var result = [Int]()

    for spell in spells {
        
        let target = Double(success)/Double(spell)
        let idx = (binarySearch(sortedPotions, target))
        result.append(m-idx)
    }    
    
    return result
}



//Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.

func insertPosition(_ num: [Int], _ target: Int) -> Int {
    
    var left = 0 
    var right = num.count
    
    while left < right {
        let mid = (right+left)/2
        
        if num[mid] == target {
            return mid
        }
        if num[mid]<target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }

    return left
}


//--------------------------on a solution space/answer ---------------------------------------------------------------------------------------------//


// problem 1 :Koko loves to eat bananas. There are n piles of bananas, the ith pile has piles[i] bananas. Koko can decide her bananas-per-hour eating speed of k. Each hour, she chooses a pile and eats k bananas from that pile. If the pile has less than k bananas, she eats all of them and will not eat any more bananas during the hour. Return the minimum integer k such that she can eat all the bananas within h hours.


func minEatingSpeed(_ piles: [Int], _ h: Int) -> Int {
    
    // Edge case
           if piles.isEmpty { return 0 }
    
    func check(_ k: Int) -> Bool {
        var hrs = 0 
        for pile in piles {
            hrs += Int(ceil(Double(pile)/Double(k)))
        }
            return hrs <= h
    }
    
    var left = 0 
    var right = piles.max()!
    
    while left <= right {
       let mid = (left + right)/2
        
        if check(mid){
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return left
}


func minTimeSpeet(_ dist: [Int], _ h: Double) -> Int {
    
    if dist.count > Int(ceil(h)){
        return -1 
    }
    
    func check(_ k: Int) -> Bool{
        var t = 0.0
        for dis in dist {
            t =  ceil(Double(t))
            t += Double(dis)/Double(t)
        }
        return t <= h
    }
    
    var left = 1 
    var right = 10_000_000
    
    while left <= right {
        let mid = (left+right)/2
        
        if check(mid){
            right = mid - 1
        } else {
            left = mid + 1
        }
        
    }
    return left
}
