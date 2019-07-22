//
//  Database.swift
//  DbFromJson
//
//  Created by Marcelo Sampaio on 22/07/19.
//  Copyright © 2019 Marcelo Sampaio. All rights reserved.
//

import Foundation
import UIKit
import SQLite3


class Database : NSObject {
    
    // MARK: - Properties
    private var db : OpaquePointer?
    private var statement: OpaquePointer?
    
    
    // MARK: - Database Queries
    public func addCity(_ city: City) {
        
        self.openDB()
        
        let sql = "insert into city (id, nome, estado) values ('\(city.id!)' , '\(city.nome!)' , '\(city.estado!)')"
        
        print("🤙 sql: \(sql)")
        
        if sqlite3_exec(db, sql, nil, nil, nil) != SQLITE_OK {
            print("🆘 error inserting row to the table 🆘")
            return
        }else{
            print("👉 insert OK")
        }
        
        self.closeDB()
        
    }

    
    // MARK: - Database Settings
    public func prepareDatabase() {
        
        let sourcePath = self.bundlePath()
        print("☘️ source path: \(sourcePath)")
        
        let targetPath = self.databasePath()
        
        print("☘️ target path: \(targetPath)")
        
        // Check if a writable copy of the database exists
        if FileManager.default.fileExists(atPath: targetPath) {
            print("🍻 writable database exists")
            return
        }
        
        print("🍻 writable database will be copied to documents folder")
        
        let sourceUrl = URL.init(fileURLWithPath: sourcePath)
        let targetUrl = URL.init(fileURLWithPath: targetPath)
        
        do {
            try FileManager.default.copyItem(at: sourceUrl, to: targetUrl)
        } catch  {
            print("🆘 error copying database to wrtable folder")
            return
        }
        print("🍻 writable database has been copied to target folder: \(targetUrl)")
        
        print("........")
        
        
    }
    
    
    
    
    private func bundlePath() -> String {
        // db file path (resource path)
        let bundle = Bundle.main
        let path = bundle.path(forResource: "city", ofType: "db")
        
        print("👉 DB PATH: \(path!)")
        return path!
    }
    
    private func databasePath() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/" + "city.db"
    }
    
    
    private func openDB() {
        if sqlite3_open(databasePath(), &db) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("🆘 error openning database 🆘  Error: \(errmsg)")
            return
        }
    }
    
    private func closeDB() {
        if sqlite3_close(db) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("🆘 error closing database 🆘   Error: \(errmsg)")
            return
        }
        
        db = nil
    }
    

    
    

    
    
}
