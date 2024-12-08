//
//  RecentChatView.swift
//  Bumble
//
//  Created by Ankita Kotadiya on 28/11/24.
//

import SwiftUI

struct RecentChatView: View {
    var imageURL: URL?
    var isMove: Bool = Bool.random()
    var userName: String = "Terry"
    var aboutMe: String = "Some Message"
    
    var body: some View {
        HStack(spacing: 10) {
            ProfileImageView(imageURL: imageURL)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 5) {
                    Text(userName)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if isMove {
                        Text("YOUR MOVE")
                            .font(.footnote)
                            .lineLimit(1)
                            .padding(4)
                            .background {
                                Capsule()
                                    .fill(Color.Custom.yellow)
                            }
                    }
                }
                .foregroundStyle(Color.Custom.black)
                
                Text(aboutMe)
                    .font(.callout)
                    .foregroundStyle(Color.Custom.gray)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(5)
    }
}

//#Preview {
//    RecentChatView()
//}
