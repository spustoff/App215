//
//  Users_4.swift
//  App215
//
//  Created by Вячеслав on 10/12/23.
//

import SwiftUI
import Alamofire
import Amplitude

struct Users_4: View {
    
    @StateObject var viewModel = Users_4ViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            if let contact = viewModel.contact {
                
                VStack {
                    
                    HStack(spacing: 0) {
                        
                        WebPic(urlString: contact.logo ?? "", width: 90, height: 90, cornerRadius: 0, isPlaceholder: false)
                        
                        Text(contact.brand ?? "")
                            .foregroundColor(.black)
                            .font(.system(size: 21, weight: .bold))
                    }
                    
                    WebPic(urlString: contact.photo ?? "", width: .infinity, height: 400, cornerRadius: 0, isPlaceholder: false)
                    
                    HStack {
                        
                        Text(contact.contactName ?? "")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .medium))
                        
                        Circle()
                            .fill(.green)
                            .frame(width: 8, height: 8)
                        
                        Text("Online")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                    }
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    .padding(.top, 5)
                    
                    VStack(spacing: 6, content: {
                        
                        Text(contact.contactHeader ?? "")
                            .foregroundColor(.black)
                            .font(.system(size: 21, weight: .semibold))
                            .multilineTextAlignment(.center)
                        
                        Text(contact.contactSubHeader ?? "")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .multilineTextAlignment(.center)
                        
                    })
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isSocials = true
                        }
                        
                    }, label: {
                        
                        Text(contact.buttonTitle ?? "Get Contacts")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 24/255, green: 103/255, blue: 221/255)))
                            .padding()
                    })
                }
                
            } else {
                
                ProgressView()
                    .frame(maxHeight: .infinity, alignment: .center)
            }
            
            VStack {
                
                HStack {
                    
                    Spacer()
                    
                    NavigationLink(destination: {
                        
                        Users_5()
                            .navigationBarBackButtonHidden()
                        
                    }, label: {
                        
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .medium))
                            .padding(11)
                            .background(Circle().fill(.gray.opacity(0.15)))
                    })
                }
                
                Spacer()
            }
            .padding()
        }
        .overlay (
            
            ZStack {
                
                Color.black.opacity(viewModel.isSocials ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isSocials = false
                        }
                    }
                
                VStack {
                    
                    Text("Get Contacts")
                        .foregroundColor(.black)
                        .font(.system(size: 19, weight: .semibold))
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if let contactLinks = viewModel.contact?.contactLinks {
                        
                        let linksArray = Mirror(reflecting: contactLinks).children.compactMap { (label, value) in
                            
                            return (label, value as? String)
                        }
                        
                        ForEach(linksArray.filter{!($0.1 ?? "").isEmpty}, id: \.0) { (label, link) in
                            
                            Button(action: {
                                
                                Amplitude.instance().logEvent("additional_screens_opened_\(label ?? "nil")")
                                
                                withAnimation(.spring()) {
                                    
                                    viewModel.isSocials = false
                                }
                                
                                guard let url = URL(string: link ?? "") else { return }
                                
                                UIApplication.shared.open(url)
                                
                            }, label: {
                                
                                HStack {
                                    
                                    Image(label ?? "")
                                    
                                    Text(label?.capitalized ?? "")
                                        .foregroundColor(.black)
                                        .font(.system(size: 15, weight: .medium))
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 13, weight: .regular))
                                }
                            })
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("bg").ignoresSafeArea())
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: viewModel.isSocials ? 0 : UIScreen.main.bounds.height)
            }
        )
        .onAppear {
            
            viewModel.fetchContact()
        }
    }
}

struct Users_4Model: Codable, Hashable {
    
    let id: Int?
    let code, logo, photo, brand, contactName, contactHeader, contactSubHeader, buttonTitle: String?
    let contactLinks: ContactLinks?
    
    struct ContactLinks: Codable, Hashable {
        
        let tg, vk, custom1, custom2, facebook, whatsapp, instagram: String?
    }
}

class Users_4ViewModel: ObservableObject {
    
    @Published var isSocials: Bool = false
    @Published var isLoading: Bool = false
    @Published var contact: Users_4Model?
    
    func fetchContact() {
        
        isLoading = true
        
        let params: Parameters = [
            
            "lang": "en",
            "token": "26752931-6c2c-4d32-a8cd-92af90647583",
        ]
        
        let request = AF.request("https://liccarop.space/api/v2/contact/ga1idansadvisors", method: .get, parameters: params)
        
        request.responseDecodable(of: Users_4Model.self) { response in
            
            guard response.value != nil else {
                
                self.isLoading = false
                
                return
            }
            
            switch response.result{
                
            case .success(_):
                
                self.contact = response.value
                self.isLoading = false
                
            case .failure(_):
                
                self.isLoading = false
            }
        }
    }
}

#Preview {
    
    Users_4()
}
