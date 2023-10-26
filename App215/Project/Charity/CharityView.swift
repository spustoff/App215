//
//  CharityView.swift
//  App215
//
//  Created by Вячеслав on 10/12/23.
//

import SwiftUI

struct CharityView: View {
    
    @StateObject var viewModel = CharityViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("yellow")
                .ignoresSafeArea()
            
            VStack {
                
                HStack(alignment: .top) {
                    
                    Text("Charity")
                        .foregroundColor(.black)
                        .font(.system(size: 28, weight: .regular))
                        .padding(.top, 40)
                    
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
                
                if viewModel.charities.isEmpty {
                    
                    VStack(spacing: 5, content: {
                        
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.system(size: 35, weight: .bold))
                            .padding(.bottom, 20)
                        
                        Text("Empty Charity")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .medium))
                            .multilineTextAlignment(.center)
                        
                        Text("Add a new charity via the 'plus' icon")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .multilineTextAlignment(.center)
                    })
                    .frame(maxHeight: .infinity, alignment: .center)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.charities, id: \.self) { index in
                             
                                NavigationLink(destination: {
                                    
                                    CharityDetail(index: index)
                                        .navigationBarBackButtonHidden()
                                    
                                }, label: {
                                    
                                    VStack(alignment: .leading, spacing: 45, content: {
                                    
                                        Text(index.title ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 23, weight: .regular))
                                        
                                        VStack(alignment: .leading, spacing: 5, content: {
                                            
                                            Text("Need")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14, weight: .regular))
                                            
                                            Text(index.need ?? "")
                                                .foregroundColor(.black)
                                                .font(.system(size: 23, weight: .regular))
                                        })
                                        
                                        Divider()
                                    })
                                })
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            
            viewModel.fetchCharities()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            CharityAdd(viewModel: viewModel)
        })
    }
}

#Preview {
    CharityView()
}
