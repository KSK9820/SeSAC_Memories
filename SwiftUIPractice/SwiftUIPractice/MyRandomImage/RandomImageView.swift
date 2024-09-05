//
//  RandomImageView.swift
//  SwiftUIPractice
//
//  Created by 김수경 on 9/5/24.
//

import SwiftUI

struct SectionTitle: Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String
}

struct MyRandomImageView: View {
    @State private var sectionTitle = [SectionTitle(name: "첫 번째 섹션"), SectionTitle(name: "두 번째 섹션"), SectionTitle(name: "세 번째 섹션"), SectionTitle(name: "네 번째 섹션"), SectionTitle(name: "다섯 번째 섹션")]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach($sectionTitle, id: \.id) { $item in
                        ImageSectionView(sectionName: $item.name)
                    }
                }
            }
            .navigationTitle("My Random Image")
        }
    }
}

struct ImageSectionView: View {
    @Binding var sectionName: String
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            Text(sectionName)
                .font(.title3)
                .bold()
                .padding()
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(0..<20) { item in
                        RandomImageView(sectionName: $sectionName)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .safeAreaPadding(.leading)
        }

    }
}

struct RandomImageView: View {
    @Binding var sectionName: String
    var url = URL(string: "https://picsum.photos/100/150")
    
    var body: some View {
        AsyncImage(url: url) { data in
            switch data {
            case .empty:
                ProgressView()
                    .frame(width: 100, height: 150)
            case .success(let image):
                NavigationLink {
                  NavigationLazyView(DetailRandomImageView(sectionTitle: $sectionName, randomImage: image))
                } label: {
                    image
                        .scaledToFit()
                        .frame(width: 100, height: 150)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                }
            case .failure(_):
                Image(systemName: "heart")
                    .frame(width: 100, height: 150)
            @unknown default:
                fatalError()
            }
        }
    }
}

#Preview {
    MyRandomImageView()
}
