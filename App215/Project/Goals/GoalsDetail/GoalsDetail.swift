//
//  GoalsDetail.swift
//  App215
//
//  Created by Вячеслав on 10/12/23.
//

import SwiftUI

struct GoalsDetail: View {
    
    @Environment(\.presentationMode) var router
    
    let category: String
    
    @StateObject var viewModel: GoalsViewModel
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Button(action: {
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        HStack {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .medium))
                            
                            Text("Back")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .medium))
                        }
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        
                        viewModel.isAdd = true
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .bold))
                    })
                }
                .padding()
                
                Text(category)
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .regular))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                if viewModel.goals.isEmpty {
                    
                    VStack(spacing: 5, content: {
                        
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.system(size: 35, weight: .bold))
                            .padding(.bottom, 20)
                        
                        Text("Empty goals")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .medium))
                            .multilineTextAlignment(.center)
                        
                        Text("You don't have any goal yet.")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .multilineTextAlignment(.center)
                    })
                    .frame(maxHeight: .infinity, alignment: .center)
                    
                } else {
                    
                    TabView(content: {
                        
                        ForEach(viewModel.goals, id: \.self) { index in
                            
                            VStack(alignment: .leading, spacing: 15) {
                                
                                VStack(alignment: .leading, spacing: 4, content: {
                                    
                                    Text("Title")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 13, weight: .regular))
                                    
                                    Text(index.title ?? "")
                                        .foregroundColor(.black)
                                        .font(.system(size: 30, weight: .regular))
                                })
                                
                                Divider()
                                
                                VStack(alignment: .leading, spacing: 4, content: {
                                    
                                    Text("Start")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 13, weight: .regular))
                                    
                                    Text((index.start ?? Date()).convertDate(format: "MMM d"))
                                        .foregroundColor(.black)
                                        .font(.system(size: 20, weight: .regular))
                                })
                                
                                VStack(alignment: .leading, spacing: 4, content: {
                                    
                                    Text("End")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 13, weight: .regular))
                                    
                                    Text((index.end ?? Date()).convertDate(format: "MMM d"))
                                        .foregroundColor(.black)
                                        .font(.system(size: 20, weight: .regular))
                                })
                                
                                Divider()
                                
                                VStack(alignment: .leading, spacing: 4, content: {
                                    
                                    Text("Comment")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 13, weight: .regular))
                                    
                                    Text(index.comment ?? "")
                                        .foregroundColor(.black)
                                        .font(.system(size: 20, weight: .regular))
                                })
                                
                                Spacer()
                            }
                            .padding()
                        }
                    })
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                }
            }
        }
        .onAppear {
            
            viewModel.fetchGoals(isFilter: true, category: category)
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            GoalsAdd(category: category, viewModel: viewModel)
        })
    }
}

#Preview {
    GoalsDetail(category: "Physical", viewModel: GoalsViewModel())
}
