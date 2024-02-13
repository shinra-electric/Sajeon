//
//  EntryView.swift
//  HanDict
//
//  Created by シェイミ on 04/05/2020.
//  Copyright © 2020 シェイミ オコナー. All rights reserved.
//

import SwiftUI

struct EntryView: View {
    @EnvironmentObject var viewModel: ViewModel
    var entry: Entry
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section(header: Text("")) {
                    HStack {
                        Text("Romaja: ")
                        Text(entry.romaja ?? "")
                    }
                    
                    HStack {
                        Text("part of speech: ")
                        Text(viewModel.getPOS(pos: entry.partOfSpeech.rawValue))
                    }
                    
                    if entry.hanja != nil {
                        HStack {
                            Text("Hanja: ")
                            Text(entry.hanja ?? "N/A")
                        }
                    }
                }
                
                
                
                if let definitions = entry.definitions {
                    Section(header: Text("Meaning")) {
                        ForEach(definitions, id: \.self) { def in
                            Text(def.definition)
                        }
                    }
                }
                
                
                if let conjugation = entry.conjugation  {
                    Section(header: Text("Conjugation")) {
                        ForEach(conjugation, id: \.self) { conj in
                            Text(conj)
                        }
                    }
                }
                
                //                if let notes = entry.notes {
                //                    Section(header: Text("Notes")) {
                //                        if notes is String {
                //                            Text(notes)
                //                        }
                //
                //                    }
                //                }
                
                
            }
            .navigationTitle(entry.word)
            .listStyle(InsetGroupedListStyle())
        }
        .scrollContentBackground(.hidden)
        .background(Color("naverblue"), ignoresSafeAreaEdges: .top)
    }
       
}


struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(entry: example)
            .environmentObject(ViewModel())
    }
}
