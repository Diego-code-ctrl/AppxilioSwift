//
//  RowView.swift
//  Appxilio
//
//  Created by Diego Becerril on 14/10/23.
//

import SwiftUI

struct RowView: View {
    
    var maniobra: Maniobra
    
    var body: some View {
        HStack{
            maniobra.imagen.resizable().frame(width: 90, height: 90).padding()
            VStack(alignment: .leading){
                Text(maniobra.nombre).bold().font(.title)
                Text(maniobra.desc).font(.subheadline)
            }
            Spacer()
        }.padding()
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(maniobra: Maniobra(id: 1, nombre: "Heilmich", desc: "Maniobra para sacar alimentos que obstruyen la via respiratoria", imagen: Image("Heimlich")))
    }
}
