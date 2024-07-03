//
//  Date+Extension.swift
//  Todo
//
//  Created by 김수경 on 7/4/24.
//

import Foundation

extension Date {
    
    enum dateFormat: String {
        case ymd = "yyyy.MM.dd"
    }
    
    func ymdToString(_ format: dateFormat) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format.rawValue
        
        return dateFormatter.string(from: self)
    }
    
}
