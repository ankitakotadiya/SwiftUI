//
//  NewReleaseCell.swift
//  Spotify
//
//  Created by Ankita Kotadiya on 26/11/24.
//

import SwiftUI

struct NewReleaseCell: View {
    var imageURL: URL?
    var headline: String? = "New Release"
    var subheadline: String? = "Some Artist"
    var title: String? = "Some Title"
    var subtitle: String? = "Some Subtitle"
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 8) {
                AsyncImageView(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                }
                .frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 5) {
                    if let headline = headline {
                        Text(headline)
                            .font(.callout)
                            .foregroundStyle(Color.Custom.lightGray)
                            .lineLimit(1)
                    }
                    
                    if let subheadline = subheadline {
                        Text(subheadline)
                            .font(.headline)
                            .foregroundStyle(.white)
                            .lineLimit(1)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack(alignment: .top, spacing: 5) {
                AsyncImageView(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                }
                .frame(width: 100)
                .clipped()
                
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 8) {
                        if let title {
                            Text(title)
                                .foregroundStyle(.white)
                                .lineLimit(1)
                        }
                        
                        if let subtitle {
                            Text(subtitle)
                                .foregroundStyle(Color.Custom.lightGray)
                                .lineLimit(2)
                        }
                    }
                    .font(.callout)
                    
                    Spacer()
                    
                    HStack(alignment: .bottom) {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(Color.Custom.lightGray)
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "play.circle.fill")
                            .foregroundStyle(Color.white)
                            .font(.title)
                    }
                }
                .padding(.vertical, 8)
                .padding(.trailing, 16)
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.Custom.gray)
            )
        }
    }
}

//#Preview {
//    NewReleaseCell()
//}
