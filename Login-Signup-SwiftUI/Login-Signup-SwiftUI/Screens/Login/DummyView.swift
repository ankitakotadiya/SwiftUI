//
//  DummyView.swift
//  Login-Signup-SwiftUI
//
//  Created by Ankita Kotadiya on 23/11/24.
//

import SwiftUI

struct DummyView: View {
    @EnvironmentObject private var router: Router<LoginFlow>
    @State var isPresent: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    isPresent = true
                }, label: {
                    Text("Click Me")
                })
            }
            .navigationTitle("Dummy")
        }
        .sheet(item: $router.sheet) { item in
            router.sheet = item
        }
            
    }
}


//#Preview {
//    DummyView()
//}
