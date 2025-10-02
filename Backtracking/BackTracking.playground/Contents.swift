import UIKit

var greeting = "Hello, playground"

//Backtracking is a way to efficiently run through all possibilities in a problem. It typically uses an optimization that involves abandoning a "path" once it is determined that the path cannot lead to a solution. The idea is similar to binary search trees - if you're looking for a value x, and the root node has a value greater than x, then you know you can ignore the entire right subtree. Because the number of nodes in each subtree is exponential relative to the depth, backtracking can save huge amounts of computation. Imagine if the constraint was that the string could only have vowels - an exhaustive search would still generate all O(26n) strings, and then check each one for if it only had vowels. With backtracking, we discard all subtrees that have non-vowels, improving from O(5n)



// What is Backtracking?
//
//Backtracking is a general algorithmic technique for solving problems incrementally by:
//
//Building a solution step by step.
//
//Abandoning ("backtracking") a path as soon as it determines that the path cannot possibly lead to a valid solution.
//
//It’s often described as:
//
//"Try → Explore → Undo → Try something else."
//
//Think of it like exploring a maze:
//
//At each intersection, you choose a direction.
//
//If it leads to a dead end, you backtrack to the previous decision point and try a different path.
//

// When to Use Backtracking
//

//Backtracking is useful when:
//
//Problems require searching all possible combinations.
//
//You need to generate permutations, subsets, or combinations.
//
//You need to solve constraint satisfaction problems (Sudoku, N-Queens, Word Search, Maze problems).
//
//You need to find paths in recursive trees/graphs.


// Backtracking Template in Swift

//
//Here’s the general Swift pseudocode for backtracking:
//
//func backtrack(_ state: inout State, _ choices: [Choice]) {
//    if isSolution(state) {
//        recordSolution(state)
//        return
//    }
//
//    for choice in choices {
//        if isValid(state, choice) {
//            // Make the move
//            state.apply(choice)
//
//            // Explore deeper
//            backtrack(&state, choices)
//
//            // Undo the move (backtrack)
//            state.undo(choice)
//        }
//    }
//}
//
//

//Key ideas:
//
//isValid → prune invalid states early (optimization).
//
//apply / undo → change state and revert it back.
//
//recordSolution → collect results when a valid solution is found.


//🔹 Example 1: Generate All Subsets (Power Set)
func subsets(_ nums: [Int]) -> [[Int]] {
    var result = [[Int]]()
    var subset = [Int]()
    
    func backtrack(_ index: Int) {
        // Add current subset
        result.append(subset)
        
        // Explore choices
        for i in index..<nums.count {
            subset.append(nums[i])       // choose
            backtrack(i + 1)             // explore
            subset.removeLast()          // undo
        }
    }
    
    backtrack(0)
    return result
}

print(subsets([1,2,3]))
// [[], [1], [1,2], [1,2,3], [1,3], [2], [2,3], [3]]

/*
            []
        /       \
     [1]         []
    /   \       /   \
[1,2]   [1]   [2]     []
/   \    ...  / \     ...
[1,2,3] [1,2] [1,3] [2,3]  [3]

 */
/*
    []
    ├── [1]
    │   ├── [1,2]
    │   │   └── [1,2,3]
    │   └── [1,3]
    ├── [2]
    │   └── [2,3]
    └── [3]
*/
/*
Start [] ✅
 ├─ Choose 1 → [1] ✅
 │   ├─ Choose 2 → [1,2] ✅
 │   │   ├─ Choose 3 → [1,2,3] ✅
 │   │   └─ Skip 3 → backtrack
 │   └─ Choose 3 → [1,3] ✅
 ├─ Choose 2 → [2] ✅
 │   ├─ Choose 3 → [2,3] ✅
 │   └─ Skip 3 → backtrack
 └─ Choose 3 → [3] ✅

 */

//Optimization in Backtracking
//
//Pruning: Cut off invalid paths early using constraints.
//
//Memoization / DP: Avoid recomputing repeated states.
//
//Ordering choices smartly: Try promising paths first.
//
//Backtracking vs Recursion
//
//Recursion: A function calling itself.
//
//Backtracking: A recursive strategy where you undo previous decisions to try other possibilities.
//So, backtracking is recursion with undo + pruning.



