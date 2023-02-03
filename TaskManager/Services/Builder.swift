//
//  Builder.swift
//  TaskManager
//
//  Created by grandmaster on 1.2.23..
//

import Foundation

protocol BuilderProtocol {
    func createRootVC(viewController: RootViewControllerProtocol,
                      presenter: PresenterProtocol,
                      model: ModelProtocol) -> RootViewController
    
    func createEditTaskVC(presentetionType: EditTaskVCType,
                          indexPath: IndexPath?,
                          viewController: EditTaskViewControllerProtocol,
                          presenter: EditTaskPresenterProtocol,
                          model: EditTaskModelProtocol,
                          delegate: EditTaskPresenterDelegate) -> EditTaskViewController
}

final class Builder: BuilderProtocol {
    
    func createRootVC(viewController: RootViewControllerProtocol = RootViewController(),
                      presenter: PresenterProtocol = Presenter(),
                      model: ModelProtocol = Model()
    ) -> RootViewController {
        let vc = viewController
        presenter.model = model
        presenter.view = vc
        vc.presenter = presenter
        return vc as! RootViewController
    }
    
    func createEditTaskVC(presentetionType: EditTaskVCType,
                          indexPath: IndexPath? = nil,
                          viewController: EditTaskViewControllerProtocol = EditTaskViewController(),
                          presenter: EditTaskPresenterProtocol = EditTaskPresenter(),
                          model: EditTaskModelProtocol,
                          delegate: EditTaskPresenterDelegate
    ) -> EditTaskViewController {
        let vc = viewController
        presenter.model = model
        model.indexPath = indexPath
        presenter.view = vc
        presenter.delegate = delegate
        vc.presentetionType = presentetionType
        vc.presenter = presenter
        return vc as! EditTaskViewController
    }
    
}
