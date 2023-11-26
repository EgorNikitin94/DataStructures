import XCTest
@testable import DataStructures

final class DataStructuresTests: XCTestCase {
  func testLinkedList() throws {
    var list = LinkedList<Int>()
    list.push(1)
    list.push(2)
    list.push(3)
    list.pop()
    
    XCTAssertTrue(list.description == "2 -> 1 ")
  }
  
  func testStack() throws {
    var stack = Stack<Int>()
    stack.push(1)
    stack.push(2)
    stack.push(3)
    stack.pop()
    
    XCTAssertTrue(stack.count == 2)
  }
  
  func testOrderedArray() throws {
    let array = [1, 2, 4, 6, 7, 9, 23, 45, 67, 89].sorted()
    let insertedArray = [0, 3, 8, 10, 42, 80, 100]
    
    var orderedArray = OrderedArray<Int>(with: array)
    orderedArray.insert(insertedArray)

    let resultArray = orderedArray.remove(insertedArray)

    XCTAssertEqual(orderedArray.array, array)
    XCTAssertEqual(resultArray, insertedArray)
  }
}
