//
//  RadioButtonView.swift
//  ProjetAppMobile
//
//  Created by user165000 on 3/18/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI

struct RadioButton: View {
    let text : String
    @Binding var boxes : [String:Bool]
    
    var body: some View {
        HStack{
            if boxes[text]! {
                HStack{
                    ZStack{
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 15, height: 15)
                        Circle()
                            .fill(Color.white)
                            .frame(width: 8, height: 8)
                    }
                    Text(text).font(.system(size : 15))
                }.onTapGesture {self.boxes[self.text]! = false}
            } else {
                HStack{
                    Circle().fill(Color.white)
                        .frame(width: 15, height: 15)
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    Text(text).font(.system(size : 15))
                }.onTapGesture {
                    for i in self.boxes.keys{
                        self.boxes[i] = (i == self.text)
                    }
                }
            }
        }
    }
}
