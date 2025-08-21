//
//  BirthdazeApp.swift
//  Birthdaze
//
//  Created by Sarah Clark on 8/20/25.
//

import SwiftData
import SwiftUI

@main
struct BirthdazeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}
