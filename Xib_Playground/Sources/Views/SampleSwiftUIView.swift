//
//  SampleSwiftUIView.swift
//  Xib_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2023/09/28.
//  Copyright (c) 2023 ReNKCHANNEL. All rihgts reserved.
//

import SwiftUI

struct SampleSwiftUIView: View {
    @State var dismissAction: (() -> Void)

    var body: some View {
        VStack {
            closeButton
            sampleView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(12)
        .background(
            Color.black
                .opacity(0.5)
                .ignoresSafeArea()
        )
        .onTapGesture {
            dismissAction()
        }
    }

    var closeButton: some View {
        HStack {
            Spacer()
            Button(action: dismissAction) {
                Asset.Assets.imgHeadBack.swiftUIImage
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: 40, height: 40)
            .padding(2)
        }
    }

    var sampleView: some View {
        VStack(spacing: 16) {
            Text("This is SwiftUI View!!!")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
            Asset.Assets.imgApple.swiftUIImage
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 80)
            mainCloseButton
        }
        .padding(20)
        .background(.white)
        .frame(maxWidth: .infinity)
        .cornerRadius(12)
    }

    var mainCloseButton: some View {
        Button(action: {
            dismissAction()
        }, label: {
            Text("Close")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        })
        .background(Asset.Colors.mainColor.swiftUIColor)
        .cornerRadius(80)
        .frame(height: 56)
    }
}

struct SampleSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SampleSwiftUIView(dismissAction: {})
    }
}
