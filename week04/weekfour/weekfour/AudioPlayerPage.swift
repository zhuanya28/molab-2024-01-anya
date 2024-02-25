
import SwiftUI
import AVFoundation

struct AudioPlayerPage: View {
    var body: some View {
        Text("Audio Player Page")
    }
}


struct AudioPlayerPage_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerPage()
    }
}


    
//    @StateObject var audioDJ = AudioDJ()
//    var body: some View {
//        TimelineView(.animation) { context in
//            VStack {
//                HStack {
//                    Button("Play") {
//                        audioDJ.play()
//                    }
//                    Button("Stop") {
//                        audioDJ.stop()
//                    }
//                    Button("Next") {
//                        audioDJ.next()
//                    }
//                }
//                Text("soundIndex \(audioDJ.soundIndex)")
//                Text(audioDJ.soundFile)
//                if let player = audioDJ.player {
//                    Text("duration " + String(format: "%.1f", player.duration))
//                    Text("currentTime " + String(format: "%.1f", player.currentTime))
//                }
//            }
//        }
//    }


