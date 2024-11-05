; https://github.com/radian-software/straight.el#getting-started
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(setq package-enable-at-startup nil)

;
(add-to-list 'load-path "~/.emacs.d/site-lisp")

; https://github.com/yoshiki/yaml-mode.git
(require 'yaml-mode)

;--------------------------------------------------
; Modes
(setq auto-mode-alist
      (append '(("\\.txt$"   . text-mode)
                ("\\.h$"     . c++-mode)
                ("\\.yml\\'" . yaml-mode)
                ("\\.yaml\\'" . yaml-mode)
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
;; from https://stackoverflow.com/questions/56105716/magit-over-tramp-re-use-ssh-connection
;; Alternatively, if you want to tell Tramp to use the customisations in your ~/.ssh/config file you need to change the tramp-use-ssh-controlmaster-options variable:
(customize-set-variable 'tramp-use-ssh-controlmaster-options nil)
;; (connection-local-set-profile-variables
;;  'remote-without-auth-sources '((auth-sources . nil)))
;; (setq
;;  tramp-password-prompt-regexp
;;  (concat
;;   "^.*"
;;   (regexp-opt
;;    '("passphrase" "Passphrase"
;;      ;; English
;;      "password" "Token_Response"
;;      ;; Deutsch
;;      "passwort" "Passwort"
;;      ;; Français
;;      "mot de passe" "Mot de passe") t)
;;   ".*:\0? *"))



;--------------------------------------------------
; https://github.com/copilot-emacs/copilot.el#installation
(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :ensure t)
(require 'copilot)

;; enable completion automatically
;;(load bootstrap-file nil 'nomessage))(add-hook 'prog-mode-hook 'copilot-mode)

; https://robert.kra.hn/posts/2023-02-22-copilot-emacs-setup/
(defun rk/copilot-complete-or-accept ()
  "Command that either triggers a completion or accepts one if one
is available."
  (interactive)
  (if (copilot--overlay-visible)
      (progn
        (copilot-accept-completion)
        (open-line 1)
        (next-line))
    (copilot-complete)))

(define-key copilot-mode-map (kbd "M-C-<up>") #'copilot-next-completion)
(define-key copilot-mode-map (kbd "M-C-<left>") #'copilot-previous-completion)
(define-key copilot-mode-map (kbd "M-C-<right>") #'copilot-accept-completion-by-word)
(define-key copilot-mode-map (kbd "M-C-<down>") #'copilot-accept-completion-by-line)
(define-key copilot-mode-map (kbd "M-<tab>") #'copilot-accept-completion)
(define-key global-map (kbd "M-C-<return>") #'rk/copilot-complete-or-accept)


;--------------------------------------------------
; https://github.com/chep/copilot-chat.el
(use-package copilot-chat
  :straight (:host github :repo "chep/copilot-chat.el" :files ("*.el"))
  :after (request))


;; Local Variables:
;; mode: lisp
;; End:
