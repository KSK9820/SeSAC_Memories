//
//  MBTIView.swift
//  SwiftUIPractice
//
//  Created by 김수경 on 9/3/24.
//

import SwiftUI

struct MBTIView: View {
    @State var mbti: [Bool?] = [nil,nil,nil,nil]
    @State var isSheet = false
    @State var isFull = false
    @State var nickname = ""
    
    var body: some View {
        NavigationStack {
            
            NavigationLink {
                ProfileView()
            } label: {
                ProfileImageView(image: "profile_0")
                    .padding()
            }
            TextField("닉네임을 입력해주세요 :)", text: $nickname)
                .padding(.top)
                .padding(.horizontal)
                .padding(.horizontal)
            Divider()
                .frame(height: 1)
                .background(.gray)
                .padding(.horizontal)
                .padding(.horizontal)
                .padding(.bottom)
                
            
            HStack(spacing: 60, content: {
                Text("MBTI")
                    .bold()
                HStack {
                    MBTIStackView(status: $mbti[0], top: "I", bottom: "E")
                    MBTIStackView(status: $mbti[1], top: "S", bottom: "N")
                    MBTIStackView(status: $mbti[2], top: "T", bottom: "F")
                    MBTIStackView(status: $mbti[3], top: "J", bottom: "P")
                }
            })
            Spacer()
            
            Button {
                isSheet = mbti.filter { $0 != nil }.count == 4 ? true : false
            } label: {
                Text("완료")
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .foregroundStyle(.white)
                    .background(mbti.filter{ $0 != nil }.count == 4 ? .blue : .gray)
                    .clipShape(.capsule)
            }
            .padding(.horizontal)
            
            .navigationTitle("PROFILE SETTING")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $isSheet) {
            FinishView()
        }
        
    }
    
}



struct MBTIStackView: View {
    @Binding var status: Bool?
    
    var top: String
    var bottom: String
    
    var body: some View {
        VStack {
            MBTIButtonView(status: $status, type: top)
            MBTIButtonView(status: Binding(
                get: { status == nil ? nil : !(status!) },
                set: { newValue in status = newValue != nil ? !newValue! : nil }
            ), type: bottom)
        }
    }
}

struct MBTIButtonView: View {
    @Binding var status: Bool?
    
    var type: String
    
    var body: some View {
        Button(action: {
            if status == nil {
                status = true
            } else if status == true {
                status = nil
            } else {
                status?.toggle()
            }
        }, label: {
            Text(type)
                .frame(width: 40, height: 40)
                .background(status ?? false ? .blue : .clear)
                .foregroundStyle(status ?? false ? .white : .gray)
                .clipShape(.circle)
                .overlay(
                    Circle().stroke(Color.gray, lineWidth: 1.0)
                )
        })
    }
}

#Preview {
    MBTIView()
}
