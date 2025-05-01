import UIKit

var greeting = "Hello, playground"

//.......STACK......

struct Stack<T> {
    
    var elements: [T] = []
    
    var isEmpty: Bool {
       return elements.isEmpty
    }
    
    var peek: T? {
        return elements.last
    }
    
    mutating func push(_ value: T) {
        return elements.append(value)
    }
    
    mutating func pop() -> T? {
        
        return elements.popLast()
    }
    
}

 var stack = Stack<Int>()

stack.push(10)
stack.push(20)
stack.push(30)

print(stack.peek!)    // 30
print(stack.pop()!)   // 30
print(stack.pop()!)   // 20
print(stack.isEmpty)  // false
print(stack.pop()!)   // 10
print(stack.isEmpty)  // true


// Stack using linkedList

// Node class
class Node<T> {
    var value: T
    var next: Node?
    
    init(_ value: T) {
        self.value = value
        self.next = nil
    }
}

// Stack class
class LinkedListStack<T> {
    private var head: Node<T>?
    private var size: Int = 0
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var count: Int {
        return size
    }
    
    var top: T? {
        return head?.value
    }
    
    func push(_ value: T) {
        let newNode = Node(value)
        newNode.next = head
        head = newNode
        size += 1
    }
    
    func pop() -> T? {
        if isEmpty { return nil }
        let value = head!.value
        head = head!.next
        size -= 1
        return value
    }
}


// Given a string containing '(', ')', '{', '}', '[' and ']', check if it's valid (every open has matching close, correct order).

func isValidParentheses(_ str: String) -> Bool {
    
    var stack = [Character]()
    
    var mapping: [Character:Character] = [")":"(","]":"[","}":"{"]
    
    for s in str {
        
        if mapping.values.contains(s){
            stack.append(s)
        }
        else if let matching = mapping[s] {
            if stack.isEmpty || stack.popLast() != matching {
                return false
            }
        }
    }
    return stack.isEmpty
}


func isBalanced(_ str: String) -> Bool {
    var stack = [Character]()
    
    for c in str {
        switch c {
        case "{","[","(":
            stack.append(c)
        case "}":
            if stack.isEmpty || stack.last != "{" {
                return false
            }
            stack.popLast()
        
    case "]":
        if stack.isEmpty || stack.last != "[" {
            return false
        }
        stack.popLast()
    
    case ")":
      if stack.isEmpty || stack.last != "(" {
        return false
      }
      stack.popLast()
        default:
            print("breaking \(c)")
}

    }
    
    return stack.isEmpty ? true : false
}


//PROBLEM--You are given a string s. Continuously remove duplicates (two of the same character beside each other) until you can't anymore. Return the final string after this.

//For example, given s = "abbaca", you can first remove the "bb" to get "aaca". Next, you can remove the "aa" to get "ca". This is the final answer.

func removeconsecutiveDuplicates(_ str: String) -> String {
    
    var stack = [Character]()
    
    for char in str {
        if stack.last == char {
            stack.popLast()
        } else {
            stack.append(char)
        }
    }
    
    return String(stack)
}


//Example 3: 844. Backspace String Compare
//
//Given two strings s and t, return true if they are equal when both are typed into empty text editors. '#' means a backspace character.
//
//For example, given s = "ab#c" and t = "ad#c", return true. Because of the backspace, the strings are both equal to "ac".
 
func backSpaceCompare(_ str: String , _ tr: String) -> Bool {
    
    var stack = [Character]()
    
    func build(_ s: String) -> String{
        
        for c in s {
            if c == "#"{
                stack.popLast()
            } else {
                stack.append(c)
            }
            
        }
        return String(stack)
    }
    
    return build(str) == build(tr)
}

// PROBLEM -- Evaluate expressions like ["2","1","+","3","*"] → (2 + 1) * 3 = 9

func evalRPN(_ tokens: [String]) -> Int {
    var stack = [Int]()
    
    for token in tokens {
        if let num = Int(token) {
            stack.append(num)
        } else {
            let second = stack.popLast()!
            let first = stack.popLast()!
            switch token {
                case "+": stack.append(first + second)
                case "-": stack.append(first - second)
                case "*": stack.append(first * second)
                case "/": stack.append(first / second)
                default: break
            }
        }
    }
    return stack[0]
}

// You are given an absolute path for a Unix-style file system, which always begins with a slash '/'. Your task is to transform this absolute path into its simplified canonical path.

//Example 1:
//
//Input: path = "/home/"
//
//Output: "/home"
//
//Explanation:
//
//The trailing slash should be removed.

func simplifyPath(_ path: String) -> String {
    var stack = [String]()
    
    let components = path.split(separator: "/")
    
    for component in components {
        if component == "." {
            continue
        }
        else if component == ".." {
            if !stack.isEmpty {
                stack.removeLast()
            }
        } else {
            stack.append(String(component))
        }
    }
    return "/"+stack.joined(separator: "/")
}

// shorter solution

func simplifyPathShorter(_ path: String) -> String {
        let stack = path.split(separator: "/").reduce(into: [String]()) { stack, component in
            if component == "." {
                // Do nothing
            } else if component == ".." {
                _ = stack.popLast()
            } else {
                stack.append(String(component))
            }
        }
        
        return "/" + stack.joined(separator: "/")
    }


  // shortest solution

func simplifyPathShortest(_ path: String) -> String {
       "/" + path.split(separator: "/").reduce(into: [String]()) {
           $1 == "." ? () : ($1 == ".." ? _ = $0.popLast() : $0.append(String($1)))
       }.joined(separator: "/")
   }
