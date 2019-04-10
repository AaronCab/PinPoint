//
//  ItemsDataManager.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/10/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class ItemsDataManager{
    private  static let filename = "UserModel.plist"
    // create
    static public func saveToDocumentsDirectory(thisUser: UserModel) -> (success: Bool, error: Error?){
        let path = FileManagerHelper.filepathToDocumentsDirectory(filename: filename)
        var newUser = fetchItemsFromDocumentsDirectory()
        newUser.append(thisUser)
        do {
            let data = try PropertyListEncoder().encode(newUser)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list decoding error: \(error)")
            return(false, nil)
        }
        return(true, nil)
    }
    
    // read
    static public func fetchItemsFromDocumentsDirectory() -> [UserModel] {
        let path = FileManagerHelper.filepathToDocumentsDirectory(filename: filename).path
        var article = [UserModel]()
        var items = [UserModel]()
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    article = try PropertyListDecoder().decode([UserModel].self, from: data)
                    items = article
                } catch {
                   
                }
            } else {
                print("data is nil")
            }
        }
        return items
    }
    
    // update
    public func updateItem(item: UserModel, atIndex index: Int) {
        let path = FileManagerHelper.filepathToDocumentsDirectory(filename: ItemsDataManager.filename)
        var items = ItemsDataManager.fetchItemsFromDocumentsDirectory()
        items[index] = item
        do {
            let data = try PropertyListEncoder().encode(items)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list decoding error: \(error)")
        }
    }
    
    // delete
    static public func deleteItem(atIndex index: Int, item: UserModel) {
        let path = FileManagerHelper.filepathToDocumentsDirectory(filename: ItemsDataManager.filename)
        var items = ItemsDataManager.fetchItemsFromDocumentsDirectory()
        items.remove(at: index)
        
        do {
            let data = try PropertyListEncoder().encode(items)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list decoding error: \(error)")
        }
    }
}
