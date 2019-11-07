//
//  Piada.swift
//  ChuckNorris
//
//  Created by Junior Obici on 10/09/19.
//  Copyright © 2019 Junior Obici. All rights reserved.
//

import Foundation

class Piada: Decodable {
    public let categoria: [String]
    public let id: String
    public let iconeUrl: String
    public let url: String
    public let valor: String
    public let dataInclusao: String
    public let dataAtualizacao: String
    
    init(categoria: [String], id: String, iconeUrl: String, url: String, valor: String, dataInclusao: String, dataAtualizacao: String) {
        self.categoria = categoria
        self.id = id
        self.iconeUrl = iconeUrl
        self.url = url
        self.valor = valor
        self.dataInclusao = dataInclusao
        self.dataAtualizacao = dataAtualizacao
    }

}

