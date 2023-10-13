//
//  App215App.swift
//  App215
//
//  Created by Вячеслав on 10/12/23.
//

import SwiftUI
import FirebaseCore
import ApphudSDK
import Amplitude

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Apphud.start(apiKey: "app_ibXom9ifSohcjEscKBwVbcJbuvyNaR")
        Amplitude.instance().initializeApiKey("a21ce379540844713a1718c2c2c37059")

        FirebaseApp.configure()
        
        return true
    }
}

@main
struct App215App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        
        WindowGroup {
            
            NavigationView(content: {
                
                ContentView()
            })
        }
    }
}
