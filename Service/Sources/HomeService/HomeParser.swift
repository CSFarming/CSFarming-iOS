//
//  HomeParser.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import Foundation
import SwiftSoup
import BaseService

public protocol HomeParserInterface: AnyObject {
    func parse(_ html: String) -> [ContentElement]
}

public final class HomeParser: HomeParserInterface {
    
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
