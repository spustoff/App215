//
//  CharityDetail.swift
//  App215
//
//  Created by Вячеслав on 10/12/23.
//

import SwiftUI

struct CharityDetail: View {
    
    let index: CharityModel
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("yellow")
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
                }
                .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack(alignment: .leading) {
                        
                        Text(index.title ?? "")
                            .foregroundColor(.black)
                            .font(.system(size: 26, weight: .regular))
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 40)
                        
                        VStack(alignment: .leading, spacing: 25, content: {
                            
                            VStack(alignment: .leading, spacing: 5, content: {
                                
                                Text("Info")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                
                                Text(index.text ?? "")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16, weight: .medium))
                            })
                            
                            VStack(alignment: .leading, spacing: 5, content: {
                                
                                Text("Need")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                
                                Text(index.need ?? "")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16, weight: .medium))
                            })
                        })
                    }
                    .padding()
                }
            }
        }
    }
}

//#Preview {
//    CharityDetail()
//}
