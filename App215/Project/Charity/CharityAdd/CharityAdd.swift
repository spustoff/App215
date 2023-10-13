//
//  CharityAdd.swift
//  App215
//
//  Created by Вячеслав on 10/12/23.
//

import SwiftUI

struct CharityAdd: View {
    
    @Environment(\.presentationMode) var router
    
    @StateObject var viewModel: CharityViewModel
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack(alignment: .top) {
                    
                    Text("New Charity Goal")
                        .foregroundColor(.black)
                        .font(.system(size: 28, weight: .regular))
                        .padding(.top, 40)
                    
                    Spacer()
                    
                    Button(action: {
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .medium))
                    })
                }
                .padding()
                
                ScrollView(.vertical, showsIndicators: true) {
                    
                    LazyVStack(spacing: 30) {
                        
                        VStack(alignment: .leading, spacing: 4, content: {
                            
                            Text("Title")
                                .foregroundColor(.gray)
                                .font(.system(size: 13, weight: .regular))
                            
                            TextField("", text: $viewModel.title)
                                .foregroundColor(.black)
                                .font(.system(size: 25, weight: .regular))
                            
                            Rectangle()
                                .fill(.gray.opacity(0.4))
                                .frame(height: 1)
                        })
                        
                        VStack(alignment: .leading, spacing: 4, content: {
                            
                            Text("Description")
                                .foregroundColor(.gray)
                                .font(.system(size: 13, weight: .regular))
                            
                            TextField("", text: $viewModel.text)
                                .foregroundColor(.black)
                                .font(.system(size: 25, weight: .regular))
                            
                            Rectangle()
                                .fill(.gray.opacity(0.4))
                                .frame(height: 1)
                        })
                        
                        VStack(alignment: .leading, spacing: 4, content: {
                            
                            Text("Need")
                                .foregroundColor(.gray)
                                .font(.system(size: 13, weight: .regular))
                            
                            TextField("", text: $viewModel.need)
                                .foregroundColor(.black)
                                .font(.system(size: 25, weight: .regular))
                            
                            Rectangle()
                                .fill(.gray.opacity(0.4))
                                .frame(height: 1)
                        })
                    }
                    .padding()
                }
                
                Spacer()
                
                Button(action: {
                    
                    viewModel.addCharity {
                        
                        viewModel.fetchCharities()
                        
                        router.wrappedValue.dismiss()
                    }
                    
                }, label: {
                    
                    Text("Save")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                        .padding()
                })
                .opacity(viewModel.title.isEmpty || viewModel.text.isEmpty || viewModel.need.isEmpty ? 0.5 : 1)
                .disabled(viewModel.title.isEmpty || viewModel.text.isEmpty || viewModel.need.isEmpty ? true : false)
            }
        }
    }
}

#Preview {
    CharityAdd(viewModel: CharityViewModel())
}
