//
//  File.swift
//  
//
//  Created by Егор Никитин on 11/2/23.
//

import Foundation

fileprivate final class BackendStack<Item> {
  var array: Array<Item>
  
  init(with array: [Item] = Array<Item>()) {
    self.array = array
  }
  
  func push(_ value: Item) {
    array.append(value)
  }
  
  @discardableResult
  func pop() -> Item? {
    array.popLast()
  }
  
  func top() -> Item? {
    array.last
  }
  
  func copy() -> BackendStack<Item> {
    BackendStack<Item>(with: array)
  }
}

public struct Stack<Item> {
  private var internalStack: BackendStack<Item>
  
  public init(with array: [Item] = Array<Item>()) {
    self.internalStack = BackendStack<Item>(with: array)
  }
  
  public mutating func push(_ value: Item) {
    checkUniquelyReferencedInternalStack()
    internalStack.push(value)
  }
  
  @discardableResult
  public mutating func pop() -> Item? {
    checkUniquelyReferencedInternalStack()
    return internalStack.pop()
  }
  
  public func top() -> Item? {
    internalStack.top()
  }
  
  private mutating func checkUniquelyReferencedInternalStack() {
    if !isKnownUniquelyReferenced(&internalStack) {
      internalStack = internalStack.copy()
    }
  }
}

//MARK: - Collection
extension Stack: Collection {
  
  public typealias Index = Int

  public var startIndex: Index {
    internalStack.array.startIndex
  }
  
  public var endIndex: Index {
    internalStack.array.endIndex
  }
  
  public func index(after i: Index) -> Index {
    i + 1
  }
  
  public subscript(position: Index) -> Item {
    internalStack.array[position]
  }
}
