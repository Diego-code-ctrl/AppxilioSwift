//
//  DetLectura.swift
//  Appxilio
//
//  Created by Diego Becerril on 14/10/23.
//

import SwiftUI

struct DetLectura: View {
    
    var lectura: Lectura
    
    var body: some View {
        ScrollView{
            VStack{
                lectura.imagen.resizable().frame(width: 200, height: 200)
                Text(lectura.nombre).font(.largeTitle)
                Text(lectura.texto).font(.subheadline)
            }
        }
    }
}

struct DetLectura_Previews: PreviewProvider {
    static var previews: some View {
        DetLectura(lectura: Lectura(nombre: "Heridas", texto: "", icono: "bandage.fill", imagen: Image("Herida.png")))
    }
}
