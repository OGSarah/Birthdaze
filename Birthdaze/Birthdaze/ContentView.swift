//
//  ContentView.swift
//  Birthdaze
//
//  Created by Sarah Clark on 8/20/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {

    /*@State private var friends: [Friend] = [
        Friend(name: "Kate", birthday: Self.createDate(year: 1964, month: 7, day: 15)),
        
    ]*/

    @Query(sort: \Friend.birthday) private var friends: [Friend]
    @Environment(\.modelContext) private var context

    @State private var newName = ""
    @State private var newDate = Date.now

    var body: some View {
        NavigationStack {
            List(friends) { friend in
                HStack {
                    if friend.isBirthdayToday {
                        Image(systemName: "birthday.cake.fill")
                            .foregroundStyle(
                                LinearGradient(
                                    gradient: Gradient(colors: [.pink, .purple, .blue]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    }
                    Text(friend.name)
                        .bold(friend.isBirthdayToday)
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
                        context.insert(newFriend)

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
             /*.task {
                context.insert(Friend(name: "Kate", birthday: Self.createDate(year: 1964, month: 7, day: 15)))
                context.insert(Friend(name: "Joe", birthday: Self.createDate(year: 1964, month: 1, day: 18)))
                context.insert(Friend(name: "Orko", birthday: Self.createDate(year: 2018, month: 6, day: 20)))
                context.insert(Friend(name: "Molly", birthday: Self.createDate(year: 2023, month: 8, day: 10)))
                context.insert(Friend(name: "Rachel", birthday: Self.createDate(year: 2017, month: 3, day: 16)))
                context.insert(Friend(name: "Caitlin", birthday: Self.createDate(year: 1987, month: 9, day: 25)))
                context.insert(Friend(name: "Brenton", birthday: Self.createDate(year: 2008, month: 10, day: 7)))
                context.insert(Friend(name: "Logan", birthday: Self.createDate(year: 2012, month: 12, day: 9)))
                context.insert(Friend(name: "Declan", birthday: Self.createDate(year: 2017, month: 4, day: 18)))
             }*/
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
        .modelContainer(for: Friend.self, inMemory: true)
        .preferredColorScheme(.dark)
}

#Preview("Light Mode") {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
        .preferredColorScheme(.light)
}
