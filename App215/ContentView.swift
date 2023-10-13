//
//  ContentView.swift
//  App215
//
//  Created by Вячеслав on 10/12/23.
//

import SwiftUI
import Amplitude

struct ContentView: View {
    
    @State var current_tab: Tab = Tab.Goals
    
    @State var server: String = ""
    
    @State var isDead: Bool = false
    @State var isContacts: Bool = false
    @State var isTelegram: Bool = false
    
    @State var telegram: URL = URL(string: "h")!
    
    @AppStorage("status") var status: Bool = false
    
    init() {
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            if server.isEmpty || telegram.absoluteString == "h" {
                
                LoadingView()
                
            } else {
                
                if server == "0" {
                    
                    if status {
                        
                        WebSystem()
                        
                    } else {
                        
                        Users_1(telegram: telegram, isTelegram: isTelegram, isContacts: isContacts)
                    }
                    
                } else if server == "1" {
                    
                    if status {
                        
                        VStack(spacing: 0, content: {
                            
                            TabView(selection: $current_tab, content: {
                                
                                GoalsView()
                                    .tag(Tab.Goals)
                                
                                CompletedView()
                                    .tag(Tab.Completed)
                                
                                CharityView()
                                    .tag(Tab.Charity)
                            })
                            
                            TabBar(selectedTab: $current_tab)
                        })
                        .ignoresSafeArea(.all, edges: .bottom)
                        .onAppear {
                            
                            Amplitude.instance().logEvent("did_show_main_screen")
                        }
                         
                    } else {
                        
                        Reviewers_1()
                    }
                }
            }
        }
        .onAppear {
            
            check_data(isCaptured: false)
        }
    }
    
    private func check_data(isCaptured: Bool) {
        
        getFirebaseData(field: "isDead", dataType: .bool) { result1 in
            
            let result1 = result1 as? Bool ?? false
            isDead = result1
            
            getFirebaseData(field: "isTelegram", dataType: .bool) { result2 in
                
                let result2 = result2 as? Bool ?? false
                isTelegram = result2
            
                getFirebaseData(field: "telegram", dataType: .url) { result3 in
                    
                    let result3 = result3 as? URL ?? URL(string: "nil")!
                    telegram = result3
                    
                    getFirebaseData(field: "isContacts", dataType: .bool) { result4 in
                        
                        let result4 = result4 as? Bool ?? false
                        isContacts = result4
                        
                        
                        
                        let data = MyDataClass.getMyData()
                        let now = Date().timeIntervalSince1970

                        var dateComponents = DateComponents()
                        dateComponents.year = 2023
                        dateComponents.month = 10
                        dateComponents.day = 16

                        let targetDate = Calendar.current.date(from: dateComponents)!
                        let targetUnixTime = targetDate.timeIntervalSince1970
                        
                        guard now > targetUnixTime else {

                            server = "1"

                            return
                        }
                        
                        if data.isVpn || data.isFullChrg || isCaptured {
                            
                            server = "1"
                            
                        } else {
                            
                            server = "0"
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
