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
    @State private var currentAudioFileName: String?
    @State private var currentAudioIndex: Int = 0
    
    
    @State private var currentTime: TimeInterval = 0
     @State private var totalTime: TimeInterval = 0
    
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
                
                
                Text("Time remaining: \(timeRemaining) seconds")
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
                        if isTimerRunning {
                            self.stopTimer()
                        } else {
                            startTimer()
                            self.playSound()
                        }
                    }) {
                        Image(systemName: isTimerRunning ? "pause.fill" : "play.fill")
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
                currentTime = player?.currentTime ?? 0
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
            return Color.cyan.ignoresSafeArea()
        case .coding:
            return Color.mint.ignoresSafeArea()
        case .writing:
            return Color.teal.ignoresSafeArea()
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

    func playSound() {
        let randomAudioFile = audioFiles[currentAudioIndex]

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

    func stopSound() {
        player?.stop()
        currentTime = 0
           totalTime = 0
    }
    
    func playNextSound() {
        currentAudioIndex = (currentAudioIndex + 1) % audioFiles.count
        stopSound()
        playSound()
    }

    func playPreviousSound() {
        currentAudioIndex = (currentAudioIndex - 1 + audioFiles.count) % audioFiles.count
        stopSound()
        playSound()
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
            return 300 // 5 minutes for reading
        case .coding:
            return 600 // 10 minutes for coding
        case .writing:
            return 450 // 7.5 minutes for writing
        }
    }
}

struct MusicProgressBar: View {
    @Binding var currentTime: TimeInterval
    @Binding var totalTime: TimeInterval

    var body: some View {
        VStack {
            CircularProgressBar(progress: CGFloat(currentTime / totalTime))
                .padding()

            HStack {
                Text("Current Time: \(formattedTime(currentTime))")
                Spacer()
                Text("Total Time: \(formattedTime(totalTime))")
            }
            .padding()
        }
    }

    private func formattedTime(_ time: TimeInterval) -> String {
        let minutes = Int(time / 60)
        let seconds = Int(time.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct CircularProgressBar: View {
    var progress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(lineWidth: 10.0)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)

                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.blue)
                    .rotationEffect(Angle(degrees: -90))
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}


struct Page1_Previews: PreviewProvider {
    static var previews: some View {
        Page1()
    }
}

