import UIKit

var greeting = "Hello, playground"


 //Binary Tree

class TreeNode {
    var value: Int
    var left: TreeNode?
    var right: TreeNode?

    init(_ value: Int) {
        self.value = value
    }
}

let root = TreeNode(1)
root.left = TreeNode(2)
root.right = TreeNode(3)
root.left?.left = TreeNode(4)
root.left?.right = TreeNode(5)


//Tree Traversals

// Pre-order Traversal (Root → Left → Right)

func preorder(_ node: TreeNode?) {
    guard let node = node else { return }
    print(node.value)
    preorder(node.left)
    preorder(node.right)
}

// In-order Traversal (Left → Root → Right)

func inorder(_ node: TreeNode?) {
    guard let node = node else { return }
    inorder(node.left)
    print(node.value)
    inorder(node.right)
}

// Post-order Traversal (Left → Right → Root)

func postorder(_ node: TreeNode?) {
    guard let node = node else { return }
    postorder(node.left)
    postorder(node.right)
    print(node.value)
}

// 🔢 Breadth-First Search (Level Order Traversal)

func levelOrder(_ root: TreeNode?) {
    guard let root = root else { return }
    var queue: [TreeNode] = [root]
    
    while !queue.isEmpty {
        let current = queue.removeFirst()
        print(current.value)
        
        if let left = current.left { queue.append(left) }
        if let right = current.right { queue.append(right) }
    }
}


//The name of each traversal is describing when the current node's logic is performed.
//
//Pre -> before children
//
//In -> in the middle of children
//
//Post -> after children



// using Recursion

func levelOrderRecursive(_ root: TreeNode?) {
    var result: [[Int]] = []
    traverse(root, level: 0, result: &result)

    for level in result {
        for value in level {
            print(value, terminator: " ")
        }
    }
}

func traverse(_ node: TreeNode?, level: Int, result: inout [[Int]]) {
    guard let node = node else { return }

    // Make sure the array has space for the current level
    if result.count == level {
        result.append([])
    }

    result[level].append(node.value)

    traverse(node.left, level: level + 1, result: &result)
    traverse(node.right, level: level + 1, result: &result)
}



 


//Maximum Depth of Binary Tree
//
//Given the root of a binary tree, find the length of the longest path from the root to a leaf.


func maxDepth(_ root: TreeNode?) -> Int {
    
    guard let root = root else { return 0 }
    
    let leftNode = maxDepth(root.left)
    let rightNode = maxDepth(root.right)
    
    return max(leftNode,rightNode) + 1
}

//Solution 2: Iterative BFS (Level Order)

func maxDepths(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }

    var queue: [TreeNode] = [root]
    var depth = 0

    while !queue.isEmpty {
        let levelSize = queue.count
        for _ in 0..<levelSize {
            let current = queue.removeFirst()
            if let left = current.left { queue.append(left) }
            if let right = current.right { queue.append(right) }
        }
        depth += 1
    }

    return depth
}

func maxDepth2(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }

    var stack: [(TreeNode, Int)] = [(root, 1)]
    var maxDepth = 0

    while !stack.isEmpty {
        let (node, depth) = stack.removeLast()
        maxDepth = max(maxDepth, depth)

        if let left = node.left {
            stack.append((left, depth + 1))
        }
        if let right = node.right {
            stack.append((right, depth + 1))
        }
    }

    return maxDepth
}


//Given the root of a binary tree and an integer targetSum, return true if there exists a path from the root to a leaf such that the sum of the nodes on the path is equal to targetSum, and return false otherwise.

func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
    guard let root = root else { return false }

    // If it's a leaf node, check if remaining sum equals the node's value
    if root.left == nil && root.right == nil {
        return targetSum == root.value
    }

    // Recurse on left and right subtree with reduced target
    let remainingSum = targetSum - root.value
    return hasPathSum(root.left, remainingSum) || hasPathSum(root.right, remainingSum)
}


