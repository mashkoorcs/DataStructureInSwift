import UIKit

var greeting = "Hello, playground"


//-----------Two pointers------------------//


//Two pointers is an extremely common technique used to solve array and string problems. It involves having two integer variables that both move along an iterable. In this article, we are focusing on arrays and strings. This means we will have two integers, usually named something like i and j, or left and right which each represent an index of the array or string.


// Start the pointers at the edges of the input. Move them towards each other until they meet.


//Converting this idea into instructions:
//
//1. Start one pointer at the first index 0 and the other pointer at the last index input.length - 1.
//2. Use a while loop until the pointers are equal to each other.
//3. At each iteration of the loop, move the pointers towards each other. This means either increment the pointer that started at the first index, decrement the pointer that started at the last index, or both. Deciding which pointers to move will depend on the problem we are trying to solve.


// Pseudo code for two pointer concept :
/*
function fn(arr):
    left = 0
    right = arr.length - 1

    while left < right:
        Do some logic here depending on the problem
        Do some more logic here to decide on one of the following:
            1. left++
            2. right--
            3. Both left++ and right--
                                    */




// Example : Palindrome number

func isPalindrome(_ s: String) -> Bool {

    let chars = Array(s)
    var left = 0
    var right = chars.count-1

    while left < right {
        print("the char is is \(chars[left]) and \(chars[right])")
        if chars[left] != chars[right] {
            return false
        }
        left += 1
        right -= 1
    }

    return true
}

isPalindrome("manam")


// Example 2: Given a sorted array of unique integers and a target integer, return true if there exists a pair of numbers that sum to target, false otherwise


func findTarget(_ nums: [Int], target: Int) -> Bool {
     var left = 0
    var right = nums.count-1
    
    while left < right {
        let curr = nums[left] + nums[right]
        if curr == target {
            return true
        }
        else if curr > target {
            right -= 1
        } else {
            left += 1
        }
    }
    return false
}


//Example: Given two sorted integer arrays arr1 and arr2, return a new array that combines both of them and is also sorted.

func combineArray<T:Comparable>(_ arr1: [T], _ arr2: [T]) -> [T] {
    var i = 0
    var j = 0
    var ans: [T] = []
    
    // Merge while both arrays have elements
    while i < arr1.count && j < arr2.count {
        if arr1[i] < arr2[j] {
            ans.append(arr1[i])
            i += 1
        } else {
            ans.append(arr2[j])
            j += 1
        }
    }
    
    // Append remaining elements of arr1
    while i < arr1.count {
        ans.append(arr1[i])
        i += 1
    }
    
    // Append remaining elements of arr2
    while j < arr2.count {
        ans.append(arr2[j])
        j += 1
    }
    return ans
}





class SolutionSubsquence {
    func isSubsequence(_ s: String, _ t: String) -> Bool {
        var i = s.startIndex
        var j = t.startIndex
        
        while i < s.endIndex && j < t.endIndex {
            if s[i] == t[j] {
                i = s.index(after: i)
            }
            j = t.index(after: j)
        }
        
        return i == s.endIndex
    }
}


func reverseString(_ s: inout [String]) {

        var i = 0
        var j = s.count-1
        var newArr = s
        while i < j {
           newArr[i] = s[j]
            newArr[j] = s[i]
            i += 1
            j -= 1
        }
        s = newArr
        print("the s is is \(s)")
    }

    var arr = ["h","e","l","l","o"]
  print(reverseString(&arr))



//class Solution {
//func sortedSquares(_ nums: inout [Int]) {
//
//    var left = 0
//    var right = nums.count-1
//    var newArr = Array(repeating: 0, count: nums.count)
//
//    var index = nums.count-1
//
//    while left <= right {
//
//       let leftAbs = abs(nums[left])
//       let rightAbs = abs(nums[right])
//
//        if leftAbs > rightAbs {
//            nums[index] = nums[left] * nums[left]
//            left += 1
//        } else {
//            nums[index] = nums[right] * nums[right]
//            right -= 1
//        }
//
//            index -= 1
//
//    }
//
//}
// }
//var nums = [-7, -3, 0, 2, 5]
//let sol = Solution()
//print(sol.sortedSquares(&nums))


