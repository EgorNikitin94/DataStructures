//
//  File.swift
//  
//
//  Created by Егор Никитин on 11/25/23.
//

import Foundation

struct SortedArray<Item> where Item: Equatable & Comparable {
  private var array: Array<Item>
  
  var isEmpty: Bool {
    array.isEmpty
  }
  
  var count: Int {
    array.count
  }
  
  init(with array: Array<Item> = []) {
    self.array = array.sorted()
  }
  
  func insert(_ item: Item) {
    
  }
  
  private func searchInsertIndex(for item: Item) -> Int {
    guard !array.isEmpty else { return 0 }
    var index: Int = array.count / 2
    var startIndex = 0
    var endIndex = array.count - 1
    
    return 2
  }
}
