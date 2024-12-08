import SwiftUI

struct CardView: View {
    var user: User
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                LazyVStack(spacing: 0) {
                    headerCell(for: geo.size)
                        .frame(height: geo.size.height)
                    
                    aboutmeSection
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    myInterest
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    ForEach(user.userImages, id: \.self) { image in
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width)
                    }
                    
                    locationSection
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    footerSection
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                }
            }
            .cornerRadius(10)
            .background(Color.Custom.lightYellow)
            .overlay(alignment: .bottomTrailing) {
                Image(systemName: "hexagon.fill")
                    .font(.largeTitle)
                    .foregroundStyle(Color.Custom.yellow)
                    .overlay {
                        Image(systemName: "star.fill")
                            .font(.title3)
                            .foregroundStyle(Color.Custom.black)
                            .fontWeight(.medium)
                    }
                    .padding()
            }
        }
    }
    
    private func sectionTitle(for title: String) -> some View {
        Text(title)
            .font(.body)
            .foregroundStyle(Color.Custom.gray)
    }
    
    private func acceptRejectButton(for imageName: String) -> some View {
        Circle()
            .fill(Color.Custom.yellow)
            .overlay {
                Image(systemName: imageName)
                    .font(.title)
                    .fontWeight(.semibold)
            }
            .frame(width: 50, height: 50)
    }
    
    private var footerSection: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                acceptRejectButton(for: "xmark")
                Spacer()
                acceptRejectButton(for: "checkmark")
            }
            
            Text("Hide and Report")
                .font(.headline)
                .foregroundStyle(Color.Custom.gray)
                .padding(8)
                .frame(alignment: .center)
        }
    }
    
    private var locationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "mappin.circle.fill")
                Text(user.firstName + "'s Location")
            }
            .font(.body)
            .fontWeight(.medium)
            .foregroundStyle(Color.Custom.gray)
            
            Text("10 miles away")
                .font(.headline)
                .foregroundStyle(Color.Custom.black)
            
            InterestPillView(emoji: "🇺🇸" ,text: "Lives in \(user.address?.city ?? "Newyork"), \(user.address?.stateCode ?? "NY")")
        }
    }
    
    private var myInterest: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 8) {
                sectionTitle(for: "My Basics")
                InterestPillGridView(interests: user.basics)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                sectionTitle(for: "My Interests")
                InterestPillGridView(interests: user.interests)
            }
        }
    }
    
    private var aboutmeSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionTitle(for: "About Me")
            
            Text(user.aboutme)
                .font(.headline)
                .foregroundStyle(Color.Custom.black)
            
            HStack(spacing:4) {
                HeartView()
                
                Text("Send a Compliment")
                    .font(.body)
                    .foregroundStyle(Color.Custom.black)
            }
            .padding(.horizontal, 10)
            .background {
                Capsule()
                    .fill(Color.Custom.yellow)
            }
        }
    }
    
    private func headerCell(for geo: CGSize) -> some View {
        ZStack(alignment: .bottomLeading) {
            
            Image(user.userImage)
                .resizable()
                .scaledToFill()
                .frame(width: geo.width, height: geo.height)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("\(user.firstName), \(user.age)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                HStack(spacing: 4) {
                    Image(systemName: "suitcase")
                        .frame(width: 30, height: 30)
                    Text("Working as \(user.company?.title ?? "Some Job")")
                        .lineLimit(1)
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "graduationcap")
                        .frame(width: 30, height: 30)
                    Text("\(user.university ?? "Graduate Degree")")
                        .lineLimit(1)
                }
                HeartView()
            }
            .padding(24)
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                LinearGradient(
                    colors: [Color.Custom.black.opacity(0), Color.Custom.black.opacity(0.6), Color.Custom.black.opacity(0.6)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
        }
    }
}

//#Preview {
//    CardView()
//}
