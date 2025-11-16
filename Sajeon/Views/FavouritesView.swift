//
//  FavouritesView.swift
//  Handict3
//
//  Created by シェイミ on 15/11/2022.
//

import SwiftUI

struct FavouritesView: View {
    @State private var searchTerm: String = ""
    @EnvironmentObject var viewModel: ViewModel    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.sajeonBlue)
                    .ignoresSafeArea(.container, edges: .vertical)

                VStack(alignment: .leading, spacing: 0) {
                    BannerView()
                    
                    Text("Favourites")
                        .font(.system(.title, weight: .heavy))
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                    
                    if viewModel.favourites.isEmpty {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text("Mark a word as a favourite to have it appear here")
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 160)
                                    .padding(.bottom, 200)
                                Spacer()
                            }
                            Spacer()
                        }
                    } else {
                        List {
                            ForEach(viewModel.dictionary.filter { viewModel.favourites.contains($0) }, id: \.id) { item in
                                NavigationLink(destination: EntryView(entry: item)) {
                                    EntryRow(entry: item)
                                }
                                
                                .swipeActions {
                                    Button {
                                        viewModel.toggle(favourite: item)
                                    } label: {
                                        if viewModel.favourites.contains(item) {
                                            Label("Remove Favourite", systemImage: "star.slash")
                                        } else {
                                            Label("Add Favourite", systemImage: "star")
                                        }
                                    }
                                    .tint(.sajeonBlue)
                                }
                            }
                            
                        }
                        .scrollContentBackground(.hidden)
                        .scrollIndicators(.hidden)
                    }
                    Spacer()
                }
                .padding(.top)
            }
            .navigationTitle("Favourites")
            .navigationBarHidden(true)
        }
        .accentColor(.white)
    }
}

#Preview {
    FavouritesView()
        .environmentObject(ViewModel())
}
