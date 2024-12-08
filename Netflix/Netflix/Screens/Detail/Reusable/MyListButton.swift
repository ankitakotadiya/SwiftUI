//
//  MyListButton.swift
//  Netflix
//
//  Created by Ankita Kotadiya on 30/11/24.
//

import SwiftUI

struct MyListButton: View {
    var isMyList: Bool = false
    var onPressMyList: (() -> Void)?
    
    var body: some View {
        Button(action: {
            onPressMyList?()
        }, label: {
            VStack(spacing: 8) {
                Image(systemName: isMyList ? "checkmark" : "plus")
                    .rotationEffect(.degrees(isMyList ? 0 : 180))
                
                Text("My List")
                    .font(.callout)
                    .foregroundStyle(Color.Custom.lightGray)
            }
            .font(.title)
        })
        .foregroundStyle(.white)
        .padding(8)
        .animation(.bouncy, value: isMyList)
    }
}

//#Preview {
//    MyListButton()
//}
