//
//  SwiftMediator+Url.swift
//  SwiftMediator
//
//  Created by iOS on 2023/5/25.
//

import Foundation
//MARK:--URL routing jump--Swift
extension SwiftMediator {
    /// URL routing jump Jump to distinguish Push, present, fullScreen
    /// - Parameter urlString: Call native page function scheme ://push/moduleName/vcName?quereyParams
    /// - Note here that the string encoded into the URL cannot contain special characters. URL encoding is required. It does not support the queryParams parameter with url and query in the url (if you want the URL to have a token, intercept it and use the routing code jump)
    public func openUrl(_ urlString: String?) {
        
        guard let str = urlString, let url = URL(string: str) else { return }
        let path = url.path as String
        let startIndex = path.index(path.startIndex, offsetBy: 1)
        let pathArray = path.suffix(from: startIndex).components(separatedBy: "/")
        guard pathArray.count == 2 , let first = pathArray.first , let last = pathArray.last else { return }
        
        switch url.host {
        case "push":
            push(last, moduleName: first, paramsDic: url.queryDictionary)
        case "fullScreen":
            present(last, moduleName: first, paramsDic: url.queryDictionary)
        default:
            if #available(iOS 13.0, *) {
                present(last, moduleName: first, paramsDic: url.queryDictionary, modelStyle: .automatic)
            } else {
                present(last, moduleName: first, paramsDic: url.queryDictionary)
            }
        }
    }
}

//MARK:--URL get query dictionary
public extension URL {
    
    var queryDictionary: [String: Any]? {
        guard let query = self.query else { return nil}
        
        var queryStrings = [String: String]()
        for pair in query.components(separatedBy: "&") {
            
            let key = pair.components(separatedBy: "=")[0]
            
            let value = pair
                .components(separatedBy:"=")[1]
                .replacingOccurrences(of: "+", with: " ")
                .removingPercentEncoding ?? ""
            
            queryStrings[key] = value
        }
        return queryStrings
    }
}
//MARK:--URL codec
public extension String {
    //Encode the original url into a valid url
    func urlEncoded() -> String {
        self.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed) ?? ""
    }
    
    //convert the encoded url back to the original url
    func urlDecoded() -> String {
        self.removingPercentEncoding ?? ""
    }
}

