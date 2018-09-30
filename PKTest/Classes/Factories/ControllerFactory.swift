//
//  Created by Dmitry Sochnev.
//  Copyright © 2018 Sochnev Dmitry. All rights reserved.
//

import Foundation

class ControllerFactory {
    static func profileViewController() -> ProfileViewController {
        let profileController = ProfileViewController()
        profileController.setStorage(Storage())
        return profileController
    }

    static func profileEditorViewController() -> ProfileEditorViewController {
        return ProfileEditorViewController()
    }
}
