import SwiftUI
import SpriteKit

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            GeometryReader {
                
                let size = $0.size
                
                LinearGradient(gradient: Gradient(colors: [Color.mainNavy, Color.mainBlue]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(alignment: .center) {
                    Text("Just Space out!")
                        .multilineTextAlignment(.center)
                        .font(.custom("TiquiTaca-Regular", size: 120))
                        .foregroundColor(Color.mainPink)
                        .padding(.bottom)
                    
                    Text("*Please use a 12.9-inch iPad.")
                        .foregroundColor(Color.warningRed)
                    
                    Text("\nWe are living in a world where there’s just too much information for us to process every day.\nFeeling overwhelmed with the vast amount of information has become normal.\n\nDon’t you feel like your brain is being overloaded?\nYou might want to take a break for your brain to rest, but at the same time, you can’t take your hands off your phone.\nIf that’s the case, take a moment to tune out with this app.\n\nTo interact, all you need to do is touch the screen.\nNo need to think about anything!\nYou can even close your eyes while using this app and just focus on the sound.\n\nJust take a break and give your mind a rest!")
                        .lineSpacing(1)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 30))
                        .foregroundColor(Color.mainPink)
                        .padding(.bottom, size.width / 30)
                    
                    NavigationLink(destination: PastureView()) {
                        Text("GO")
                        .font(.custom("TiquiTaca-Regular", size: 96))
                        .frame(width: size.width / 3, height: size.height / 9)
                        .foregroundColor(Color.mainPink)
                        .background(RoundedRectangle(cornerRadius: 30).strokeBorder()
                            .foregroundColor(Color.mainPink))
                    }
                    
                }
                .padding(.horizontal)
                .padding(.top, size.height / 10.5)
                
                
            }
            .navigationBarHidden(true)  // 네비게이션 바 숨김
        }.navigationViewStyle(StackNavigationViewStyle())
            }
        }
    

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
