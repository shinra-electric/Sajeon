//
//  BannerView.swift
//  Handict3
//
//  Created by シェイミ on 23/11/2022.
//

import SwiftUI

struct BannerView: View {
//    @State private var isShowingFeatureSheet: Bool = false
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading) {
                
                
                Text("Sajeon")
                    .font(.system(.largeTitle, design: .serif, weight: .heavy))
                Text("Korean\nDictionary")
            }
            .lineLimit(2)
            .layoutPriority(1)
            .foregroundColor(Color.white)
            .font(.largeTitle)
            .fontWeight(.bold)
            
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 0) {
//                Button {
//                    isShowingFeatureSheet.toggle()
//                } label: {
//                    Image(systemName: "ellipsis.circle.fill")
//                }
//                .frame(maxWidth: .infinity, alignment: .trailing)
//                .foregroundColor(Color.white)
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .offset(x: -4, y: -8)
                
                Image(.launchScreenLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                    .offset(x: 16)
                
            }
        }
        .padding(.horizontal, 30)
        .padding(.bottom)
        .frame(height: 160)
//        .sheet(isPresented: $isShowingFeatureSheet) {
//            FeaturesView()
//                .presentationDetents([.medium])
//        }
    }
}

#Preview {
    BannerView()
}
