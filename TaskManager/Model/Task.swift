//
//  Task.swift
//  TaskManager
//
//  Created by grandmaster on 1.2.23..
//

import Foundation

struct Task: Codable {
    var title: String?
    var body: String?
    var isDone: Bool = false
}

extension Task {
    static var mock: Self {
        .init(title: "Test Title", body: "some description", isDone: true)
    }
    
    static var mock1: Self {
        .init(title: "Test Title1", body: "some description1", isDone: true)
    }
    
    static var mock2: Self {
        .init(title: "Test Title2", body: "some description2", isDone: true)
    }
    
    static var mock3: Self {
        .init(title: "Test Title3", body: "some description3", isDone: true)
    }
    
    static var mock4: Self {
        .init(title: "Test Title4", body: "some description4", isDone: true)
    }
    
    static var mock5: Self {
        .init(title: "Test Title5", body: "some description5", isDone: true)
    }
}
