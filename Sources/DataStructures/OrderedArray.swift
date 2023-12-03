//
//  File.swift
//  
//
//  Created by Егор Никитин on 11/25/23.
//

import Foundation

fileprivate final class BackendOrderedArray<Item> where Item: Comparable {
  private(set) var array: Array<Item>
  
  init(with array: Array<Item> = []) {
    self.array = array.sorted()
  }
  
  func insert(_ item: Item) {
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
  
  func insert(_ items: [Item]) {
    items.forEach({ insert($0) })
  }
  
  @discardableResult
  func remove(_ item: Item) -> Item? {
    if let index = findItemIndex(item, in: 0 ..< array.count) {
      return removeAtIndex(index)
    }
    return nil
  }
  
  @discardableResult
  func remove(_ items: [Item]) -> [Item] {
    return items.compactMap({ remove($0) })
  }
  
  @discardableResult
  func removeAtIndex(_ index: Int) -> Item {
    array.remove(at: index)
  }
  
  func copy() -> BackendOrderedArray<Item> {
    BackendOrderedArray<Item>(with: array)
  }
}

//MARK: - Private
fileprivate extension BackendOrderedArray {
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

public struct OrderedArray<Item> where Item: Comparable {
  private var internalOrderedArray: BackendOrderedArray<Item>
  
  public var array: [Item] {
    internalOrderedArray.array
  }
  
  public init(with array: Array<Item> = []) {
    self.internalOrderedArray = BackendOrderedArray<Item>(with: array)
  }
  
  /// Inserts a new element in sort order into OrderedArray
  ///
  /// The new element is inserted in sort order
  ///
  ///     var numbers = OrderedArray<Int>(with: [1, 3, 5])
  ///     numbers.insert(2)
  ///     numbers.insert(4)
  ///
  ///     print(numbers)
  ///     // Prints "OrderedArray: [1, 2, 3, 4, 5]"
  ///
  /// - Parameter item: The new element to insert into the array. Must be Comparable
  ///
  /// - Complexity: O(*n*), where *n* is the length of the array
  public mutating func insert(_ item: Item) {
    checkUniquelyReferencedInternalQueue()
    return internalOrderedArray.insert(item)
  }
  
  /// Inserts a new elements in sort order into OrderedArray
  ///
  /// The new elements is inserted in sort order
  ///
  ///     var numbers = OrderedArray<Int>(with: [1, 3, 5])
  ///     numbers.insert([0, 2, 4, 6])
  ///
  ///     print(numbers)
  ///     // Prints "OrderedArray: [0, 1, 2, 3, 4, 5, 6]"
  ///
  /// - Parameter items: The new elements to insert into the array. All must be Comparable
  ///
  /// - Complexity: O(*n*), where *n* is the length of the array
  public mutating func insert(_ items: [Item]) {
    checkUniquelyReferencedInternalQueue()
    items.forEach({ insert($0) })
  }
  
  /// Removes and returns the element
  ///
  /// All the elements following the specified position are moved up to
  /// close the gap.
  ///
  ///     var numbers = OrderedArray<Int>(with: [0, 1, 3, 5, 9, 29])
  ///     numbers.remove(9)
  ///
  ///     print(numbers)
  ///     // Prints "OrderedArray: [1, 3, 5, 9, 29]"
  ///
  /// - Parameter item: The elements to removes from the array. All must be Comparable
  ///
  /// - Returns: The finded element or nil
  ///
  /// - Complexity: O(*n*), where *n* is the length of the array
  @discardableResult
  public mutating func remove(_ item: Item) -> Item? {
    checkUniquelyReferencedInternalQueue()
    return internalOrderedArray.remove(item)
  }
  
  /// Removes and returns the elements
  ///
  /// All the elements following the specified position are moved up to
  /// close the gap.
  ///
  ///     var numbers = OrderedArray<Int>(with: [0, 1, 3, 5, 9, 29])
  ///     numbers.remove([0, 5])
  ///
  ///     print(numbers)
  ///     // Prints "OrderedArray: [1, 3, 9, 29]"
  ///
  /// - Parameter item: The elements to remove from the array. All must be Comparable
  ///
  /// - Returns: The finded elements in array
  ///
  /// - Complexity: O(*n*), where *n* is the length of the array
  @discardableResult
  public mutating func remove(_ items: [Item]) -> [Item] {
    checkUniquelyReferencedInternalQueue()
    return items.compactMap({ remove($0) })
  }
  
  /// Removes and returns the element at the specified position.
  ///
  /// All the elements following the specified position are moved up to
  /// close the gap.
  ///
  ///     var numbers = OrderedArray<Int>(with: [0, 1, 3, 5, 9, 29])
  ///     numbers.removeAtIndex(1)
  ///
  ///     print(numbers)
  ///     // Prints "OrderedArray: [0, 3, 5, 9, 29]"
  ///
  /// - Parameter index: The position of the element to remove. `index` must
  ///   be a valid index of the orderedArray.
  /// - Returns: The element at the specified index.
  ///
  /// - Complexity: O(*n*), where *n* is the length of the array.
  @discardableResult
  public mutating func removeAtIndex(_ index: Int) -> Item {
    checkUniquelyReferencedInternalQueue()
    return internalOrderedArray.removeAtIndex(index)
  }
}

//MARK: - CustomStringConvertible
extension OrderedArray: CustomStringConvertible {
  public var description: String {
    "OrderedArray: " + internalOrderedArray.array.description
  }
}

//MARK: - COW
private extension OrderedArray {
  private mutating func checkUniquelyReferencedInternalQueue() {
    if !isKnownUniquelyReferenced(&internalOrderedArray) {
      internalOrderedArray = internalOrderedArray.copy()
    }
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
