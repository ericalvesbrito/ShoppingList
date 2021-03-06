//
//  RemoteConfigValues.swift
//  ShoppingList
//
//  Created by Eric Alves Brito on 08/10/20.
//  Copyright © 2020 FIAP. All rights reserved.
//

import Foundation
import Firebase

class RemoteConfigValues {
    
    static let shared = RemoteConfigValues()
    private let rc = RemoteConfig.remoteConfig()
    private let defaultValues: [String: Any] = [
        "copyrightMessage": "FIAP 20MOB 2020: Todos direitos reservados",
        "signupEnabled": true
    ]
    
    private init() {
        loadDefaultsValues()
    }
    
    private func loadDefaultsValues() {
        rc.setDefaults(defaultValues as? [String: NSObject])
    }
    
    func fetch() {
        rc.fetch(withExpirationDuration: 5) { (status, error) in
            if let error = error {
                print(error)
            }
            switch status {
            case .failure:
                print("Falha")
            case .noFetchYet:
                print("Não foi feito fetch!!")
            case .throttled:
                print("Negado o fectch")
            case .success:
                print("Sucesso!")
                self.rc.activate { (error) in
                    if let error = error {
                        print(error)
                    }
                }
            @unknown default:
                print("Desconhecido")
            }
        }
    }
    
    var copyrightMessage: String {
        rc.configValue(forKey: "copyrightMessage").stringValue ?? "FIAP 20MOB 2020: Todos direitos reservados"
    }
    
    var signupEnabled: Bool {
        rc.configValue(forKey: "signupEnabled").boolValue
    }
    
}
