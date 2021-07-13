//
//  ArticleResponse.swift
//  NewsMvvmRxSwift
//
//  Created by Len van Zyl on 2021/07/13.
//

import Foundation

struct ArticleResponse: Decodable {
    let articles: [Article]
}

extension ArticleResponse {
    static var all: Resource<ArticleResponse> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=" + Commons.apiKey)!
        return Resource(url: url)
    }()
}
