//
//  ListView.swift
//  Appxilio
//
//  Created by Diego Becerril on 14/10/23.
//

import SwiftUI
import Foundation

//Listas para las funciones que muestran los elementos
private let maniobras = [Maniobra(id: 1, nombre: "Heilmich", desc: "Maniobra para sacar alimentos que obstruyen la via respiratoria", imagen: Image("Heimlich")),
                         Maniobra(id: 2, nombre: "Vendajes", desc: "Vendar la zona asfectada", imagen: Image(systemName: "photo.artframe")),
                         Maniobra(id: 3, nombre: "RCP", desc: "Maniobra para reanimar a una persona por problema cardiopulmonar", imagen: Image("RCP"))]

//Lista para que muestre los textos de las lesiones
private let lecturasLesiones = [Lectura(nombre: "Heridas", texto: leerArchivo(arch: "Heridas"), icono: "bandage.fill", imagen: Image("Herida")),
                                Lectura(nombre: "Hemorragias", texto: leerArchivo(arch: "Hemorragias"), icono: "drop.fill", imagen: Image("Hemorragia")),
                                Lectura(nombre: "Quemaduras", texto: leerArchivo(arch: "Quemaduras"), icono: "burn", imagen: Image("Quemadura"))]

//Lista para que muestre los textos de las lesiones Osteomusculares
private let lecturasLesionesO = [Lectura(nombre: "Fracturas", texto: leerArchivo(arch: "Fracturas"), icono: "cross.circle.fill", imagen: Image("Fractura")),
                                 Lectura(nombre: "Luxaciones", texto: leerArchivo(arch: "Luxaciones"), icono: "bed.double.fill", imagen: Image("Luxacion")),
                                 Lectura(nombre: "Esguinces", texto: leerArchivo(arch: "Esguinces"), icono: "waveform.path.ecg", imagen: Image("Esguince"))]

//Lista para que muestre los textos de RCP
private let lecturasRCP = [Lectura(nombre: "Reanimación cardiopulmonar", texto: leerArchivo(arch: "RCP"), icono: "lungs.fill", imagen: Image("RCP")),
                           Lectura(nombre: "Maniobra Heimlich", texto: leerArchivo(arch: "Heimlich"), icono: "bubbles.and.sparkles.fill", imagen: Image("Heimlich"))]
    
struct ListView: View {
    var body: some View {
        TabView{
            InicioView().tabItem{
                Image(systemName: "house.fill")
                Text("Inicio")
            }
            
            AprendeView().tabItem{
                Image(systemName: "book.fill")
                Text("Aprende")
            }
            
            ConfigView().tabItem{
                Image(systemName: "gear")
                Text("Config.")
            }
        }.accentColor(.mint)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

//La estrucutra que nos ayuda a poner en la barra de menú la opción de
//Inicio
struct InicioView: View {
    var body: some View {
        NavigationView{
            List(maniobras, id: \.id){ maniobra in
                NavigationLink(destination: DetManiobra(maniobra: maniobra)){
                    RowView(maniobra: maniobra)
                }
            }.navigationTitle("Maniobras")
        }
    }
}

//La estrucutra que nos ayuda a poner en la barra de menú la opción de
//Aprende
struct AprendeView: View{
    var body: some View{
        NavigationView{
            List{
                Section(header: Text("Lesiones en partes blandas")){
                    ForEach(lecturasLesiones, id: \.nombre) { lectura in
                        NavigationLink(destination: DetLectura(lectura: lectura)){
                            Label(lectura.nombre, systemImage: lectura.icono)
                        }
                    }
                }
                
                Section(header: Text("Lesiones Osteomusculares")){
                    ForEach(lecturasLesionesO, id: \.nombre) { lectura in
                        NavigationLink(destination: DetLectura(lectura: lectura)){
                            Label(lectura.nombre, systemImage: lectura.icono)
                        }
                    }
                }
                
                Section(header: Text("RCP")){
                    ForEach(lecturasRCP, id: \.nombre) { lectura in
                        NavigationLink(destination: DetLectura(lectura: lectura)){
                            Label(lectura.nombre, systemImage: lectura.icono)
                        }
                    }
                }
            }.listStyle(InsetGroupedListStyle()).navigationTitle("Aprende")
        }
    }
}


//La estrucutra que nos ayuda a poner en la barra de menú la opción de
//Configuración
struct ConfigView: View {
    
    @State var appearance = false
    @State var step = 0
    @State var volume = 5.0
    @State var isEditing = false
    
    var body: some View {
        Form {
            Toggle("Tema Oscuro", isOn: $appearance)
            
            Section(header: Text("Volúmen"),
                    footer:
                        HStack{
                            Spacer()
                            Label("Versión 1.0.0", systemImage: "iphone")
                            Spacer()
                        }
                ){
                Slider(value: $volume, in: 0...10, step: 1, onEditingChanged: { editing in isEditing = editing}, minimumValueLabel: Text("min"), maximumValueLabel: Text("max")) {
                    Text("")
                }
                Text("Volúmen: \(Int(volume))")
            }
        }
        .preferredColorScheme(appearance ? .dark : .light)
    }
}

//Función que toma el nombre del archivo y regresa el texto de ese archivo
//La carpeta se llama info y dentro de ella se encuentran todos los archivos
//Que necesitamos
public func leerArchivo(arch: String) -> String {
    if let infoDirectory = Bundle.main.url(forResource: "info", withExtension: nil) {
        let filePath = infoDirectory.appendingPathComponent("\(arch)")
        
        do {
            let text = try String(contentsOf: filePath, encoding: .utf8)
            return text
        } catch {
            print("Error al leer el archivo: \(error)")
        }
    } else {
        print("No se encontró el directorio 'Info'")
    }
    
    return ""
}
