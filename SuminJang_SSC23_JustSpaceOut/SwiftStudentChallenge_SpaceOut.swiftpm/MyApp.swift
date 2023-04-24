import SwiftUI
import SpriteKit

@main
struct MyApp: App {
    
    init() {
          FontManager.registerFonts()
      }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