// Another recursive solution

func hasPathSums(_ root: TreeNode?, _ targetSum: Int) -> Bool {
    func dfs(_ node: TreeNode?, _ curr: Int) -> Bool {
        guard let node = node else { return false }

        // If it's a leaf, check if the path sum equals target
        if node.left == nil && node.right == nil {
            return (curr + node.value) == targetSum
        }

        let newSum = curr + node.value
        let leftResult = dfs(node.left, newSum)
        let rightResult = dfs(node.right, newSum)
        return leftResult || rightResult
    }

    return dfs(root, 0)
}

 
//🔧 Swift Solution (Iterative DFS using Stack):

func hasPathSum1(_ root: TreeNode?, _ targetSum: Int) -> Bool {
    guard let root = root else { return false }

    // Stack holds (node, currentPathSum)
    var stack: [(TreeNode, Int)] = [(root, root.value)]

    while !stack.isEmpty {
        let (node, currentSum) = stack.removeLast()

        // Check if this is a leaf and path sum matches
        if node.left == nil && node.right == nil && currentSum == targetSum {
            return true
        }

        // Push children with updated sum
        if let right = node.right {
            stack.append((right, currentSum + right.value))
        }
        if let left = node.left {
            stack.append((left, currentSum + left.value))
        }
    }

    return false
}




//🔧 Swift Solution (BFS using Queue):

func hasPathSum3(_ root: TreeNode?, _ targetSum: Int) -> Bool {
    guard let root = root else { return false }

    // Queue holds (node, currentPathSum)
    var queue: [(TreeNode, Int)] = [(root, root.value)]

    while !queue.isEmpty {
        let (node, currentSum) = queue.removeFirst()

        // Check if it's a leaf and sum matches
        if node.left == nil && node.right == nil && currentSum == targetSum {
            return true
        }

        // Enqueue children with updated sum
        if let left = node.left {
            queue.append((left, currentSum + left.value))
        }
        if let right = node.right {
            queue.append((right, currentSum + right.value))
        }
    }

    return false
}



// Count Good Nodes in Binary Tree
//
//Given the root of a binary tree, find the number of nodes that are good. A node is good if the path between the root and the node has no nodes with a greater value.


//✅ Swift Solution (Recursive DFS)

func goodNodes(_ root: TreeNode?) -> Int {
    func dfs(_ node: TreeNode?, _ maxSoFar: Int) -> Int {
        guard let node = node else { return 0 }

        let isGood = node.value >= maxSoFar ? 1 : 0
        let newMax = max(maxSoFar, node.value)

        let leftCount = dfs(node.left, newMax)
        let rightCount = dfs(node.right, newMax)

        return isGood + leftCount + rightCount
    }

    return dfs(root, root?.value ?? Int.min)
}


  //Another recursive solution

func goodNodes1(_ root: TreeNode?) -> Int {
    func dfs(_ node: TreeNode?, _ maxSoFar: Int) -> Int {
        guard let node = node else { return 0 }

        let newMax = max(maxSoFar, node.value)
        let left = dfs(node.left, newMax)
        let right = dfs(node.right, newMax)

        var count = left + right
        if node.value >= maxSoFar {
            count += 1
        }

        return count
    }

    return dfs(root, Int.min)
}




//Preorder DFS for Good Nodes — Swift
//Here’s the logic written using preorder style DFS in Swift:

class Solution {
    func goodNodes(_ root: TreeNode?) -> Int {
        func dfs(_ node: TreeNode?, _ maxSoFar: Int) -> Int {
            guard let node = node else { return 0 }
            
            // Check current node before children (preorder)
            var count = 0
            if node.value >= maxSoFar {
                count += 1
            }
            
            let newMax = max(maxSoFar, node.value)
            count += dfs(node.left, newMax)
            count += dfs(node.right, newMax)
            
            return count
        }

        return dfs(root, Int.min)
    }
}



//🚀 Iterative DFS Approach (using stack)

