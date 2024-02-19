//
//  FeaturesView.swift
//  Handict3
//
//  Created by シェイミ on 23/11/2022.
//

import SwiftUI

struct FeaturesView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 140))
    ]
    
    var body: some View {
        ZStack {
//            Color("naverblue")
//                .ignoresSafeArea(.all)
            
             LazyVGrid(columns: columns, spacing: 20) {
                 ForEach(viewModel.availableFeatures, id: \.self) { item in
                     item
                 }
             }
             .padding(.horizontal)
         }
         
    }
}

#Preview {
    FeaturesView()
        .environmentObject(ViewModel())
}
