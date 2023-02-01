//
//  DataStorage.swift
//  TaskManager
//
//  Created by grandmaster on 1.2.23..
//

import Foundation

final class DataStorage {
    
    private let storage = UserDefaults.standard
    
    func saveSelectedListIndex(_ index: Int) {
        storage.set(index, forKey: Constant.selectedListIndexKey)
    }
    
    func getSelectedIndexKey() -> Int {
        storage.integer(forKey: Constant.selectedListIndexKey)
    }
    
    func saveData(_ lists: [List], completion: (Bool) -> Void) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(lists)
            storage.set(data, forKey: Constant.dataKey)
            completion(true)
        } catch let error {
            print("Save failed with error: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func getData(completion: ([List]?) -> Void) {
        if let data = storage.object(forKey: Constant.dataKey) as? Data {
            do {
                let decoder = JSONDecoder()
                let lists = try decoder.decode([List].self, from: data)
                completion(lists)
            } catch {
                print("Decode failed with error: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
