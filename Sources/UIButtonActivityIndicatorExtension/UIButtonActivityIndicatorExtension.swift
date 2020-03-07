import UIKit

public extension UIButton {
    private enum AssociatedKeys {
        static var activityIndicatorView = "activityIndicatorView"
        static var activityIndicatorEnabled = "activityIndicatorEnabled"
        static var activityIndicatorColor = "activityIndicatorColor"
    }

    /// The activity indicator view that is rendered in the vertical and horizontal center of the button.
    private(set) var activityIndicatorView: UIActivityIndicatorView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.activityIndicatorView) as? UIActivityIndicatorView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.activityIndicatorView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    /// When set to `true` it will fade out the label, disable user interaction through `isUserInteractionEnabled`, and begin animating the activity indicator.
    /// When changed back to `false` it will stop animating the activity indicator, fade the label back in, and re-enable user interaction.
    var activityIndicatorEnabled: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.activityIndicatorEnabled) as? Bool ?? false
        }
        set {
            ensureActivityIndicator()
            objc_setAssociatedObject(self, &AssociatedKeys.activityIndicatorEnabled, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            toggleActivityIndicator()
        }
    }

    /// A color for the activity indicator, if this property is set to `nil` the result of `titleColor(for:)` will be used in its place.
    var activityIndicatorColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.activityIndicatorColor) as? UIColor ?? titleColor(for: .normal)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.activityIndicatorColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            if activityIndicatorEnabled {
                activityIndicatorView?.color = newValue
            }
        }
    }

    private func ensureActivityIndicator() {
        // We always want to update the color if we are about to show
        guard activityIndicatorView == nil else { return }

        let activityIndicatorView: UIActivityIndicatorView
        if #available(iOS 13, *) {
            activityIndicatorView = UIActivityIndicatorView(style: .medium)
        } else {
            activityIndicatorView = UIActivityIndicatorView(style: .white)
        }
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.hidesWhenStopped = true
        addSubview(activityIndicatorView)

        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])

        self.activityIndicatorView = activityIndicatorView
    }

    private func toggleActivityIndicator() {
        isUserInteractionEnabled = !activityIndicatorEnabled

        if !activityIndicatorEnabled {
            activityIndicatorView?.stopAnimating()
        } else {
            activityIndicatorView?.color = activityIndicatorColor
        }

        UIView.animate(withDuration: 0.26, delay: 0, options: .curveEaseInOut, animations: {
            self.titleLabel?.alpha = self.activityIndicatorEnabled ? 0.0 : 1.0
        }, completion: { _ in
            if self.activityIndicatorEnabled {
                self.activityIndicatorView?.startAnimating()
            }
        })
    }
}
