import SwiftUI

struct Quote: Codable {
    let id: String
    let category: String
    let text: String
}

class QuoteViewModel: ObservableObject {
    @Published var quotes: [Quote] = []

    init() {
        loadQuotes()
    }

    func loadQuotes() {
        if let path = Bundle.main.path(forResource: "quotes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let quotesData = try decoder.decode([String: [Quote]].self, from: data)

                // Extract quotes array from the dictionary
                if let quotesArray = quotesData["quotes"] {
                    quotes = quotesArray
                } else {
                    print("Error: Could not find 'quotes' key in the JSON.")
                }
            } catch {
                print("Error loading JSON: \(error)")
            }
        }
    }
}

struct Page2: View {
    var username: String
    @StateObject private var quoteViewModel = QuoteViewModel()
    @State private var selectedCategory: String = "study"
    @State private var currentQuote: String = ""

    var body: some View {
        VStack {
            Picker("Select Category", selection: $selectedCategory) {
                Text("Study").tag("study")
                Text("Life").tag("life")
                Text("Work").tag("work")
                Text("Inspiration").tag("inspiration")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: selectedCategory) { newValue, oldValue in
                regenerateQuote()
            }
            Spacer()

            Text(currentQuote)
                .font(.headline)
                .padding()
            Spacer()
            
            Button("Generate Quote") {
                regenerateQuote()
            }
            .padding()
            .font(.headline)
            .foregroundColor(.white)
            .background(Color.black)
            .cornerRadius(10)

        }
        .onAppear {
            quoteViewModel.loadQuotes()
            regenerateQuote()
        }
        .navigationTitle("Page 2")
    }

    private func regenerateQuote() {
        if let categoryQuotes = getCategoryQuotes() {
            currentQuote = categoryQuotes.randomElement()?.text ?? ""
        }
    }

    private func getCategoryQuotes() -> [Quote]? {
        let categoryQuotes = quoteViewModel.quotes.filter { $0.category == selectedCategory }
        return categoryQuotes.isEmpty ? nil : categoryQuotes
    }
}


//#Preview {
//    Page2()
//}


//generation of the JSON is entirely chatgpt, except for the format

