//
//  ProfileImageView.swift
//  Bumble
//
//  Created by Ankita Kotadiya on 28/11/24.
//

import SwiftUI

struct ProfileImageView: View {
    var percentageRemaining: Double = Double.random(in: 0...1)
    var imageURL: URL?
    var hasNewMessage: Bool = Bool.random()
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.Custom.gray, lineWidth: 1)
            
            Circle()
                .trim(from: 0, to: percentageRemaining)
                .stroke(Color.Custom.yellow, lineWidth: 4)
                .rotationEffect(.degrees(-90))
                .scaleEffect(x: -1, y: 1, anchor: .center)
            
            AsyncImageView(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipped()
            }
            .clipShape(Circle())
            .padding(8)
        }
        .frame(width: 75, height: 75)
        .overlay(alignment: .bottomTrailing) {
            ZStack {
                if hasNewMessage {
                    Circle()
                        .fill(Color.white)
                    
                    Circle()
                        .fill(Color.Custom.yellow)
                        .padding(3)
                }
            }
            .frame(width: 20, height: 20)
        }
    }
}

//#Preview {
//    ProfileImageView()
//}
