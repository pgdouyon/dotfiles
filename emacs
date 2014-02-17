;==================================================
;Start Emacs server
;==================================================
(server-start)

;==================================================
;Import package archives
;==================================================
(require 'package)

;In order for the Helm package to initialize properly, cl-lib MUST be loaded first
(setq package-load-list '((cl-lib t)))
(package-initialize)
(require 'cl-lib)

(add-to-list 'package-archives
	     '("elpa" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives
	     '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq package-load-list '(all))
(package-initialize)

;==================================================
;Install packages
;==================================================
(unless (package-installed-p 'auctex)
  (package-install 'auctex))
(unless (package-installed-p 'magit)
  (package-install 'magit))
(unless (package-installed-p 'ace-jump-mode)
  (package-install 'ace-jump-mode))
(unless (package-installed-p 'ace-jump-buffer)
  (package-install 'ace-jump-buffer))
(unless (package-installed-p 'diminish)
  (package-install 'diminish))
;packages to consider:
;projectile, rainbow-delimiter, flycheck, flyspell, flx-ido, helm

;Evil Packages
(unless (package-installed-p 'evil)
  (package-install 'evil))
(unless (package-installed-p 'key-chord)
  (package-install 'key-chord))
(unless (package-installed-p 'surround)
  (package-install 'surround))
(unless (package-installed-p 'evil-leader)
  (package-install 'evil-leader))
(unless (package-installed-p 'evil-nerd-commenter)
  (package-install 'evil-nerd-commenter))
(unless (package-installed-p 'evil-indent-textobject)
  (package-install 'evil-indent-textobject))

;Color Themes
(unless (package-installed-p 'color-theme-solarized)
  (package-install 'color-theme-solarized))
(unless (package-installed-p 'color-theme-sanityinc-tomorrow)
  (package-install 'color-theme-sanityinc-tomorrow))
(unless (package-installed-p 'sublime-themes)
  (package-install 'sublime-themes))

;Clojure development
(unless (package-installed-p 'cider)
  (package-install 'cider))
(unless (package-installed-p 'smartparens)
  (package-install 'smartparens))
(unless (package-installed-p 'rainbow-delimiters)
 (package-install 'rainbow-delimiters))
(unless (package-installed-p 'clojure-cheatsheet)
  (package-install 'clojure-cheatsheet))

;==================================================
;Initialize packages
;==================================================
(require 'color-theme)
(color-theme-initialize)

(require 'evil)
(require 'evil-leader)
(require 'evil-indent-textobject)
(require 'evil-nerd-commenter)
(require 'surround)
(global-evil-leader-mode)
(global-surround-mode 1)
(evil-mode 1)
(evilnc-default-hotkeys)

(require 'key-chord)
(key-chord-mode 1)

(require 'ace-jump-mode)
(require 'ace-jump-buffer)

(require 'cider)
(require 'clojure-cheatsheet)
(require 'smartparens-config)
(require 'rainbow-delimiters)
(add-hook 'clojure-mode 'cider-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(smartparens-global-mode t)

;(require 'diminish)
;(diminish 'undo-tree)
;this should be towards the end of the init file

;TODO - set up customizations for: Magit, AucTex, Diminish, OrgMode

;(require 'solarized-dark-theme)
(require 'color-theme-sanityinc-tomorrow)
(color-theme-sanityinc-tomorrow--define-theme eighties)
;(load-theme 'spolsky)
;==================================================
;Set global defaults
;==================================================
(setq-default indent-tabs-mode nil)
(global-linum-mode t)
(menu-bar-mode -1)
(tool-bar-mode -1)

;==================================================
;Evil key mappings
;==================================================
(key-chord-define evil-insert-state-map "hh" 'evil-normal-state)
(key-chord-define evil-replace-state-map "hh" 'evil-normal-state)
(key-chord-define evil-visual-state-map "hh" 'evil-change-to-previous-state)
(key-chord-define evil-normal-state-map "hh" 'evil-force-normal-state)
(define-key evil-normal-state-map "\\" 'evil-repeat-find-char-reverse)

(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-word-mode)
(define-key evil-normal-state-map (kbd "S-SPC") 'ace-jump-buffer)

(evil-leader/set-leader ",")
(evil-leader/set-key "pu" 'sp-unwrap-sexp
                     "pbu" 'sp-backward-unwrap-sexp
                     "psp" 'sp-splice-sexp
                     "pa" 'sp-absorb-sexp
                     "pe" 'sp-emit-sexp
                     "pfs" 'sp-forward-slurp-sexp
                     "pfb" 'sp-forward-barf-sexp
                     "pbs" 'sp-backward-slurp-sexp
                     "pbb" 'sp-backward-barf-sexp
                     "pfw" 'sp-forward-sexp
                     "pbw" 'sp-backward-sexp)
(evil-leader/set-key "lr" 'cider-jack-in
                     "le" 'cider-eval-region
                     "lm" 'cider-macroexpand-1
                     "llb" 'cider-load-current-buffer
                     "lq" 'cider-quit)

;==================================================
;Cider Settings
;==================================================
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

(setq cider-popup-stacktraces nil)
(setq cider-repl-popup-stacktraces t)
(setq cider-repl-wrap-history t)
(setq cider-repl-history-file "~/Documents/temp/cider_repl_history.clj")

(setq clojure-defun-style-default-indent t)

;==================================================
;AUCTeX Settings
;==================================================
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
;==================================================
;Key bindings
;==================================================
;bind C-x C-f, C-x C-b, C-x b
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-blue)))
 '(custom-safe-themes (quote ("82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
