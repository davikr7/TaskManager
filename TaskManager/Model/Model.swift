//
//  Model.swift
//  TaskManager
//
//  Created by grandmaster on 1.2.23..
//

import Foundation

protocol ModelProtocol {
    var lists: [List] { get set }
    var listCount: Int { get }
}

final class Model: ModelProtocol {
    
    var lists = [List]()
    
    var listCount: Int {
        lists.count
    }
    
    init(lists: [List] = [.mock1, .mock2, .mock3, .mock4]) {
        self.lists = lists
    }
}
