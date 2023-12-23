//
//  Theme+.swift
//
//
//  Created by 홍성준 on 12/23/23.
//

import SwiftUI
import MarkdownUI
import DesignKit

extension Theme {
    
    public static let csFarming = Theme()
        .text {
            ForegroundColor(.text)
            BackgroundColor(.background)
            FontSize(17)
        }
        .code {
            FontFamilyVariant(.monospaced)
            FontSize(.em(0.85))
            BackgroundColor(.secondaryBackground)
        }
        .strong {
            FontWeight(.bold)
        }
        .link {
            ForegroundColor(.link)
        }
        .heading1 { configuration in
            VStack(alignment: .leading, spacing: 0) {
                configuration.label
                    .relativePadding(.bottom, length: .em(0.3))
                    .relativeLineSpacing(.em(0.125))
                    .markdownMargin(top: 40, bottom: 20)
                    .markdownTextStyle {
                        FontWeight(.bold)
                        FontSize(.em(2))
                    }
                Divider().overlay(Color.divider)
            }
        }
        .heading2 { configuration in
            VStack(alignment: .leading, spacing: 0) {
                configuration.label
                    .relativePadding(.bottom, length: .em(0.3))
                    .relativeLineSpacing(.em(0.125))
                    .markdownMargin(top: 40, bottom: 20)
                    .markdownTextStyle {
                        FontWeight(.bold)
                        FontSize(.em(1.5))
                    }
                Divider().overlay(Color.divider)
            }
        }
        .heading3 { configuration in
            VStack(alignment: .leading, spacing: 5) {
                configuration.label
                    .relativeLineSpacing(.em(0.125))
                    .markdownMargin(top: 30, bottom: 20)
                    .markdownTextStyle {
                        FontWeight(.semibold)
                        FontSize(.em(1.25))
                    }
                Divider().overlay(Color.secondaryDivider)
            }
            
        }
        .heading4 { configuration in
            configuration.label
                .relativeLineSpacing(.em(0.125))
                .markdownMargin(top: 30, bottom: 20)
                .markdownTextStyle {
                    FontWeight(.semibold)
                }
        }
        .heading5 { configuration in
            configuration.label
                .relativeLineSpacing(.em(0.125))
                .markdownMargin(top: 30, bottom: 20)
                .markdownTextStyle {
                    FontWeight(.semibold)
                    FontSize(.em(0.875))
                }
        }
        .heading6 { configuration in
            configuration.label
                .relativeLineSpacing(.em(0.125))
                .markdownMargin(top: 30, bottom: 20)
                .markdownTextStyle {
                    FontWeight(.semibold)
                    FontSize(.em(0.85))
                    ForegroundColor(.tertiaryText)
                }
        }
        .paragraph { configuration in
            configuration.label
                .fixedSize(horizontal: false, vertical: true)
                .relativeLineSpacing(.em(0.25))
                .markdownMargin(top: 0, bottom: 20)
        }
        .blockquote { configuration in
            HStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.border)
                    .relativeFrame(width: .em(0.2))
                configuration.label
                    .markdownTextStyle { ForegroundColor(.secondaryText) }
                    .relativePadding(.horizontal, length: .em(1))
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .codeBlock { configuration in
            ScrollView(.horizontal) {
                configuration.label
                    .fixedSize(horizontal: false, vertical: true)
                    .relativeLineSpacing(.em(0.225))
                    .markdownTextStyle {
                        FontFamilyVariant(.monospaced)
                        FontSize(.em(0.85))
                    }
                    .padding(20)
            }
            .background(Color.secondaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .markdownMargin(top: 0, bottom: 20)
        }
        .listItem { configuration in
            configuration.label
                .markdownMargin(top: .em(0.7))
        }
        .taskListMarker { configuration in
            Image(systemName: configuration.isCompleted ? "checkmark.square.fill" : "square")
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(Color.checkbox, Color.checkboxBackground)
                .imageScale(.small)
                .relativeFrame(minWidth: .em(1.5), alignment: .trailing)
        }
        .table { configuration in
            configuration.label
                .fixedSize(horizontal: false, vertical: true)
                .markdownTableBorderStyle(.init(color: .border))
                .markdownTableBackgroundStyle(
                    .alternatingRows(Color.background, Color.secondaryBackground)
                )
                .markdownMargin(top: 0, bottom: 20)
        }
        .tableCell { configuration in
            configuration.label
                .markdownTextStyle {
                    if configuration.row == 0 {
                        FontWeight(.semibold)
                    }
                    BackgroundColor(nil)
                }
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .relativeLineSpacing(.em(0.25))
        }
        .thematicBreak {
            Divider()
                .relativeFrame(height: .em(0.25))
                .overlay(Color.border)
                .markdownMargin(top: 30, bottom: 30)
        }
}

extension Color {
    fileprivate static let text = Color(
        light: Color(uiColor: .csBlack), dark: Color(uiColor: .csBlack)
    )
    fileprivate static let secondaryText = Color(
        light: Color(uiColor: .csGray5), dark: Color(uiColor: .csGray5)
    )
    fileprivate static let tertiaryText = Color(
        light: Color(uiColor: .csGray4), dark: Color(uiColor: .csGray4)
    )
    fileprivate static let background = Color(
        light: Color(uiColor: .csWhite), dark: Color(uiColor: .csWhite)
    )
    fileprivate static let secondaryBackground = Color(
        light: Color(uiColor: .csBlue1), dark: Color(uiColor: .csBlue1)
    )
    fileprivate static let link = Color(
        light: Color(uiColor: .csBlue5), dark: Color(uiColor: .csBlue5)
    )
    fileprivate static let border = Color(
        light: Color(uiColor: .csGray3), dark: Color(uiColor: .csGray3)
    )
    fileprivate static let divider = Color(
        light: Color(uiColor: .csGray5), dark: Color(uiColor: .csGray5)
    )
    fileprivate static let secondaryDivider = Color(
        light: Color(uiColor: .csGray3), dark: Color(uiColor: .csGray3)
    )
    fileprivate static let checkbox = Color(rgba: 0xb9b9_bbff)
    fileprivate static let checkboxBackground = Color(rgba: 0xeeee_efff)
}
