import SwiftUI
import AVFoundation

struct CountdownTimerPage: View {
    @State private var countdownSeconds: Int
    @State private var isCountingDown = false
    @State private var timer: Timer?

    let title: String

    init(duration: Int, title: String) {
        self._countdownSeconds = State(initialValue: duration)
        self.title = title
    }

    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .padding()

            Text("\(countdownSeconds)")
                .font(.system(size: 60))
                .padding()

            Toggle("Toggle Countdown", isOn: $isCountingDown)
                .padding()

            Button(action: {
                resetCountdown()
            }) {
                Text("Reset")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
        .onAppear {
            // Start the countdown when the view appears, if the toggle is on
            if isCountingDown {
                startCountdown()
            }
        }
        .onChange(of: isCountingDown) { newValue in
            // Respond to changes in the toggle value
            if newValue {
                startCountdown()
            } else {
                stopCountdown()
            }
        }
        .onDisappear {
            stopCountdown()
        }
    }

    private func startCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if countdownSeconds > 0 {
                countdownSeconds -= 1
            } else {
                isCountingDown = false
                timer?.invalidate()
                playSound()
            }
        }
    }

    private func stopCountdown() {
        timer?.invalidate()
    }

    private func resetCountdown() {
        isCountingDown = false
        countdownSeconds = 60
        timer?.invalidate()
    }

    private func playSound() {
        // You can replace "soundFileName" with the name of your audio file (e.g., "bell.mp3").
        if let soundURL = Bundle.main.url(forResource: "soundFileName", withExtension: "mp3") {
            let player = try? AVAudioPlayer(contentsOf: soundURL)
            player?.play()
        }
    }
}


struct CountdownTimerPage_Previews: PreviewProvider {
    static var previews: some View {
        CountdownTimerPage()
    }
}

