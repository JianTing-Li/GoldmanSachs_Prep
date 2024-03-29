import UIKit

//Linked List

//Find kth nodes from the end  (Answer)
// Implement a stack with two queues
//Reverse a linked-list
//Single, double, circular linked list
//How to remove a node from a singly-linked list when only given the pointer to the node
class Node<T> {
    let value: T
    var next: Node?
    
    init(value: T) {
        self.value = value
    }
}
extension Node: CustomStringConvertible {
    var description: String {
        if let nextNode = next {
            return "\(value) -> \(nextNode)"
        } else {
            return "\(value) -> nil"
        }
    }
}

let node3 = Node(value: 3)
let node5 = Node(value: 5)
let node11 = Node(value: 11)

node3.next = node5
node5.next = node11



func reverseLinkList<T>(node: Node<T>?) -> Node<T>? {
    guard let node = node else { return nil }
    var linkListValues = [node.value]
    var currentNode = node
    while let nextNode = currentNode.next {
        linkListValues.append(nextNode.value)
        currentNode = nextNode
    }
    
    let rootNode = Node(value: linkListValues.popLast()!)
    var lastNode = rootNode
    while let value = linkListValues.popLast() {
        let newNode = Node(value: value)
        lastNode.next = newNode
        lastNode = newNode
    }
    return rootNode
}
//let reverseNode = reverseLinkList(node: node3)
//print(reverseNode ?? "invalid node")
//print(node3)


//Tree
class TreeNode<T: Equatable>: CustomStringConvertible {
    var parent: TreeNode?
    var children = [TreeNode]()
    var value: T
    
    init(value: T) {
        self.value = value
    }
    
    func addChild(child: TreeNode) {
        children.append(child)
        child.parent = self
    }
    
    var description: String {
        guard !children.isEmpty else {
            return "\(value)"
        }
        return  "(\(value))" + "{" + "\(children.map {$0.description}.joined(separator: ", "))" + "}"
    }
    
    func searchValue(value: T) -> TreeNode? {
        if self.value == value { return self }
        for child in children {
            if let foundNode = searchValue(value: child.value) {
                return foundNode
            }
        }
        return nil
    }
}

let animalNode = TreeNode(value: "Animal")

let mammalNode = TreeNode(value: "Mammal")
let fishNode = TreeNode(value: "Fish")
animalNode.addChild(child: mammalNode)
animalNode.addChild(child: fishNode)

let catNode = TreeNode(value: "Cat")
let dogNode = TreeNode(value: "Dog")
let salmonNode = TreeNode(value: "Salmon")
mammalNode.addChild(child: catNode)
mammalNode.addChild(child: dogNode)
fishNode.addChild(child: salmonNode)
//print(animalNode) // (Animal){(Mammal){Cat, Dog}, (Fish){Salmon}}


//Binary Search Trees
class BinaryTreeNode<T> {
    var value: T
    var leftChild: BinaryTreeNode?
    var rightChild: BinaryTreeNode?
    
    init(value: T) {
        self.value = value
    }
    
    func inOrderTraversal(visit: (BinaryTreeNode) -> Void) {
        leftChild?.inOrderTraversal(visit: visit)
        visit(self)
        rightChild?.inOrderTraversal(visit: visit)
    }
    
    func preOrderTraversal(visit: (BinaryTreeNode) -> Void) {
        visit(self)
        leftChild?.preOrderTraversal(visit: visit)
        rightChild?.preOrderTraversal(visit: visit)
    }
    
    func postOrderTraversal(visit: (BinaryTreeNode) -> Void) {
        leftChild?.postOrderTraversal(visit: visit)
        rightChild?.postOrderTraversal(visit: visit)
        visit(self)
    }
}

/*
        10
       /  \
      2    5
     / \  / \
    4  9  7  11
   /
 12
 */
