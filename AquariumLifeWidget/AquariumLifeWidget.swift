//
//  AquariumLifeWidget.swift
//  AquariumLifeWidget
//
//  Created by Sahil Satralkar on 07/08/21.
//

import WidgetKit
import SwiftUI
import CoreData

struct Provider: IntentTimelineProvider {
    
    typealias Entry = SimpleEntry
    
    typealias Intent = SelectAquariumIntent
    
    //Text(LocalizedStringKey("MyAquariums"))
    var samplePlaceholderWidgetData : WidgetData {
        
        var tempData = WidgetData(aquariumName: "Green Mountains", aquariumID: UUID().uuidString)
        
        tempData.latestLogsAmmonia = "0.75"
        tempData.latestLogsNitrate = "10.0"
        tempData.latestLogsNitrite = "1.0"
        tempData.latestLogsPH = "7.2"
        tempData.latestLogsTemperature = "20"
        tempData.latestLogsDate =  Date(timeIntervalSinceNow: -172800) //2days ago
        
        tempData.previousLogsAmmonia = "1.25"
        tempData.previousLogsNitrate = "35.0"
        tempData.previousLogsNitrite = "0.0"
        tempData.previousLogsPH = "7.8"
        tempData.previousLogsTemperature = "21"
        tempData.previousLogsDate = Date(timeIntervalSinceNow: -604800) //7days ago
        
        return tempData
        
    }
    
    
    func getSnapshot(for configuration: SelectAquariumIntent, in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        
        let data = self.samplePlaceholderWidgetData
        
        let entry = SimpleEntry(date: data.latestLogsDate, widgetData: data)
        completion(entry)
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        
        let data = self.samplePlaceholderWidgetData
        
        return SimpleEntry(date: data.latestLogsDate, widgetData: data)
    }
    
    func getTimeline(for configuration: SelectAquariumIntent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        
        var entries: [SimpleEntry] = []
        
        let container = StorageProvider.standard.persistentContainer
        
        let intentAquariumName : String = configuration.aquarium?.displayString ?? "intentAquariumName"
        
        let requestAquarium = NSFetchRequest<NSFetchRequestResult>(entityName: "AddAquarium")
        requestAquarium.predicate = NSPredicate(format: "aquariumName == %@", intentAquariumName)
        
        var data = WidgetData(aquariumName: "", aquariumID: "")
        
        do {
            let results = try (container.viewContext.fetch(requestAquarium) as! [AddAquarium])
            
            if !results.isEmpty {
                data.aquariumName = results[0].aquariumName ?? "Add aquarium"
                data.aquariumID = results[0].id ?? "AquariumId"
            }
        }
        catch {
            fatalError("Could not fetch AddAquarium\(error)")
        }
        
        let requestLog = NSFetchRequest<NSFetchRequestResult>(entityName: "AddLog")
        
        requestLog.predicate = NSPredicate(format: "id == %@", data.aquariumID)
        
        do {
            let resultsLog = try container.viewContext.fetch(requestLog) as! [AddLog]
            
            if !resultsLog.isEmpty {
                
                data.latestLogsAmmonia = String(resultsLog[resultsLog.count - 1].ammonia)
                data.latestLogsDate = resultsLog[resultsLog.count - 1].date ?? Date()
                data.latestLogsPH = String(resultsLog[resultsLog.count - 1].pH)
                data.latestLogsNitrite =  String(resultsLog[resultsLog.count - 1].nitrites)
                data.latestLogsNitrate = String(resultsLog[resultsLog.count - 1].nitrates)
                data.latestLogsTemperature = String(resultsLog[resultsLog.count - 1].temp)
                
                if resultsLog.count > 1 {
                    
                    data.previousLogsDate = resultsLog[resultsLog.count - 2].date ?? Date()
                    data.previousLogsPH = String(resultsLog[resultsLog.count - 2].pH)
                    data.previousLogsAmmonia = String(resultsLog[resultsLog.count - 2].ammonia)
                    data.previousLogsNitrite = String(resultsLog[resultsLog.count - 2].nitrites)
                    data.previousLogsNitrate = String(resultsLog[resultsLog.count - 2].nitrates)
                    data.previousLogsTemperature = String(resultsLog[resultsLog.count - 2].temp)
                    
                }
            }
        }
        catch {
            fatalError("Could not fetch AddLog \(error)")
        }
        
        let entry = SimpleEntry(date: data.latestLogsDate, widgetData: data)
        
        entries.append(entry)
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    
    let widgetData : WidgetData
}

struct WidgetData {
        
