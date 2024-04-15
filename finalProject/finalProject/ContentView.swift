import SwiftUI

struct ContentView: View {
    @EnvironmentObject var pageModel: PageModel
    
    var body: some View {
        VStack {
            switch pageModel.pageTag {
            case .LogIn:
                LogInPage()
            case .Page1:
                Page1()
            case .Page2:
                Page2()
            case .Page3:
                Page3()
            case .RemindersPage:
                RemindersPage()
       
            }
            
            HStack {
                Spacer()
                Button(action: {
                    pageModel.pageTag = .LogIn
                }) {
                    Image(systemName: pageModel.pageTag == .LogIn ? "person.fill" : "person")
                        .foregroundColor(.purple)
                        .font(.title)
                        .padding()
                }
                
                Spacer()
                
                Button(action: {
                    pageModel.pageTag = .Page1
                }) {
                    Image(systemName: pageModel.pageTag == .Page1 ? "book.fill" : "book")
                        .foregroundColor(.purple)
                        .font(.title)
                        .padding()
                }
                
                Spacer()
                
                
                Button(action: {
                    pageModel.pageTag = .Page3
                }) {
                    Image(systemName: pageModel.pageTag == .Page3 ? "building.columns.fill" : "building.columns")
                        .foregroundColor(.purple)
                        .font(.title)
                        .padding()
                }
                
                Spacer()
                
                Button(action: {
                    pageModel.pageTag = .Page2
                }) {
                    Image(systemName: pageModel.pageTag == .Page2 ? "heart.fill" : "heart")
                        .foregroundColor(.purple)
                        .font(.title)
                        .padding()
                }
                
                Spacer()
                    
                Button(action: {
                    pageModel.pageTag = .RemindersPage
                }) {
                    Image(systemName: pageModel.pageTag == .RemindersPage ? "list.clipboard.fill" : "list.clipboard")
                        .foregroundColor(.purple)
                        .font(.title)
                        .padding()
                }
                
                Spacer()
            }
            .padding(.bottom, 5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PageModel())
    }
}
