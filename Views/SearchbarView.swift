//
//  SearchbarView.swift
//  Handict3
//
//  Created by シェイミ on 18/11/2022.
//

import SwiftUI

struct SearchbarView: View {
    @Binding var text: String
        
    @State private var isEditing = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            
            TextField("Search...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .focused($isFocused)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.text = ""
                                isFocused = false
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal)
            
                .onTapGesture {
                    self.isEditing = true
                }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchbarView(text: .constant(""))
    }
}
