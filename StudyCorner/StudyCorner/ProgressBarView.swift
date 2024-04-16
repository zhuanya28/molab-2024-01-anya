//
//  ProgressBarView.swift
//  StudyCorner
//
//  Created by anya zhukova on 4/15/24.
//
// Reference: https://github.com/pouyasadri/Timer-app-ios/tree/main

import SwiftUI

struct ProgressBarView: View {
 
    @Binding var progress : TimeInterval
    @Binding var goal : Double
    
    var body: some View {
        ZStack{
            //Default Circle
            defaultCircle
            // overlap Circle
            prograssCircle
        }
    }
    
    private var defaultCircle: some View{
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 20,lineCap: .butt,dash: [2,6]))
            .fill(Color.gray)
            .rotationEffect(Angle(degrees: -90))
            .frame(width: 300,height: 300)
    }
    private var prograssCircle: some View{
        Circle()
            .trim(from: 0.0,to: CGFloat(progress) / CGFloat(goal))
            .stroke(style: StrokeStyle(lineWidth: 20,lineCap: .butt,dash: [2,6]))
            .fill(Color(red: 236/255, green: 230/255, blue: 0/255))
            .animation(.spring(), value: progress)
            .rotationEffect(Angle(degrees: -90))
            .frame(width: 300,height: 300)
    }
}

#Preview {
    ProgressBarView(progress: .constant(0), goal: .constant(0))
}
