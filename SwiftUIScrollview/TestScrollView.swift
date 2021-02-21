//
//  TestScrollView.swift
//  SwiftUIScrollview
//
//  Created by hai on 21/2/21.
//  Copyright © 2021 biorithm. All rights reserved.
//

import SwiftUI
import CoreGraphics

struct TestScrollView: View {
    var body: some View {
        NavigationView{
            VStack{
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(0..<5){index in
                            VStack{
                                NameCardView(img: "sea")
                                Text("\(index)")
                            }
                            .padding()
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


struct TestWidgeImage : View {
    var body: some View {
        NavigationView {
            VStack{
                ScrollView(.horizontal){
                    HStack{
                        Image("sea")
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
            .navigationBarTitle(Text("Wide"))
        }
    }
}

