import UIKit

public extension UIButton {
    private enum AssociatedKeys {
        static var activityIndicatorView = "activityIndicatorView"
        static var activityIndicatorEnabled = "activityIndicatorEnabled"
    }

    private(set) var activityIndicatorView: UIActivityIndicatorView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.activityIndicatorView) as? UIActivityIndicatorView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.activityIndicatorView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

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

    private func ensureActivityIndicator() {
        // We always want to update the color if we are about to show
        guard activityIndicatorView == nil else { return }

        let activityIndicatorView = UIActivityIndicatorView(style: .white)
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

        let animationDelay: TimeInterval
        if !activityIndicatorEnabled {
            activityIndicatorView?.stopAnimating()
            animationDelay = 0.1
        } else {
            // Ensure its color reflects the latest we know
            activityIndicatorView?.color = titleColor(for: .normal)
            animationDelay = 0.0
        }

        UIView.animate(withDuration: 0.2, delay: animationDelay, options: .curveEaseInOut, animations: {
            self.titleLabel?.alpha = self.activityIndicatorEnabled ? 0.0 : 1.0
        }, completion: { _ in
            if self.activityIndicatorEnabled {
                self.activityIndicatorView?.startAnimating()
            }
        })
    }
}
