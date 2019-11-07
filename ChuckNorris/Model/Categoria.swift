//
//  Categoria.swift
//  ChuckNorris
//
//  Created by Junior Obici on 10/09/19.
//  Copyright © 2019 Junior Obici. All rights reserved.
//

import Foundation

class Categoria: Decodable {
    public let categoria: String!

    init(categoria: String) {
        self.categoria = categoria
    }
}
