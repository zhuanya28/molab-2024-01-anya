//
//  TimerView.swift
//  StudyCorner
//
//  Created by anya zhukova on 4/15/24.
//

// Reference: https://github.com/pouyasadri/Timer-app-ios/tree/main
// and https://github.com/molab-itp/05-TimerDemo


import SwiftUI

struct TimerView: View {
    private let durations = [600, 900, 1500, 2700]
    @State private var selectedDurationIndex = 0
    @AppStorage("timeRemaining") var timeRemaining = 900
    @State private var timerIsRunning = false

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    var body: some View {
        VStack {
            TimeDisplay(timeRemaining: $timeRemaining, selectedDurationIndex: $selectedDurationIndex, durations: durations)
            
            HStack {
                Button(action: {
                    self.timerIsRunning.toggle()
                }) {
                    HStack(spacing: 15) {
                        Image(systemName: timerIsRunning ? "pause.fill" : "play.fill")
                        Text(timerIsRunning ? "Pause" : "Start")
                    }
                    .font(.system(size: 20))
                    .frame(width: 130, height: 50)
                    .background(Color.black)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    self.timerIsRunning = false
                    self.timeRemaining = durations[selectedDurationIndex]
                }) {
                    HStack(spacing: 15) {
                        Image(systemName: "arrow.clockwise")
                        Text("Reset")
                    }
                    .font(.system(size: 20))
                    .frame(width: 130, height: 50)
                    .background(Color.black)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                }
            }
        }
        .onReceive(timer) { _ in
            if self.timeRemaining > 0 && self.timerIsRunning {
                self.timeRemaining -= 1
                print("Time Remaining:", self.timeRemaining)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}

struct TimeDisplay: View {
    @Binding var timeRemaining: Int
    @Binding var selectedDurationIndex: Int
    var durations: [Int]
        
    var body: some View {
        VStack {
            Picker(selection: $selectedDurationIndex, label: Text("")) {
                ForEach(0..<durations.count, id: \.self) { index in
                    Text(timeString(fromSeconds: durations[index]))
                        .foregroundColor(.black)
                }
                .foregroundColor(.black)
            }
            
            .pickerStyle(MenuPickerStyle())
            .accentColor(.white)
            
            .onChange(of: selectedDurationIndex) { oldIndex, newIndex in
                timeRemaining = durations[newIndex]
            }
            
            Text(timeString(fromSeconds: timeRemaining))
                .font(.system(size: 120))
                .foregroundColor(.white)
        }
    }
      
    private func timeString(fromSeconds seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


#Preview {
    TimerView()
}