class Solution {
    func permute(_ nums: [Int]) -> [[Int]] {
        var ans = [[Int]]()
        
        func backtrack(_ curr: inout [Int]) {
            if curr.count == nums.count {
                ans.append(curr)
                return
            }
            
            for num in nums {
                if !curr.contains(num) {   // same as Java's check
                    curr.append(num)
                    backtrack(&curr)
                    curr.removeLast()
                }
            }
        }
        
        var curr = [Int]()
        backtrack(&curr)
        return ans
    }
}


let sol = Solution()
print(sol.permute([1,2,3]))
// [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]

/*
 
             []
┌────────────┼────────────┐
[1]          [2]          [3]
/   \         /   \         /   \
[1,2]  [1,3]  [2,1]  [2,3]  [3,1]  [3,2]
|      |      |      |      |      |
[1,2,3][1,3,2][2,1,3][2,3,1][3,1,2][3,2,1] ✅
 
 */


// Output (illustration)
/*
➕ Append 1 → [1]
  ➕ Append 2 → [1, 2]
    ➕ Append 3 → [1, 2, 3]
    ✅ Found permutation: [1, 2, 3]
    ⬅️ Remove 3 → [1, 2]
  ⬅️ Remove 2 → [1]
  ➕ Append 3 → [1, 3]
    ➕ Append 2 → [1, 3, 2]
    ✅ Found permutation: [1, 3, 2]
    ⬅️ Remove 2 → [1, 3]
  ⬅️ Remove 3 → [1]
⬅️ Remove 1 → []
➕ Append 2 → [2]
  ➕ Append 1 → [2, 1]
    ➕ Append 3 → [2, 1, 3]
    ✅ Found permutation: [2, 1, 3]
    ⬅️ Remove 3 → [2, 1]
  ⬅️ Remove 1 → [2]
  ➕ Append 3 → [2, 3]
    ➕ Append 1 → [2, 3, 1]
    ✅ Found permutation: [2, 3, 1]
    ⬅️ Remove 1 → [2, 3]
  ⬅️ Remove 3 → [2]
⬅️ Remove 2 → []
➕ Append 3 → [3]
  ➕ Append 1 → [3, 1]
    ➕ Append 2 → [3, 1, 2]
    ✅ Found permutation: [3, 1, 2]
    ⬅️ Remove 2 → [3, 1]
  ⬅️ Remove 1 → [3]
  ➕ Append 2 → [3, 2]
    ➕ Append 1 → [3, 2, 1]
    ✅ Found permutation: [3, 2, 1]
    ⬅️ Remove 1 → [3, 2]
  ⬅️ Remove 2 → [3]
⬅️ Remove 3 → []

*/


