import UIKit

var greeting = "Hello, playground"

// Star Patterns in Swift
// 35+ DSA Pattern Functions
// You can paste this into a Swift Playground

import Foundation

// MARK: 1. Right Triangle
func rightTriangle(_ n: Int) -> String {
    (1...n).map { String(repeating: "*", count: $0) }.joined(separator: "\n")
}

// MARK: 2. Inverted Right Triangle
func invertedRightTriangle(_ n: Int) -> String {
    (1...n).reversed().map { String(repeating: "*", count: $0) }.joined(separator: "\n")
}

// MARK: 3. Left Padded Right Triangle
func leftPaddedTriangle(_ n: Int) -> String {
    (1...n).map { String(repeating: " ", count: n-$0) + String(repeating: "*", count: $0) }.joined(separator: "\n")
}

// MARK: 4. Pyramid
func pyramid(_ n: Int) -> String {
    (1...n).map {
        String(repeating: " ", count: n-$0) + String(repeating: "*", count: 2*$0-1)
    }.joined(separator: "\n")
}

// MARK: 5. Inverted Pyramid
func invertedPyramid(_ n: Int) -> String {
    (1...n).reversed().map {
        String(repeating: " ", count: n-$0) + String(repeating: "*", count: 2*$0-1)
    }.joined(separator: "\n")
}

// MARK: 6. Diamond
func diamond(_ n: Int) -> String {
    let top = pyramid(n)
    let bottom = (1..<n).reversed().map {
        String(repeating: " ", count: n-$0) + String(repeating: "*", count: 2*$0-1)
    }.joined(separator: "\n")
    return top + "\n" + bottom
}

// MARK: 7. Hollow Diamond
func hollowDiamond(_ n: Int) -> String {
    var lines: [String] = []
    for i in 1...n {
        if i == 1 {
            lines.append(String(repeating: " ", count: n-1) + "*")
        } else {
            lines.append(String(repeating: " ", count: n-i) + "*" + String(repeating: " ", count: 2*i-3) + "*")
        }
    }
    for i in (1..<n).reversed() {
        if i == 1 {
            lines.append(String(repeating: " ", count: n-1) + "*")
        } else {
            lines.append(String(repeating: " ", count: n-i) + "*" + String(repeating: " ", count: 2*i-3) + "*")
        }
    }
    return lines.joined(separator: "\n")
}

// MARK: 8. Hollow Square
func hollowSquare(_ n: Int) -> String {
    if n == 1 { return "*" }
    var result = [String(repeating: "*", count: n)]
    for _ in 1..<(n-1) {
        result.append("*" + String(repeating: " ", count: n-2) + "*")
    }
    result.append(String(repeating: "*", count: n))
    return result.joined(separator: "\n")
}

// MARK: 9. Filled Square
func filledSquare(_ n: Int) -> String {
    (1...n).map { _ in String(repeating: "*", count: n) }.joined(separator: "\n")
}

// MARK: 10. Hollow Half Pyramid
func hollowHalfPyramid(_ n: Int) -> String {
    var lines: [String] = []
    for i in 1...n {
        if i == 1 || i == 2 || i == n {
            lines.append(String(repeating: "*", count: i))
        } else {
            lines.append("*" + String(repeating: " ", count: i-2) + "*")
        }
    }
    return lines.joined(separator: "\n")
}

// MARK: 11. Reverse Hollow Half Pyramid
func reverseHollowHalfPyramid(_ n: Int) -> String {
    var lines: [String] = []
    for i in (1...n).reversed() {
        if i == 1 || i == n || i == 2 {
            lines.append(String(repeating: "*", count: i))
        } else {
            lines.append("*" + String(repeating: " ", count: i-2) + "*")
        }
    }
    return lines.joined(separator: "\n")
}

// MARK: 12. Pascal Style Star Triangle
func pascalStar(_ n: Int) -> String {
    (1...n).map { String(repeating: "* ", count: $0).trimmingCharacters(in: .whitespaces) }.joined(separator: "\n")
}

// MARK: 13. Number Pyramid
func numberPyramid(_ n: Int) -> String {
    (1...n).map { (1...$0).map { String($0) }.joined() }.joined(separator: "\n")
}

// MARK: 14. Floyd-like Triangle
func floydStar(_ n: Int) -> String {
    (1...n).map { String(repeating: "*", count: $0) }.joined(separator: "\n")
}

// 15. Hourglass
func hourglass(_ n: Int) -> String {
    invertedPyramid(n) + "\n" + pyramid(n)
}

// 16. Butterfly Pattern
func butterfly(_ n: Int) -> String {
    var lines: [String] = []
    for i in 1...n {
        lines.append(String(repeating: "*", count: i) + String(repeating: " ", count: 2*(n-i)) + String(repeating: "*", count: i))
    }
    for i in (1..<n).reversed() {
        lines.append(String(repeating: "*", count: i) + String(repeating: " ", count: 2*(n-i)) + String(repeating: "*", count: i))
    }
    return lines.joined(separator: "\n")
}

// 17. Sandglass
func sandglass(_ n: Int) -> String {
    invertedRightTriangle(n) + "\n" + rightTriangle(n)
}

// 18. Zig-Zag
func zigzag(_ n: Int) -> String {
    var lines = Array(repeating: Array(repeating: " ", count: n), count: 3)
    for i in 0..<n {
        if i % 4 == 1 {
            lines[1][i] = "*"
        } else if i % 4 == 0 {
            lines[0][i] = "*"
        } else {
            lines[2][i] = "*"
        }
    }
    return lines.map { $0.joined() }.joined(separator: "\n")
}

