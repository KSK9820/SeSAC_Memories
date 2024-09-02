//
//  LaunchScreenView.swift
//  SwiftUIPractice
//
//  Created by 김수경 on 9/2/24.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image("launch")
                    .padding()
                Image("launchImage")
                    .padding()
                
                NavigationLink {
                    MBTIView()
                } label: {
                    Text("시작하기")
                        .frame(maxWidth: .infinity, maxHeight: 44)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(.capsule)
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
