//
//  PlotUA.swift
//  SwiftUIScrollview
//
//  Created by hai on 21/2/21.
//  Copyright © 2021 biorithm. All rights reserved.
//

import SwiftUI

struct PlotUA: View {
    var body: some View {
        VStack{
            VStack{
                Spacer()
                Text("Real Time")
                    .fontWeight(.bold)
                    .padding()
            }
            .frame(width: UIScreen.main.bounds.width, height: 80)
            .background(Color.purple)
            .foregroundColor(Color.white)
            
            // frequency and duration
            HStack{
                Text("1-hour contraction stats")
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                Spacer()
            }.padding()
            
            HStack{
                VStack{
                    Text("9:18")
                        .font(.system(size: 40))
                    Text("frequency")
                }
                Spacer()
                Divider()
                    .frame(height: 70)
                Spacer()
                VStack{
                    Text("1:01")
                        .font(.system(size: 40))
                    Text("duration")
                    
                }
            }
            .padding([.leading, .trailing], 40)
            
            // contraction pattern
            VStack(alignment: .center){
                Text("1-hour contraction pattern")
                    .font(.system(size: 15))
                ContractionPattern()
                    .frame(width: UIScreen.main.bounds.width - 20, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 1)
                            .background(Color.green.opacity(0.1)))
            }.padding()
            
            // Plot UA contraction minutes scale
            Spacer()
            
            ScrollView(.horizontal){
                HStack{
                    ContractionPatternZoomIn()
                        .frame(width:UIScreen.main.bounds.width * 6.0, height: 400)
                        .scaledToFit()
                }
            }
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ContractionPattern : View {
    @State var contractions : [Contraction] = [
        Contraction(start: 5/60.0, end: 8/60.0),
        Contraction(start: 18/60.0, end: 22/60.0),
        Contraction(start: 32/60.0, end: 34/60.0),
        Contraction(start: 37/60.0, end: 39/60.0)
    ]
    let width : CGFloat = UIScreen.main.bounds.width
    let height :CGFloat = CGFloat(40.0)
    
    var body: some View {
        Path { path in
            contractions.forEach{ contraction in
                path.move(to: CGPoint(x: CGFloat(contraction.start) * width, y: 0.0))
                path.addLine(to: CGPoint(x: CGFloat(contraction.end) * width, y: 0.0))
                path.addLine(to: CGPoint(x: CGFloat(contraction.end) * width, y: height))
                path.addLine(to: CGPoint(x: CGFloat(contraction.start) * width, y: height))
                path.addLine(to: CGPoint(x: CGFloat(contraction.start) * width, y: 0.0))
            }
        }
        .fill(Color.green)
    }
}


struct ContractionPatternZoomIn : View {
    @State var contractions : [Contraction] = [
        Contraction(start: 5/60.0, end: 8/60.0),
        Contraction(start: 18/60.0, end: 22/60.0),
        Contraction(start: 32/60.0, end: 34/60.0),
        Contraction(start: 37/60.0, end: 39/60.0)
    ]
    
    let width : CGFloat = UIScreen.main.bounds.width
    let height : CGFloat = 300
    
    var body: some View {
        ZStack{
            Path { path in
                path.move(to: CGPoint(x: 0.0, y: 0.0))
                path.addLine(to: CGPoint(x: width * 6, y: 0))
                path.addLine(to: CGPoint(x: width * 6, y: height))
                path.addLine(to: CGPoint(x: 0.0, y: height))
                path.closeSubpath()
                
                // ten minute
                for index in 0...59 {
                    let offset: CGFloat = CGFloat(index) * width / 10.0
                    path.move(to: CGPoint(x: offset, y: 0))
                    path.addLine(to: CGPoint(x:offset, y: height))
                }
            }
            .stroke(Color.black, lineWidth: 0.5)
            
            // contraction
            Path {path in
                contractions.forEach{ contraction in
                    path.move(to: CGPoint(x: CGFloat(contraction.start) * 6 * width, y: 0.0))
                    path.addLine(to: CGPoint(x: CGFloat(contraction.end) * 6 * width, y: 0.0))
                    path.addLine(to: CGPoint(x: CGFloat(contraction.end) * 6 * width, y: height))
                    path.addLine(to: CGPoint(x: CGFloat(contraction.start) * 6 * width, y: height))
                    path.addLine(to: CGPoint(x: CGFloat(contraction.start) * 6 * width, y: 0.0))
                }
            }
            .fill(Color.blue.opacity(0.5))
        }
    }
}

struct Contraction {
    let start: Double
    let end: Double
}
