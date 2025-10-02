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


