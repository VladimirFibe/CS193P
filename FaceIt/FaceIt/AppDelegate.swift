import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let controller = UISplitViewController(style: .doubleColumn)

        controller.setViewController(UINavigationController(rootViewController: EmotionsViewController()), for: .primary)
        controller.setViewController(UINavigationController(rootViewController: FaceViewController()) , for: .secondary)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        return true
    }
}

