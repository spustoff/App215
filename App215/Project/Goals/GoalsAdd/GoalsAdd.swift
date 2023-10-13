//
//  GoalsAdd.swift
//  App215
//
//  Created by Вячеслав on 10/12/23.
//

import SwiftUI

struct GoalsAdd: View {
    
    @Environment(\.presentationMode) var router
    
    let category: String
    
    @StateObject var viewModel: GoalsViewModel
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack(alignment: .top) {
                    
                    Text("New Goal")
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
                            
                            Text("Start")
                                .foregroundColor(.gray)
                                .font(.system(size: 13, weight: .regular))
                            
                            DatePicker(selection: $viewModel.startDate, displayedComponents: .date, label: {})
                                .labelsHidden()
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 4, content: {
                            
                            Text("End")
                                .foregroundColor(.gray)
                                .font(.system(size: 13, weight: .regular))
                            
                            DatePicker(selection: $viewModel.endDate, displayedComponents: .date, label: {})
                                .labelsHidden()
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 4, content: {
                            
                            Text("Comment")
                                .foregroundColor(.gray)
                                .font(.system(size: 13, weight: .regular))
                            
                            TextField("", text: $viewModel.comment)
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
                    
                    viewModel.addGoal(category: category, completion: {
                        
                        viewModel.fetchGoals(isFilter: true, category: category)
                        
                        router.wrappedValue.dismiss()
                    })
                    
                }, label: {
                    
                    Text("Save")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                        .padding()
                })
                .opacity(viewModel.title.isEmpty || viewModel.comment.isEmpty ? 0.5 : 1)
                .disabled(viewModel.title.isEmpty || viewModel.comment.isEmpty ? true : false)
            }
        }
    }
}

#Preview {
    GoalsAdd(category: "Physical", viewModel: GoalsViewModel())
}
