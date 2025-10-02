import UIKit

var greeting = "Hello, playground"

//Given an array of integers nums and an integer target, return indices of two numbers such that they add up to target. You cannot use the same index twice.

 
 // BRUTE FORCE
func twoSumBruteForce(_ nums: [Int], _ target: Int) -> [Int] {
    
    for i in 0..<nums.count {
        for j in (i+1)..<nums.count {
            if nums[i]+nums[j] > target {
                return [i,j]
            }
        }
    }
    return []
}

//let nums = [2, 7, 11, 15]
//let target = 9
//print(twoSumBruteForce(nums, target))  // Output: [0, 1]

 
//OPTIMIZED Two SUM USING DICTIONARY
func twoSumOptemized(_ nums: [Int], _ target: Int) -> [Int] {
    var numsToIndex: [Int:Int] = [:]
    
    for (index,num) in nums.enumerated() {
        
        let complement = target - num
        
        if let complementIndex = numsToIndex[complement] {
            return [complementIndex, index]
        }
        
        numsToIndex[num] = index
    }
    
    return []
}

//let nums = [2, 7, 11, 15]
//let target = 9
//print(twoSumBruteForce(nums, target))  // Output: [0, 1]

 
//Two Pointers
func twoSumTwoPointers(_ nums: [Int], _ target: Int) -> [Int] {
    
    var numsWithIndex = nums.enumerated().map { ($0.offset,$0.element)}
    
    numsWithIndex.sort{$0.1 < $1.1}
    
    var leftptr = 0
    var rightptr = nums.count-1
     
    while leftptr < rightptr {
        
        let sum = numsWithIndex[leftptr].1 + numsWithIndex[rightptr].1
        if sum == target {
            return [numsWithIndex[leftptr].0, numsWithIndex[rightptr].0]
            
        } else if sum < target {
            leftptr += 1
        } else {
            rightptr += 1
        }
    }
    
    return []
}

//let nums = [2, 7, 11, 15]
//let target = 9
//print(twoSumBruteForce(nums, target))  // Output: [0, 1]


// TwoSum problem using SET

func twoSum(_ nums: [Int],_ target: Int) -> [Int] {
   
    var seen = Set<Int>()
    
    for num in nums {
        
     let complement = target - num
        if seen.contains(complement) {
            return [complement,num]
        }
        
        seen.insert(num)
    }
    
    return []
}

//let nums = [2, 7, 11, 15]
//let target = 9
//print(twoSum(nums, target))  // Output: [0, 1]


func dublicateChar(_ str: String) -> String {
    
    var seen = Set<Character>()
    
    for st in str {
        
        if seen.contains(st){
            return String(st)
        }
        
        seen.insert(st)
    }
    
    return " "
}


// Given an integer array nums, find all the unique numbers x in nums that satisfy the following: x + 1 is not in nums, and x - 1 is not in nums.
func findNumbers(_ nums: [Int]) -> [Int] {
        var ans = [Int]()
        var numsSet = Set<Int>()
        
        for num in nums {
            numsSet.insert(num)
        }
        
        for num in numsSet {
            if !numsSet.contains(num + 1) && !numsSet.contains(num - 1) {
                ans.append(num)
            }
        }
        
        return ans
    }


// IS PANAgram
func isPAnagram(_ str: String) -> Bool {
    var seen = Set<Character>()
    
    for st in str.lowercased() {
        
        if st >= "a" && st <= "z" {
            seen.insert(st)
        }
    }
    return seen.count == 26
}


 //Given an array nums containing n distinct numbers in the range [0, n], return the only number in the range that is missing from the array.

 
func missingNumber(_ num: [Int]) -> Int {
    let numSet = Set(num)
    
    for i in 0...num.count {
        if numSet.contains(i) {
            return i
        }
    }
    
    return -1
}

  // Given an integer array arr, count how many elements x there are, such that x + 1 is also in arr. If there are duplicates in arr, count them separately.

func NumberArray(_ num: [Int]) -> [Int] {
    
    var arrSet = Set(num)
    var arrX = [Int]()
    for i in 0...num.count-1 {
        
        let x = num[i] + 1
        
        if arrSet.contains(i) {
            arrX.append(x)
        }
    }
    
     return arrX
    
}



// You are given a string s and an integer k. Find the length of the longest substring that contains at most k distinct characters.


func lengthOFLongestSubStringKDistinct(_ str: String, _ k: Int) -> Int {
    
    if k==0 || str.isEmpty {
        return 0
    }
    
    var left = 0
    var maxlength = 0
    var chars = Array(str)
    var elementCount : [Character:Int] = [:]
    
    for right in 0...chars.count-1 {
        
        elementCount[chars[right],default: 0] += 1
        
        while elementCount.keys.count > k {
            elementCount[chars[left]]! -= 1
            
            if elementCount[chars[left]]! == 0 {
                elementCount.removeValue(forKey: chars[left])
            }
            
            left += 1
        }
        
        maxlength = max(maxlength,right-left+1)
    }
    
    return maxlength
}

print(lengthOFLongestSubStringKDistinct("eceba", 2))  // Output: 3 ("ece")
print(lengthOFLongestSubStringKDistinct("aa", 1))




//Given a 2D array nums that contains n arrays of distinct integers, return a sorted array containing all the numbers that appear in all n arrays.
//For example, given nums = [[3,1,2,4,5],[1,2,3,4],[3,4,5,6]], return [3, 4]. 3 and 4 are the only numbers that are in all arrays.

func interSection(_ nums: [[Int]]) -> [Int] {
    guard !nums.isEmpty else { return []}
    
    var countMap = [Int:Int]()
    let totalArrays = nums.count
    
    for array in nums {
        for arr in Set(array) {
            countMap[arr, default: 0] += 1
        }
    }
    
    var result: [Int] = []
    
    for (num,count) in countMap {
         
        if count == totalArrays {
            result.append(num)
        }
    }
    
    return result.sorted()
}

//let nums = [[3,1,2,4,5],[1,2,3,4],[3,4,5,6]]
//print(interSection(nums))


 // using SET
func interSectionArray(_ nums: [[Int]]) -> [Int] {
    
    guard var common = nums.first.map(Set.init) else {
        return []
    }
    
    for arr in nums.dropFirst() {
        common.formIntersection(Set(arr))
    }
    
    return Array(common).sorted()
}

//let nums = [[3,1,2,4,5],[1,2,3,4],[3,4,5,6]]
//print(interSection(nums))

// using one liner REDUCE
class Solution {
    func intersection(_ nums: [[Int]]) -> [Int] {
        return Array(nums.map(Set.init).reduce(nums.first.map(Set.init) ?? []) { $0.intersection($1) }).sorted()
    }
}



//Example 3: 1941. Check if All Characters Have Equal Number of Occurrences
//
//Given a string s, determine if all characters have the same frequency.
//
//For example, given s = "abacbc", return true. All characters appear twice. Given s = "aaabb", return false. "a" appears 3 times, "b" appears 2 times. 3 != 2.


func charEqualFrequencies(_ str:String) -> Bool {
    
   
    var charCountDict = [Character:Int]()
    
    for char in str {
        charCountDict[char, default: 0] += 1
        
    }
      
    
    var frequencies = charCountDict.values
   
    
    return Set(frequencies).count == 1 ? true : false
}



// one liner using REDUCE..

func areOccurrencesEqual(_ s: String) -> Bool {
      Set(s.reduce(into: [:]) { $0[$1, default: 0] += 1 }.values).count == 1
  }





