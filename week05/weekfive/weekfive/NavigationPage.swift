// NavigationPage.swift
import SwiftUI



struct NavigationPage: View {
    var username: String

    var body: some View {
        NavigationView {
            GenreList()
                .navigationTitle("\(username)'s playlist")
        }
    }
}

struct GenreList: View {
    var body: some View {
        List {
            NavigationLink(destination: ArtistList(genre: .pop)) {
                Text("pop")
            }
            NavigationLink(destination: ArtistList(genre: .indie)) {
                Text("indie")
            }
            NavigationLink(destination: ArtistList(genre: .hipHop)) {
                Text("hip hop")
            }
        }
        .listStyle(GroupedListStyle())
    }
}

struct ArtistList: View {
    var genre: Genre

    var body: some View {
        List {
            ForEach(artistData.filter { $0.genre == genre }) { artist in
                NavigationLink(destination: ArtistDetail(artist: artist)) {
                    HStack {
                        AsyncImage(url: URL(string: artist.imageURL)) { image in
                            image.resizable().scaledToFit().frame(width: 50, height: 50).cornerRadius(25)
                        } placeholder: {
                            Image(systemName: "person.fill").resizable().scaledToFit().frame(width: 50, height: 50).cornerRadius(25)
                        }
                        Text(artist.name)
                    }
                }
            }
        }
        .navigationTitle("\(genre.rawValue) artists")
    }
}

struct ArtistDetail: View {
    var artist: Artist

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: artist.imageURL)) { image in
                image.resizable().scaledToFit().frame(width: 100, height: 100).cornerRadius(50)
            } placeholder: {
                Image(systemName: "person.fill").resizable().scaledToFit().frame(width: 100, height: 100).cornerRadius(50)
            }
            Text("artist: \(artist.name)")
                .padding()
            Text("genre: \(artist.genre.rawValue)")
        }
        .navigationTitle("artist detail")
    }
}

struct NavigationPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPage(username: "stranger")
    }
}

struct Artist: Identifiable {
    var id = UUID()
    var name: String
    var genre: Genre
    var imageURL: String
}

enum Genre: String, CaseIterable {
    case pop, indie, hipHop
}

let artistData: [Artist] = [
    Artist(name: "Billie Eilish", genre: .pop, imageURL: "billie_eilish_image_url"),
    Artist(name: "Shawn Mendes", genre: .pop, imageURL: "shawn_mendes_image_url"),
    Artist(name: "Arctic Monkeys", genre: .indie, imageURL: "arctic_monkeys_image_url"),
    Artist(name: "The 1975", genre: .indie, imageURL: "the_1975_image_url"),
    Artist(name: "Kendrick Lamar", genre: .hipHop, imageURL: "kendrick_lamar_image_url"),
    Artist(name: "Drake", genre: .hipHop, imageURL: "drake_image_url")
]

