//
//  PlayerMainView.swift
//  StudyCorner
//
//  Created by anya zhukova on 4/28/24.
//

// https://medium.com/@killian.j.sonna/integrating-spotifys-api-with-swiftui-a-step-by-step-guide-f85e92985e31

//

import SwiftUI
import SpotifyiOS
import Combine

@MainActor
final class SpotifyController: NSObject, ObservableObject {
    let spotifyClientID = "YOUR_CLIENT_ID"
    let spotifyRedirectURL = URL(string:"spotify-ios-quick-start://spotify-login-callback")!
    
    var accessToken: String? = nil
    ...
}



