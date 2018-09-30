//
//  Created by Dmitry Sochnev.
//  Copyright © 2018 Sochnev Dmitry. All rights reserved.
//

import Foundation

enum Gender: Int, CaseIterable, Codable, AlertPickerItem {
    
    case undefined
    case male
    case female

    var title: String {
        switch self {
        case .undefined: return "Не задан"
        case .male: return "Мужской"
        case .female: return "Женский"
        }
    }
}

struct Profile: Equatable, Codable {
    var name: String
    var gender: Gender

    func isEqual(with profile: Profile) -> Bool {
        return self == profile
    }

    static func == (lhs: Profile, rhs: Profile) -> Bool {
        return lhs.name == rhs.name && lhs.gender == rhs.gender
    }
}
