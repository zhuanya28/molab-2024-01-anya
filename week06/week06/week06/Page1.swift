import SwiftUI
import AVFoundation

struct Page1: View {
    @State private var selectedMode = StudyMode.reading
    @State private var isMusicPlaying = false

    @State private var player: AVAudioPlayer?
    @State private var currentAudioFileName: String?
    @State private var currentAudioIndex: Int = 0
    @State private var currentTime: TimeInterval = 0
    @State private var totalTime: TimeInterval = 0
    @State private var timer: Timer?

    let modes: [StudyMode] = [.reading, .coding, .writing]

    var body: some View {
        ZStack {
            backgroundView(for: selectedMode)
            VStack {
                Spacer()
                Picker("Select Study Mode", selection: $selectedMode) {
                    ForEach(modes, id: \.self) { mode in
                        Text(mode.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Text("Now Playing: \(currentAudioFileName ?? "No audio file")")
                    .padding()

                HStack {
                    Button(action: {
                        playPreviousSound()
                    }) {
                        Image(systemName: "backward.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    .padding()

                    Button(action: {
                        if isMusicPlaying {
                            self.stopSound()
                        } else {
                            self.playSound()
                        }
                    }) {
                        Image(systemName: isMusicPlaying ? "pause.fill" : "play.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()

                    Button(action: {
                        playNextSound()
                    }) {
                        Image(systemName: "forward.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    .padding()
                }

                MusicProgressBar(currentTime: $currentTime, totalTime: $totalTime)
                    .padding()

                Spacer()
            }
            .navigationBarTitle("study corner")
        }
        .onChange(of: selectedMode) { newMode, _ in
            stopSound()
        }
        .onAppear {
            loadAudioFile()
            startTimer()
        }
        .onDisappear {
            stopSound()
            stopTimer()
        }
    }

    private func backgroundView(for mode: StudyMode) -> some View {
        switch mode {
        case .reading:
            return Color.cyan.ignoresSafeArea()
        case .coding:
            return Color.mint.ignoresSafeArea()
        case .writing:
            return Color.blue.ignoresSafeArea()
        }
    }

    private var audioFiles: [String] {
        switch selectedMode {
        case .reading:
            return ["reading1", "reading2", "reading3"]
        case .coding:
            return ["coding1", "coding2", "coding3"]
        case .writing:
            return ["writing1", "writing2", "writing3"]
        }
    }
    
    private func loadAudioFile() {
        let randomAudioFile = audioFiles[currentAudioIndex]
        
        currentAudioFileName = randomAudioFile
        
        guard let soundURL = Bundle.main.url(forResource: randomAudioFile, withExtension: "wav") else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
            totalTime = player?.duration ?? 0
        } catch {
            print("Failed to load the sound: \(error)")
        }
    }

    private func playSound() {
        let randomAudioFile = audioFiles[currentAudioIndex]

        isMusicPlaying = true
        currentAudioFileName = randomAudioFile

        guard let soundURL = Bundle.main.url(forResource: randomAudioFile, withExtension: "wav") else {
            return
        }

        if let player = player, player.isPlaying {
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
            totalTime = player?.duration ?? 0
            player?.play()
        } catch {
            print("Failed to load the sound: \(error)")
        }
    }

    private func stopSound() {
        player?.stop()
        isMusicPlaying = false
        currentTime = 0
        totalTime = 0
    }

    private func playNextSound() {
        currentAudioIndex = (currentAudioIndex + 1) % audioFiles.count
        stopSound()
        playSound()
    }

    private func playPreviousSound() {
        currentAudioIndex = (currentAudioIndex - 1 + audioFiles.count) % audioFiles.count
        stopSound()
        playSound()
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            guard isMusicPlaying else { return }
            currentTime = player?.currentTime ?? 0
        }
    }

    private func stopTimer() {
        timer?.invalidate()
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

enum StudyMode: String, CaseIterable {
    case reading = "Reading"
    case coding = "Coding"
    case writing = "Writing"

    var duration: Int {
        switch self {
        case .reading:
            return 200
        case .coding:
            return 400
        case .writing:
            return 450
        }
    }
}

struct Page1_Previews: PreviewProvider {
    static var previews: some View {
        Page1()
    }
}
