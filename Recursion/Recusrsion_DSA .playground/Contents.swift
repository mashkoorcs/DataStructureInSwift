import UIKit

var greeting = "Hello, playground"

 // ----------********RECURSION**********----------


   //Iterative approach

for i in 0...10 {
    print(i)
  }

// recursive approach ---PSEUDOCODE

  //function fn(i):
//     if i > 10:
//       return

  //    print(i)
   //    fn(i + 1)
  //    return
 //
 //fn(1)
 //
 //
  
 




 // Directory and folder Traversal EXAMPLE
 
//  func listFiles(in directory: Directory) {
//    for file in directory.files {
//        print(file.name)
//    }
//    for subdirectory in directory.subdirectories {
//        listFiles(in: subdirectory) // Recursive call
//    }
// }
    
  

    // View hierarchy UI PROBLEM example .

//func findAllButtons(in view: UIView) -> [UIButton] {
//    var buttons = [UIButton]()
//    
//    for subview in view.subviews {
//        if let button = subview as? UIButton {
//            buttons.append(button)
//        }
//        buttons += findAllButtons(in: subview) // Recursive call
//    }
//    
//    return buttons
//  }



// Factorial using recursion


func factorial(_ n: Int) -> Int {
 if n == 0 {
     return 1 // Base Case
 }
 return n * factorial(n - 1) // Recursive Call
}


//Here, after factorial(n-1) returns, you still have to multiply by n.
//So it’s NOT tail recursive.




func tailFactorial(_ n: Int, accumulator: Int = 1) -> Int {
    if n == 0 { return accumulator }
    return tailFactorial(n - 1, accumulator: accumulator * n)  // ✅ Last operation
}


//🧮 Example:
//Let's compute tailFactorial(4)
//
//
//Step    n    accumulator
//Call    4    1
//Call    3    4
//Call    2    12
//Call    1    24
//Call    0    24 → return 24
//✅ No extra work pending after each call — pure tail recursion.

// Tail Recursion — Tail Factorial


//Sum of Array -- using Tail Recursion

func sumTail(_ arr: [Int], _ acc: Int = 0) -> Int {
    if arr.isEmpty { return acc }
    return sumTail(Array(arr.dropFirst()), acc + arr[0])
}

  //iterative version for above
 
func sumIterative(_ arr: [Int]) -> Int {
    var total = 0
    
    for num in arr {
        total += num
    }
    
    return total
}


    // Reverse a String -------- Tail Recursion

    func reverseTail(_ str: String, _ acc: String = "") -> String {
        if str.isEmpty { return acc }
        return reverseTail(String(str.dropFirst()), String(str.first!) + acc)
      }

    // -------------------iterative version -------------

    func reverseIterative(_ str: String) -> String {
        var result = ""
    
        for char in str {
            result = String(char) + result
        }
    
        return result
    }

 
  // Fibonacci sequence (simple example)

  func fibonacci(_ n: Int) -> Int {
      if n <= 1 {
         return n
     }
     return fibonacci(n - 1) + fibonacci(n - 2)
  }

  //  is inefficient — it recalculates the same subproblems many times.
  //❌ Time Complexity: O(2ⁿ)



   // Fibonacci with Memoization

   
   func fib(_ n: Int) -> Int {
      var memo = [Int: Int]()
    
      func helper(_ n: Int) -> Int {
        if n <= 1 { return n }
        if let value = memo[n] {
            return value
        }
        
        let result = helper(n - 1) + helper(n - 2)
        memo[n] = result
        return result
      }
    
    return helper(n)
   }


  //    🧩 How It Works:
  //    memo stores values of previously computed fib(n).
 //
 //    Before computing, we check: "Have we already computed fib(n)?"
 //
 //    If yes → return from memo (cache hit)
 //
 //    If no → compute recursively and store the result in memo.
 //
 //    📈 Time Complexity
 //    ✅ O(n) — Each value from 0 to n is computed just once.


//  🔁 Optional: Memoization with Class (Reusable)
//
  class Fibonacci {
     private var memo = [Int: Int]()
    
     func fib(_ n: Int) -> Int {
         if n <= 1 { return n }
         if let value = memo[n] {
             return value
         }
         let result = fib(n - 1) + fib(n - 2)
         memo[n] = result
         return result
     }
 }


//🟩 3. Tabulation (Bottom-Up DP)

 func fibTab(_ n: Int) -> Int {
     if n <= 1 { return n }
     var dp = [0, 1]
     for i in 2...n {
        dp.append(dp[i - 1] + dp[i - 2])
     }
     return dp[n]
}

//🧠 Time: O(n)
//🧠 Space: O(n) for the dp array
//✅ Avoids recursion
//✅ Great for large n values


//🟦 4. Optimized Iterative (Constant Space)

func fibOptimized(_ n: Int) -> Int {
    if n <= 1 { return n }
    var a = 0, b = 1
    for _ in 2...n {
        (a, b) = (b, a + b)
    }
    return b
}
//🧠 Time: O(n)
//🧠 Space: O(1)
//✅ Fastest and most space-efficient
//✅ Perfect for interviews
//

