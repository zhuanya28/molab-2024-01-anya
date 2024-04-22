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

    @AppStorage("timeRemaining") var timeRemaining = 60
    @State private var timerIsRunning = false
    @State private var selectedDurationIndex = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let durations = [30, 60, 90, 120]
    
    var body: some View {
        VStack {
            TimeDisplay(timeRemaining: $timeRemaining)
            
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
    @State private var isSelectorPresented = false
    @State private var isMenuVisible = false
    @State private var selectedDurationIndex = 0 // Added state variable for selected duration
        private let durations = [5, 10, 15, 25, 45, 60] // Define durations here
        
    var body: some View {
           VStack {
              
               if self.selectedDurationIndex >= 0 && self.selectedDurationIndex < durations.count {
                   Picker(selection: $selectedDurationIndex, label: Text("")) {
                       ForEach(0..<durations.count, id: \.self) { index in
                           Text("\(durations[index]) seconds")
                               .foregroundColor(.black)
                       }
                   }
                   .pickerStyle(MenuPickerStyle())
                   
                   .onChange(of: selectedDurationIndex) { _ in
                       timeRemaining = durations[selectedDurationIndex] // Update timeRemaining when selection changes
                   }
                   Text(timeString)
                       .font(.system(size: 120))
                       .foregroundColor(.white)
                       .onTapGesture {
                           self.selectedDurationIndex = durations.firstIndex(of: timeRemaining) ?? 0
                       }
                   
               }
           }
       }
      
      private var timeString: String {
          let minutes = timeRemaining / 60
          let seconds = timeRemaining % 60
          return String(format: "%02d:%02d", minutes, seconds)
      }
}





#Preview {
    TimerView()
}
