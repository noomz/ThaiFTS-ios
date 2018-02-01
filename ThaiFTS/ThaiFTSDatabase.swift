//
// Created by Siriwat Uamngamsup on 31/1/2018 AD.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

import Foundation
import FMDB
import FMDB.FMTokenizers

class ThaiFTSDatabase: FMDatabase {
    static var shared: ThaiFTSDatabase = ThaiFTSDatabase.init(url: "")

    var tokenizer: FMSimpleTokenizer
    var locale: CFLocale

    override init(path: String?) {
        let Thai_LocaleIdentifier = CFLocaleIdentifier.init(Locale.canonicalIdentifier(from: "Thai") as CFString)
        self.locale = CFLocaleCreate(nil, Thai_LocaleIdentifier)
        self.tokenizer = FMSimpleTokenizer.init(locale: self.locale)

        super.init(path: path)
    }

    init(url: String?) {
        let Thai_LocaleIdentifier = CFLocaleIdentifier.init(Locale.canonicalIdentifier(from: "Thai") as CFString)
        self.locale = CFLocaleCreate(nil, Thai_LocaleIdentifier)
        self.tokenizer = FMSimpleTokenizer.init(locale: self.locale)

        if url == "" {
            super.init()
            return
        }

        super.init(path: "\(url!)/main.db")
        ThaiFTSDatabase.shared = self
    }

    func initTokenizer() {
        self.installTokenizerModule()
        FMDatabase.registerTokenizer(tokenizer, withKey: "thai")
    }
}

//class ThaiTokenizer: FMTokenizerDelegate {
//
//    func open(_ cursor: UnsafeMutablePointer<FMTokenizerCursor>!) {
//        var tokenCursor = cursor.pointee
//        let inputString = tokenCursor.inputString.takeRetainedValue()
//
//        let Thai_LocaleIdentifier = CFLocaleIdentifier.init(Locale.canonicalIdentifier(from: "Thai") as CFString)
//        let thaiLocale: CFLocale = CFLocaleCreate(nil, Thai_LocaleIdentifier)
//
//        let inputRange = CFRangeMake(0, (inputString as String).utf16.count)
//
////        tokenCursor.userObject = CFStringTokenizerCreate(kCFAllocatorDefault, inputString, inputRange, kCFStringTokenizerUnitWord, thaiLocale)
//    }
//
//    func nextToken(for cursor: UnsafeMutablePointer<FMTokenizerCursor>!) -> Bool {
//
//    }
//
//    func close(_ cursor: UnsafeMutablePointer<FMTokenizerCursor>!) {
//
//    }
//}
