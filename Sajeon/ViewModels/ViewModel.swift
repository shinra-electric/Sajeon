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
    
    @Published var favourites = Set<Entry>() {
        didSet {
            saveFavourites()
        }
    }
    @Published var recents = Deque<Entry>() {
        didSet {
            saveRecents()
        }
    }
    
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
    
    // UserDefaults keys
    private let favouritesKey = "favourites"
    private let recentsKey = "recents"
    
    init() {
        loadFavourites()
        loadRecents()
    }
    
    // MARK: - Favourites Persistence
    private func saveFavourites() {
        do {
            let data = try JSONEncoder().encode(Array(favourites))
            UserDefaults.standard.set(data, forKey: favouritesKey)
        } catch {
            print("Failed to save favourites: \(error)")
        }
    }
    
    private func loadFavourites() {
        guard let data = UserDefaults.standard.data(forKey: favouritesKey) else { return }
        do {
            let decoded = try JSONDecoder().decode([Entry].self, from: data)
            favourites = Set(decoded)
        } catch {
            print("Failed to load favourites: \(error)")
        }
    }
    
    // MARK: - Recents Persistence
    private func saveRecents() {
        do {
            let data = try JSONEncoder().encode(Array(recents))
            UserDefaults.standard.set(data, forKey: recentsKey)
        } catch {
            print("Failed to save recents: \(error)")
        }
    }
    
    private func loadRecents() {
        guard let data = UserDefaults.standard.data(forKey: recentsKey) else { return }
        do {
            let decoded = try JSONDecoder().decode([Entry].self, from: data)
            recents = Deque(decoded)
        } catch {
            print("Failed to load recents: \(error)")
        }
    }
    
    func addToRecents(word: Entry) {
        if !recents.contains(word) {
            if recents.count < numberOfRecentViews {
                recents.prepend(word)
            } else {
                recents.removeLast()
                recents.prepend(word)
            }
        } else {
            // print("Word not added to deque. Duplicate. ")
        }
        // saveRecents() is automatically called by didSet on recents
    }

    func toggle(favourite word: Entry) {
        if favourites.contains(word) {
            favourites.remove(word)
        } else {
            favourites.insert(word)
        }
        // saveFavourites() is automatically called by didSet
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
