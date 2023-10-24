//
//  DetManiobra.swift
//  Appxilio
//
//  Created by Diego Becerril on 14/10/23.
//

import SwiftUI

struct DetManiobra: View {
    
    var maniobra: Maniobra
    
    var body: some View {
        VStack{
            maniobra.imagen.resizable().frame(width: 200, height: 200).clipShape(Rectangle()).overlay(Rectangle().stroke(Color.black, lineWidth: 4)).shadow(color: Color.gray, radius: 5)
            Text(maniobra.nombre).font(.largeTitle)
            Text(maniobra.desc).font(.subheadline)
            Spacer()
        }
    }
}

struct DetManiobra_Previews: PreviewProvider {
    static var previews: some View {
        DetManiobra(maniobra: Maniobra(id: 1, nombre: "Heilmich", desc: "Maniobra para sacar alimentos que obstruyen la via respiratoria", imagen: Image(systemName: "photo.artframe")))
    }
}
