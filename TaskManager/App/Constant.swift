//
//  Constant.swift
//  TaskManager
//
//  Created by grandmaster on 1.2.23..
//

import UIKit

enum Constant {
    
    enum Image {
        static let imageCheckmarkDone = "checkmark.square.fill"
        static let imageCheckmarkEmpty = "squareshape"
        static let imageAddList = "doc.fill.badge.plus"
        static let imageEditList = "square.and.pencil"
        static let imagePlus = "icons8-plus-math-30"
        static let imageBin = "bin.xmark.fill"
    }
    
    enum Size {
        static let padding: CGFloat = 10
        static let tableViewCellHeight: CGFloat = 80
        static let cornerRadius: CGFloat = 8
        static let listCellSize = CGSize(width: 100, height: 40)
        static let addTaskButtomSize: CGFloat = 60
    }
    
    enum Font {
        static let bold18 = UIFont.boldSystemFont(ofSize: 18)
        static let bold22 = UIFont.boldSystemFont(ofSize: 22)
        static let system16 = UIFont.systemFont(ofSize: 16)
    }
    
    enum SaveKey {
        static let dataKey = "SaveList"
        static let selectedListIndexKey = "SelectedListIndexKey"
    }
    
}
