//
//  UserDetailsView.swift
//  People
//
//  Created by Adam Elfsborg on 2024-08-04.
//

import SwiftUI

extension DateFormatter {
    func medium() -> DateFormatter {
        self.dateStyle = .medium
        return self
    }
    
    func formatDate(with string: String) -> DateFormatter {
        self.dateFormat = string
        return self
    }
}

struct UserDetailsView: View {
    let user: UserModel
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            List() {
                Section("About") {
                    
                    HStack {
                        Text("Worked at \(user.company) since")
                        Spacer()
                        Text(user.registered, formatter: DateFormatter().medium())
                    }
                    Text(user.about)
                }
                Section("Friends with") {
                    ForEach(user.friends) { friend in
                        NavigationLink(value: friend.id) {
                            Text(friend.name)
                        }
                    }
                }
            }
        }
        .navigationTitle(user.name)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button("Home", systemImage: "house") {
                   path = NavigationPath()
                }
            }
        }
    }
}

#Preview {
    let dateString = "2015-11-10T01:47:18-00:00"
    let dateFormatter = DateFormatter().formatDate(with: "yyyy-MM-dd'T'HH:mm:ssZ")
    guard let date = dateFormatter.date(from: dateString) else {
        fatalError("Failed to format date")
    }
   
    let user = UserModel(
            id: UUID(),
            isActive: true,
            name: "Test user",
            age: 20,
            about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.",
            company: "Imkam",
            email: "alfordrodriguez@imkan.com",
            address: "907 Nelson Street, Cotopaxi, South Dakota, 5913",
            registered: date,
            tags: ["cillum","consequat","deserunt","nostrud","eiusmod","minim","tempor"],
            friends: [FriendModel(id: UUID(), name: "Floki"), FriendModel(id: UUID(), name: "Athelstan")]
    )
   
    @State var path = NavigationPath()
    return UserDetailsView(
        user: user, path: $path
    )
}

