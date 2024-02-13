//
//  ViewModel.swift
//  Handict3
//
//  Created by シェイミ on 15/11/2022.
//

import Foundation
import DequeModule

class ViewModel: ObservableObject {
    let dictionary = Bundle.main.decode([Entry].self, from: "kedict.json")
    @Published var favourites = Set<Entry>()
    @Published var recents = Deque<Entry>()
    
    @Published var showFavoritesOnly = false
    
    let availableFeatures: [FeatureButton] = [
        FeatureButton(icon: "a.square", title: "English Dict"),
        FeatureButton(icon: "bird", title: "Papago"),
        FeatureButton(icon: "highlighter", title: "Open Dict"),
        FeatureButton(icon: "rectangle.3.group.bubble.left", title: "Accentia"),
        FeatureButton(icon: "questionmark.bubble", title: "Quiz"),
        FeatureButton(icon: "speaker.wave.2.bubble.left", title: "Conversation")
    ]
    
    let numberOfRecentViews = 6
    func addToRecents(word: Entry) {
        if !recents.contains(word) ? true : false {
            if recents.count < numberOfRecentViews {
                recents.prepend(word)
            } else {
                recents.removeLast()
                recents.prepend(word)
            }
        } else {
//            print("Word not added to deque. Duplicate. ")
        }
    }
    

    func toggle(favourite word: Entry) {
        if favourites.contains(word) {
            favourites.remove(word)
        } else {
            favourites.insert(word)
        }
    }
    
    func isContainedInDictionary(word searchTerm: String) -> Bool {
        let hangulFilter = dictionary.filter { $0.word.contains(searchTerm) }
        
        return hangulFilter.isEmpty ? false : true
    }
    
    func getDefinitionsForEntryRow(entry: Entry) -> String {
        guard let definitions = entry.definitions else { return "No definition found"}
        var definitionsList = ""
        
        for item in definitions {
            definitionsList.append(item.definition + ", ")
        }
  
        // Remove the last character. Need to do twice.
        definitionsList.remove(at: definitionsList.index(before: definitionsList.endIndex))
        definitionsList.remove(at: definitionsList.index(before: definitionsList.endIndex))
        
        return definitionsList
    }
    
    
    
    
    func getPOS(pos: String) -> String {
        switch(pos) {
            case "a": return "Adjective"
            case "abbrev": return "Abbreviation"
            case "adv": return "Adverb"
            case "det": return "Determiner"
            case "intj": return "Interjection"
            case "n": return "Noun"
            case "num": return "Number"
            case "part": return "Particle"
            case "pref": return "Prefix"
            case "pron": return "Pronoun"
            case "propn": return "Proper Noun"
            case "suf": return "Suffix"
            case "v": return "Verb"
            default: return ""
        }
    }
}
