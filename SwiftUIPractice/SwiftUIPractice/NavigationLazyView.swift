//
//  NavigationLazyView.swift
//  SwiftUIPractice
//
//  Created by 김수경 on 9/5/24.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    
    let closure: () -> Content
    
    var body: some View {
        closure()
    }
    
    init(_ closure: @autoclosure @escaping () -> Content) {
        self.closure = closure
    }
}
