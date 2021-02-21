//
//  TestScrollView.swift
//  SwiftUIScrollview
//
//  Created by hai on 21/2/21.
//  Copyright © 2021 biorithm. All rights reserved.
//

import SwiftUI

struct TestScrollView: View {
    var body: some View {
        NavigationView{
            VStack{
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(0..<5){index in
                            NameCardView(img: "sea")
                                .padding(6)
                        }
                    }
                }
            }
        }
    }
}

struct NameCardView : View {
    var img = ""
    var body: some View {
        Image(img)
            .resizable()
            .scaledToFit()
            .frame(width: UIScreen.main.bounds.width - 30)
            .cornerRadius(20)
    }
}
