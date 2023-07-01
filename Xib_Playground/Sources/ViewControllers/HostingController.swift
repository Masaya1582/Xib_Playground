//
//  HostingController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/07/01.
//

import UIKit
import SwiftUI

final class HostingController<T: View>: UIHostingController<T> {

    // MARK: - Initialize
    override init(rootView: T) {
        super.init(rootView: rootView)
        view.backgroundColor = .clear
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
