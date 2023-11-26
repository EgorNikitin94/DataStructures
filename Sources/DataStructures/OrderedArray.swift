//
//  File.swift
//  
//
//  Created by Егор Никитин on 11/25/23.
//

import Foundation

public struct OrderedArray<Item> where Item: Comparable {
  private(set) var array: Array<Item>
  
  public var isEmpty: Bool {
    array.isEmpty
  }
  
  public var count: Int {
    array.count
  }
  
  public init(with array: Array<Item> = []) {
    self.array = array.sorted()
  }
  
  public mutating func insert(_ item: Item) {
    let index = if let min = array.first, item < min {
      0
    } else if let max = array.last, item > max {
      array.count
    } else if array.isEmpty {
      0
    } else {
      findInsertIndex(for: item, in: 0 ..< array.count - 1)
    }
    array.insert(item, at: index)
  }
  
  public mutating func insert(_ items: [Item]) {
    items.forEach({ insert($0) })
  }
  
  @discardableResult
  public mutating func remove(_ item: Item) -> Item? {
    if let index = findItemIndex(item, in: 0 ..< array.count) {
      return removeAtIndex(index)
    }
    return nil
  }
  
  @discardableResult
  public mutating func remove(_ items: [Item]) -> [Item] {
    return items.compactMap({ remove($0) })
  }
  
  @discardableResult
  public mutating func removeAtIndex(_ index: Int) -> Item {
    array.remove(at: index)
  }
}

//MARK: - CustomStringConvertible
extension OrderedArray: CustomStringConvertible {
  public var description: String {
    "OrderedArray: " + array.description
  }
}

//MARK: - Collection
extension OrderedArray: Collection {
  
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

//MARK: - Private
private extension OrderedArray {
  private func findInsertIndex(for item: Item, in range: Range<Int>) -> Int {
    if range.lowerBound == range.upperBound {
      return range.lowerBound
    }
    
    let midIndex = ((range.upperBound - range.lowerBound) / 2) + range.lowerBound
    let midItem = array[midIndex]
    
    if item > midItem {
      return findInsertIndex(for: item, in: midIndex + 1 ..< range.upperBound)
    } else if item < midItem  {
      return findInsertIndex(for: item, in: range.lowerBound ..< midIndex)
    } else {
      return midIndex
    }
  }
  
  private func findItemIndex(_ item: Item, in range: Range<Int>) -> Int? {
    if range.lowerBound >= range.upperBound {
      return nil
    }
    
    let midIndex = ((range.upperBound - range.lowerBound) / 2) + range.lowerBound
    let midItem = array[midIndex]
    
    if item > midItem {
      return findItemIndex(item, in: midIndex + 1 ..< range.upperBound)
    } else if item < midItem {
      return findItemIndex(item, in: range.lowerBound ..< midIndex)
    } else {
      return midIndex
    }
  }
}