func goodNodes2(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }

    var stack: [(TreeNode, Int)] = [(root, root.value)]
    var goodNodeCount = 0

    while !stack.isEmpty {
        let (node, maxSoFar) = stack.removeLast()

        // Check if the current node is "good"
        if node.value >= maxSoFar {
            goodNodeCount += 1
        }

        // Update max for the path and push children
        let newMax = max(maxSoFar, node.value)
        if let left = node.left {
            stack.append((left, newMax))
        }
        if let right = node.right {
            stack.append((right, newMax))
        }
    }

    return goodNodeCount
}




//🔁 Iterative BFS (using queue)
//If you prefer BFS, just swap stack with a queue (FIFO):

func goodNodes7(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }

    var queue: [(TreeNode, Int)] = [(root, root.value)]
    var goodNodeCount = 0

    while !queue.isEmpty {
        let (node, maxSoFar) = queue.removeFirst()

        if node.value >= maxSoFar {
            goodNodeCount += 1
        }

        let newMax = max(maxSoFar, node.value)
        if let left = node.left {
            queue.append((left, newMax))
        }
        if let right = node.right {
            queue.append((right, newMax))
        }
    }

    return goodNodeCount
}


//sum of nodes
 
func sumOfNodes(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }
    
    var count = 0
    
    count += root.value
    
    count += sumOfNodes(root.left)
    count += sumOfNodes(root.right)
    
    return count
}



//----------------------------------------------------------------------

// Given a binary tree, find its minimum depth.
//The minimum depth is the number of nodes along the shortest path from the root node down to the nearest leaf node. in swift language

func minDepth(_ root: TreeNode?) -> Int {
        func dfs(_ root: TreeNode?) -> Int {
            guard let root = root else {
                return 0
            }

            if root.left == nil {
                return 1 + dfs(root.right)
            } else if root.right == nil {
                return 1 + dfs(root.left)
            }

            return 1 + min(dfs(root.left), dfs(root.right))
        }

        return dfs(root)
    }


 //BFS Approach

func minDepthBFS(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }

    var queue: [(node: TreeNode, depth: Int)] = [(root, 1)]

    while !queue.isEmpty {
        let (current, depth) = queue.removeFirst()

        // If it's a leaf node, return its depth immediately
        if current.left == nil && current.right == nil {
            return depth
        }

        if let left = current.left {
            queue.append((left, depth + 1))
        }

        if let right = current.right {
            queue.append((right, depth + 1))
        }
    }

    return 0 // This line is never reached if root is not nil
}

//Given the root of a binary tree, return the length of the diameter of the tree.
//
//The diameter of a binary tree is the length of the longest path between any two nodes in a tree. This path may or may not pass through the root.
//
//The length of a path between two nodes is represented by the number of edges between them.

 
   func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
       var maxDiameter = 0

       func dfs(_ node: TreeNode?) -> Int {
           guard let node = node else { return 0 }

           let left = dfs(node.left)
           let right = dfs(node.right)

           // Update the diameter at this node
           maxDiameter = max(maxDiameter, left + right)

           // Return height of this subtree
           return 1 + max(left, right)
       }

       _ = dfs(root)
       return maxDiameter
   }




//---------------------------------------------------------------------------

//---------------BFS Travesal ------

