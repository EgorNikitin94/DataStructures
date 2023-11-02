//
//  File.swift
//  
//
//  Created by Егор Никитин on 11/2/23.
//

import Foundation

public struct Stack<T> {
  private var array: Array<T>
  
  public var count: Int {
    array.count
  }
  
  public var isEmpty: Bool {
    array.isEmpty
  }
  
  public init(with array: [T] = Array<T>()) {
    self.array = array
  }
  
  public mutating func push(_ value: T) {
    array.append(value)
  }
  
  @discardableResult
  public mutating func pop() -> T? {
    array.popLast()
  }
  
  public func top() -> T? {
    array.last
  }
}
