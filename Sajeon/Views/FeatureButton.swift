//
//  FeatureButton.swift
//  Handict3
//
//  Created by シェイミ on 23/11/2022.
//

import SwiftUI

struct FeatureButton: View, Hashable {
    var icon: String
    var title: String
    
    var body: some View {
        Button {
            //
        } label: {
            Label(title, systemImage: icon)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(width: 136)
        }
        .buttonStyle(GradientButtonStyle())
    }
}

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [.sajeonBlue, Color.indigo]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
            .shadow(color: .black, radius: 6, x: 4, y: 5)
    }
}

#Preview {
    FeatureButton(icon: "bookmark.fill", title: "Bookmark")
}
