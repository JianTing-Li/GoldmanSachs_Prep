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

//Binary Search Trees
//Find the depth of the binary tree (a level by the level output of a binary tree)?
//Given a binary tree find the maximum sum from leaf to leaf?


//General Coding Challenge
//Given a matrix of integers, task is to find out the number of positional elements. A positional element is one that is either minimum or maximum in a row or in a column.
// Find the minimum sum of integer equal or less to a number?
//How would you insert an element in a sorted array?

//Find the second largest number in the array.
func findSecondLargest(nums: [Int]) -> Int {
    return 1
}
//Given an integer, return all sequences of numbers that sum to it. (Example: 3 -&gt; (1, 2), (2, 1), (1, 1, 1))
//Write a method to calculate the cubic root of a number to 3 decimal places.
//Look through the array to find pairs that sum to k (Answer)
//An online retailer allows sellers to post different prices for the same product at different time intervals. Find an algorithm to return a list of sorted intervals with the lowest price.  (Answer)
//Move all zeroes to the beginning of the given array. This needs to be in linear time.  (Answer)

// Other Preps
//What is Object-Oriented Programming?
//What is Polymorphism?
//What happens if we do not have a hashcode method in an object?
//Mullti-threaded Question
// Concurrency qne multi-threading
// Graphs
// Binary Search
//Sorting Algorithm
//Implementation of Hash table
