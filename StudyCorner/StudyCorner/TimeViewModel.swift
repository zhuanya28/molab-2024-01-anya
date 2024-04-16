//
//  TimeViewModel.swift
//  StudyCorner
//
//  Created by anya zhukova on 4/15/24.
//



import SwiftUI
import AudioToolbox
import AVFoundation

class TimerViewModel: NSObject, ObservableObject{
    

    @Published var progress : Double
    @Published var seconds : TimeInterval
    @Published var displayTime : String = ""
    @Published var goalTime : Double = 0
    
    

    private var timer : Timer = Timer()
    private var soundID : SystemSoundID = 1407
    private let feedback = UIImpactFeedbackGenerator(style: .soft)
    
    // Reference: https://github.com/pouyasadri/Timer-app-ios/tree/main

    init(seconds: TimeInterval, goalTime: Double) {
        self.seconds = seconds
        self.goalTime = goalTime
        self.progress = seconds / Double(goalTime)
    }

    @objc func fireTimer(){
        seconds += 0.2
        progress = Double(seconds) / Double(goalTime)
        self.displayTime = calculateDisplayTime()
        
        // Timer is completed
        if progress >= 1 {
            stopSession()
            makeSoundAndVibration()
        }
    }
    
    func startSession(){
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
    }
    
    func stopSession(){
        timer.invalidate()
    }
    
    func pauseSession(){
        timer.invalidate()
    }
    
    func reset(){
        seconds = 0
        progress = 0
    }
    
    //MARK: - Public Methods
    func viewDidLoad(){
        self.progress = seconds / Double(goalTime)
        self.displayTime = calculateDisplayTime()
    }
    
    //MARK: - Private Methods
    private func calculateDisplayTime() -> String{
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes,seconds)
    }
    private func makeSoundAndVibration(){
        AudioServicesPlayAlertSoundWithCompletion(soundID, nil)
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate), {})
    }
}
