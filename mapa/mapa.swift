//
//  mapa.swift
//  SenacTarde
//
//  Created by StudentBackup01 on 06/09/23.
//

import SwiftUI
import MapKit
struct mapa: View {
    
    @State private var modal = false
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
   
    struct location: Identifiable{
        let id = UUID()
        let nome: String
        let zoom: MKCoordinateSpan
        let endereco: CLLocationCoordinate2D
        let flag: String
        let description: String
    }
    
    @State var localizacoes = [
        location(nome: "Londres", zoom: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5), endereco: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), flag:"https://www.passagenspromo.com.br/blog/wp-content/uploads/2019/12/roteiro-londres-viagem.jpg", description: "Londres, capital da Inglaterra e do Reino Unido, é uma cidade do século 21 com uma história que remonta à era romana. Seu centro abriga as sedes imponentes do Parlamento, a famosa torre do relógio do Big Ben e a Abadia de Westminster, local de coroação dos monarcas britânicos. Do outro lado do rio Tâmisa, a roda gigante London Eye tem vista panorâmica do complexo cultural da margem sul e de toda a cidade."),
        location(nome: "Brasil", zoom: MKCoordinateSpan(latitudeDelta: 38, longitudeDelta: 38),endereco: CLLocationCoordinate2D(latitude: -14.668338, longitude: -52.285231), flag:"https://cdn.maioresemelhores.com/imagens/paisagens-mais-bonitas-do-brasil-og.jpg", description: "O Brasil, um vasto país sul-americano, estende-se da Bacia Amazônica, no norte, até os vinhedos e as gigantescas Cataratas do Iguaçu, no sul. O Rio de Janeiro, simbolizado pela sua estátua de 38 metros de altura do Cristo Redentor, situada no topo do Corcovado, é famoso pelas movimentadas praias de Copacabana e Ipanema, bem como pelo imenso e animado Carnaval, com desfiles de carros alegóricos, fantasias extravagantes e samba."),
        location(nome: "Espanha", zoom: MKCoordinateSpan(latitudeDelta: 18, longitudeDelta: 18), endereco: CLLocationCoordinate2D(latitude: 38.503353, longitude: -3.177347), flag:"https://www.loucoporviagens.com.br/wp-content/uploads/2020/06/sevilha-lugares-espanha.jpg", description: "A Espanha, país europeu da península Ibérica, tem 17 regiões autônomas com geografia e cultura diversas. Madri, a capital, abriga o Palácio Real e o Museu do Prado, obras erigidas por mestres europeus. Segóvia tem um castelo medieval (Alcázar) e um aqueduto romano intacto. A capital da Catalunha, Barcelona, apresenta monumentos modernistas de Antoni Gaudí, como a Igreja da Sagrada Família"),
        location(nome: "Jamaica",zoom: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2), endereco: CLLocationCoordinate2D(latitude: 18.144664, longitude: -77.539278), flag:"https://www.constancezahn.com/wp-content/uploads/2018/04/07-teresa-perez-tours-destino-lua-de-mel-jamaica-ochos-rios-blue-hole.jpg", description: "A Jamaica é um país insular no Caribe com uma topografia exuberante de montanhas, florestas tropicais e praias com recifes. Muitos dos seus resorts all-inclusive estão localizados em Montego Bay, com sua arquitetura colonial britânica, e Negril, conhecida pelos locais de mergulho e snorkeling. A Jamaica é famosa como berço da música reggae, e sua capital, Kingston, abriga um museu dedicado ao cantor Bob Marley"),
        location(nome: "EUA", zoom: MKCoordinateSpan(latitudeDelta: 35, longitudeDelta: 35), endereco: CLLocationCoordinate2D(latitude: 36.536916, longitude: -95.722690), flag: "https://www.qualviagem.com.br/wp-content/uploads/2018/08/iStock-692647864.jpg", description: "Os EUA são um país com 50 estados que cobrem uma vasta faixa da América do Norte, com o Alasca ao noroeste e o Havaí no Oceano Pacífico, estendendo a presença do país. As principais cidades da costa atlântica são Nova York, um centro financeiro e cultural global, e a capital, Washington, DC. Chicago, uma metrópole do centro-oeste, é conhecida por sua importante arquitetura, enquanto Los Angeles, na costa oeste, é famosa pelas produções cinematográficas de Hollywood.")
  
    ]
    
    struct City: Identifiable {
        let id = UUID()
        let name: String
        let coordinate: CLLocationCoordinate2D
    }

    
    @State var  aux : location = location(nome: "EUA", zoom: MKCoordinateSpan(latitudeDelta: 35, longitudeDelta: 35), endereco: CLLocationCoordinate2D(latitude: 36.536916, longitude: -95.722690), flag: "https://www.qualviagem.com.br/wp-content/uploads/2018/08/iStock-692647864.jpg", description: "Os EUA são um país com 50 estados que cobrem uma vasta faixa da América do Norte, com o Alasca ao noroeste e o Havaí no Oceano Pacífico, estendendo a presença do país. As principais cidades da costa atlântica são Nova York, um centro financeiro e cultural global, e a capital, Washington, DC. Chicago, uma metrópole do centro-oeste, é conhecida por sua importante arquitetura, enquanto Los Angeles, na costa oeste, é famosa pelas produções cinematográficas de Hollywood.")
    
    var body: some View {
   /*.onLongPressGesture {
        print("Long pressed!")
    }*/
        VStack{
            Text("World map").font(.title).bold()
            Text("Brazil")
            Spacer()
            
            Map(coordinateRegion: $region, annotationItems: localizacoes){
                MapMarker(coordinate: $0.endereco)
            }.onLongPressGesture {
                modal=true
            }.frame(width: 400, height: 600)
            
            Spacer()
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(localizacoes) { localizacoe in
                        Button(localizacoe.nome){
                           aux = localizacoe
                            region = MKCoordinateRegion(
                                center:localizacoe.endereco,
                                span: localizacoe.zoom)
                            
                        }.padding(8).background(Color.blue).foregroundColor(Color.white).cornerRadius(4)
                    }
                }
            }
            //segundoCaminho2(nomePronto: nome)){
        }.sheet(isPresented: $modal){
            VStack{
                Text(aux.nome).bold().font(.title)
                AsyncImage(url: URL(string: aux.flag)) {image in image.resizable().offset()
            }placeholder: {
                ProgressView()
            }.frame(width: 190,height: 170)
                    
            
                
                Text(aux.description)
             
            }
        }.background(Color.gray)
            
    }
        
    }


struct mapa_Previews: PreviewProvider {
    static var previews: some View {
        mapa()
    }
}
