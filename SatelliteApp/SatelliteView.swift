//
//  SatelliteView.swift
//  SatelliteApp
//
//  Created by labadmin on 16/03/23.
//

import SwiftUI
import Alamofire
import Charts

struct SatelliteView: View {
    var apiURLList: [String] = ["https://api.wheretheiss.at/v1/satellites/25544"]
    var body: some View {
        VStack{
            NavigationStack{
                ScrollView{
                    ForEach(apiURLList, id:\.self) {url in
                        ZStack{
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(.teal)
                                .frame(width: 300, height: 250)
                            Text("Satellite 1")
                                .foregroundColor(.white)
                                .padding(.bottom, 150)
                            NavigationLink(destination: SatelliteDetailView(satURL: url)) {
                                Text("See Details")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SatelliteDetailView: View {
    @State var satURL: String
    @ObservedObject var satelliteRecorder = SatelliteRecorder()
    @State var elapsedTime: Int = 0
    var id: UUID = UUID()
    var timeSkip: Int = 1
    var timeCounter = 0
    @State var scaleAnimationAmount: CGFloat = CGFloat(130)
    var body: some View {
        VStack{
            Image("satellite-icon")
                .resizable()
                .frame(width: scaleAnimationAmount, height: scaleAnimationAmount)
                .animation(
                    .easeInOut(duration: 1)
                    .repeatForever(),
                    value: scaleAnimationAmount
                )
                .onAppear() {
                    scaleAnimationAmount = CGFloat(150)
                }
            ScrollView{
                Chart{
                    ForEach(0...satelliteRecorder.trakedTime.count - 1, id: \.self) {i in
                        LineMark(x: .value("Time", satelliteRecorder.trakedTime[i]), y: .value("Velocity", satelliteRecorder.trakedVelocity[i]))
                    }
                }
                .frame(height: 200)
                .padding()
            }
        }
        .onAppear() {
            Timer.scheduledTimer(withTimeInterval: TimeInterval(timeSkip), repeats: true, block: { _ in
                getTargetSatellite(url: satURL)
            })
        }
    }
    
    func getTargetSatellite(url: String) {
        elapsedTime += timeSkip

        AF.request(url).responseDecodable(of: SatelliteModel.self) { response in
            switch(response.result) {
            case .success(let value):
                satelliteRecorder.trakedTime.append(timeCounter + elapsedTime)
                satelliteRecorder.trakedVelocity.append(value.velocity)
            case.failure(let error):
                print(error)
            }
        }
    }
}

class SatelliteRecorder: ObservableObject {
    @Published var trakedTime: [Int] = [0]
    @Published var trakedVelocity: [Float] = [0.0]
}

struct SatelliteView_Previews: PreviewProvider {
    static var previews: some View {
        SatelliteView()
    }
}
