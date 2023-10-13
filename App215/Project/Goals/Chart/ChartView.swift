//
//  ChartView.swift
//  App215
//
//  Created by Вячеслав on 10/12/23.
//

import SwiftUI

struct ChartView: View {
    
    @Environment(\.presentationMode) var router
    
    @StateObject var viewModel = GoalsViewModel()
    
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
                }
                .padding()
                
                HStack {
                    
                    ForEach(["Candle Chart", "Pie Chart"], id: \.self) { index in
                        
                        Button(action: {
                            
                            viewModel.pie_currentTab = index
                            
                        }, label: {
                            
                            Text(index)
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)
                                .background(RoundedRectangle(cornerRadius: 5).fill(viewModel.pie_currentTab == index ? .white : .gray.opacity(0.1)))
                        })
                    }
                }
                .padding(7)
                .background(Color.gray.opacity(0.1))
                
                switch viewModel.pie_currentTab {
                    
                case "Candle Chart":
                    candleView()
                    
                case "Pie Chart":
                    pieView()
                    
                default:
                    ProgressView()
                }
                
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    func pieView() -> some View {
        
        VStack {
            
            Image("pie_chart")
            
            VStack(spacing: 20, content: {
                
                ForEach(["Financial", "Physical", "Personal"], id: \.self) { index in
                    
                    VStack(alignment: .leading) {
                        
                        HStack {
                            
                            Circle()
                                .stroke(Color("red"), lineWidth: 5)
                                .frame(width: 10, height: 10)
                            
                            Spacer()
                            
                            Text(index)
                                .foregroundColor(.black)
                                .font(.system(size: 18, weight: .regular))
                        }
                        
                        HStack {
                            
                            Text("All")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                            
                            Spacer()
                            
                            Text("0")
                                .foregroundColor(.black)
                                .font(.system(size: 18, weight: .regular))
                        }
                        
                        HStack {
                            
                            Text("Done")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                            
                            Spacer()
                            
                            Text("0")
                                .foregroundColor(.black)
                                .font(.system(size: 18, weight: .regular))
                        }
                    }
                }
            })
        }
        .padding()
    }
    
    @ViewBuilder
    func candleView() -> some View {
        
        VStack {
            
            HStack {
                
                Text("$\(Int.random(in: 2000...25000))")
                    .foregroundColor(.black)
                    .font(.system(size: 23, weight: .semibold))
                
                Spacer()
                
                Text("+\(Int.random(in: 1...20))%")
                    .foregroundColor(.green)
                    .font(.system(size: 14, weight: .regular))
            }
            .padding()
            
            Chart(pair: viewModel.pie_currentPair)
                .disabled(true)
            
            Menu {
                
                ForEach(["EURUSD", "EURTRY", "EURKZT", "EURJPY", "EURCAD"], id: \.self) { index in
                
                    Button(action: {
                        
                        viewModel.pie_currentPair = index
                        
                    }, label: {
                        
                        HStack {
                            
                            Text(index)
                            
                            Spacer()
                            
                            if viewModel.pie_currentPair == index {
                                
                                Image(systemName: "xmark")
                            }
                        }
                    })
                }
                
            } label: {
                
                VStack {
                    
                    HStack {
                        
                        Text(viewModel.pie_currentPair)
                            .foregroundColor(.black)
                            .font(.system(size: 17, weight: .medium))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.up")
                            .foregroundColor(.black)
                            .font(.system(size: 13, weight: .regular))
                    }
                    
                    Rectangle()
                        .fill(.gray.opacity(0.2))
                        .frame(height: 1)
                }
                .padding()
            }
        }
    }
}

#Preview {
    ChartView()
}
