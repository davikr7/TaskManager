//
//  ListCell.swift
//  TaskManager
//
//  Created by grandmaster on 1.2.23..
//

import UIKit

enum ListCellType {
    case title(List)
    case image(String)
}

final class ListCell: UICollectionViewCell, ReusableView {
    
    static var identifier: String = "ListCell"
    
    private let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateCell(_ list: List) {
        title.text = list.name
    }
    
    private func configureUI() {
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}


//final class ListImageCell: UICollectionViewCell, ReusableView {
//    
//    static var identifier: String = "ListImageCell"
//    
//    private let imageView = UIImageView()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        configureUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func configureUI() {
//        imageView.image = UIImage(systemName: Constant.imageAddList)
//        contentView.addSubview(imageView)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            imageView.widthAnchor.constraint(equalToConstant: 30),
//            imageView.heightAnchor.constraint(equalToConstant: 30)
//        ])
//    }
//    
//}

