//
//  File.swift
//  
//
//  Created by Егор Никитин on 11/2/23.
//

import Foundation

fileprivate final class BackendQueue<Item> {
  var array: [Item]
  
  init(array: [Item] = Array<Item>()) {
    self.array = array
  }
  
  func enqueue(_ element: Item) {
    array.append(element)
  }
  
  func dequeue() -> Item? {
    array.removeFirst()
  }
  
  func front() -> Item? {
    array.first
  }
  
  func copy() -> BackendQueue<Item> {
    BackendQueue<Item>(array: array)
  }
}

public struct Queue<Item> {
  private var internalQueue: BackendQueue<Item>
  
  public init(with array: [Item] = Array<Item>()) {
    self.internalQueue = BackendQueue<Item>(array: array)
  }
  
  public mutating func enqueue(_ element: Item) {
    checkUniquelyReferencedInternalQueue()
    internalQueue.enqueue(element)
  }
  
  public mutating func dequeue() -> Item? {
    checkUniquelyReferencedInternalQueue()
    return internalQueue.dequeue()
  }
  
  public func front() -> Item? {
    internalQueue.front()
  }
  
  private mutating func checkUniquelyReferencedInternalQueue() {
    if !isKnownUniquelyReferenced(&internalQueue) {
      internalQueue = internalQueue.copy()
    }
  }
}

//MARK: - Collection
extension Queue: Collection {
  
  public typealias Index = Int

  public var startIndex: Index {
    internalQueue.array.startIndex
  }
  
  public var endIndex: Index {
    internalQueue.array.endIndex
  }
  
  public func index(after i: Index) -> Index {
    i + 1
  }
  
  public subscript(position: Index) -> Item {
    internalQueue.array[position]
  }
}
