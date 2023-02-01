//
//  TaskCell.swift
//  TaskManager
//
//  Created by grandmaster on 1.2.23..
//

import UIKit

protocol ReusableView {
    static var identifier: String { get }
}

final class TaskCell: UITableViewCell, ReusableView {
    
    static let identifier: String = "TaskCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constant.bold18
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bodyLabel = UILabel()
    
    private let checkboxImage = UIImageView()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, checkboxImage])
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var isDone: Bool = false {
        didSet {
            checkboxImage.image = UIImage(systemName: isDone ? Constant.imageCheckmarkDone : Constant.imageCheckmarkEmpty)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        addConstraints()
    }
    
    func populateData(_ task: Task) {
        titleLabel.text = task.title
        bodyLabel.text = task.title
        isDone = task.isDone
    }
    
    private func setupUI() {
        contentView.addSubview(stackView)
        contentView.addSubview(bodyLabel)
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        checkboxImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.padding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.padding),
            
            checkboxImage.widthAnchor.constraint(equalToConstant: 24),
            checkboxImage.heightAnchor.constraint(equalToConstant: 24),

            bodyLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constant.padding)
        ])
    }
    
    private func addGesture() {
        let tap = UITapGestureRecognizer()
        tap.numberOfTouchesRequired = 1
        tap.addTarget(self, action: #selector(checkBoxTapHandler))
        checkboxImage.addGestureRecognizer(tap)
    }
    
    @objc private func checkBoxTapHandler() {
        isDone.toggle()
    }
}
