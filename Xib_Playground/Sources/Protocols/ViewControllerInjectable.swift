//
//  ViewControllerInjectable.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/07/06.
//

import UIKit

protocol ViewControllerInjectable: UIViewController {

    associatedtype Dependency

    init(dependency: Dependency)
}

extension ViewControllerInjectable where Dependency == Void {
    init(dependency: Dependency = ()) {
        self.init(dependency: dependency)
    }
}
