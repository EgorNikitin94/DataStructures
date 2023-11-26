//
//  File.swift
//  
//
//  Created by Егор Никитин on 11/2/23.
//

import Foundation

public struct Queue<Item> {
  private var array: [Item]
  
  public var isEmpty: Bool {
    array.isEmpty
  }
  
  public var count: Int {
    array.count
  }
  
  public init(with array: [Item] = Array<Item>()) {
    self.array = array
  }
  
  public mutating func enqueue(_ element: Item) {
    array.append(element)
  }
  
  public mutating func dequeue() -> Item? {
    array.removeFirst()
  }
  
  public func front() -> Item? {
    array.first
  }
}

//MARK: - Collection
extension Queue: Collection {
  
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
