import SwiftUI
import AVFoundation

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

struct CountdownTimerPage: View {
    @State private var counter: Int = 0
    @State private var isCountingDown = true
    @State private var player: AVAudioPlayer?
    
    var body: some View {
        VStack {
            ZStack {
                ProgressTrack()
                ProgressBar(counter: counter, countTo: 20)
                Clock(counter: counter, countTo: 20)
            }
            
            HStack {
                Button(action: {
                    resetCountdown()
                }) {
                    Text("Reset")
                        .font(.system(size: 20))
                        .frame(width: 100, height: 40)
                        .background(Color.red)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
              
                }
                .padding()
                
                Button(action: {
                    toggleCountdown()
                }){
                    Text(isCountingDown ? "Pause" : "Resume")
                        .font(.system(size: 20))
                        .frame(width: 100, height: 40)
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                }
                .padding()
            }
        }
        .onReceive(timer) { time in
            if isCountingDown, self.counter < 20 {
                self.counter += 1
            } else if self.counter == 20 {
                playSound()
            }
        }
    }
    
    private func resetCountdown() {
        counter = 0
    }
    
    private func toggleCountdown() {
        isCountingDown.toggle()
    }
    
    private func playSound() {
        if let soundURL = Bundle.main.url(forResource: "A_major", withExtension: "m4a") {
            do {
                player = try AVAudioPlayer(contentsOf: soundURL)
                player?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}

struct CountdownTimerPage_Previews: PreviewProvider {
    static var previews: some View {
        CountdownTimerPage()
    }
}

