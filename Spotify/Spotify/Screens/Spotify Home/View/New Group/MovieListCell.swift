//
//  MovieListCell.swift
//  Spotify
//
//  Created by Ankita Kotadiya on 27/11/24.
//

import SwiftUI

struct MovieListCell: View {
    var imageURL: URL?
    var title: String? = "Some Title"
    var subTitle: String? = "Some Subtitle"
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            AsyncImageView(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            }
            .frame(width: 50, height: 50)
            .clipped()
            
            VStack(alignment: .leading, spacing: 5) {
                if let title {
                    Text(title)
                        .font(.body)
                        .foregroundStyle(.white)
                }
                
                if let subTitle {
                    Text(subTitle)
                        .font(.callout)
                        .foregroundStyle(Color.Custom.lightGray)
                }
            }
            .lineLimit(1)
            .frame(maxWidth: .infinity)

            Image(systemName: "ellipsis")
                .foregroundStyle(Color.Custom.lightGray)
                .font(.callout)
                .frame(width: 20, height: 20)
        }
    }
}

//#Preview {
//    MovieListCell()
//}