//class Solution {
//    func sortedSquares(_ nums: inout [Int]) {
//        var left = 0
//        var right = nums.count - 1
//        var index = nums.count - 1
//
//        while left <= right {
//            let leftAbs = abs(nums[left])
//            let rightAbs = abs(nums[right])
//
//            if leftAbs > rightAbs {
//                nums[index] = leftAbs * leftAbs
//                left += 1
//            } else {
//                nums[index] = rightAbs * rightAbs
//                right -= 1
//            }
//            index -= 1
//        }
//    }
//}
//
//var nums = [-7, -3, 0, 2, 5]
//let sol = Solution()
//sol.sortedSquares(&nums)
//print(nums)
//// Output: [0, 4, 9, 25, 49]


//class Solution {
//    func sortedSquares(_ nums: inout [Int]) {
//        var left = 0
//        var right = nums.count - 1
//        var index = nums.count - 1  // Track position to insert
//
//        while left <= right {
//            let leftAbs = abs(nums[left])
//            let rightAbs = abs(nums[right])
//
//            if leftAbs > rightAbs {
//                nums[index] = leftAbs * leftAbs
//                left += 1
//            } else {
//                nums[index] = rightAbs * rightAbs
//                right -= 1
//            }
//            index -= 1  // Move insertion index backward
//        }
//    }
//}
//
//var nums = [-7, -3, 0, 2, 5]
//let sol = Solution()
//sol.sortedSquares(&nums)  // No print required, modifies nums directly
//print(nums)  // Output: [0, 4, 9, 25, 49]


//func maxSubArray(_ s: String) -> Int {
//
//       var charArray = Array(s)
//       var left = 0
//       var right = 0
//       var ans = 0
//       var cur = 0
//
//    for char in 0...charArray.count-1 {
//        if charArray[char] == "0" {
//              cur += 1
//          }
//           while cur > 1 {
//               cur -= 1
//               left += 1
//           }
//           right += 1
//           ans = max(ans, right - left + 1)
//       }
//       return ans
//   }
//
//
//   maxSubArray("1101100111")
//
//
//func subArrayavg(_ arr: [Int], _ k: Int)-> Int {
//
//      var curr = 0
//      var ans = 0
//      for i in 0...k {
//           curr += arr[i]
//      }
//      ans = curr/k
//
//      for i in (k+1)...arr.count-1 {
//         curr += arr[i] + arr[i-k]
//          ans = max(ans, curr/i)
//      }
//      return ans
//  }



//func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
//    if nums.count < k || k <= 0 {
//        return 0.0
//    }
//    
//    var curr = 0
//    for i in 0..<k {
//        curr += nums[i]
//    }
//    
//    var ans = Double(curr)
//    
//    for i in k..<nums.count {
//        curr += nums[i] - nums[i - k]  // Slide window
//        ans = max(ans, Double(curr))
//    }
//    
//    return Double(ans)/Double(k)
//}
//
//  findMaxAverage([1,12,-5,-6,50,3], 4)
//
//
//class Solution {
//    func answerQueries(_ nums: [Int], _ queries: [[Int]], _ limit: Int) -> [Bool] {
//        // Build prefix sum array
//        var prefix = [Int](repeating: 0, count: nums.count)
//        prefix[0] = nums[0]
//        for i in 1..<nums.count {
//            prefix[i] = nums[i] + prefix[i - 1]
//        }
//        
//        // Process queries
//        var result = [Bool]()
//        for query in queries {
//            let x = query[0]
//            let y = query[1]
//            let sum = prefix[y] - (x > 0 ? prefix[x - 1] : 0)
//            result.append(sum < limit)
//        }
//        
//        return result
//    }
//}
//
//


// --------------------------Sliding Window Problem-----------------------------------------------//