    init(aquariumName: String, aquariumID: String) {
        
        self.aquariumName = aquariumName
        self.aquariumID = aquariumID
        
        self.latestLogsAmmonia = "3.25"
        self.latestLogsTemperature = "-"
        self.latestLogsPH = "-"
        self.latestLogsNitrite = "-"
        self.latestLogsNitrate = "-"
        self.latestLogsDate = Date()
        
        self.previousLogsAmmonia = "-"
        self.previousLogsTemperature = "-"
        self.previousLogsPH = "-"
        self.previousLogsNitrite = "-"
        self.previousLogsNitrate = "-"
        self.previousLogsDate = Date()
        
    }
    
    var aquariumName : String
    var aquariumID : String
    
    var latestLogsAmmonia : String
    var latestLogsTemperature : String
    var latestLogsPH : String
    var latestLogsNitrite : String
    var latestLogsNitrate : String
    var latestLogsDate : Date
    
    var previousLogsAmmonia : String
    var previousLogsTemperature : String
    var previousLogsPH : String
    var previousLogsNitrite : String
    var previousLogsNitrate : String
    var previousLogsDate : Date
    
}

struct AquariumLifeWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @Environment(\.colorScheme) var colorSchemeAmmonia
    
    private var ammoniaColor : Color  {
        guard let tempAmmoniaColor = Double(entry.widgetData.latestLogsAmmonia) else { return .green}
        if tempAmmoniaColor == 0.0 {
            return .green
        } else if tempAmmoniaColor > 0 && tempAmmoniaColor <= 1.0 {
            return .yellow
        } else {
            return .red
        }
    }
    
    private var nitratesColor : Color {
        guard let tempNitrateColor = Double(entry.widgetData.latestLogsNitrate) else {
            return .green
        }
        if tempNitrateColor < 30 {
            return .green
        } else if tempNitrateColor > 30 && tempNitrateColor < 50 {
            return .yellow
        } else {
            return .red
        }
    }
    
    private var nitritesColor : Color {
        guard let tempNitriteColor = Double(entry.widgetData.latestLogsNitrite) else {
            return .green
        }
        if tempNitriteColor == 0 {
            return .green
        }
        else if tempNitriteColor > 0 && tempNitriteColor <= 1.0 {
            return .yellow
        }
        else {
            return .red
        }
    }
    
    private var pHColor : Color {
        guard let tempPhColor = Double(entry.widgetData.latestLogsPH) else {
            return .green
        }
        if tempPhColor <= 7.5 {
            return .blue
        } else {
            return .green
        }
    }
    
    private var pHLevel : String {
        guard let tempPhLevel = Double(entry.widgetData.latestLogsPH) else {
            return "Low"
        }
        if tempPhLevel <= 7.5 {
            return "Low"
        } else {
            return "High"
        }
    }
    
    private var prevAmmoniaColor : Color {
        guard let tempColor = Double(entry.widgetData.previousLogsAmmonia) else {
            return .green}
        if tempColor == 0.0 {
            return .green
        } else if tempColor > 0 && tempColor <= 1.0 {
            return .yellow
        } else {
            return .red
        }
    }
    
    private var prevNitrateColor : Color {
        guard let tempColor = Double(entry.widgetData.previousLogsNitrate) else {
            return .green
        }
        if tempColor < 30 {
            return .green
        } else if tempColor > 30 && tempColor < 50 {
            return .yellow
        } else {
            return .red
        }
    }
    
    private var prevNitriteColor : Color {
        guard let tempColor = Double(entry.widgetData.previousLogsNitrite) else {
            return .green
        }
        if tempColor == 0 {
            return .green
        }
        else if tempColor > 0 && tempColor <= 1.0 {
            return .yellow
        }
        else {
            return .red
        }
    }
    
