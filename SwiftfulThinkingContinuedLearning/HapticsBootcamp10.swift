//
//  HapticsBootcamp10.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by User03 on 18.07.2023.
//

import SwiftUI

class HapticManager {
    static let instance = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}



struct HapticsBootcamp10: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("success") { HapticManager.instance.notification(type: .success)}
            Button("warning") { HapticManager.instance.notification(type: .warning)}
            Button("error") { HapticManager.instance.notification(type: .error)}
            Divider()
            Button("soft") { HapticManager.instance.impact(style: .soft)}
            Button("light") { HapticManager.instance.impact(style: .light)}
            Button("medium") { HapticManager.instance.impact(style: .medium)}
            Button("rigid") { HapticManager.instance.impact(style: .rigid)}
            Button("heavy") { HapticManager.instance.impact(style: .heavy)}
        }
    }
}

struct HapticsBootcamp10_Previews: PreviewProvider {
    static var previews: some View {
        HapticsBootcamp10()
    }
}