func printAllNodes(_ root: TreeNode?) {
    guard let root = root else { return }

    var queue: [TreeNode] = [root]

    while !queue.isEmpty {
        let nodesInCurrentLevel = queue.count
        // Do some logic here for the current level
        
        for _ in 0..<nodesInCurrentLevel {
            let node = queue.removeFirst()
            
            // Do some logic here on the current node
            print(node.value)
            
            // Put the next level onto the queue
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
    }
}



//Example -- Binary Tree Right Side View
//
//Given the root of a binary tree, imagine yourself standing on the right side of it. Return the values of the nodes you can see ordered from top to bottom.
//

func rightSideView(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }

        var result: [Int] = []
        var queue: [TreeNode] = [root]

        while !queue.isEmpty {
            let levelSize = queue.count
            result.append(queue.last!.value) // Rightmost node at this level

            for _ in 0..<levelSize {
                let node = queue.removeFirst()
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
        }

        return result
    }


func maxValueAtEveryNode(_ root: TreeNode?) -> [Int] {
    
    guard let root = root else { return [] }
    
    var result: [Int] = []
    var queue: [TreeNode] = [root]
    
    while !queue.isEmpty {
        var queueLength = queue.count
        var maxLevelNode = Int.min
        
        for _ in 0..<queueLength {
            var node = queue.removeFirst()
            maxLevelNode = max(node.value, maxLevelNode)
            if let left = node.left {queue.append(left)}
            if let right = node.right {queue.append(right)}
        }
        result.append(maxLevelNode)
    }
    return result
}



// Given the root of a binary tree, return the sum of values of its deepest leaves.


func deepestLeavesSum(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }
    
    var queue: [TreeNode] = [root]
    var levelSum = 0
    
    while !queue.isEmpty {
        let levelSize = queue.count
        levelSum = 0  // Reset at the start of each level
        
        for _ in 0..<levelSize {
            let node = queue.removeFirst()
            levelSum += node.value
            
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
    }
    
    return levelSum
}


  // approaoch DFS preorder

func deepestLeavesSums(_ root: TreeNode?) -> Int {
    var maxDepth = 0
    var sum = 0

    func dfs(_ node: TreeNode?, _ depth: Int) {
        guard let node = node else { return }

        // If it's a leaf node
        if node.left == nil && node.right == nil {
            if depth > maxDepth {
                maxDepth = depth
                sum = node.value
            } else if depth == maxDepth {
                sum += node.value
            }
        }

        dfs(node.left, depth + 1)
        dfs(node.right, depth + 1)
    }

    dfs(root, 0)
    return sum
}


  // Given the root of a binary tree, return the zigzag level order traversal of its nodes' values. (i.e., from left to right, then right to left for the next level and alternate between).


func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
    guard let root = root else { return [] }

    var result: [[Int]] = []
    var queue: [TreeNode] = [root]
    var leftToRight = true

    while !queue.isEmpty {
        let levelSize = queue.count
        var levelValues: [Int] = []

        for _ in 0..<levelSize {
            let node = queue.removeFirst()
            levelValues.append(node.value)

            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }

        result.append(leftToRight ? levelValues : levelValues.reversed())
        leftToRight.toggle()
    }

    return result
}


  // Anothere solution BFS

func zigzagLevelOrderr(_ root: TreeNode?) -> [[Int]] {
    var result: [[Int]] = []
    guard let root = root else { return result }

    var nodeQueue: [TreeNode?] = [root, nil]
    var levelList: [Int] = []
    var isOrderLeft = true

    while !nodeQueue.isEmpty {
        let currentNode = nodeQueue.removeFirst()

        if let node = currentNode {
            if isOrderLeft {
                levelList.append(node.value)
            } else {
                levelList.insert(node.value, at: 0)
            }

            if let left = node.left {
                nodeQueue.append(left)
            }
            if let right = node.right {
                nodeQueue.append(right)
            }
        } else {
            // End of current level
            result.append(levelList)
            if !nodeQueue.isEmpty {
                nodeQueue.append(nil)
            }
            levelList = []
            isOrderLeft.toggle()
        }
    }

    return result
}

   // Another solution that avoids delimeter nil logic
   
func zigzagLevelOrders(_ root: TreeNode?) -> [[Int]] {
    guard let root = root else { return [] }
    
    var result: [[Int]] = []
    var queue: [TreeNode] = [root]
    var isLeftToRight = true

    while !queue.isEmpty {
        let levelSize = queue.count
        var levelValues: [Int] = []

        for _ in 0..<levelSize {
            let node = queue.removeFirst()
            
            if isLeftToRight {
                levelValues.append(node.value)
            } else {
                levelValues.insert(node.value, at: 0)
            }

            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }

        result.append(levelValues)
        isLeftToRight.toggle()
    }

    return result
}