// Example 1: Given an array of positive integers nums and an integer k, find the length of the longest subarray whose sum is less than or equal to k. This is the problem we have been talking about above. We will now formally solve it.

class SolutionFindLength {
    func findLength(_ nums: [Int], _ k: Int) -> Int {
        var left = 0
        var curr = 0
        var ans = 0
        
        for right in 0...nums.count-1 {
            curr += nums[right]
            while curr > k {
                curr -= nums[left]
                left += 1
            }
            ans = max(ans, right-left+1)
        }
          return ans
    }
}


//Example 2: You are given a binary string s (a string containing only "0" and "1"). You may choose up to one "0" and flip it to a "1". What is the length of the longest substring achievable that contains only "1"?
//
//For example, given s = "1101100111", the answer is 5. If you perform the flip at index 2, the string becomes 1111100111.


func findLengthMaxOne(_ str: String) -> Int {
    var curr = 0
    var ans = 0
    var left = 0
    var arrayStr = Array(str)
    
    for right in 0...arrayStr.count-1 {
        
        if arrayStr[right] == "0" {
            curr += 1
        }
        while curr > 1{
            if arrayStr[left] == "0" {
                curr -= 1
            }
            left += 1
        }
        
        ans = max(ans, right-left+1)
    }
    return ans
}


//Example 3: 713. Subarray Product Less Than K.
//
//Given an array of positive integers nums and an integer k, return the number of subarrays where the product of all the elements in the subarray is strictly less than k.
//
//For example, given the input nums = [10, 5, 2, 6], k = 100, the answer is 8. The subarrays with products less than k are:
//
//[10], [5], [2], [6], [10, 5], [5, 2], [2, 6], [5, 2, 6]


func findNumOfSubArray(_ num: [Int],_ k: Int) -> Int {
    var left = 0
    var curr = 1
    var ans = 0
    
    for right in 0...num.count-1 {
       curr *= num[right]
        
        while curr >= k {
            curr /= num[right]
            left += 1
        }
        ans += (right-left+1)
    }
    return ans
}


// Example 4: Given an integer array nums and an integer k, find the sum of the subarray with the largest sum whose length is k.

func findBestSubarray(_ nums: [Int], _ k: Int) -> Int {
       // compute sum of first k elements
       var curr = 0
       for i in 0..<k {
           curr += nums[i]
       }
       
       var ans = curr
       
       // slide the window
       for i in k..<nums.count {
           curr += nums[i] - nums[i - k]
           ans = max(ans, curr)
       }
       
       return ans
   }





//----------------------------------Prefix sum---------------------------------------//

// Prefix sums allow us to find the sum of any subarray in
//O(1). If we want the sum of the subarray from i to j (inclusive), then the answer is prefix[j] - prefix[i - 1], or alternatively prefix[j] - prefix[i] + nums[i] if you don't want to deal with the out of bounds case when i = 0.
//
//This works because prefix[i - 1] is the sum of all elements before index i. When you subtract this from the sum of all elements up to index j, you are left with the sum of all elements starting at index i and ending at index j, which is exactly what we are looking for.


/*
 
Building a prefix sum is very simple. Here's some pseudocode:

Given an array nums,

prefix = [nums[0]]
for (int i = 1; i < nums.length; i++)
    prefix.append(nums[i] + prefix[prefix.length - 1])


    */

//Example 1: Given an integer array nums, an array queries where queries[i] = [x, y] and an integer limit, return a boolean array that represents the answer to each query. A query is true if the sum of the subarray from x to y is less than limit, or false otherwise.

//For example, given nums = [1, 6, 3, 2, 7, 2], queries = [[0, 3], [2, 5], [2, 4]], and limit = 13, the answer is [true, false, true]. For each query, the subarray sums are [12, 14, 12].



// solution--1

import Foundation

