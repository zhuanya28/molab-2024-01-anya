// Credits: https://medium.com/@killian.j.sonna/integrating-spotifys-api-with-swiftui-a-step-by-step-guide-f85e92985e31
// Spotify documentation: https://developer.spotify.com/documentation/ios/getting-started


import SwiftUI

struct AppBarView: View {
    @StateObject private var spotifyController = SpotifyController()
    @State private var currentPlaybackPosition: Double = 0.0
    @State var backgroundColor: Color = .black
    

    
    var body: some View {
        ZStack{
            ZStack {
                Color.clear
            }
            .background(backgroundColor)
            
            VStack {
                if let image = spotifyController.currentTrackImage {
                    ZStack {
                           Image(uiImage: image)
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(width: 350, height: 350)
                       }
                       .padding(.bottom, 10)
                       .cornerRadius(10)
                    
                } else {
                    Image(systemName: "music.note")
                        .resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .padding(.bottom, 10)
                }
          
                
                Text(spotifyController.currentTrackName ?? "Unknown Track")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    
                
                Text(spotifyController.currentTrackArtist ?? "Unknown Artist")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.white)
              
     
                
                
                
                HStack {
                    Button(action: {
                        spotifyController.skipToPreviousTrack()
                    }) {
                        Image(systemName: "backward.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .padding()
                    Button(action: {
                        if spotifyController.isPlaying {
                            spotifyController.pause()
                        } else {
                            spotifyController.play()
                        }
                    }) {
                        Image(systemName: spotifyController.isPlaying ? "pause.fill" : "play.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                    Button(action: {
                        spotifyController.skipToNextTrack()
                    }) {
                        Image(systemName: "forward.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .padding()
                    
      
                }
          
                
                Divider()
                    .frame(width: 70)
                    .background(Color.white)
                    .padding()
            
                
                
                Button {
                    if !spotifyController.appRemote.isConnected {
                        spotifyController.authorize()
                    }
                } label: {
                    HStack {
                        Image(systemName: "personalhotspot")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 8)
                        Text("Connect Spotify")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(15)
                }
           
                .padding(.top, 30)
         
              
            }
            .zIndex(2)
            .padding()
         
            
        }
        .onOpenURL { url in
            spotifyController.setAccessToken(from: url)
            
        }
        .environmentObject(spotifyController)
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .onReceive(spotifyController.$currentTrackImage) { image in
                    if let uiColor = image?.averageColor(withDarkeningFactor: 0.6) {
                        let darkenedColor = Color(uiColor: uiColor)
                        backgroundColor = darkenedColor
                    }
                }
        .background(backgroundColor)
    }
}
