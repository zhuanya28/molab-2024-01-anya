//
//  TimerView.swift
//  StudyCorner
//
//  Created by anya zhukova on 4/15/24.
//

// Reference: https://github.com/pouyasadri/Timer-app-ios/tree/main


import SwiftUI

struct TimerView: View {

    @ObservedObject var timerViewModel : TimerViewModel
    @State var isPaused = false
    @State private var rotation = 0
    

    init(seconds: TimeInterval = 0 ){
        timerViewModel = TimerViewModel(seconds: seconds, goalTime: 20)
    }

    var body: some View {
        ZStack{
            ProgressBarView(progress: $timerViewModel.seconds, goal: $timerViewModel.goalTime)
            centerTitle
            bottomButtons
                .onAppear{
                    timerViewModel.startSession()
                    timerViewModel.viewDidLoad()
                }
        }
    }
    

    private var centerTitle: some View{
        VStack{
            Text(timerViewModel.progress >= 1 ? "Done" : timerViewModel.displayTime)
                .font(.system(size: 50,weight: .bold))
                .foregroundStyle(.white)
            Text("\(timerViewModel.goalTime.asString(style: .short))")
                .foregroundStyle(.white.opacity(0.6))
        }
    }
    private var bottomButtons: some View{
        VStack{
            Text("Timer App")
                .font(.title)
                .foregroundStyle(Color(red: 180/255, green: 187/255, blue: 62/255))
            Spacer()
            buttonView
        }
    }
    private var buttonView: some View{
        HStack{
            resetButton
            startPauseButton
        }
        .padding(.bottom,40)
        .padding(.horizontal,20)
    }
    private var resetButton: some View{
        Button{
            reset()
        } label: {
            HStack(spacing:8){
                Image(systemName: "arrow.clockwise")
                    .rotationEffect(.degrees(Double(rotation)))
                Text("Reset")
            }
            .padding()
            .tint(.black)
            .frame(maxWidth: .infinity)
            .font(.system(size: 18,weight: .bold))
        }
        .background(Color(red: 236/255, green: 230/255, blue: 0/255))
        .cornerRadius(15)
    }
    private var startPauseButton: some View{
        Button{
            if timerViewModel.progress < 1 {
                isPaused.toggle()
                isPaused ? timerViewModel.pauseSession() : timerViewModel.startSession()
            }
        } label: {
            HStack(spacing:8){
                Image(systemName: isPaused ? "play.fill" : "pause.fill")
                Text(isPaused ? "Start" : "Pause")
            }
            .padding()
            .tint(.black)
            .frame(maxWidth: .infinity)
            .font(.system(size: 18,weight: .bold))
        }
        .background(Color(red: 236/255, green: 230/255, blue: 0/255))
        .cornerRadius(15)
    }
    
    private func reset(){
        withAnimation(.easeInOut(duration:0.4)){
            rotation += 360
        }
        if timerViewModel.progress >= 1{
            timerViewModel.reset()
            timerViewModel.startSession()
        }
        else{
            timerViewModel.reset()
            timerViewModel.displayTime = "00:00"
        }
    }
}

#Preview {
    TimerView()
}
