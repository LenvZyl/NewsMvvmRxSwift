//
//  ArticleViewModel.swift
//  NewsMvvmRxSwift
//
//  Created by Len van Zyl on 2021/07/13.
//

import Foundation
import RxCocoa
import RxSwift


struct ArticleViewModel {
    let article: Article
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    var title: Observable<String> {
        return Observable<String>.just(article.title)
    }
    var description: Observable<String> {
        return Observable<String>.just(article.description ?? "")
    }
}
