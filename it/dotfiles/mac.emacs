;--------------------------------------------------
; Modes
(setq auto-mode-alist
      (append '(("\\.txt$"   . text-mode)
                ("\\.h$"     . c++-mode)
                ("\\.for$"   . fortran-mode))
              auto-mode-alist))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;--------------------------------------------------
; Colors
(require 'color-theme)
   (color-theme-initialize)
   (color-theme-dark-laptop)

;--------------------------------------------------
; Transparency
(setq transparency-level 90)
(set-frame-parameter nil 'alpha transparency-level)
(add-hook 'after-make-frame-functions (lambda (selected-frame)
(set-frame-parameter selected-frame 'alpha transparency-level)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(display-battery-mode t)
 '(inhibit-startup-screen t)
 '(show-paren-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "OrangeRed" :slant italic :width normal))))
 '(primary-selection ((t (:background "darkslategrey"))))
 '(region ((t (:background "darkslategrey")))))
