
import SwiftUI

struct AppBarView: View {
    @StateObject private var spotifyController = SpotifyController()

    var body: some View {
        VStack {
            Button {
                if !spotifyController.appRemote.isConnected {
                    spotifyController.authorize()
                }
            } label: {
                Text("Authenticate with Spotify")
            }

            Text(spotifyController.currentTrackName ?? "Unknown Track")
            Text(spotifyController.currentTrackArtist ?? "Unknown Artist")

            if let image = spotifyController.currentTrackImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            } else {
                Image(systemName: "music.note")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }

            Button(action: {
                if spotifyController.isPlaying {
                    spotifyController.pause()
                } else {
                    spotifyController.play()
                }
            }) {
                Image(systemName: spotifyController.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .font(.largeTitle)
            }
           
        }
        .onOpenURL { url in
            spotifyController.setAccessToken(from: url)
        }
        .padding()
        .environmentObject(spotifyController)
    }
}
