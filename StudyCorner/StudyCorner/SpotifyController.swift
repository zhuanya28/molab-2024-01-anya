// Credits: https://medium.com/@killian.j.sonna/integrating-spotifys-api-with-swiftui-a-step-by-step-guide-f85e92985e31
// Spotify documentation: https://developer.spotify.com/documentation/ios/getting-started

import SwiftUI
import SpotifyiOS
import Combine


@MainActor
final class SpotifyController: NSObject, ObservableObject {
    let spotifyClientID = "d0775ce1e3c141ce9d6bf968c4f79fbf"
    let spotifyRedirectURL = URL(string: "StudyCorner://spotify-login-callback")!

    @Published var accessToken: String?
    @Published var currentTrackURI: String?
    @Published var currentTrackName: String?
    @Published var currentTrackArtist: String?
    @Published var currentTrackDuration: Int?
    @Published var currentTrackImage: UIImage?
    @Published var isPlaying: Bool = true

    private var connectCancellable: AnyCancellable?
    private var disconnectCancellable: AnyCancellable?

    
    func pause() {
           appRemote.playerAPI?.pause()
           isPlaying = false
       }
    
    func play() {
          appRemote.playerAPI?.resume()
          isPlaying = true
      }
    
    
    lazy var configuration = SPTConfiguration(
        clientID: spotifyClientID,
        redirectURL: spotifyRedirectURL
    )

    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
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

    func authorize() {
        appRemote.authorizeAndPlayURI("")
    }

    func connect() {
        if let accessToken = accessToken {
            appRemote.connectionParameters.accessToken = accessToken
            appRemote.connect()
        }
    }

    func disconnect() {
        if appRemote.isConnected {
            appRemote.disconnect()
        }
    }
    
    func setAccessToken(from url: URL) {
           let parameters = appRemote.authorizationParameters(from: url)

           if let accessToken = parameters?[SPTAppRemoteAccessTokenKey] {
               appRemote.connectionParameters.accessToken = accessToken
               self.accessToken = accessToken
           } else if let errorDescription = parameters?[SPTAppRemoteErrorDescriptionKey] {
               
           }
       }
    
    func skipToNextTrack() {
        appRemote.playerAPI?.skip(toNext: nil)
    }
    
    func skipToPreviousTrack() {
        appRemote.playerAPI?.skip(toPrevious: nil)
    }

    func getCurrentPlaybackPosition(completion: @escaping (Double?) -> Void) {
        appRemote.playerAPI?.getPlayerState { (result, error) in
            guard error == nil, let playerState = result as? SPTAppRemotePlayerState else {
                completion(nil)
                return
            }
            let playbackPosition = Double(playerState.playbackPosition)
            completion(playbackPosition)
        }
    }


    func fetchImage() {
        appRemote.playerAPI?.getPlayerState { (result, error) in
            if let error = error {
                print("Error getting player state: \(error)")
            } else if let playerState = result as? SPTAppRemotePlayerState {
                self.appRemote.imageAPI?.fetchImage(forItem: playerState.track, with: CGSize(width: 300, height: 300)) { (image, error) in
                    if let error = error {
                        print("Error fetching track image: \(error.localizedDescription)")
                    } else if let image = image as? UIImage {
                        DispatchQueue.main.async {
                            self.currentTrackImage = image
                        }
                    }
                }
            }
        }
    }
}

extension SpotifyController: SPTAppRemoteDelegate {
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("Connection established.")
        appRemote.playerAPI?.delegate = self
        appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
            if let error = error {
                print("Error subscribing to player state: \(error.localizedDescription)")
            } else {
                print("Successfully subscribed to player state")
            }
        })
    }

    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("Failed to connect: \(error?.localizedDescription ?? "Unknown error")")
    }

    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("Disconnected: \(error?.localizedDescription ?? "Unknown error")")
    }
}

extension SpotifyController: SPTAppRemotePlayerStateDelegate {
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
           print("Track Name: \(playerState.track.name)")
           print("Artist Name: \(playerState.track.artist.name)")
           
           self.currentTrackURI = playerState.track.uri
           self.currentTrackName = playerState.track.name
           self.currentTrackArtist = playerState.track.artist.name
           self.currentTrackDuration = Int(playerState.track.duration) / 1000
           
           fetchImage()
       }
    
}
