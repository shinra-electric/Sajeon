//
//  SearchView.swift
//  Handict3
//
//  Created by シェイミ on 15/11/2022.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State private var searchTerm: String = ""
    
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color("naverblue")
                    .ignoresSafeArea(.container, edges: .top)
                
                VStack(spacing: 0) {
                    BannerView()
                    
                    SearchbarView(text: $searchTerm)
                        .padding(.bottom)
                    
                    List {
                        if !viewModel.isContainedInDictionary(word: searchTerm) {
                            RecentsView()
                            
                        } else {
                            DictionarySearchView(searchTerm: searchTerm)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.hidden)
                }
                .padding(.top)
            }
            .navigationTitle("Search")
            .navigationBarHidden(true)
        }
        .accentColor(.white)

        
    }
}



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(ViewModel())
    }
}



struct RecentsView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        Section(header: viewModel.recents.isEmpty ? Text("") : Text("Recent Searches")
            .foregroundColor(.white))
        {
            ForEach(viewModel.recents, id: \.id) { item in
                NavigationLink(destination: EntryView(entry: item)) {
                    EntryRow(entry: item)
                        .swipeActions {     // Swipe actions need to be on the Navigation link if it's there, otherwise on the row is ok.
                            Button {
                                viewModel.toggle(favourite: item)
                            } label: {
                                if viewModel.favourites.contains(item) {
                                    Label("Remove Favourite", systemImage: "star.slash")
                                } else {
                                    Label("Add Favourite", systemImage: "star")
                                }
                            }
                            .tint(Color("naverblue"))
                        }
                }
            }
        }
        
    }
}

struct DictionarySearchView: View {
    @EnvironmentObject var viewModel: ViewModel
    var searchTerm: String
    
    var body: some View {
        Section(header: Text("Exact Matches").foregroundColor(.white)) {
            ForEach(viewModel.dictionary.filter { $0.word.starts(with: searchTerm) }, id: \.id) { item in
                NavigationLink(destination: EntryView(entry: item).onAppear() {
                    viewModel.addToRecents(word: item)
                }) {
                    EntryRow(entry: item)
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
                            .tint(Color("naverblue"))
                        }
                }
            }
        }
        
        Section(header: Text("Related Terms").foregroundColor(.white)) {
            ForEach(viewModel.dictionary.filter { $0.word.contains(searchTerm)
                && !$0.word.starts(with: searchTerm) }, id: \.id) { item in
                NavigationLink(destination: EntryView(entry: item).onAppear() {
                    viewModel.addToRecents(word: item)
                }) {
                    EntryRow(entry: item)
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
                            .tint(Color("naverblue"))
                        }
                }
            }
        }
        
        
        
    }
}
