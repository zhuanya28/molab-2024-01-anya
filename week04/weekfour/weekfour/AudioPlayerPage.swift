import AVFoundation
import SwiftUI

struct AudioPlayerPage: View {
    @State private var player: AVAudioPlayer?
    @State private var selectedAnimal: String = "fish"

    let animals = ["fish", "cat", "dog"]

    var body: some View {
        VStack {
            Image(systemName: selectedAnimal + ".fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)

            Picker(selection: $selectedAnimal, label: Text("Select Animal")) {
                ForEach(animals, id: \.self) { animal in
                    Text(animal)
                }
            }
            .padding()

            Button(action: {
                self.playSound()
            }) {
             
                    Text("Play Sound")
                        .font(.system(size: 20))
                        .frame(width: 200, height: 40)
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
            }
        }
    }
    func playSound() {
        guard let soundURL = Bundle.main.url(forResource: selectedAnimal, withExtension: "wav") else {
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
            player?.play()
        } catch {
            print("Failed to load the sound: \(error)")
        }
    }

}



struct AudioPlayerPage_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerPage()
    }
}