//Find the depth of the binary tree (a level by the level output of a binary tree)?
// keep checking whether there is a next level for the nodes by adding their children to an array. As long as one node has 1 children, the temp array of nodes would not be empty. During each iteration, we go down 1 level.
// https://windsuzu.github.io/leetcode-104/
func maxDepth<T>(_ root: BinaryTreeNode<T>?) -> Int {
    guard root != nil else { return 0 }
    var depth = 0
    var temp = [BinaryTreeNode<T>]()
    while !temp.isEmpty {
        for node in temp {
            temp.removeFirst()
            if let leftNode = node.leftChild {
                temp.append(leftNode)
            }
            if let rightNode = node.rightChild {
                temp.append(rightNode)
            }
        }
        depth += 1
    }
    return depth
}
func getHeight<T>(node: BinaryTreeNode<T>?) -> Int{
    guard let node = node else {return 0}
    return 1 + max(getHeight(node: node.leftChild), getHeight(node: node.rightChild))
}

// find the longest path of a binary search tree
func findAllPaths<T>(node: BinaryTreeNode<T>?,
                     path: [Int] = [],
                     allPaths: [[Int]] = []) -> [[Int]] {
    guard let node = node else { return allPaths }
    var path = path
    var allPaths = allPaths
    // if we are all the end of the node
    if node.leftChild == nil && node.rightChild == nil {
        path.append(node.value as! Int)
        allPaths.append(path)
    } else {
        if let leftNode = node.leftChild {
            allPaths = findAllPaths(node: leftNode, path: path, allPaths: allPaths)
        }
        if let rightNode = node.rightChild {
            allPaths = findAllPaths(node: rightNode, path: path, allPaths: allPaths)
        }
    }
    return allPaths
}




//General Coding Challenge
//Find the second largest number in the array.
func findSecondLargest(nums: [Int]) -> Int? {
    guard nums.count > 1 else { return nil }
    var largest = Int.min
    var secondLargest = Int.min
    for currentNum in nums {
        if currentNum > largest {
            secondLargest = largest
            largest = currentNum
        } else if currentNum > secondLargest {
            secondLargest = currentNum
        }
    }
    return secondLargest
}
//print(findSecondLargest(nums: [3, 5, 1, -1, 10, 100]))    // 10
//print(findSecondLargest(nums: [1])) // nil

// given 2 sorted arrs, return the median
func medianOf2Arrs(arr1: [Int], arr2: [Int]) -> Double {
    let mergeArr = combinedTwoSortedArrs(arr1: arr1, arr2: arr2)
    print(mergeArr)
    if mergeArr.count.isMultiple(of: 2) {
        let middleIndex = mergeArr.count / 2
        return Double(mergeArr[middleIndex] + mergeArr[middleIndex - 1]) / 2
    } else {
        return Double(mergeArr[mergeArr.count / 2])
    }
}

func combinedTwoSortedArrs(arr1: [Int], arr2: [Int]) -> [Int] {
    var index1 = 0
    var index2 = 0
    var newArr = [Int]()
    while index1 < arr1.count && index2 < arr2.count {
        let num1 = arr1[index1]
        let num2 = arr2[index2]
        if num1 < num2 {
            newArr.append(num1)
            index1 += 1
        } else if num2 < num1 {
            newArr.append(num2)
            index2 += 1
        } else {
            newArr.append(contentsOf: [num1, num2])
            index1 += 1
            index2 += 1
        }
    }
    if index1 < arr1.count {
        newArr.append(contentsOf: arr1[index1..<arr1.count])
    }
    if index2 < arr2.count {
        newArr.append(contentsOf: arr2[index2..<arr2.count])
    }
    return newArr
}
//print(medianOf2Arrs(arr1: [-1, 5], arr2: [0]))