/*
🌳 Full Walkthrough with Call Stack Frames

I’ll show Frame, curr, and loop progress step by step.

Frame 0 (curr = [])
for num in [1,2,3]:
  num = 1 → append [1] → recurse → Frame 1

Frame 1 (curr = [1])
for num in [1,2,3]:
  num = 1 → skip
  num = 2 → append [1,2] → recurse → Frame 2

Frame 2 (curr = [1,2])
for num in [1,2,3]:
  num = 1 → skip
  num = 2 → skip
  num = 3 → append [1,2,3] → recurse → Frame 3

Frame 3 (curr = [1,2,3])
Base case (3 == nums.count) → save [1,2,3]
Return to Frame 2

Back to Frame 2 (curr = [1,2])
removeLast → [1,2]
Loop is done (tried num=3)
Return to Frame 1

Back to Frame 1 (curr = [1])
removeLast → [1]
Loop continues...
Already tried num=2
Next: num=3 → append [1,3] → recurse → Frame 2'

Frame 2' (curr = [1,3])
for num in [1,2,3]:
  num = 1 → skip
  num = 2 → append [1,3,2] → recurse → Frame 3'

Frame 3' (curr = [1,3,2])
Base case → save [1,3,2]
Return to Frame 2'

Back to Frame 2' (curr = [1,3])
removeLast → [1,3]
Loop continues...
num = 3 → skip
Done loop
Return to Frame 1

Back to Frame 1 (curr = [1])
removeLast → [1]
Loop ends (tried 2 and 3)
Return to Frame 0

Back to Frame 0 (curr = [])
removeLast → []
Loop continues...
num = 2 → append [2] → recurse → Frame 1''

Frame 1'' (curr = [2])
for num in [1,2,3]:
  num = 1 → append [2,1] → recurse → Frame 2''

Frame 2'' (curr = [2,1])
for num in [1,2,3]:
  num = 1 → skip
  num = 2 → skip
  num = 3 → append [2,1,3] → recurse → Frame 3''

Frame 3'' (curr = [2,1,3])
Base case → save [2,1,3]
Return → Frame 2''

Back to Frame 2'' (curr = [2,1])
removeLast → [2,1]
Loop done
Return → Frame 1''

Back to Frame 1'' (curr = [2])
removeLast → [2]
Loop continues...
num = 2 → skip
num = 3 → append [2,3] → recurse → Frame 2'''

Frame 2''' (curr = [2,3])
for num in [1,2,3]:
  num = 1 → append [2,3,1] → recurse → Frame 3'''

Frame 3''' (curr = [2,3,1])
Base case → save [2,3,1]
Return → Frame 2'''

Back to Frame 2''' (curr = [2,3])
removeLast → [2,3]
num=2 → skip
num=3 → skip
Done loop
Return → Frame 1''

Back to Frame 1'' (curr = [2])
removeLast → [2]
Loop done
Return → Frame 0

Back to Frame 0 (curr = [])
removeLast → []
Loop continues...
num = 3 → append [3] → recurse → Frame 1'''

Frame 1''' (curr = [3])
for num in [1,2,3]:
  num = 1 → append [3,1] → recurse → Frame 2''''

Frame 2'''' (curr = [3,1])
for num in [1,2,3]:
  num = 2 → append [3,1,2] → recurse → Frame 3''''

Frame 3'''' (curr = [3,1,2])
Base case → save [3,1,2]
Return → Frame 2''''

Back to Frame 2'''' (curr = [3,1])
removeLast → [3,1]
Loop continues...
num=3 skip
Done
Return → Frame 1'''

Back to Frame 1''' (curr = [3])
removeLast → [3]
Loop continues...
num = 2 → append [3,2] → recurse → Frame 2'''''

Frame 2''''' (curr = [3,2])
for num in [1,2,3]:
  num = 1 → append [3,2,1] → recurse → Frame 3'''''

Frame 3''''' (curr = [3,2,1])
Base case → save [3,2,1]
Return → Frame 2'''''

Back to Frame 2''''' (curr = [3,2])
removeLast → [3,2]
Loop done
Return → Frame 1'''

Back to Frame 1''' (curr = [3])
removeLast → [3]
Loop done
Return → Frame 0

Frame 0 finishes

All numbers tried.

✅ Final Permutations collected
[1,2,3]
[1,3,2]
[2,1,3]
[2,3,1]
[3,1,2]
[3,2,1]


💡 Key Intuition:
Each recursive level has its own for-loop pointer. When recursion returns, execution resumes at the next item in the loop, not from the beginning. That’s how [1,2,...] is followed by [1,3,...], then [2,...], then [3,...].


*/


