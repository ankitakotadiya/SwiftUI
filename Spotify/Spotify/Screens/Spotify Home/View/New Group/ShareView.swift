//
//  ShareView.swift
//  Spotify
//
//  Created by Ankita Kotadiya on 27/11/24.
//

import SwiftUI

struct ShareView: View {
    var body: some View {
        
        HStack(alignment: .center, spacing:0) {
            HStack {
                Group {
                    Image(systemName: "plus.circle")
                        .font(.callout)
                        .foregroundStyle(Color.Custom.lightGray)
                    
                    Image(systemName: "arrow.down.circle")
                        .font(.callout)
                        .foregroundStyle(Color.Custom.lightGray)
                    
                    Image(systemName: "square.and.arrow.up")
                        .font(.callout)
                        .foregroundStyle(Color.Custom.lightGray)
                    
                    Image(systemName: "ellipsis")
                        .font(.callout)
                        .foregroundStyle(Color.Custom.lightGray)
                }
                .padding(8)
            }
            .offset(x: -8)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            
            HStack {
                Image(systemName: "shuffle")
                    .font(.title3)
                    .foregroundStyle(Color.Custom.green)
                
                Image(systemName: "play.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(Color.Custom.green)
            }
            
        }
    }
}

//#Preview {
//    ShareView()
//}
