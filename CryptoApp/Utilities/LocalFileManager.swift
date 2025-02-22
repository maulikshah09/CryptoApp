//
//  LocalFileManager.swift
//  CryptoApp
//
//  Created by Maulik Shah on 2/22/25.
//

import Foundation

class LocalFileManager{
    private let directoryURL: URL?
    
    init(directoryType: FileManager.SearchPathDirectory, folder: String? = nil) {
        let baseURL = FileManager.default.urls(for: directoryType, in: .userDomainMask).first
        if let subfolder = folder {
            self.directoryURL = baseURL?.appendingPathComponent(subfolder, isDirectory: true)
            createDirectoryIfNeeded() // Ensure folder exists
        } else {
            self.directoryURL = baseURL
        }
    }
    
    /// Ensure that the subfolder exists before saving files
    private func createDirectoryIfNeeded() {
        guard let directoryURL = directoryURL else { return }
        if !FileManager.default.fileExists(atPath: directoryURL.path) {
            do {
                try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true)
            } catch {
                print("❌ Error creating directory: \(error.localizedDescription)")
            }
        }
    }
    
    /// Get file path
    private func getFilePath(fileName: String) -> URL? {
         directoryURL?.appendingPathComponent(fileName)
    }
    
    /// Check file exist or not
    func fileExists(fileName: String) -> Bool {
        guard let fileURL = getFilePath(fileName: fileName) else { return false }
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
    
    ///  Load file
    func loadFile(fileName: String) -> Data? {
        guard let fileURL = getFilePath(fileName: fileName) else { return nil }
        return try? Data(contentsOf: fileURL)
    }
    
    ///  Save file
    @discardableResult
    func saveFile(data: Data, fileName: String) -> Bool {
        guard let fileURL = getFilePath(fileName: fileName) else { return false}
        do {
            try data.write(to: fileURL)
            return true
        } catch {
            print("❌ Error saving file: \(error.localizedDescription)")
            return false
        }
    }
    
    ///  Delete  file
    @discardableResult
    func deleteFile(fileName: String) -> Bool {
        guard let fileURL = getFilePath(fileName: fileName) else { return false }
        do {
            try FileManager.default.removeItem(at: fileURL)
            return true
        } catch {
            print("❌ Error deleting file: \(error.localizedDescription)")
            return false
        }
    }
    
    ///  Delete  folder
    func deleteFolder() -> Bool {
        guard let directoryURL = directoryURL else { return false }
        
        do{
            try FileManager.default.removeItem(atPath: directoryURL.absoluteString)
            return true
        }catch{
            print("❌ Error deleting folder: \(error.localizedDescription)")
            return false
        }
    }
}


//let documentManager = LocalFileManager(directoryType: .documentDirectory)

 