/*
Legend

Frame # → recursion depth (backtrack calls)

Loop → which num in for num in nums is being tried

curr → current state of the permutation

Action → what happens at that step

🟢 Execution Trace
Frame 0 (root call)

curr = []

Frame    Loop num    curr before    Action    curr after
F0    num=1    []    append 1    [1]
F1    (new call)    [1]    recurse    —
Frame 1 (with [1])

curr = [1]

Frame    Loop num    curr before    Action    curr after
F1    num=1    [1]    skip (already in curr)    [1]
F1    num=2    [1]    append 2    [1,2]
F2    (new call)    [1,2]    recurse    —
Frame 2 (with [1,2])

curr = [1,2]

Frame    Loop num    curr before    Action    curr after
F2    num=1    [1,2]    skip    [1,2]
F2    num=2    [1,2]    skip    [1,2]
F2    num=3    [1,2]    append 3    [1,2,3]
F3    (new call)    [1,2,3]    base case → add [1,2,3]    [1,2,3]
F2    —    [1,2,3]    backtrack (remove 3)    [1,2]

✅ Returned from F3 → loop continues in F2.

Resume Frame 2 (after exploring [1,2,3])

Loop at F2 has no more nums left.

Backtrack: remove 2 → curr = [1]

Return to Frame 1.

Resume Frame 1 (with [1])

Now loop continues:

Frame    Loop num    curr before    Action    curr after
F1    num=3    [1]    append 3    [1,3]
F2    (new call)    [1,3]    recurse    —
Frame 2 (with [1,3])

curr = [1,3]

Frame    Loop num    curr before    Action    curr after
F2    num=1    [1,3]    skip    [1,3]
F2    num=2    [1,3]    append 2    [1,3,2]
F3    (new call)    [1,3,2]    base case → add [1,3,2]    [1,3,2]
F2    —    [1,3,2]    backtrack remove 2    [1,3]
F2    num=3    [1,3]    skip    [1,3]

F2 loop ends → remove 3 → back to [1].

Resume Frame 1 (with [1])

Loop ends → remove 1 → back to [].

Resume Frame 0 (root)

Now F0 loop continues:

Frame    Loop num    curr before    Action    curr after
F0    num=2    []    append 2    [2]
F1    (new call)    [2]    recurse    —

And this process repeats symmetrically for [2,...] and [3,...] branches.

🔑 Key Observation

At every recursion level, once the recursive call returns, execution resumes right after that backtrack(&curr) in the loop.

Then the for-loop continues with the next num.

That’s how it “remembers” where it left off → because each recursion frame has its own loop index position saved on the call stack.


*/






//Example 1: 46. Permutations
//
//Given an array nums of distinct integers, return all the possible permutations in any order.
//
//For example, given nums = [1, 2, 3], return [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]].

class Solutions {
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        var ans = [[Int]]()
        var curr = [Int]()
        
        func backtrack(_ start: Int) {
            if curr.count == k {
                ans.append(curr)
                return
            }
            
            for num in start...n {
                curr.append(num)
                backtrack(num + 1)
                curr.removeLast()
            }
        }
        
        backtrack(1)
        return ans
    }
}


//let sol = Solutions()
//print(sol.combine(4, 2))
//// Output: [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]



class SolutionNum {
    
    func letterCombinations(_ digits: String) -> [String]{
        if digits.isEmpty {
            return []
        }
       
        let phoneMap: [Character: [Character]] = [
                    "2": ["a", "b", "c"],
                    "3": ["d", "e", "f"],
                    "4": ["g", "h", "i"],
                    "5": ["j", "k", "l"],
                    "6": ["m", "n", "o"],
                    "7": ["p", "q", "r", "s"],
                    "8": ["t", "u", "v"],
                    "9": ["w", "x", "y", "z"]
                ]

        var result : [String] = []
        var path : [Character] = []
        let digitArray = Array(digits)
        
        func backTrack(_ index: Int) {
            
            if index == digitArray.count {
                return result.append(String(path))
            }
            
            let digit = digitArray[index]
            
            guard let letters = phoneMap[digit] else {
                return
            }
            
            for letter in letters {
                path.append(letter)
                backTrack(index+1)
                path.removeLast()
            }
        }
        backTrack(0)
        return result
    }
}



//Example : Combination Sum
//
//Given an array of distinct positive integers candidates and a target integer target, return a list of all unique combinations of candidates where the chosen numbers sum to target. The same number may be chosen from candidates an unlimited number of times. Two combinations are unique if the frequency of at least one of the chosen numbers is different.


class SolutionCombine {
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var ans = [[Int]]()
        var path = [Int]()
        
