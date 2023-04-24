//
//  Font.swift
//  SwiftStudentChallenge
//
//  Created by 장수민 on 2023/04/07.
//

// credits http://i-eumcreative.org/?page_id=3921 // Title font by DDUNGSANG Corp

import SwiftUI

public struct FontManager {
    public static func registerFonts() {
        registerFont(bundle: Bundle.main, fontName: "TiquiTaca-Regular", fontExtension: ".ttf")
    }
    fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        print(Bundle.main)
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }
        
        var error: Unmanaged<CFError>?
        
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}

