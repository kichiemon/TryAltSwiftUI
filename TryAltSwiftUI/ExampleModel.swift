//
//  ExampleModel.swift
//  TryAltSwiftUI
//
//  Created by ikuya on 2020/09/19.
//

import AltSwiftUI

struct Example: Identifiable {
    var id: String
    var name: String
    var price: Int
}

class ExampleModel : ObservableObject {
    @Published var exampleList: [Example] = []
    
    func load() {
        exampleList = (0 ... 10).map({ (i) -> Example in
            Example(id: "\(i)", name: "name_\(i)", price: i * 100)
        })
    }
}
