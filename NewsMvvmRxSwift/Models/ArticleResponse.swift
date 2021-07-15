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
