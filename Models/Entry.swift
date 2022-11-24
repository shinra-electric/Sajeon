//
//  dictionary.swift
//  HanDict
//
//  Created by シェイミ on 23/04/2020.
//  Copyright © 2020 シェイミ オコナー. All rights reserved.
//

import Foundation

// MARK: - Entry
struct Entry: Codable, Identifiable, Hashable {
        static func == (lhs: Entry, rhs: Entry) -> Bool {
            return lhs.word == rhs.word
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    
    var id = UUID().uuidString
    let word: String
    let romaja: String?
    let partOfSpeech: Pos
    let definitions: [Definition]?
    let conjugation: [String]?
    let notes: Notes?
    let confer: [String]?
    let tags: [Tag]?
    let hanja: String?
    let synonyms, relatedWords, antonyms, derivedTerms: [String]?
    
        private enum CodingKeys: String, CodingKey {
            case word
            case partOfSpeech = "pos"
            case definitions = "defs"
            case romaja
            case hanja
            case notes
            case synonyms = "syns"
            case tags
            case conjugation = "conj"
            case antonyms = "ants"
            case relatedWords = "rels"
            case confer = "cf"
            case derivedTerms = "ders"
        }
}

// MARK: - Def
struct Definition: Codable, Hashable {
    let definition: String
    let examples: [Example]?

    private enum CodingKeys: String, CodingKey {
        case definition = "def"
        case examples = "examples"
    }
}


// MARK: - Example
struct Example: Codable, Hashable {

    var example: String
    var transliteration, translation: String?

    private enum CodingKeys: String, CodingKey {
        case example = "example"
        case transliteration = "transliteration"
        case translation = "translation"
    }
}


enum Notes: Codable {
    case string(String)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Notes.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Notes"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}


enum Pos: String, Codable {
    case a = "a"
    case abbrev = "abbrev"
    case adv = "adv"
    case det = "det"
    case intj = "intj"
    case n = "n"
    case num = "num"
    case part = "part"
    case pref = "pref"
    case pron = "pron"
    case propn = "propn"
    case suf = "suf"
    case v = "v"
}

enum Tag: String, Codable {
    case ikB1 = "ik-b1"
    case topik1 = "topik1"
}




#if DEBUG

let example = Entry(word: "병원",
                    romaja: "byeong-won",
                    partOfSpeech: Pos(rawValue: "n")!,
                    definitions: [Definition(definition: "a hospital",
                                             examples: [
                                                Example(example: "당신은 돈복이 많군요.", transliteration: "Dangsineun donbogi mankunyo.", translation: "you are blessed with money and fortune."),
                                                Example(example: "나는 인복이 많다.")]
                                            ),
                                  Definition(definition: "fortune, blessing, luck", examples: [])],
                    conjugation: ["복무한다", "복무해", "복무해요", "복무합니다"],
                    notes: nil,
                    confer: ["굉장히", "매우"],
                    tags: [Tag(rawValue: "ik-b1")!, Tag(rawValue: "topik1")!],
                    hanja: "眼鏡",
                    synonyms: ["넷"],
                    relatedWords: ["친"],
                    antonyms: ["병"],
                    derivedTerms: ["거","게","걸","건"])



#endif
