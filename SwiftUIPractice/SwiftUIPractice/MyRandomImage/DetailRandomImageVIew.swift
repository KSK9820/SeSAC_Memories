//
//  DetailRandomImageView.swift
//  SwiftUIPractice
//
//  Created by 김수경 on 9/5/24.
//

import SwiftUI

struct DetailRandomImageView: View {
    @Binding var sectionTitle: String
    var randomImage: Image
    
    var body: some View {
        VStack(alignment: .center) {
            randomImage
                .frame(width: 300, height: 450)
                .scaledToFill()
            TextField(sectionTitle, text: $sectionTitle)
                .multilineTextAlignment(.center)
                .frame(width: 300)
                .font(.title3)
        }
    }
}

#Preview {
    DetailRandomImageView(sectionTitle: .constant("d"), randomImage: Image(systemName: "star"))
}
