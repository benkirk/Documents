;--------------------------------------------------
; Modes
(setq auto-mode-alist
      (append '(("\\.txt$"   . text-mode)
                ("\\.h$"     . c++-mode)
                ("\\.for$"   . fortran-mode))
              auto-mode-alist))

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq-default indent-tabs-mode nil)


; ;--------------------------------------------------
; ; Transparency
; (setq transparency-level 90)
; (set-frame-parameter nil 'alpha transparency-level)
; (add-hook 'after-make-frame-functions (lambda (selected-frame)
; (set-frame-parameter selected-frame 'alpha transparency-level)))


; (use-package tex
;   :ensure auctex)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark))
 '(display-battery-mode t)
 '(inhibit-startup-screen t)
 '(package-selected-packages '(auctex))
 '(ring-bell-function 'ignore)
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "OrangeRed" :slant italic :width normal)))))

;--------------------------------------------------
; Tramp
(customize-set-variable 'tramp-verbose 6 "Enable remote command traces")
(connection-local-set-profile-variables
 'remote-without-auth-sources '((auth-sources . nil)))
(setq
 tramp-password-prompt-regexp
 (concat
  "^.*"
  (regexp-opt
   '("passphrase" "Passphrase"
     ;; English
     "password" "Token_Response"
     ;; Deutsch
     "passwort" "Passwort"
     ;; Français
     "mot de passe" "Mot de passe") t)
  ".*:\0? *"))
