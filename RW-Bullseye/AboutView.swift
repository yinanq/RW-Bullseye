//
//  AboutView.swift
//  RW-Bullseye
//
//  Created by Yinan Qiu on 10/26/19.
//  Copyright © 2019 Yinan. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            bgColor.edgesIgnoringSafeArea(.all)
            VStack {
                Text("🎯")
                    .font(.largeTitle)
                Text("This is Bull's Eye, that super complicated and sophisticated game from the ingenious Ray Wenderlich. This is Bull's Eye, that super complicated and sophisticated game from the ingenious Ray Wenderlich. This is Bull's Eye, that super complicated and sophisticated game from the ingenious Ray Wenderlich.").lineLimit(nil)
            }
            .foregroundColor(.white)
            .frame(maxWidth: 480)
        }
        .navigationBarTitle("About")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 812, height: 375))
    }
}
