//
//  List.swift
//  TaskManager
//
//  Created by grandmaster on 1.2.23..
//

import Foundation

struct List: Codable {
    
    var name: String
    var tasks: [Task]
    
    var taskCount: Int {
        tasks.count
    }

    var doneTaskCount: Int {
        tasks.map{ $0.isDone ? 1 : 0 }.reduce(0, +)
    }
}

extension List {
    static var mock: Self {
        .init(name: "Test List", tasks: [.mock, .mock, .mock, .mock])
    }
}