// Longest Word - Given a list of random letters see the longest word you can make from a bank of words
func getLongestWord(randomLetters: String, wordBank: [String]) -> String? {
    let sortedWordBank = wordBank.sorted { $0.count > $1.count }
    let lowercasedRandomLetters = randomLetters.lowercased()
    for word in sortedWordBank {
        if lowercasedRandomLetters.contains(word.lowercased()) { return word }
    }
    return nil
}
//print(getLongestWord(randomLetters: "skfjldcatsfjdsl", wordBank: ["cat", "meow"])) // "cat"


/*
 https://leetcode.com/problems/circular-array-loop/ simlar problem
countLengthOfCycle(arr, startIndex)
* You are given an integer array of size N.
* Every element of the array is greater than or equal to 0.
* Starting from arr[startIndex], follow each element to the index it points to.
* Continue to do this until you find a cycle.
* Return the length of the cycle. If no cycle is found return -1
countLengthOfCycle([1, 0, 3], 0) = 2        0, 1,    0, 1
countLengthOfCycle([1, 2, 0], 0) = 3        0, 1, 2,    0, 1, 2
countLengthOfCycle([3, 2, 1, 1], 0) = 2
countLengthOfCycle([3, 2, 4, 1, 0], 0) = 5      0, 3, 1, 2, 4,   0, 3, 1, 2, 4
*/
    // keep track of the indexes I go into, once I go into an in which I already gone to, that's where the cycle repeats itself
    // keep track of the count of the cycle
    // questions: non-empty array? Out of bound indexes?
func countLengthOfCycle(arr: [Int], startIndex: Int) -> Int {
    guard arr.indices.contains(startIndex) else { return -1 }
    var indexTracker = [Int]()
    var currentIndex = startIndex
    while !indexTracker.contains(currentIndex) {
        indexTracker.append(currentIndex)
        let nextIndex = arr[currentIndex]
        guard arr.indices.contains(nextIndex) else { return -1 }
        currentIndex = nextIndex
    }
    return indexTracker.count
}
// print(countLengthOfCycle(arr: [3,2,4,1,0], startIndex: 0))


/*
Find the longest subString
and return the starting index of the subString and its length
input: ''             output: [-1, 0]
input: '123'          output: [-1, 0]
input: 'aabbccccc'    output: [4, 5]
input: 'aaaabccdddd'  output: [-1, 0]
*/



/*
 https://leetcode.com/problems/longest-substring-without-repeating-characters/
 Given a string, find the length of the longest substring without repeating characters.
 
 Input: "abcabcbb"
 Output: 3
 Explanation: The answer is "abc", with the length of 3.
 if`
 abc bca cab abc bcb
 // variable to keep track of the non-repeating chars for each substring
 // placeholder to keep track of the longest subtring
 */

//func lengthOfLongestSubstring(string: String) -> Int {
//    var longestLength = 0
//    var subString = string.prefix(0)
//    // keep track of the indices 1) start indice 2) end indice
//    // each I move to a new char, check if that charcter already exist in the substring
//        //if it exist, move to the next starting indice & reset subString w/ the start & end indices of the next letter
//
//    return longestLength
//}

func lengthOfLongestSubstring(string: String) -> Int {
    var longestLength = 0
    let arrString = Array(string)
    var letterTracker = [Character]()
    
    for startIndex in 0..<string.count {
        for endIndex in startIndex..<string.count {
            let currentLetter = arrString[endIndex]
            if letterTracker.contains(currentLetter) {
                break
            } else {
                letterTracker.append(currentLetter)
            }
        }
        if letterTracker.count > longestLength {
            longestLength = letterTracker.count
        }
        letterTracker = [Character]()
    }
    return longestLength
}
//print(lengthOfLongestSubstring(s: " "))