    private var prevPHColor : Color {
        guard let tempColor = Double(entry.widgetData.previousLogsPH) else {
            return .green
        }
        if tempColor <= 7.5 {
            return .blue
        } else {
            return .green
        }
    }
    
    private var prevPHLevel : String {
        guard let tempPHLevel = Double(entry.widgetData.previousLogsPH) else {
            return "Low)"
        }
        if tempPHLevel <= 7.5 {
            return "Low"
        } else {
            return "High"
        }
    }
    
    private static let deeplinkURL = URL(string: "aquarium-life://myAquariums/")!
    
    let dateFormatter = DateFormatter()
    
    var body: some View {
        switch family {
        case .systemSmall:
            ZStack {
                GeometryReader { geometry in
                    VStack {
                        
                        Text(LocalizedStringKey("\(entry.widgetData.aquariumName)"))
                            .font(.callout)
                            .fontWeight(.medium)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .lineLimit(2)
                            .frame(width: geometry.size.width, height: geometry.size
                                    .height/3)
                            .overlay(VStack{Divider().offset(x: 0, y: 24)})
                        
                        VStack {
                            //"\(LocalizedStringKey("Low"))"
                            Text (LocalizedStringKey("Ammonia"))
                                .font(.footnote)
                                .fontWeight(.light)
                            
                            Text("\(entry.widgetData.latestLogsAmmonia)")
                                .font(.largeTitle)
                                .foregroundColor(self.ammoniaColor)
                        }
                        .frame(width: geometry.size.width, height: (geometry.size
                                .height / 3) + 20)
                        //.background(Color.green)
                        
                        Text(entry.widgetData.latestLogsDate.dayAgoDisplay())
                            .font(.footnote)
                            .fontWeight(.light)
                            .frame(width: geometry.size.width, height: geometry.size
                                    .height/3 - 20)
                            //.background(Color.yellow)
                    }
                }
                .background(
                    LinearGradient(gradient:
                                    Gradient(colors: colorSchemeAmmonia == .light ?
                                                [Color.white, Color.white, Color.white, Color.blue ]
                                                :
                                                [Color.black, Color.black, Color.black, Color.blue ]
                                    ),startPoint: .top, endPoint: .bottom
                    )
                )
            }
            .widgetURL(Self.deeplinkURL)
        case .systemMedium:
            ZStack {
                GeometryReader { geometry in
                    VStack
                    {
                        Text(LocalizedStringKey("\(entry.widgetData.aquariumName)"))
                            .font(.title2)
                            .fontWeight(.light)
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            //.padding()
                            .lineLimit(1)
                            .frame(width: geometry.size.width,height: (geometry.size.height/4) + 6 )
                            .overlay(VStack{Divider().offset(x: 0, y: 24)})
                        //.background(Color.gray)
                        HStack {
                            HStack {
                                Text (LocalizedStringKey("Ammonia"))
                                    .font(.callout)
                                    //.fontWeight(.medium)
                                    .frame(width : 73)
                                //.background(Color.blue)
                                
                                Image(systemName: "circle.fill")
                                    .foregroundColor(
                                        self.ammoniaColor
                                    )
                                    .font(.callout)
                                    .frame(width : 14)
                                //.background(Color.red)
                                Text("\(entry.widgetData.latestLogsAmmonia)")
                                    .font(.callout)
                                    //.fontWeight(.medium)
                                    .frame(width : 43)
                                //.background(Color.red)
                            }
                            //.background(Color.blue)
                            
                            //Nitrites
                            HStack {
                                Text (LocalizedStringKey("Nitrites"))
                                    .foregroundColor(
                                        colorSchemeAmmonia == .dark ? .white : .black
                                    )
                                    .font(.callout)
                                    .frame(width : 73)
                                //.background(Color.blue)
                                Image(systemName: "circle.fill")
                                    .foregroundColor(
                                        self.nitritesColor
                                    )
                                    .font(.callout)
                                    .frame(width : 14)
                                //.background(Color.red)
                                Text("\(entry.widgetData.latestLogsNitrite)")
                                    .font(.callout)
                                    .frame(width : 43)
                                //.background(Color.red)
                            }
                        }
                        .frame(width : geometry.size.width, height : (geometry.size.height/4) )
                        //.background(Color.orange)
                        HStack {
                            HStack {
                                Text (LocalizedStringKey("Nitrates"))
                                    .foregroundColor(
                                        colorSchemeAmmonia == .dark ? .white : .black
                                    )
                                    .font(.callout)
                                    .frame(width : 73)
                                Image(systemName: "circle.fill")
                                    .foregroundColor(
                                        self.nitratesColor
                                    )
                                    .font(.callout)
                                    .frame(width : 14)
                                Text("\(entry.widgetData.latestLogsNitrate)")
                                    .font(.callout)
                                    .frame(width : 43)
                            }
                            //Ph
                            HStack {
                                Text ("pH: \(entry.widgetData.latestLogsPH)")
                                    .foregroundColor(
                                        colorSchemeAmmonia == .dark ? .white : .black
                                    )
                                    .font(.callout)
                                    .frame(width : 73)
                                Image(systemName: "circle.fill")
                                    .foregroundColor(
                                        self.pHColor
                                    )
                                    .font(.callout)
                                    .frame(width : 14)
                                Text(self.pHLevel)
                                    .font(.callout)
                                    .frame(width : 43)
                            }
                            //.background(Color.red)
                            
                        }
                        .frame(width : geometry.size.width, height : geometry.size.height/4)
                        //.background(Color.blue)
                        Text(entry.widgetData.latestLogsDate.dayAgoDisplay())
                            .font(.callout)
                            .frame(width : geometry.size.width, height: geometry.size.height/4 - 6)
                        //.background(Color.blue)
                    }
                }
                //
                .background(
                    LinearGradient(gradient:
                                    Gradient(colors: colorSchemeAmmonia == .light ?
                                                [ Color.white,Color.white,Color.white, Color.blue ]
                                                :
                                                [ Color.black,Color.black,Color.black, Color.blue ]
                                    ),startPoint: .top, endPoint: .bottom
                    )
                )
            }
            .widgetURL(Self.deeplinkURL)
        default:
            ZStack {
                GeometryReader { geometry in
                    VStack {
                        VStack {
                            Text(LocalizedStringKey("\(entry.widgetData.aquariumName)"))
                                .font(.title2)
                                .fontWeight(.light)
                                .lineLimit(1)
                                .frame(width: geometry.size.width + 8 , height: (geometry.size.height/7) )                               .overlay(VStack{Divider().offset(x: 1, y: 24)})
                        }
                        HStack {
                            Text(LocalizedStringKey("Latest"))
                                .font(.callout)
                                .frame(width: geometry.size.width/2, height: geometry.size.height/7)
                            //.background(Color.blue)
                            Text(LocalizedStringKey("Previous"))
                                .font(.callout)
                                .frame(width: geometry.size.width/2, height: geometry.size.height/7)
                            //.background(Color.blue
                        }
                        .frame(width: geometry.size.width)
                        //.background(Color.red)
                        HStack {
                            HStack {
                                Text(LocalizedStringKey("Ammonia"))
                                    .frame(width: 73)
                                Image(systemName: "circle.fill")
                                    .frame(width: 14)
                                    .foregroundColor(ammoniaColor)
                                Text("\(entry.widgetData.latestLogsAmmonia)")
                                    .frame(width: 43)
                            }
                            .frame(width: geometry.size.width/2, height: geometry.size.height/7)
                            //.background(Color.blue)
                            HStack {
                                Text(LocalizedStringKey("Ammonia"))
                                    .frame(width: 73)
                                Image(systemName: "circle.fill")
                                    .frame(width: 14)
                                    .foregroundColor(prevAmmoniaColor)
                                Text("\(entry.widgetData.previousLogsAmmonia)")
                                    .frame(width: 43)
                            }
                            .frame(width: geometry.size.width/2, height: geometry.size.height/7)
                            //.background(Color.blue)
                        }
                        //.background(Color.blue)
                        HStack {
                            HStack {
                                Text(LocalizedStringKey("Nitrites"))
                                    .frame(width: 73)
                                Image(systemName: "circle.fill")
                                    .frame(width: 14)
                                    .foregroundColor(nitritesColor)
                                Text("\(entry.widgetData.latestLogsNitrite)")
                                    .frame(width: 43)
                            }
                            .frame(width: geometry.size.width/2, height: geometry.size.height/7)
                            //.background(Color.blue)
                            HStack {
                                Text(LocalizedStringKey("Nitrites"))
                                    .frame(width: 73)
                                Image(systemName: "circle.fill")
                                    .frame(width: 14)
                                    .foregroundColor(prevNitriteColor)
                                Text("\(entry.widgetData.previousLogsNitrite)")
                                    .frame(width: 43)
                            }
                            .frame(width: geometry.size.width/2, height: geometry.size.height/7)
                            //.background(Color.blue)
                        }
                        //.background(Color.orange)
                        
                        HStack {
                            HStack{
                                Text(LocalizedStringKey("Nitrates"))
                                    .frame(width: 73)
                                Image(systemName: "circle.fill")
                                    .frame(width: 14)
                                    .foregroundColor(nitratesColor)
                                Text("\(entry.widgetData.latestLogsNitrate)")
                                    .frame(width: 43)
                            }
                            .frame(width: geometry.size.width/2, height: geometry.size.height/7)
                            //.background(Color.blue)
                            HStack {
                                Text(LocalizedStringKey("Nitrates"))
                                    .frame(width: 73)
                                Image(systemName: "circle.fill")
                                    .frame(width: 14)
                                    .foregroundColor(prevNitrateColor)
                                Text("\(entry.widgetData.previousLogsNitrate)")
                                    .frame(width: 43)
                            }
                            .frame(width: geometry.size.width/2, height: geometry.size.height/7)
                            //.background(Color.blue)
                        }
                        //.background(Color.blue)
                        
                        HStack {
                            HStack {
                                Text("pH: \(entry.widgetData.latestLogsPH)")
                                    .frame(width: 73)
                                Image(systemName: "circle.fill")
                                    .frame(width: 14)
                                    .foregroundColor(pHColor)
                                Text(pHLevel)
                                    .frame(width: 43)
                            }
                            .frame(width: geometry.size.width/2, height: geometry.size.height/7)
                            //.background(Color.blue)
                            HStack {
                                Text("pH: \(entry.widgetData.previousLogsPH)")
                                    .frame(width: 73)
                                Image(systemName: "circle.fill")
                                    .frame(width: 14)
                                    .foregroundColor(prevPHColor)
                                Text(prevPHLevel)
                                    .frame(width: 43)
                            }
                            .frame(width: geometry.size.width/2, height: geometry.size.height/7)
                            //.background(Color.blue)
                        }
                        //.background(Color.red)
                        
                        HStack {
                            Text(entry.widgetData.latestLogsDate.dayAgoDisplay())
                                .font(.footnote)
                                .frame(width: geometry.size.width/2)
                            Text(entry.widgetData.previousLogsDate.dayAgoDisplay())
                                .font(.footnote)
                                .frame(width: geometry.size.width/2)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/7)
                        //.background(Color.gray)
                    }
                }
                .background(
                    LinearGradient(gradient:
                                    Gradient(colors: colorSchemeAmmonia == .light ?
                                                [Color.white, Color.white, Color.white,Color.white,Color.white, Color.blue ]
                                                :
                                                [Color.black,Color.black, Color.black,Color.black,Color.black, Color.blue ]
                                    ),startPoint: .top, endPoint: .bottom
                    )
                )
            }
            .widgetURL(Self.deeplinkURL)
        }
    }
}

