;;; abn-core-packages.el --- Default package selection

;;; Commentary:
;;

;;; Code:
(eval-when-compile
  (require 'cl))
(require 'package)

;; Always load the newer .el or .elc file.
(setq load-prefer-newer t)

(setq package-archives '(("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(defun abn-install-use-package ()
  "Install `use-package'."
  (unless (package-installed-p 'use-package)
    (message "%s" "Refreshing package database...")
    (package-refresh-contents)
    (message "done.")
    (package-install 'use-package)))

(abn-install-use-package)

(require 'use-package)
(setq use-package-always-ensure t)

(use-package which-key
  :defer nil ; load immediately
  )

(use-package bind-map
  :defer nil ; load immediately
  )

(use-package dash
  :defer nil ; load immediately
  )

(use-package evil
  :defer nil ; load immediately
  )

(use-package f
  :defer nil ; load immediately
  )

(use-package spacemacs-theme
  :defer nil ; load immediately
  )

(defun abn-package-menu-find-marks ()
  "Find packages marked for action in *Packages*."
  (interactive)
  (occur "^[A-Z]"))

(defun abn-package-menu-filter-by-status (status)
  "Filter the *Packages* buffer by status."
  (interactive
   (list (completing-read
          "Status: " '("new" "installed" "dependency" "obsolete"))))
  (package-menu-filter (concat "status:" status)))

(define-key package-menu-mode-map "s" #'abn-package-menu-filter-by-status)
(define-key package-menu-mode-map "a" #'abn-package-menu-find-marks)

(provide 'abn-core-packages)
;;; abn-core-packages.el ends here