// DFS solution of zigZag

 
func zigzagLevelOrderDfs(_ root: TreeNode?) -> [[Int]] {
    guard let root = root else { return [] }

    var results: [[Int]] = []

    func dfs(_ node: TreeNode, _ level: Int) {
        if level == results.count {
            // Add a new level
            results.append([node.value])
        } else {
            if level % 2 == 0 {
                results[level].append(node.value)
            } else {
                results[level].insert(node.value, at: 0)
            }
        }

        if let left = node.left {
            dfs(left, level + 1)
        }
        if let right = node.right {
            dfs(right, level + 1)
        }
    }

    dfs(root, 0)
    return results
}


// zigZag Dfs using Deque SWIFT-COLLECTION

//let Deque = Deque
//
//func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
//    guard let root = root else { return [] }
//
//    var results: [Deque<Int>] = []
//
//    func dfs(_ node: TreeNode, _ level: Int) {
//        if level == results.count {
//            results.append(Deque([node.value]))
//        } else {
//            if level % 2 == 0 {
//                results[level].append(node.value)
//            } else {
//                results[level].prepend(node.value)
//            }
//        }
//
//        if let left = node.left {
//            dfs(left, level + 1)
//        }
//        if let right = node.right {
//            dfs(right, level + 1)
//        }
//    }
//
//    dfs(root, 0)
//    return results.map { Array($0) }
//}



//-----------------------------------BINARY SEARCH TREE ------------------------------------------------------------------------------//




  //Given the root node of a binary search tree and two integers low and high, return the sum of values of all nodes with a value in the inclusive range [low, high].


func rangeSumBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> Int {
    guard let root = root else { return 0 }

    var sum = 0

    if low <= root.value && root.value <= high {
        sum += root.value
    }
    if low < root.value {
        sum += rangeSumBST(root.left, low, high)
    }
    if root.value < high {
        sum += rangeSumBST(root.right, low, high)
    }

    return sum
}


// ✅ Swift Version (Iterative DFS using Stack)

func rangeSumBSTs(_ root: TreeNode?, _ low: Int, _ high: Int) -> Int {
    guard let root = root else { return 0 }

    var stack: [TreeNode?] = [root]
    var sum = 0

    while !stack.isEmpty {
        guard let node = stack.popLast()! else { continue }

        if low <= node.value && node.value <= high {
            sum += node.value
        }

        if let left = node.left, low < node.value {
            stack.append(left)
        }

        if let right = node.right, node.value < high {
            stack.append(right)
        }
    }

    return sum
}


  // Example  Minimum Absolute Difference in BST
  //Given the root of a BST, return the minimum absolute difference between the values of any two different nodes in the tree.


func getMinimumDifference(_ root: TreeNode?) -> Int {
    var values: [Int] = []

    func dfs(_ node: TreeNode?) {
        guard let node = node else { return }
        dfs(node.left)
        values.append(node.value)
        dfs(node.right)
    }

    dfs(root)

    var minDiff = Int.max
    for i in 1..<values.count {
        minDiff = min(minDiff, values[i] - values[i - 1])
    }

    return minDiff
}


  // Swift iterative Version

func getMinimumDifferences(_ root: TreeNode?) -> Int {
    func iterativeInorder(_ root: TreeNode?) -> [Int] {
        var stack: [TreeNode] = []
        var values: [Int] = []
        var current = root

        while !stack.isEmpty || current != nil {
            while let node = current {
                stack.append(node)
                current = node.left
            }

            let node = stack.removeLast()
            values.append(node.value)
            current = node.right
        }

        return values
    }

    let values = iterativeInorder(root)
    var minDiff = Int.max

    for i in 1..<values.count {
        minDiff = min(minDiff, values[i] - values[i - 1])
    }

    return minDiff
}


