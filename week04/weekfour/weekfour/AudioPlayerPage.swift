import SwiftUI
import AVFoundation

struct AudioPlayerPage: View {
    @State private var isAudioPlaying = false
    private var audioPlayer: AVAudioPlayer?

    var body: some View {
        VStack {
            Text("Audio Player")
                .font(.largeTitle)
                .padding()

            Button(action: {
                playPauseAudio()
            }) {
                Image(systemName: isAudioPlaying ? "pause.fill" : "play.fill")
                    .padding()
                    .foregroundColor(.white)
                    .background(isAudioPlaying ? Color.red : Color.green)
                    .cornerRadius(10)
            }
            .padding()

            Toggle("Toggle Audio Player", isOn: $isAudioPlaying)
                .padding()

            // You can add additional audio controls or information here.
        }
        .onAppear {
            prepareAudioPlayer()
        }
        .onDisappear {
            stopAudioPlayer()
        }
    }

    private func prepareAudioPlayer() {
        // You can replace "soundFileName" with the name of your audio file (e.g., "music.mp3").
        if let soundURL = Bundle.main.url(forResource: "soundFileName", withExtension: "mp3") {
            audioPlayer = try? AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
        }
    }

    private func playPauseAudio() {
        if isAudioPlaying {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
    }

    private func stopAudioPlayer() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}

