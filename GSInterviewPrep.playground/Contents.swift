import UIKit

//Linked List

//Find kth nodes from the end  (Answer)
// Implement a stack with two queues
//Reverse a linked-list
//Single, double, circular linked list
//How to remove a node from a singly-linked list when only given the pointer to the node

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
    
    
}
//Find the depth of the binary tree (a level by the level output of a binary tree)?
//Given a binary tree find the maximum sum from leaf to leaf?


//General Coding Challenge
//Given a matrix of integers, task is to find out the number of positional elements. A positional element is one that is either minimum or maximum in a row or in a column.
// Find the minimum sum of integer equal or less to a number?
//How would you insert an element in a sorted array?

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

//Given an integer, return all sequences of numbers that sum to it. (Example: 3 -&gt; (1, 2), (2, 1), (1, 1, 1))
//Write a method to calculate the cubic root of a number to 3 decimal places.
//Look through the array to find pairs that sum to k (Answer)
//An online retailer allows sellers to post different prices for the same product at different time intervals. Find an algorithm to return a list of sorted intervals with the lowest price.  (Answer)
//Move all zeroes to the beginning of the given array. This needs to be in linear time.  (Answer)

// Other Preps
//What is Object-Oriented Programming?
    //https://www.raywenderlich.com/599-object-oriented-programming-in-swift#toc-anchor-011
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

//Mullti-threaded Question
// Concurrency qne multi-threading
// Graphs
// Binary Search
//Sorting Algorithm
//Implementation of Hash table
