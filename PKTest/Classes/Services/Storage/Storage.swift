//
//  Created by Dmitry Sochnev.
//  Copyright © 2018 Sochnev Dmitry. All rights reserved.
//

import Foundation

protocol StorageProtocol {
    func retrieveProfile() -> Profile
    func saveProfile(_ profile: Profile)
}

class Storage: StorageProtocol {

    enum Keys: String {
        case profile
    }
    
    func retrieveProfile() -> Profile  {
        guard let profileData = UserDefaults.standard.object(forKey: Keys.profile.rawValue) as? Data  else {
            return Profile(name: "", gender: .undefined)
        }
        return try! JSONDecoder().decode(Profile.self, from: profileData)
    }

    func saveProfile(_ profile: Profile) {
        let data = try! JSONEncoder().encode(profile)
        UserDefaults.standard.set(data, forKey: Keys.profile.rawValue)
    }
}