        func backtrack(_ start: Int, _ curr: Int) {
            if curr == target {
                ans.append(path)
                return
            }
            
            for i in start..<candidates.count {
                let num = candidates[i]
                if curr + num <= target {
                    path.append(num)                // choose
                    backtrack(i, curr + num)        // explore (reuse allowed, so i not i+1)
                    path.removeLast()               // un-choose (backtrack)
                }
            }
        }
        
        backtrack(0, 0)
        return ans
    }
}

/*
 🔑 Rule of Thumb

Subsets / Combinations (no reuse) → backtrack(i + 1, …)

Only move forward to prevent duplicates.

Combination Sum (reuse allowed) → backtrack(i, …)

Stay at same index to allow reusing the same number multiple times.

✅ That’s the difference:

In subsets, i+1 avoids picking the same element again.

In combination sum, staying at i intentionally allows reuse.

Duplicates like [2,3] vs [3,2] are avoided because the loop is always forward (start..<count).
 
 */

/*
Start: path = [], curr = 0

Pick 2 (index 0):
  path = [2], curr = 2
  → Pick 2 again:
       path = [2,2], curr = 4
       → Pick 2 again:
            path = [2,2,2], curr = 6
            → Pick 2 again → curr=8 > 7 (stop)
            → Pick 3 → curr=9 > 7 (stop)
            → Pick 6 → curr=12 > 7 (stop)
            → Pick 7 → curr=13 > 7 (stop)
       → Pick 3:
            path = [2,2,3], curr = 7 ✅ solution
       → Pick 6 → curr=10 (stop)
       → Pick 7 → curr=11 (stop)
  → Pick 3:
       path = [2,3], curr = 5
       → Pick 3 again → curr=8 (stop)
       → Pick 6 → curr=11 (stop)
       → Pick 7 → curr=12 (stop)
  → Pick 6 → curr=8 (stop)
  → Pick 7 → curr=9 (stop)

Pick 3 (index 1):
  path = [3], curr = 3
  → Pick 3 again → [3,3], curr=6
       → Pick 3 → curr=9 (stop)
       → Pick 6 → curr=12 (stop)
       → Pick 7 → curr=13 (stop)
  → Pick 6 → curr=9 (stop)
  → Pick 7 → curr=10 (stop)

Pick 6 (index 2):
  path = [6], curr = 6
  → Pick 6 → curr=12 (stop)
  → Pick 7 → curr=13 (stop)

Pick 7 (index 3):
  path = [7], curr = 7 ✅ solution

*/

//✅ Results collected:
//[[2,2,3],[7]]

/*
    []
    ├── [2]
    │   ├── [2,2]
    │   │   └── [2,2,3] ✅
    │   └── [2,3]
    └── [3]
        └── [3,3]

*/



  
class SolutionNqueen {
    func totalNQueens(_ n: Int) -> Int {
        func backtrack(_ row: Int, _ diagonals: inout Set<Int>, _ antiDiagonals: inout Set<Int>, _ cols: inout Set<Int>) -> Int {
            // Base case - N queens have been placed
            if row == n {
                return 1
            }
            
            var solutions = 0
            for col in 0..<n {
                let currDiagonal = row - col
                let currAntiDiagonal = row + col
                
                // If the queen is not placeable
                if cols.contains(col) || diagonals.contains(currDiagonal) || antiDiagonals.contains(currAntiDiagonal) {
                    continue
                }
                
                // "Add" the queen to the board
                cols.insert(col)
                diagonals.insert(currDiagonal)
                antiDiagonals.insert(currAntiDiagonal)
                
                // Move on to the next row with the updated board state
                solutions += backtrack(row + 1, &diagonals, &antiDiagonals, &cols)
                
                // "Remove" the queen from the board (backtrack)
                cols.remove(col)
                diagonals.remove(currDiagonal)
                antiDiagonals.remove(currAntiDiagonal)
            }
            
            return solutions
        }
        
        var cols = Set<Int>()
        var diagonals = Set<Int>()
        var antiDiagonals = Set<Int>()
        
        return backtrack(0, &diagonals, &antiDiagonals, &cols)
    }
}




// others problems - generate parantheses , soduko , graph colouring , some graph related problem .
