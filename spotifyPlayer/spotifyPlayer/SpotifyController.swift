import SwiftUI
import SpotifyiOS
import Combine

@MainActor
final class SpotifyController: NSObject, ObservableObject {
    let spotifyClientID = "d0775ce1e3c141ce9d6bf968c4f79fbf"
    let spotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")!

    var accessToken: String? = nil

    @Published var currentTrackURI: String?
    @Published var currentTrackName: String?
    @Published var currentTrackArtist: String?
    @Published var currentTrackDuration: Int?
    @Published var currentTrackImage: UIImage?

    private var connectCancellable: AnyCancellable?
    private var disconnectCancellable: AnyCancellable?

    lazy var configuration = SPTConfiguration(
        clientID: spotifyClientID,
        redirectURL: spotifyRedirectURL
    )

    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.connectionParameters.accessToken = self.accessToken
        appRemote.delegate = self
        return appRemote
    }()

    override init() {
        super.init()
        connectCancellable = NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.connect()
            }

        disconnectCancellable = NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.disconnect()
            }
    }

    func setAccessToken(from url: URL) {
        let parameters = appRemote.authorizationParameters(from: url)

        if let accessToken = parameters?[SPTAppRemoteAccessTokenKey] {
            appRemote.connectionParameters.accessToken = accessToken
            self.accessToken = accessToken
        } else if let errorDescription = parameters?[SPTAppRemoteErrorDescriptionKey] {
            // Handle the error
        }
    }

    func authorize() {
        self.appRemote.authorizeAndPlayURI("")
    }

    func connect() {
        if let _ = self.appRemote.connectionParameters.accessToken {
            appRemote.connect()
        }
    }

    func disconnect() {
        if appRemote.isConnected {
            appRemote.disconnect()
        }
    }

    func fetchImage() {
        appRemote.playerAPI?.getPlayerState { (result, error) in
            if let error = error {
                print("Error getting player state: \(error)")
            } else if let playerState = result as? SPTAppRemotePlayerState {
                self.appRemote.imageAPI?.fetchImage(forItem: playerState.track, with: CGSize(width: 300, height: 300), callback: { (image, error) in
                    if let error = error {
                        print("Error fetching track image: \(error.localizedDescription)")
                    } else if let image = image as? UIImage {
                        DispatchQueue.main.async {
                            self.currentTrackImage = image
                        }
                    }
                })
            }
        }
    }
}

struct AppTabBarView: View {
    @StateObject private var spotifyController = SpotifyController()

    var body: some View {
        VStack {
            Button(action: {
                if !spotifyController.appRemote.isConnected {
                    spotifyController.authorize()
                }
            }) {
                Text("Authenticate with Spotify")
            }
        }
        .onOpenURL { url in
            spotifyController.setAccessToken(from: url)
        }
        .environmentObject(spotifyController)
    }
}

extension SpotifyController: SPTAppRemoteDelegate {
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        self.appRemote = appRemote
        self.appRemote.playerAPI?.delegate = self
        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
            if let error = error {
                print("Error subscribing to player state: \(error.localizedDescription)")
            } else {
                print("Successfully subscribed to player state")
            }
        })
    }

    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        // Handle the connection failure
    }

    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        // Handle the connection loss
    }
}

extension SpotifyController: SPTAppRemotePlayerStateDelegate {
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        self.currentTrackURI = playerState.track.uri
        self.currentTrackName = playerState.track.name
        self.currentTrackArtist = playerState.track.artist.name
        self.currentTrackDuration = Int(playerState.track.duration) / 1000 // playerState.track.duration is in milliseconds
        fetchImage()
    }
}