extension Date {
    func dayAgoDisplay() -> String {
        let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
        if diff == 1 {
            return "\(diff) day ago"
        }
        return "\(diff) days ago"
    }
}

@main
struct AquariumLifeWidget: Widget {
    let kind: String = Constants.Widget.kind
    
    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: SelectAquariumIntent.self,
            provider: Provider()
        ) { entry in
            AquariumLifeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(LocalizedStringKey("Water test results"))
        .description(LocalizedStringKey("Quickly glance at the log records for every aquarium"))
        .supportedFamilies([.systemSmall,.systemMedium,.systemLarge])
    }
}

struct AquariumLifeWidget_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            
            AquariumLifeWidgetEntryView(entry: SimpleEntry(date: Date(), widgetData: WidgetData(aquariumName: "Green mountains", aquariumID: "123")))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .previewDevice("iPhone 6s")
                .previewDisplayName("iPhone 6s")
                .preferredColorScheme(.dark)
            
            AquariumLifeWidgetEntryView(entry: SimpleEntry(date: Date(), widgetData: WidgetData(aquariumName: "Green mountaina qu aaaaad dasdasdasdasdasdasdasd", aquariumID: "123")))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .previewDevice("iPhone 6s")
                .previewDisplayName("iPhone6s- 2line")
            
            AquariumLifeWidgetEntryView(entry: SimpleEntry(date: Date(), widgetData: WidgetData(aquariumName: "Greenssssssssss mountains", aquariumID: "123")))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .previewDevice("iPhone 12 Max Pro")
                .previewDisplayName("iPhone 12 Max Pro")
            
            AquariumLifeWidgetEntryView(entry: SimpleEntry(date: Date(), widgetData: WidgetData(aquariumName: "Green mountains aquarium 567890", aquariumID: "123")))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .previewDevice("iPhone 11")
                .previewDisplayName("iPhone 11")
            
            AquariumLifeWidgetEntryView(entry: SimpleEntry(date: Date(), widgetData: WidgetData(aquariumName: "Green mountains aquarium sad", aquariumID: "123")))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .previewDevice("iPhone 6s")
                .previewDisplayName("iPhone 6s")
            
            AquariumLifeWidgetEntryView(entry: SimpleEntry(date: Date(), widgetData: WidgetData(aquariumName: "Green mountains aquarium sad", aquariumID: "123")))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .previewDevice("iPhone 11")
                .previewDisplayName("iPhone 11")
            
            AquariumLifeWidgetEntryView(entry: SimpleEntry(date: Date(), widgetData: WidgetData(aquariumName: "Green mountains aquariums", aquariumID: "123")))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .previewDevice("iPhone 12 Max Pro")
                .previewDisplayName("iPhone 12 Max Pro")
            
            AquariumLifeWidgetEntryView(entry: SimpleEntry(date: Date(), widgetData: WidgetData(aquariumName: "Green mountains", aquariumID: "123")))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .previewDevice("iPhone 12 Max Pro")
                .previewDisplayName("iPhone 12 Max Pro")
            
            AquariumLifeWidgetEntryView(entry: SimpleEntry(date: Date(), widgetData: WidgetData(aquariumName: "Green mountains", aquariumID: "123")))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .previewDevice("iPhone 7 plus")
                .previewDisplayName("iPhone 7 plus - dark")
                .preferredColorScheme(.dark)
                            
            AquariumLifeWidgetEntryView(entry: SimpleEntry(date: Date(), widgetData: WidgetData(aquariumName: "Green mountains", aquariumID: "123")))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .previewDevice("iPhone 11")
                .previewDisplayName("iPhone 11")
            
        }
        Group {
            
            AquariumLifeWidgetEntryView(entry: SimpleEntry(date: Date(), widgetData: WidgetData(aquariumName: "Green mountains", aquariumID: "123")))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .previewDevice("iPhone 6s")
                .previewDisplayName("iPhone 6s")
            
            AquariumLifeWidgetEntryView(entry: SimpleEntry(date: Date(), widgetData: WidgetData(aquariumName: "Greenssssssssss mountains", aquariumID: "123")))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .previewDevice("iPhone 12 Max Pro")
                .previewDisplayName("iPhone 12 Max Pro")
            
            AquariumLifeWidgetEntryView(entry: SimpleEntry(date: Date(), widgetData: WidgetData(aquariumName: "Green mountains aquarium 567890", aquariumID: "123")))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .previewDevice("iPhone 11")
                .previewDisplayName("iPhone 11")
            
            AquariumLifeWidgetEntryView(entry: SimpleEntry(date: Date(), widgetData: WidgetData(aquariumName: "Green mountains aquarium sad", aquariumID: "123")))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .previewDevice("iPhone Xr")
                .previewDisplayName("iPhone Xr")
            
            AquariumLifeWidgetEntryView(entry: SimpleEntry(date: Date(), widgetData: WidgetData(aquariumName: "Green mountains aquarium sad", aquariumID: "123")))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .previewDevice("iPhone 11")
                .previewDisplayName("iPhone 11")
                //.previewContext()
        }
    }
}
