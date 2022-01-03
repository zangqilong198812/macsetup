//
//  Smile.swift
//  Smile
//
//  Created by Khoa Pham on 05/06/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

// MARK: - List

/// List all emojis
public func list() -> [String] {
    return emojiCategories.keys
        .sorted()
        .compactMap { key in
            return emojiCategories[key]
        }.flatMap {
            $0
        }
}

// MARK: - Emoji

/// Check if a character is emoji
public func isEmoji(character: String) -> Bool {
    return emojiList.values.contains(character)
}

/// Check if a string contains any emojis
@available(iOS, deprecated: 10.2, renamed: "containsEmoji(_string:)")
public func containsEmoji(string: String) -> Bool {
    let set = CharacterSet(charactersIn: emojiList.values.joined())
    let range = string
        .smile_removingDigits
        .rangeOfCharacter(from: set)
    
    return range != nil
}

/// Get emoji from unicode value
public func emoji(unicodeValues: [Int]) -> String {
    return unicodeValues.compactMap({
        guard let scalar = UnicodeScalar($0) else {
            return nil
        }
        
        return String(scalar)
    }).joined()
}

/// Unmodify an emoji
public func unmodify(emoji: String) -> String {
    guard let first = emoji.unicodeScalars.first?.value else {
        return emoji
    }
    
    return Smile.emoji(unicodeValues: [Int(first)])
}

/// Check if String is a simple emoji
@available(macOS 10.12.2, iOS 10.2, tvOS 10.1, watchOS 3.1.1, *)
public func isSimpleEmoji(_ string: String) -> Bool{
    guard let firstScalar = string.unicodeScalars.first else { return false }
    return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
}

/// Check if multiple scalars will be merged into an emoji
@available(macOS 10.12.2, iOS 10.2, tvOS 10.1, watchOS 3.1.1, *)
public func isCombinedIntoEmoji(_ string: String) -> Bool{
    return string.unicodeScalars.count > 1 && string.unicodeScalars.first?.properties.isEmoji ?? false
}

/// Checks if string is emoji
@available(macOS 10.12.2, iOS 10.2, tvOS 10.1, watchOS 3.1.1, *)
public func checkForEmoji(_ string: String) -> Bool{
    return isSimpleEmoji(string) || isCombinedIntoEmoji(string)
}

/// Checks if string contains an emoji
@available(macOS 10.12.2, iOS 10.2, tvOS 10.1, watchOS 3.1.1, *)
public func containsEmoji(_ string: String) -> Bool{
    return countEmoji(string) > 0
}

/// Counts number of emoji characters found in string
@available(macOS 10.12.2, iOS 10.2, tvOS 10.1, watchOS 3.1.1, *)
public func countEmoji(_ string: String) -> Int{
    var count = 0
    for char in string{
        if checkForEmoji("\(char)"){
            count += 1
        }
    }
    return count
}

/// Counts number of non-emoji characters found in string
@available(macOS 10.12.2, iOS 10.2, tvOS 10.1, watchOS 3.1.1, *)
public func countNonEmoji(_ string: String) -> Int{
    var count = 0
    for char in string{
        if !checkForEmoji("\(char)"){
            count += 1
        }
    }
    return count
}

/// Checks if string contains only emoji characters
@available(macOS 10.12.2, iOS 10.2, tvOS 10.1, watchOS 3.1.1, *)
public func isEmojiOnly(_ string: String) -> Bool{
    return countEmoji(string) > 0 && countNonEmoji(string) == 0
}

/// Checks if string contains only one emoji
@available(macOS 10.12.2, iOS 10.2, tvOS 10.1, watchOS 3.1.1, *)
public func isSingleEmoji(_ string: String) -> Bool{
    return string.count == 1 && containsEmoji(string)
}

// MARK: - Name

/// Return standard name for a emoji
public func name(emoji: String) -> [String] {
    let string = NSMutableString(string: String(emoji))
    var range = CFRangeMake(0, CFStringGetLength(string))
    CFStringTransform(string, &range, kCFStringTransformToUnicodeName, false)
    
    return Utils.dropPrefix(string: String(string), subString: "\\N")
        .components(separatedBy: "\\N")
        .map {
            return Utils.remove(string: $0, set: (Set(["{", "}"])))
        }
}