func checkSubarraySums(_ nums: [Int], _ queries: [[Int]], _ limit: Int) -> [Bool] {
    // Step 1: Build prefix sum array
    var prefix = [0]
    for num in nums {
        prefix.append(prefix.last! + num)
    }
    
    // Step 2: Answer each query using prefix sums
    var result = [Bool]()
    for query in queries {
        let x = query[0]
        let y = query[1]
        
        let subarraySum = prefix[y + 1] - prefix[x]
        result.append(subarraySum < limit)
    }
    
    return result
}

//// Example usage:
//let nums = [1, 6, 3, 2, 7, 2]
//let queries = [[0, 3], [2, 5], [2, 4]]
//let limit = 13
//
//let output = checkSubarraySums(nums, queries, limit)
//print(output) // [true, false, true]
//

// solution 2 -- less recomended--------

import Foundation

func answerQueries(_ nums: [Int], _ queries: [[Int]], _ limit: Int) -> [Bool] {
    // Step 1: Build prefix sum array
    var prefix = [nums[0]]
    for i in 1..<nums.count {
        prefix.append(nums[i] + prefix.last!)
    }
    
    // Step 2: Process each query
    var ans = [Bool]()
    for query in queries {
        let x = query[0]
        let y = query[1]
        
        let curr = prefix[y] - prefix[x] + nums[x]
        ans.append(curr < limit)
    }
    
    return ans
}

// Example usage:
//let nums = [1, 6, 3, 2, 7, 2]
//let queries = [[0, 3], [2, 5], [2, 4]]
//let limit = 13
//
//let output = answerQueries(nums, queries, limit)
//print(output)  // [true, false, true]



// soultion 3 ---------------- covers all edge cases---------

import Foundation

// Errors for the strict/throwing API:
enum QueryError: Error, CustomStringConvertible {
    case emptyNumsButQueriesExist
    case malformedQuery(index: Int)           // query doesn't have exactly 2 ints
    case invalidRange(index: Int, x: Int, y: Int)
    
    var description: String {
        switch self {
        case .emptyNumsButQueriesExist:
            return "nums is empty but queries were provided."
        case .malformedQuery(let i):
            return "Query at index \(i) is malformed (expected exactly two integers)."
        case .invalidRange(let i, let x, let y):
            return "Query at index \(i) has invalid range (x=\(x), y=\(y)). Expected 0 <= x <= y < nums.count."
        }
    }
}

/*
 Strict / throwing variant:
 - Throws on invalid input (empty nums with queries, malformed queries, or out-of-bounds ranges)
 - Uses Int64 for prefix sums to reduce overflow risk.
 - Uses leading-zero prefix so building prefix is safe even if nums is empty.
*/
func answerQueriesThrowing(_ nums: [Int], _ queries: [[Int]], _ limit: Int) throws -> [Bool] {
    // If nums empty but queries non-empty, treat as invalid input.
    if nums.isEmpty {
        if queries.isEmpty { return [] } // nothing to do
        throw QueryError.emptyNumsButQueriesExist
    }
    
    let n = nums.count
    // Build leading-zero prefix with Int64
    var prefix = [Int64](repeating: 0, count: n + 1)
    for i in 0..<n {
        prefix[i + 1] = prefix[i] + Int64(nums[i])
    }
    
    var result = [Bool]()
    let limit64 = Int64(limit)
    
    for (i, q) in queries.enumerated() {
        guard q.count == 2 else { throw QueryError.malformedQuery(index: i) }
        let x = q[0], y = q[1]
        
        guard 0 <= x && x <= y && y < n else {
            throw QueryError.invalidRange(index: i, x: x, y: y)
        }
        
        let sumXY = prefix[y + 1] - prefix[x]   // Int64
        result.append(sumXY < limit64)
    }
    return result
}