// 19. Rhombus
func rhombus(_ n: Int) -> String {
    (1...n).map { String(repeating: " ", count: n-$0) + String(repeating: "*", count: n) }.joined(separator: "\n")
}

// 20. Hollow Rhombus
func hollowRhombus(_ n: Int) -> String {
    var lines: [String] = []
    for i in 1...n {
        if i == 1 || i == n {
            lines.append(String(repeating: " ", count: n-i) + String(repeating: "*", count: n))
        } else {
            lines.append(String(repeating: " ", count: n-i) + "*" + String(repeating: " ", count: n-2) + "*")
        }
    }
    return lines.joined(separator: "\n")
}

// 21. Cross Pattern
func cross(_ n: Int) -> String {
    var grid = Array(repeating: Array(repeating: " ", count: n), count: n)
    for i in 0..<n {
        grid[i][i] = "*"
        grid[i][n-i-1] = "*"
    }
    return grid.map { $0.joined() }.joined(separator: "\n")
}

// 22. Plus Pattern
func plusPattern(_ n: Int) -> String {
    let mid = n/2
    var grid = Array(repeating: Array(repeating: " ", count: n), count: n)
    for i in 0..<n {
        grid[mid][i] = "*"
        grid[i][mid] = "*"
    }
    return grid.map { $0.joined() }.joined(separator: "\n")
}

// 23. X Pattern
func xPattern(_ n: Int) -> String {
    cross(n)
}

// 24. Star Box with diagonals
func diagonalBox(_ n: Int) -> String {
    var grid = Array(repeating: Array(repeating: " ", count: n), count: n)
    for i in 0..<n {
        grid[0][i] = "*"
        grid[n-1][i] = "*"
        grid[i][0] = "*"
        grid[i][n-1] = "*"
        grid[i][i] = "*"
        grid[i][n-i-1] = "*"
    }
    return grid.map { $0.joined() }.joined(separator: "\n")
}

// 25. Hollow Pyramid
func hollowPyramid(_ n: Int) -> String {
    var lines: [String] = []
    for i in 1...n {
        if i == 1 {
            lines.append(String(repeating: " ", count: n-1) + "*")
        } else if i == n {
            lines.append(String(repeating: "*", count: 2*n-1))
        } else {
            lines.append(String(repeating: " ", count: n-i) + "*" + String(repeating: " ", count: 2*i-3) + "*")
        }
    }
    return lines.joined(separator: "\n")
}

// 26. Hollow Inverted Pyramid
func hollowInvertedPyramid(_ n: Int) -> String {
    var lines: [String] = []
    for i in (1...n).reversed() {
        if i == n {
            lines.append(String(repeating: "*", count: 2*n-1))
        } else if i == 1 {
            lines.append(String(repeating: " ", count: n-1) + "*")
        } else {
            lines.append(String(repeating: " ", count: n-i) + "*" + String(repeating: " ", count: 2*i-3) + "*")
        }
    }
    return lines.joined(separator: "\n")
}

// 27. Binary Stair Pattern
func binaryStair(_ n: Int) -> String {
    (1...n).map { i in
        (0..<i).map { (($0 + i) % 2 == 0) ? "1" : "0" }.joined()
    }.joined(separator: "\n")
}

// 28. 0-1 Triangle
func zeroOneTriangle(_ n: Int) -> String {
    (1...n).map { i in
        (0..<i).map { (($0 + i) % 2 == 0) ? "1" : "0" }.joined()
    }.joined(separator: "\n")
}

// 29. Alternating Star Pattern
func alternatingStar(_ n: Int) -> String {
    (0..<n).map {
        (($0 % 2 == 0) ? "* " : " *").trimmingCharacters(in: .whitespaces)
    }.joined(separator: "\n")
}

// 30. Spiral-like step
func stepPattern(_ n: Int) -> String {
    (0..<n).map { String(repeating: " ", count: $0) + "*" }.joined(separator: "\n")
}

// 31. Double Hill
func doubleHill(_ n: Int) -> String {
    (1...n).map {
        String(repeating: " ", count: n-$0) + String(repeating: "*", count: $0) + String(repeating: " ", count: 2*(n-$0)) + String(repeating: "*", count: $0)
    }.joined(separator: "\n")
}

// 32. Hollow Double Hill
func hollowDoubleHill(_ n: Int) -> String {
    var lines: [String] = []
    for i in 1...n {
        if i == 1 {
            lines.append(String(repeating: " ", count: n-1) + "*" + String(repeating: " ", count: 2*n-2) + "*")
        } else {
            lines.append(String(repeating: " ", count: n-i) + "*" + String(repeating: " ", count: i-2) + "*" + String(repeating: " ", count: 2*(n-i)) + "*" + String(repeating: " ", count: i-2) + "*")
        }
    }
    return lines.joined(separator: "\n")
}

// 33. Increase-Decrease Mixed
func upDown(_ n: Int) -> String {
    let up = (1...n).map { String(repeating: "*", count: $0) }
    let down = (1..<n).reversed().map { String(repeating: "*", count: $0) }
    return (up + down).joined(separator: "\n")
}

// 34. K Pattern
func kPattern(_ n: Int) -> String {
    var lines: [String] = []
    var mid = n/2
    for i in 0..<n {
        if i == mid {
            lines.append("*")
        } else {
            let spaces = abs(mid - i)
            lines.append("*" + String(repeating: " ", count: spaces) + "*")
        }
    }
    return lines.joined(separator: "\n")
}

// 35. Christmas Tree
func christmasTree(_ n: Int) -> String {
    let tree = pyramid(n)
    let trunk = (1...2).map { _ in String(repeating: " ", count: n-1) + "***" }.joined(separator: "\n")
    return tree + "\n" + trunk
}

// Example usage:
print(pyramid(5))
