//
//  Model.swift
//  StubbyEditor
//
//  Created by Andras Olah on 2025. 03. 29..
//

import Foundation

struct StubbyEntry: Codable, Identifiable {
    var id = UUID()
    var request: StubbyRequest
    var response: [StubbyResponse]

    enum CodingKeys: String, CodingKey {
        case request
        case response
    }
}

struct StubbyRequest: Codable {
    var url: String
    var method: String
    var query: [String: String]?  // optional
    var post: String?             // optional
}

struct StubbyResponse: Codable {
    var status: Int
    var headers: [String: String]?
    var file: String?
    var latency: Int?
}
