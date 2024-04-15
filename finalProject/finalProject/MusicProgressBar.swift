//
//  MusicProgressBar.swift
//  week06
//
//  Created by anya zhukova on 3/11/24.
//

import SwiftUI

struct MusicProgressBar: View {
    @Binding var currentTime: TimeInterval
    @Binding var totalTime: TimeInterval

    var body: some View {
        VStack {
            CircularProgressBar(progress: CGFloat(currentTime / totalTime)) {
                           Text(formattedTime(currentTime))
                               .font(.system(size: 24))
                               .fontWeight(.bold)
                               .foregroundColor(.black)
                       }
            .padding()
            HStack {
                Text("Total Time: \(formattedTime(totalTime))")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
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

struct CircularProgressBar<Content: View>: View {
    var progress: CGFloat
    @ViewBuilder var content: Content

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
                    .foregroundColor(Color.black)
                    .rotationEffect(Angle(degrees: -90))

                content
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

