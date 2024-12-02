//
//  Font+Extensions.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 31.10.2024.
//

import SwiftUI

extension Font {
    static func bold(size: CGFloat) -> Font {
        Font.custom("Montserrat-Bold", size: size)
    }

    static func medium(size: CGFloat) -> Font {
        Font.custom("Montserrat-Medium", size: size)
    }

    static func regular(size: CGFloat) -> Font {
        Font.custom("Montserrat-Regular", size: size)
    }

    static func semiBold(size: CGFloat) -> Font {
        Font.custom("Montserrat-SemiBold", size: size)
    }
}
