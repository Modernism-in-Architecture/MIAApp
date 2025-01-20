//
//  MIAappApp.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import SwiftUI
import BackgroundTasks
import MIACoreNetworking

@main
struct MIAappApp: App {
    
    @Environment(\.scenePhase)
    private var phase
    
    @StateObject
    var router = MIARouter()
    
    @StateObject
    var buildingsListViewModel = BuildingsListViewModel()
    
    @StateObject
    var mapViewModel = MIAMapViewModel()
    
    @StateObject
    var architectsListViewModel = ArchitectsListViewModel()
    
    @StateObject
    var cloudKitBookmarksController = BookmarksViewModel()
    
    @State
    private var authorizationStatus: UNAuthorizationStatus?
        
    var body: some Scene {
        
        WindowGroup {
            
            ContentView()
                .environmentObject(router)
                .environmentObject(buildingsListViewModel)
                .environmentObject(mapViewModel)
                .environmentObject(architectsListViewModel)
                .environmentObject(cloudKitBookmarksController)
                .task {
                    scheduleRefresh()
                }
                .task {
                    
                    buildingsListViewModel.fetch()
                    architectsListViewModel.fetch()
                }
                .task {
                    if authorizationStatus == .none {
                        await requestAuthorization()
                    }
                }
                .onOpenURL { url in
                    
                    router.deepLinkTarget = url
                    router.checkDeepLinkTarget()
                }
        }
        
//        .onChange(of: phase) {
//            handeChange(of: phase)
//        }
        .backgroundTask(.appRefresh("refresh")) {
            print("called")
            await scheduleRefresh()
            await checkForNewBuildings()
        }
    }
}

extension MIAappApp {
    
    func requestAuthorization() async {
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        _ = try? await notificationCenter.requestAuthorization(options: [.alert, .sound, .badge])
        authorizationStatus = await notificationCenter.notificationSettings().authorizationStatus
        
        print("authorization requested")
        dump(authorizationStatus)
    }
    
//    func handeChange(of phase: ScenePhase) {
//        
//        switch phase {
//            
//        case .background:
//            scheduleRefresh()
//            
//        case .inactive:
//            break
//            
//        case .active:
//            break
//            
//        @unknown default:
//            break
//        }
//    }
    
    func scheduleRefresh() {
        
        let request = BGAppRefreshTaskRequest(identifier: "refresh")
        request.earliestBeginDate = .now.addingTimeInterval(1 * 60 * 60) // 1 hour
        do {
            try BGTaskScheduler.shared.submit(request)
            Task {
                let notificationCenter = UNUserNotificationCenter.current()
                try? await notificationCenter.setBadgeCount(1)
            }
            print("scheduled")
        } catch {
            print("error on scheduling")
            print(error)
        }
           
    }
    
    func checkForNewBuildings() async {
        
        let buildingsManager = BuildingsManager()
        let notificationCenter = UNUserNotificationCenter.current()
        
        try? await notificationCenter.setBadgeCount(5)
        
//        guard let date = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, year: 2024, month: 12, day: 01).date else {
//            return
//        }
//        
//        guard let newBuildingsCount = try? await buildingsManager.newBuildingsCount(since: date) else {
//            return
//        }
//
//        try? await notificationCenter.setBadgeCount(newBuildingsCount)
    }
}