// out of bound
func lengthOfLongestSubstring2(s: String) -> Int {
    var longestLength = 0
    var subString = s.prefix(0)
    var endIndexOffset = 0
    for startIndexOffset in 0..<s.count {
        endIndexOffset = -s.count + startIndexOffset + 2
        while endIndexOffset < 1 {
            let end = s.index(s.endIndex, offsetBy: endIndexOffset)
            guard !subString.contains(s[end])  else { break }
            let start = s.index(s.startIndex, offsetBy: startIndexOffset)
            let range = start..<end
            subString = s[range]
            endIndexOffset += 1
        }
        if subString.count > longestLength {
            longestLength = subString.count
        }
    }
    return longestLength
}



/*
https://leetcode.com/problems/trapping-rain-water/  (hard problem)
Given n non-negative integers representing an elevation map where the width of each bar is 1,
compute how much water it is able to trap after raining.
Input: [0,1,0,2,1,0,1,3,2,1,2,1]
Output: 6
*/



/*
https://leetcode.com/problems/string-compression/
 Given an array of characters, compress it in-place.
 The length after compression must always be smaller than or equal to the original array.
 Every element of the array should be a character (not int) of length 1.
 After you are done modifying the input array in-place, return the new length of the array.
 Follow up:
 Could you solve it using only O(1) extra space?

 Example 1:

 Input:
 ["a","a","b","b","c","c","c"]

 Output:
 Return 6, and the first 6 characters of the input array should be: ["a","2","b","2","c","3"]

 Explanation:
 "aa" is replaced by "a2". "bb" is replaced by "b2". "ccc" is replaced by "c3".
 */
/*
[a, a, c, c]
 [a, c] -> 2
*/
// 2 pointers
    // 1) where I am overwriting
    // 2) where I am at at the orignal array
func lengthOfCompressedArr(_ chars: inout [Character]) -> Int {
    var dict = [Character : Int]()
    for char in chars {
        if let letterCount = dict[char] {
            dict[char] = letterCount + 1
        } else {
            dict[char] = 1
        }
    }
    var count = 0
    for letterCount in dict.values {
        if letterCount > 1 { count += letterCount.description.count }
        count += 1
    }
    return count
}
//var arrChars: [Character] = ["a","a","b","b","c","c","c"]
//print(lengthOfCompressedArr(&arrChars)) // 6  because ["a", "2", "b", "2", "c", "3"]






//Look through the array to find pairs that sum to k (Answer)
//An online retailer allows sellers to post different prices for the same product at different time intervals. Find an algorithm to return a list of sorted intervals with the lowest price.  (Answer)
//Move all zeroes to the beginning of the given array. This needs to be in linear time.  (Answer)

// Other Preps
//What is Object-Oriented Programming?
    // https://www.raywenderlich.com/599-object-oriented-programming-in-swift#toc-anchor-011
    // Encapsulation (reduce complexity + increase reusability)
    // A Software Design that encapsulates related variables and functions that operate on then into a unit (object)
        // eg. Car
            // properties such as make, model, & color
            // functions such as start(), stop(), honk(), move()
    // Abstraction (reduce complexity + isolate impact of changes)
        // hide properties and methods from outside and this give us benefits
            // make interface of those objects simpler
            // reduce the impact of change because those code will be inside the object & not the rest of the application code
    // Inheritance (reduce redundant code)
        // Another benefit is Inheritance which reduce the redundancy of code
    // Polymorphism (many forms; refactor ugly switch statements)
        // Objects of different classes can be used interchangeably if they have a common superclass
        // technique that get rid of if and else & switch statements

//What is Protocol Oriented Programming
    // https://www.raywenderlich.com/1258671-advanced-swift-protocol-oriented-programming
    // https://www.youtube.com/watch?v=lBr8onqP_fM
    // new type of programming design that solves the probems in OOP
        // e.g., (shape in Rectangle & circle, circle don't need size)
        // inheritance (only 1)
        // shared value changes (implicit sharing)
    // add rules to the object

//Mullti-threaded Question
// Concurrency and multi-threading
// Graphs
// Binary Search
//Sorting Algorithm
//Implementation of Hash table
