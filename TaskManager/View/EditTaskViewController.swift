//
//  EditTaskViewController.swift
//  TaskManager
//
//  Created by grandmaster on 1.2.23..
//

import UIKit

protocol EditTaskViewControllerProtocol: AnyObject {
    var presenter: EditTaskPresenterProtocol! { get set }
    var presentetionType: EditTaskVCType! { get set }
}

enum EditTaskVCType {
    case new, edit
}

enum KeybordState {
    case isShow(CGFloat), notShow
}

final class EditTaskViewController: UIViewController, EditTaskViewControllerProtocol {
    
    var presenter: EditTaskPresenterProtocol!
    
    var presentetionType: EditTaskVCType!
    
    let stackSpacing: CGFloat = 8
    let padding: CGFloat = 6
    let buttonSize: CGFloat = 40
    
    var keyboardState: KeybordState = .notShow {
        didSet {
            switch keyboardState {
            case .isShow(let keyboardHeight):
                addTaskButton.frame.origin.y -= keyboardHeight - Constant.Size.padding * 2
                addTaskButton.transform = CGAffineTransformMakeScale(0.8, 1)
            case .notShow:
                addTaskButton.frame.origin.y += 200
                addTaskButton.transform = CGAffineTransformMakeScale(1, 1)
            }
        }
    }
    
    private var buttonTitle: String {
        switch presentetionType {
        case .new:
            return "Add task"
        case .edit:
            return "Edit task"
        case .none:
            return ""
        }
    }
    
    private let titleTextField = UITextField()
    
    private let bodyTextView = UITextView()
    
    private let titleLabel: UILabel = .boldLabel()
    
    private let bodyLabel: UILabel = .boldLabel()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel,
                                                   titleTextField.embedViewInBorder(padding),
                                                   bodyLabel,
                                                   bodyTextView.embedViewInBorder(padding),
                                                   addTaskButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = stackSpacing
        return stack
    }()
    
    private lazy var addTaskButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.titleLabel?.font = Constant.Font.bold22
        button.widthAnchor.constraint(equalToConstant: view.bounds.width/2).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        button.setTitle(buttonTitle, for: .normal)
        button.isEnabled = titleTextField.text?.isEmpty ?? true ? false : true
        button.layer.cornerRadius = Constant.Size.cornerRadius
        button.addTarget(self, action: #selector(addTaskButtonHandler), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
        addConstraints()
    }
    
    private func setupUI() {
        view.addSubview(stackView)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        titleTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.delegate = self
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        bodyTextView.text = presenter.getTaskBody()
        titleTextField.text = presenter.getTaskName()
        titleLabel.text = "Task name"
        bodyLabel.text = "Description"
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constant.Size.padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.Size.padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Size.padding),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.Size.padding)
        ])
    }
    
    @objc private func addTaskButtonHandler() {
        guard let title = titleTextField.text, let body = bodyTextView.text else { return }
        let task = Task(title: title, body: body, isDone: false)
        presenter.createTask(task)
        dismiss(animated: true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {
            addTaskButton.isEnabled = false
            return }
        addTaskButton.isEnabled = !text.isEmpty
    }
    
}

//MARK: - UITextFieldDelegate

extension EditTaskViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let title = textField.text, !title.isEmpty else { return false }
        let task = Task(title: title, body: bodyTextView.text, isDone: false)
        presenter.createTask(task)
        dismiss(animated: true)
        return true
    }
    
}
