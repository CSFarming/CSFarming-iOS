//
//  GitHubRootParser.swift
//
//
//  Created by 홍성준 on 12/9/23.
//

import Foundation
import SwiftSoup

public protocol GitHubRootParserInterface: AnyObject {
    func parse(_ html: String) -> [ContentElement]
}

public final class GitHubRootParser: GitHubRootParserInterface {
    
    public init() {}
    
    public func parse(_ html: String) -> [ContentElement] {
        do {
            let document: Document = try SwiftSoup.parse(html)
            let elements = try document.getElementsByClass("js-navigation-open")
                .compactMap { $0.contentElement() }
            return elements
        } catch {
            return []
        }
    }
    
}

private extension Element {
    
    func contentElement() -> ContentElement? {
        guard let title = try? attr("title"),
              let path = try? attr("href")
        else {
            return nil
        }
        return ContentElement(title: title, path: path)
    }
    
}
