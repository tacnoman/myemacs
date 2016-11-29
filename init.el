;;;(setq make-backup-files nil)

(add-to-list 'load-path "~/.emacs.d/themes/")
(add-to-list 'load-path "~/.emacs.d/elpa/neotree")
(add-to-list 'load-path "~/.emacs.d/custom")

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(global-linum-mode t)
(load-theme 'wombat)

;; Find file
(global-set-key (kbd "C-x f") 'fiplr-find-file)

;; Cursor
(setq-default cursor-type 'bar)

;; No tabs
(setq-default indent-tabs-mode nil)
(setq tab-width 2) ; or any other preferred value
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;; Space between line
(setq linum-format "%4d \u2502 ")

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js-indent-level 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;; For ruby env
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'robe-mode-hook 'ac-robe-setup)

;; RVM
(require 'rvm)
(rvm-use-default) ;; use rvm's default ruby for the current Emacs session

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

;; Autocomplete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
             "~/.emacs.d/.cask/24.3.50.1/elpa/auto-complete-20130724.1750/dict")
(ac-config-default)
(setq ac-ignore-case nil)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)

; JSX and ECMA
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
(add-to-list 'auto-mode-alist '("\\.es6\\'" . jsx-mode))
(autoload 'jsx-mode "jsx-mode" "JSX mode" t)

;(load "00common-setup.el")
;(load "01ruby.el")
;(load "02org.el")


(defun my-macro-query (arg)
        "Prompt for input using minibuffer during kbd macro execution.
    With prefix argument, allows you to select what prompt string to use.
    If the input is non-empty, it is inserted at point."
        (interactive "P")
        (let* ((query (lambda () (kbd-macro-query t)))
               (prompt (if arg (read-from-minibuffer "PROMPT: ") "Input: "))
               (input (unwind-protect
                          (progn
                            (add-hook 'minibuffer-setup-hook query)
                            (read-from-minibuffer prompt))
                        (remove-hook 'minibuffer-setup-hook query))))
          (unless (string= "" input) (insert input))))
(global-set-key "\C-xQ" 'my-macro-query)

