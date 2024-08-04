//
//  ContentView.swift
//  People
//
//  Created by Adam Elfsborg on 2024-08-04.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [UserModel]()
    @State var path = NavigationPath()
    
    var body: some View {
        
        NavigationStack(path: $path) {
            List {
                ForEach(users) { user in
                    NavigationLink(value: user.id) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(user.name)
                                    .font(.headline)
                                Text(user.company)
                                    .foregroundStyle(.gray)
                            }
                            Spacer()
                            Text(user.isActive ? "Active" : "Offline")
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 2)
                                .background(user.isActive ? .green : .gray)
                                .foregroundStyle(.white.opacity(0.9))
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationDestination(for: UUID.self)  { id in
                let user = users.first { $0.id == id }!
                UserDetailsView(user: user, path: $path)
            }
            .navigationTitle("People")
            .onAppear {
                Task {
                    await fetch()
                }
            }
        }
    }
    
    func fetch() async {
        guard users.count == 0 else { return }
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            fatalError("Invalid url")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            decoder.dateDecodingStrategy = .formatted(formatter)
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            users = try decoder.decode([UserModel].self, from: data)
        } catch {
            fatalError("Failed to load people: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
