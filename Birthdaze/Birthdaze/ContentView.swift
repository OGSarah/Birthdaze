//
//  ContentView.swift
//  Birthdaze
//
//  Created by Sarah Clark on 8/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var friends: [Friend] = [
        Friend(name: "Kate", birthday: Self.createDate(year: 1964, month: 7, day: 15)),
        Friend(name: "Joe", birthday: Self.createDate(year: 1964, month: 1, day: 18)),
        Friend(name: "Orko", birthday: Self.createDate(year: 2018, month: 6, day: 20)),
        Friend(name: "Molly", birthday: Self.createDate(year: 2023, month: 8, day: 10)),
        Friend(name: "Rachel", birthday: Self.createDate(year: 2017, month: 3, day: 16)),
        Friend(name: "Caitlin", birthday: Self.createDate(year: 1987, month: 9, day: 25)),
        Friend(name: "Brenton", birthday: Self.createDate(year: 2008, month: 10, day: 7)),
        Friend(name: "Logan", birthday: Self.createDate(year: 2012, month: 12, day: 9)),
        Friend(name: "Declan", birthday: Self.createDate(year: 2017, month: 4, day: 18))
    ]

    @State private var newName = ""
    @State private var newDate = Date.now

    var body: some View {
        NavigationStack {
            List(friends, id: \.name) { friend in
                HStack {
                    Text(friend.name)
                    Spacer()
                    Text("\(formatDate(friend.birthday))")
                }
            }
             .navigationTitle("Birthdays")
             .safeAreaInset(edge: .bottom) {
                VStack(alignment: .center, spacing: 20) {
                    Text("New Birthday")
                        .font(.headline)
                    DatePicker(selection: $newDate, in: Date.distantPast...Date.now, displayedComponents: .date) {
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                    }
                    Button("Save") {
                        let newFriend = Friend(name: newName, birthday: newDate)
                        friends.append(newFriend)

                        newName = ""
                        newDate = .now
                    }
                    .foregroundStyle(.white)
                    .padding(10)
                    .bold()
                    .glassEffect(.regular.tint(.blue).interactive())
                }
                .padding()
                .background(.bar)
             }
        }

    }

    // MARK: - Private Functions
    private static func createDate(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        let calendar = Calendar.current
        return calendar.date(from: components) ?? Date()
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }

}

// MARK: - Previews
#Preview("Dark Mode") {
    ContentView()
        .preferredColorScheme(.dark)
}

#Preview("Light Mode") {
    ContentView()
        .preferredColorScheme(.light)
}
