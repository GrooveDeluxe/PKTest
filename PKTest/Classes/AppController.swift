//
//  Created by Dmitry Sochnev.
//  Copyright © 2018 Sochnev Dmitry. All rights reserved.
//

import UIKit

protocol AppControllerProtocol {
    func setup()
}

class AppController {

    weak var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }
}

extension AppController: AppControllerProtocol {
    func setup() {
        setupInitialViewController()
    }
}

// MARK: Private
extension AppController {

    // MARK: - Initial screen
    private func setupInitialViewController() {
        let profileViewController = ControllerFactory.profileViewController()
        let navigationController = UINavigationController(rootViewController: profileViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
