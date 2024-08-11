//
//  DetailViewModel.swift
//  AppStoreProject
//
//  Created by 김수경 on 8/12/24.
//

import Foundation
import RxSwift

final class DetailViewModel {
    let appData: AppStoreResult

    init(_ appData: AppStoreResult) {
        self.appData = appData
    }
    
    var thumbnailImageUrl: URL? {
        URL(string: appData.artworkUrl100) 
    }
    var version: String {
        "버전 " + appData.version
    }
    var urlString: [URL?] {
        appData.screenshotUrls.map { URL(string: $0) }
    }
}
