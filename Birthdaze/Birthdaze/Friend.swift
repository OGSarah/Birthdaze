//
//  Friend.swift
//  Birthdaze
//
//  Created by Sarah Clark on 8/21/25.
//

import Foundation
import SwiftData

@Model
class Friend {
    var name: String
    var birthday: Date

    init(name: String, birthday: Date) {
        self.name = name
        self.birthday = birthday
    }

    var isBirthdayToday: Bool {
        return Calendar.current.isDateInToday(birthday)
    }

}
