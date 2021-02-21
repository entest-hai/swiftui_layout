//
//  TestDrawWideFrame.swift
//  SwiftUIScrollview
//
//  Created by hai on 21/2/21.
//  Copyright © 2021 biorithm. All rights reserved.
//

import SwiftUI

// Wide Rectangular With ScrollView and HStack
struct TestDrawSquare : View {
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                ScrollView(.horizontal){
                    HStack{
                        MySquare()
                            .stroke(lineWidth: 1.0)
                            .background(Color.blue)
                            .frame(width: UIScreen.main.bounds.width*5, height: 300)
                            .scaledToFit()
                            .padding()
                        
                    }
                    .padding()
                }
                Spacer()
            }
        .navigationBarTitle(Text("Draw"))
        }
    }
}

// Wide BadgeBackGround Width ScrollView and HStack
struct TestDrawWideFrame: View {
    var body: some View {
        NavigationView{
            ScrollView(.horizontal){
                HStack{
                    BadgeBackGround()
                        .scaledToFit()
                }
            }
            .navigationBarTitle(Text("Trends"))
            
        }
    }
}

struct BadgeBackGround : View {
    var body: some View {
        GeometryReader{ geometry in
            Path { path in
                let width: CGFloat = max(geometry.size.width, geometry.size.height)
                let height = width
                path.move(
                    to: CGPoint(
                        x: width * 0.95,
                        y: height * (0.20 + HexagonParameters.adjustment)
                    )
                )
                
                HexagonParameters.segments.forEach{segment in
                    path.addLine(
                        to: CGPoint(
                            x: width * segment.line.x,
                            y: height * segment.line.y
                        )
                    )
                    
                    path.addQuadCurve(
                        to: CGPoint(
                            x: width * segment.curve.x,
                            y: height * segment.curve.y
                        ),
                        control: CGPoint(
                            x: width * segment.control.x,
                            y: height * segment.control.y
                        )
                    )
                }
                
            }
            .fill(Color.blue)
        }
    }
}


struct HexagonParameters {
    struct Segment {
        let line: CGPoint
        let curve: CGPoint
        let control: CGPoint
    }
    
    static let adjustment: CGFloat = 0.085
    
    static let segments = [
        Segment(
            line:    CGPoint(x: 0.60, y: 0.05),
            curve:   CGPoint(x: 0.40, y: 0.05),
            control: CGPoint(x: 0.50, y: 0.00)
        ),
        Segment(
            line:    CGPoint(x: 0.05, y: 0.20 + adjustment),
            curve:   CGPoint(x: 0.00, y: 0.30 + adjustment),
            control: CGPoint(x: 0.00, y: 0.25 + adjustment)
        ),
        Segment(
            line:    CGPoint(x: 0.00, y: 0.70 - adjustment),
            curve:   CGPoint(x: 0.05, y: 0.80 - adjustment),
            control: CGPoint(x: 0.00, y: 0.75 - adjustment)
        ),
        Segment(
            line:    CGPoint(x: 0.40, y: 0.95),
            curve:   CGPoint(x: 0.60, y: 0.95),
            control: CGPoint(x: 0.50, y: 1.00)
        ),
        Segment(
            line:    CGPoint(x: 0.95, y: 0.80 - adjustment),
            curve:   CGPoint(x: 1.00, y: 0.70 - adjustment),
            control: CGPoint(x: 1.00, y: 0.75 - adjustment)
        ),
        Segment(
            line:    CGPoint(x: 1.00, y: 0.30 + adjustment),
            curve:   CGPoint(x: 0.95, y: 0.20 + adjustment),
            control: CGPoint(x: 1.00, y: 0.25 + adjustment)
        )
    ]
}

struct MySquare: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.size.width, y: 0))
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))
        path.addLine(to: CGPoint(x: 0, y: rect.size.height))
        path.addLine(to: CGPoint(x:0, y: 0))
        path.closeSubpath()
        return path
    }
}

