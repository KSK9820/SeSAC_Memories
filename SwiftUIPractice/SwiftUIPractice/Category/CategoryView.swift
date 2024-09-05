//
//  CategoryView.swift
//  SwiftUIPractice
//
//  Created by 김수경 on 9/5/24.
//

import SwiftUI


struct MovieGenre: Hashable, Identifiable {
    let id = UUID()
    let genre: String
    let count: Int = .random(in: 1...100)
}

struct CategoryView: View {
    @State private var searchText: String = ""
    @State private var selectedGenre = [MovieGenre]()
    @State private var searchResult = [MovieGenre]()
    
    private var genres = ["액션", "코미디", "드라마", "공포", "SF", "판타지", "로맨스", "스릴러", "애니메이션", "다큐멘터리", "모험", "가족", "뮤지컬", "전쟁", "역사", "범죄", "서부극", "스포츠", "심리", "재난", "스파이", "어드벤처", "극복", "치유", "실화", "패러디", "컬트"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResult, id: \.id) { item in
                    NavigationLink {
                        
                    } label: {
                        Text("\(item.genre) (\(item.count))")
                    }
                }
            }
            .navigationTitle("영화 검색")
            .navigationBar {
                Text("")
            } trailing: {
                Button {
                    let randomData = genres.randomElement()!
                    selectedGenre.append(MovieGenre(genre: randomData))
                    searchResult.append(MovieGenre(genre: randomData))
                } label: {
                    Text("추가")
                }

            }
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            if searchText == "" {
                searchResult = selectedGenre
            } else {
                searchResult = selectedGenre.filter { $0.genre.contains(searchText) }
            }
        }
    }
}

#Preview {
    CategoryView()
}