/*
 Forgiving / safe variant:
 - Never throws.
 - Builds Int64 prefix (leading zero).
 - For each query:
     - if query invalid (malformed or out-of-range) -> append nil
     - else append Bool (true/false)
 - Use this if you prefer to continue processing even on invalid queries.
*/
func answerQueriesSafe(_ nums: [Int], _ queries: [[Int]], _ limit: Int) -> [Bool?] {
    let n = nums.count
    var prefix = [Int64](repeating: 0, count: n + 1)
    for i in 0..<n {
        prefix[i + 1] = prefix[i] + Int64(nums[i])
    }
    
    var result = [Bool?]()
    let limit64 = Int64(limit)
    
    for q in queries {
        guard q.count == 2 else {
            result.append(nil)
            continue
        }
        let x = q[0], y = q[1]
        guard 0 <= x && x <= y && y < n else {
            result.append(nil)
            continue
        }
        let sumXY = prefix[y + 1] - prefix[x]
        result.append(sumXY < limit64)
    }
    return result
}

// ---------------------------
// Example usage and outputs:
// ---------------------------
do {
    // Normal example (your original case)
    let nums = [1, 6, 3, 2, 7, 2]
    let queries = [[0, 3], [2, 5], [2, 4]]
    let limit = 13
    let ans = try answerQueriesThrowing(nums, queries, limit)
    print("Normal example:", ans) // -> [true, false, true]
    
    // Empty nums + empty queries -> empty result (non-error)
    let emptyResult = try answerQueriesThrowing([], [], 10)
    print("Empty/empty:", emptyResult) // -> []
    
    // Example of large values (safe with Int64)
    let bigNums = [1_000_000_000, 1_000_000_000, 1_000_000_000]
    let bigQueries = [[0, 2]] // sum = 3_000_000_000
    let bigLimit = 3_000_000_001
    let bigAns = try answerQueriesThrowing(bigNums, bigQueries, bigLimit)
    print("Large numbers example:", bigAns) // -> [true]
    
} catch {
    print("Thrown error:", error)
}

// Demonstrate safe variant behavior on invalid queries
let nums2 = [1,2,3]
let queries2 = [[0,2], [2,1], [0,10], [0]]   // contains valid, reversed, out-of-range, malformed
let safeResult = answerQueriesSafe(nums2, queries2, 10)
print("Safe results (nil means invalid query):", safeResult)
// Example output:
//   [Optional(true), nil, nil, nil]





// Example Number of Ways to Split Array Given an integer array nums, find the number of ways to split the array into two parts so that the first section has a sum greater than or equal to the sum of the second section. The second section should have at least one number.


class Solution {
    func waysToSplitArray(_ nums: [Int]) -> Int {
        let n = nums.count
        var prefix = [Int64](repeating: 0, count: n)
        prefix[0] = Int64(nums[0])
        
        for i in 1..<n {
            prefix[i] = Int64(nums[i]) + prefix[i - 1]
        }
        
        var ans = 0
        for i in 0..<n - 1 {
            let leftSection = prefix[i]
            let rightSection = prefix[n - 1] - prefix[i]
            if leftSection >= rightSection {
                ans += 1
            }
        }
        
        return ans
    }
}


    func waysToSplitArray(_ nums: [Int]) -> Int {
        var ans = 0
        var leftSection: Int64 = 0
        var total: Int64 = 0
        
        for num in nums {
            total += Int64(num)
        }
        
        for i in 0..<nums.count - 1 {
            leftSection += Int64(nums[i])
            let rightSection = total - leftSection
            if leftSection >= rightSection {
                ans += 1
            }
        }
        
        return ans
    }


// option 3
func wasyToSplitArray2(_ nums: [Int]) -> Int {
    
    var leftSection = 0
    var totlalSum =  nums.reduce(0,+)
    var count = 0
    
    for i in 0..<nums.count-1 {
        leftSection += nums[i]
        let rightSection = totlalSum - leftSection
        if leftSection > rightSection {
            count += 1
        }
    }
    
    return count
}


    func runningSum(_ nums: [Int]) -> [Int] {
        
        var prefix = [Int](repeating: 0, count: nums.count)
        
         prefix[0] = nums[0]
        
        for i in 1...nums.count-1 {
             prefix[i] = nums[i] + prefix[i-1]
            
        }
        
        return prefix
    }




// Practice DSA 