//Validate Binary Search Tree
//Given the root of a binary tree, determine if it is a valid BST.
//

func isValidBST(_ root: TreeNode?) -> Bool {
    func dfs(_ node: TreeNode?, _ lower: Int, _ upper: Int) -> Bool {
        guard let node = node else { return true }

        if node.value <= lower || node.value >= upper {
            return false
        }

        return dfs(node.left, lower, node.value) && dfs(node.right, node.value, upper)
    }

    return dfs(root, Int.min, Int.max)
}



//✅ Swift Version (Iterative BST Validation)

func isValidBSTs(_ root: TreeNode?) -> Bool {
    guard let root = root else { return true }

    var stack: [(node: TreeNode, lower: Int, upper: Int)] = [(root, Int.min, Int.max)]

    while !stack.isEmpty {
        let (node, lower, upper) = stack.removeLast()

        if node.value <= lower || node.value >= upper {
            return false
        }

        if let left = node.left {
            stack.append((left, lower, node.value))
        }

        if let right = node.right {
            stack.append((right, node.value, upper))
        }
    }

    return true
}


 // You are given the root node of a binary search tree (BST) and a value to insert into the tree. Return the root node of the BST after the insertion. It is guaranteed that the new value does not exist in the original BST.


func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
    guard let root = root else {
        return TreeNode(val)
    }

    if val > root.value {
        root.right = insertIntoBST(root.right, val)
    } else {
        root.left = insertIntoBST(root.left, val)
    }

    return root
}

// ✅ Swift Version (Iterative BST Insertion)

func insertIntoBSTT(_ root: TreeNode?, _ val: Int) -> TreeNode? {
    guard let root = root else {
        return TreeNode(val)
    }

    var node = root

    while true {
        if val > node.value {
            if node.right == nil {
                node.right = TreeNode(val)
                return root
            } else {
                node = node.right!
            }
        } else {
            if node.left == nil {
                node.left = TreeNode(val)
                return root
            } else {
                node = node.left!
            }
        }
    }
}



//Given the root of a binary search tree and a target value, return the value in the BST that is closest to the target. If there are multiple answers, print the smallest.


  // SOLUTION :  a Binary Search Tree (BST) using in-order traversal:

func inorder(_ root: TreeNode?, _ nums: inout [Int]) {
    guard let root = root else { return }
    inorder(root.left, &nums)
    nums.append(root.value)
    inorder(root.right, &nums)
}

func closestValue(_ root: TreeNode?, _ target: Double) -> Int {
    var nums: [Int] = []
    inorder(root, &nums)
    
    return nums.min(by: { abs(Double($0) - target) < abs(Double($1) - target) }) ?? 0
}


 // SOLUTION - iterative in-order traversal for finding the closest value to a target in a BST, without building a full array

func closestValues(_ root: TreeNode?, _ target: Double) -> Int {
    var root = root
    var stack: [TreeNode] = []
    var pred: Double = -Double.greatestFiniteMagnitude

    while !stack.isEmpty || root != nil {
        while let node = root {
            stack.append(node)
            root = node.left
        }

        root = stack.removeLast()

        if pred <= target && target < Double(root!.value) {
            return abs(pred - target) <= abs(Double(root!.value) - target) ? Int(pred) : root!.value
        }

        pred = Double(root!.value)
        root = root!.right
    }

    return Int(pred)
}

  //SOLUTION: optimized BST traversal to find the closest value to a target using binary search logic

func closestValuee(_ root: TreeNode?, _ target: Double) -> Int {
    var root = root
    var closest = root!.value

    while let node = root {
        let val = node.value
        if abs(Double(val) - target) < abs(Double(closest) - target) ||
            (abs(Double(val) - target) == abs(Double(closest) - target) && val < closest) {
            closest = val
        }

        root = target < Double(val) ? node.left : node.right
    }

    return closest
}


