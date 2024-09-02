//
//  ProfileView.swift
//  SwiftUIPractice
//
//  Created by 김수경 on 9/3/24.
//

import SwiftUI

struct ProfileView: View {
    @State var imageName: String = "profile_0"
    
    private let columns = [
         GridItem(.flexible()),
         GridItem(.flexible()),
         GridItem(.flexible()),
         GridItem(.flexible())
     ]
    
    var body: some View {
        NavigationStack {
            ProfileImageView(image: imageName)
            
            LazyVGrid(columns: columns, content: {
                ForEach(0..<12) { item in
                    Button(action: {
                        imageName = "profile_\(item)"
                    }, label: {
                        SmallProfileImageView(imageName: $imageName, image: "profile_\(item)")
                    })
                }
            })
            .padding()
          
            Spacer()

                .navigationTitle("PROFILE SETTING")
                .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct ProfileImageView: View {
    var image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .frame(width: 100, height: 100)
            .clipShape(.circle)
            .overlay(
                Circle().stroke(Color.blue, lineWidth: 3.0)
            )
            .overlay(alignment: .bottomTrailing, content: {
                Image(systemName: "camera.fill")
                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(.circle)
            })
            .padding()
    }
}

struct SmallProfileImageView: View {
    @Binding var imageName: String
    var image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .frame(width: 80, height: 80)
            .clipShape(.circle)
            .overlay(
                Circle().stroke(imageName == image ? Color.blue : Color.gray, lineWidth: imageName == image ? 3.0 : 1.0)
            )
            .opacity(imageName == image ? 1.0 : 0.6)
            .padding()
    }
}

#Preview {
    ProfileView()
}
