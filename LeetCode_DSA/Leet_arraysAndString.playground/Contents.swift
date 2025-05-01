import UIKit

var greeting = "Hello, playground"


//func isPalindrome(_ s: String) -> Bool {
//
//    let chars = Array(s)
//    var left = 0
//    var right = chars.count-1
//
//    while left < right {
//        print("the char is is \(chars[left]) and \(chars[right])")
//        if chars[left] != chars[right] {
//            return false
//        }
//        left += 1
//        right -= 1
//    }
//
//    return true
//}
//
//isPalindrome("manam")
//





//func reverseString(_ s: inout [String]) {
//
//        var i = 0
//        var j = s.count-1
//        var newArr = s
//        while i < j {
//           newArr[i] = s[j]
//            newArr[j] = s[i]
//            i += 1
//            j -= 1
//        }
//        s = newArr
//        print("the s is is \(s)")
//    }
//
//    var arr = ["h","e","l","l","o"]
//  print(reverseString(&arr))
//


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


    func runningSum(_ nums: [Int]) -> [Int] {
        
        var prefix = [Int](repeating: 0, count: nums.count)
        
         prefix[0] = nums[0]
        
        for i in 1...nums.count-1 {
             prefix[i] = nums[i] + prefix[i-1]
            
        }
        
        return prefix
    }


  