// MARK: - Flag

/// Return emoji for a flag
public func emoji(countryCode: String) -> String {
    let base = UnicodeScalar("🇦").value - UnicodeScalar("A").value
    return Utils.flatten(string: countryCode.uppercased(), base: base).joined()
}

// MARK: - Keywords

/// Search emoji by keywords
public func emojis(keywords: [String]) -> [String] {
    var result: [String] = []
    
    list().forEach { emoji in
        keywords.forEach { keyword in
            name(emoji: emoji).forEach { name in
                if name.range(of: keyword) != nil {
                    result.append(emoji)
                }
            }
        }
    }
    
    return result
}

// MARK: - Alias

/// Return emoji for an alias
public func emoji(alias: String) -> String? {
    return emojiList[alias]
}

/// Find alias of emoji
public func alias(emoji: String) -> String? {
    for (key, value) in emojiList {
        if value == emoji {
            return key
        }
    }
    
    return nil
}

/// Replace alias within a string by emoji
public func replaceAlias(string: String) -> String {
    guard let regex = try? NSRegularExpression(pattern: ":\\w*?:", options: .caseInsensitive) else {
        return string
    }
    
    let range = NSMakeRange(0, string.count)
    var mutableString = string
    regex.enumerateMatches(in: string, options: [], range: range) { (result, flags, context) in
        guard let range = result?.range else {
            return
        }
        
        let start = string.index(string.startIndex, offsetBy: range.location)
        let end = string.index(start, offsetBy: range.length)
        
        let alias = string[start..<end].replacingOccurrences(of: ":", with: "")
        
        guard let emoji = emoji(alias: alias) else {
            return
        }
        
        mutableString = mutableString.replacingOccurrences(of: ":\(alias):", with: emoji)
    }
    
    return mutableString
}

// MARK: - Category

/// Determine the category of emoji
public func category(emoji: String) -> String? {
    for (category, list) in emojiCategories {
        if list.contains(emoji) {
            return category
        }
    }
    
    return nil
}

// MARK: - Manipulation

/// Extract all emojis within a string
public func extractEmojis(string: String) -> String {
    return Utils.flatten(string: string).filter({ character in
        return isRelatedToEmoji(character: character)
    }).joined()
}

/// Remove all emojis within a string
public func removeEmojis(string: String) -> String {
    let first =  Utils.flattenCharacters(string: string).filter({ character in
        return !isRelatedToEmoji(character: character)
    }).joined()
    
    let second = Utils.flatten(string: first).filter({ character in
        return !isRelatedToEmoji(character: character)
    }).joined()
    
    return second
}

/// Assemble many emojis into one
public func assemble(emojis: [String]) -> String {
    let simple = Utils.flatten(string: emojis.joined())
    let joiner = Utils.insert(element: Smile.Sequence.Mark.zeroWidthJoiner, betweenArray: simple)
    let selector = Utils.add(element: Smile.Sequence.Mark.presentationSelector, array: joiner)
    
    if isEmoji(character: simple.joined()) {
        return simple.joined()
    }
    
    if isEmoji(character: joiner.joined()) {
        return joiner.joined()
    }
    
    if isEmoji(character: selector.joined()) {
        return selector.joined()
    }
    
    return emojis.joined()
}

/// Disassemble an emoji into many
public func disassemble(emoji: String) -> [String] {
    return Utils.flatten(string: emoji).filter({ character in
        return isEmoji(character: character)
    })
}

// MARK: - Helper

/// Check if a character is emoji, or emoji sequence marks
fileprivate func isRelatedToEmoji(character: String) -> Bool {
    return isEmoji(character: character)
    || list().contains(character)
    || Smile.Sequence.all.contains(character)
}

fileprivate extension String {
    var smile_removingDigits: String {
        return components(separatedBy: .decimalDigits).joined()
    }
}
