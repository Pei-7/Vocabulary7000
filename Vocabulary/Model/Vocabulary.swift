//
//  Vocabulary.swift
//  Vocabulary
//
//  Created by 陳佩琪 on 2023/8/14.
//

import Foundation

struct Vocabulary: Codable {
    var letterCount: Int
    var word: String
    var definitions: [Definition]
}

struct Definition: Codable {
    var text: String
    var partOfSpeech: String
}
