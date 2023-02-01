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
}

final class Builder: BuilderProtocol {
    
    func createRootVC(viewController: RootViewControllerProtocol = RootViewController(),
                      presenter: PresenterProtocol = Presenter(),
                      model: ModelProtocol = Model()
    ) -> RootViewController {
        let vc = viewController
        let presenter = presenter
        presenter.model = model
        presenter.loadData()
        presenter.view = vc
        vc.presenter = presenter
        return vc as! RootViewController
    }
    
}
