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
}
