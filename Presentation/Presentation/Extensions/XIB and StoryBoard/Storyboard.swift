import UIKit

extension UIStoryboard
{
    public enum StoryboardType: String
    {
        case authentication
        case home
        case main
        case createTrip
        case wallet
        case pinOnMap
        case savedPlaces
        case sideMenu
        case validatePromoCode
        case currentRides
        case selectLocation
        case myRides
        case promoCode
        case inputDialog
        case settings
        case infoDialog
        case about
        
        public var fileName: String
        {
            return firstUppercased
        }
        
        private var firstUppercased: String
        {
            return rawValue.prefix(1).uppercased() + rawValue.dropFirst()
        }
    }
    
    convenience public init(storyboard: StoryboardType, bundle: Bundle? = nil)
    {
        self.init(name: storyboard.fileName, bundle: bundle)
    }
    
    // MARK: View Controller Instantiation from Generics
    
    public func instantiateViewController<T: UIViewController>() -> T
    {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else
        {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
}

public protocol StoryboardIdentifiable
{
    static var storyboardIdentifier: String { get }
    static func instantiate(storyboard: UIStoryboard.StoryboardType) -> Self
}

extension StoryboardIdentifiable where Self: UIViewController
{
    public static var storyboardIdentifier: String
    {
        return String(describing: self)
    }
    
    public static func instantiate(storyboard: UIStoryboard.StoryboardType) -> Self
    {
        return UIStoryboard(storyboard: storyboard).instantiateViewController()
    }
}

extension UIViewController: StoryboardIdentifiable { }
