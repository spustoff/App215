//
//  GoalsView.swift
//  App215
//
//  Created by Вячеслав on 10/12/23.
//

import SwiftUI

struct GoalsView: View {
    
    @StateObject var viewModel = GoalsViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack(alignment: .top) {
                    
                    Text("Goals")
                        .foregroundColor(.black)
                        .font(.system(size: 28, weight: .regular))
                    
                    Spacer()
                    
                    NavigationLink(destination: {
                        
                        ChartView()
                            .navigationBarBackButtonHidden()
                        
                    }, label: {
                        
                        Image("pie_icon")
                            .frame(width: 25, height: 25)
                    })
                }
                .padding()
                
                LazyVStack(spacing: 4) {
                    
                    ForEach(["Financial", "Physical", "Personal"], id: \.self) { index in
                        
                        NavigationLink(destination: {
                            
                            GoalsDetail(category: index, viewModel: viewModel)
                                .navigationBarBackButtonHidden()
                                .onAppear {
                                    
                                    viewModel.fetchGoals(isFilter: true, category: index)
                                }
                            
                        }, label: {
                            
                            VStack(spacing: 50) {
                                
                                HStack {
                                    
                                    Text(index)
                                        .foregroundColor(.black)
                                        .font(.system(size: 25, weight: .regular))
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.white)
                                        .font(.system(size: 15, weight: .regular))
                                }
                                
                                Image("card")
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(Circle().stroke(.white))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding()
                            .frame(height: 220)
                            .background(viewModel.colors.randomElement())
                        })
                    }
                }
            }
        }
    }
}

#Preview {
    GoalsView()
}
