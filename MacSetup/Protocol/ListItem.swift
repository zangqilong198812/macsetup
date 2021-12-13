//
//  ListItem.swift
//  MacSetup
//
//  Created by zang qilong on 2021/12/13.
//

import Foundation


protocol ListItem: Identifiable {}

protocol ListSection {
    associatedtype Item: ListItem
    var header: String? { get }
    var items: [Item] { get }
}
