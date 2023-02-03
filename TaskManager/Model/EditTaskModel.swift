//
//  EditTaskModel.swift
//  TaskManager
//
//  Created by grandmaster on 1.2.23..
//

import Foundation

protocol EditTaskModelProtocol: AnyObject {
    var task: Task? { get }
    var indexPath: IndexPath? { get set }
}

final class EditTaskModel: EditTaskModelProtocol {
    
    var task: Task?
    var indexPath: IndexPath?
    
    init(task: Task? = nil, indexPath: IndexPath? = nil) {
        self.task = task
        self.indexPath = indexPath
    }
}
