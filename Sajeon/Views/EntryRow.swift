//
//  EntryRow.swift
//  HanDict
//
//  Created by シェイミ on 04/05/2020.
//  Copyright © 2020 シェイミ オコナー. All rights reserved.
//

import SwiftUI

struct EntryRow: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var entry: Entry
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(entry.word)
                        .font(.title)
                        .layoutPriority(1)
                    Text(entry.romaja ?? "")
                        .font(.callout)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                        
                }
                
                Text(viewModel.getDefinitionsForEntryRow(entry: entry))
                    .lineLimit(1)
                
            }
            Spacer()
            
            VStack {
                
                
            }
        }
    }
    
}



struct EntryRow_Previews: PreviewProvider {
    static var previews: some View {
        EntryRow(entry: example)
            .environmentObject(ViewModel())
    }
}
