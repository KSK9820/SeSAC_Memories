//
//  SearchBitCoinView.swift
//  SwiftUIPractice
//
//  Created by 김수경 on 9/3/24.
//

import SwiftUI

struct SearchBitCoinView: View {
    @State private var searchText: String = ""
    @State private var totalData: Markets = []
    @State private var searchData: Markets = []
    
    var body: some View {
        NavigationStack {
            searchListView()
               
            .navigationTitle("Search")
        }
        .searchable(text: $searchText)
        .task {
            do {
                totalData = try await UpbitAPI.fetchAllMarket()
                searchData = totalData
            } catch {
                print(error)
            }
        }
        .onChange(of: searchText) { oldValue, newValue in
            searchData = totalData.filter { $0.englishName.contains(newValue) }
            if newValue == "" {
                searchData = totalData
            }
        }
        
    }
    
    func searchListView() -> some View {
        List {
            ForEach($searchData, id: \.self) { item in
                HStack {
                    NavigationLink(destination: NextView(item: item.wrappedValue)) {
                        SearchResultView(item: item.wrappedValue)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
        }
    }
    
    
}

struct SearchResultView: View {
    @State var status = false
    var item: Market
    
    
    var body: some View {
        HStack(spacing: 20, content: {
            Image(systemName: "heart.fill")
            VStack(alignment: .leading) {
                Text(item.englishName)
                Text(item.market)
            }
            Spacer()
            Button {
                status.toggle()
            } label: {
                Image(systemName: status ? "star.fill" : "star")
                    .padding()
            }
            
        })
    }
}

struct NextView: View {
    var item: Market
    
    var body: some View {
        Text(item.englishName)
    }
}

#Preview {
    SearchBitCoinView()
}
