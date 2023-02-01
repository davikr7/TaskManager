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
    static var mock1: Self {
        .init(name: "Sport", tasks: [.mock, .mock1, .mock3, .mock2])
    }
    
    static var mock2: Self {
        .init(name: "Health", tasks: [.mock2, .mock1, .mock4, .mock3])
    }
    
    static var mock3: Self {
        .init(name: "Daily", tasks: [.mock2, .mock1, .mock3, .mock4])
    }
    
    static var mock4: Self {
        .init(name: "Meetings", tasks: [.mock, .mock3, .mock2, .mock1])
    }
    
    static var mock5: Self {
        .init(name: "Dog", tasks: [.mock4, .mock2, .mock1, .mock5])
    }
}
