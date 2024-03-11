import SwiftUI
import AVFoundation

struct Page1: View {
    @State private var selectedMode = StudyMode.reading
    @State private var timeRemaining = 0
    @State private var timer: Timer?
    @State private var isTimerRunning = false

    @State private var player: AVAudioPlayer?
    
    @State private var countdownCounter = 0
    @State private var isCountingDown = true
    
    let modes: [StudyMode] = [.reading, .coding, .writing]

    var body: some View {
        ZStack {
            backgroundView(for: selectedMode)

            VStack {
                Spacer()
                Text("Time remaining: \(timeRemaining) seconds")
                    .padding()

                Button(action: {
                    startTimer()
                    self.playSound()
                }) {
                    Text("Start Timer")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Button(action: {
                    stopTimer()
                }) {
                    Text("Stop Timer")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Picker("Select Study Mode", selection: $selectedMode) {
                    ForEach(modes, id: \.self) { mode in
                        Text(mode.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Spacer()
            }
            .navigationBarTitle("study corner")
        }
        .onChange(of: selectedMode) { newMode, _ in
            resetTimerAndStopSound()
        }
        .onAppear {
            timeRemaining = selectedMode.duration
        }
        .onDisappear {
                   stopSound()
        }
    }


    private func startTimer() {
        guard !isTimerRunning else { return }

        timeRemaining = selectedMode.duration
        isTimerRunning = true

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
                countdownCounter += 1
            } else {
                stopTimer()
                playSound()
            }
        }
    }

    private func stopTimer() {
        isTimerRunning = false
        timer?.invalidate()
        stopSound()
    }

    private func resetTimerAndStopSound() {
        stopTimer()
        timeRemaining = selectedMode.duration
        countdownCounter = 0
    }

    private func updateCountdownTimer() {
        resetTimerAndStopSound()
        isCountingDown = true
    }

    private func backgroundView(for mode: StudyMode) -> some View {
        switch mode {
        case .reading:
            return Color.green.ignoresSafeArea()
        case .coding:
            return Color.yellow.ignoresSafeArea()
        case .writing:
            return Color.orange.ignoresSafeArea()
        }
    }

    func playSound() {
        guard let soundURL = Bundle.main.url(forResource: selectedMode.rawValue, withExtension: "wav") else {
            return
        }


        if let player = player, player.isPlaying {
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
            player?.play()
        } catch {
            print("Failed to load the sound: \(error)")
        }
    }

    func stopSound() {
        player?.stop()
    }
}

let timer = Timer
    .publish(every: 1, on: .main, in: .common)
    .autoconnect()

struct Clock: View {
    var counter: Int
    var countTo: Int
    
    var body: some View {
        VStack {
            Text(counterToMinutes())
                .font(.system(size: 36))
                .fontWeight(.black)
        }
    }
    
    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
        
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}

struct ProgressTrack: View {
    var body: some View {
        Circle()
            .fill(Color.clear)
            .frame(width: 250, height: 250)
            .overlay(
                Circle().stroke(Color.black, lineWidth: 15)
            )
    }
}

struct ProgressBar: View {
    var counter: Int
    var countTo: Int
    
    var body: some View {
        Circle()
            .fill(Color.clear)
            .frame(width: 250, height: 250)
            .overlay(
                Circle().trim(from: 0, to: (progress()))
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: 15,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
                    .foregroundColor(
                        (completed() ? Color.red : Color.green)
                    )
            )
    }
    
    func completed() -> Bool {
        return progress() == 1
    }
    
    func progress() -> CGFloat {
        return (CGFloat(counter) / CGFloat(countTo))
    }
}

enum StudyMode: String, CaseIterable {
    case reading = "Reading"
    case coding = "Coding"
    case writing = "Writing"

    var duration: Int {
        switch self {
        case .reading:
            return 300 // 5 minutes for reading
        case .coding:
            return 600 // 10 minutes for coding
        case .writing:
            return 450 // 7.5 minutes for writing
        }
    }
}

struct Page1_Previews: PreviewProvider {
    static var previews: some View {
        Page1()
    }
}

