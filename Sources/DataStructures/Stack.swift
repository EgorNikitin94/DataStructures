//
//  File.swift
//  
//
//  Created by Егор Никитин on 11/2/23.
//

import Foundation

public struct Stack<Item> {
  private var array: Array<Item>
  
  public var count: Int {
    array.count
  }
  
  public var isEmpty: Bool {
    array.isEmpty
  }
  
  public init(with array: [Item] = Array<Item>()) {
    self.array = array
  }
  
  public mutating func push(_ value: Item) {
    array.append(value)
  }
  
  @discardableResult
  public mutating func pop() -> Item? {
    array.popLast()
  }
  
  public func top() -> Item? {
    array.last
  }
}

//MARK: - Collection
extension Stack: Collection {
  
  public typealias Index = Int

  public var startIndex: Index {
    array.startIndex
  }
  
  public var endIndex: Index {
    array.endIndex
  }
  
  public func index(after i: Index) -> Index {
    i + 1
  }
  
  public subscript(position: Index) -> Item {
    array[position]
  }
}
