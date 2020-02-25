;;; -*- lexical-binding: t; -*-
(setq ring-bell-function 'ignore) ; Turn off bell
;; Use MELPA (a package manager)
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
;; This presumes emacs 24.4 or above which is what I am using
(setq package-pinned-packages
	  '((doom-themes              . "melpa")))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-visited-mode t)
 '(global-visual-line-mode t)
 '(package-selected-packages
   (quote
	(aggressive-indent company spotlight neotree org-beautify-theme org-bullets doom-themes which-key helm undo-tree emojify))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-neotree-data-file-face ((t (:family "Source Sans Pro" :height 1.0 :foreground "#727280"))))
 '(doom-neotree-dir-face ((t (:family "Source Sans Pro" :height 1.0))))
 '(doom-neotree-file-face ((t (:family "Source Sans Pro" :height 1.0))))
 '(doom-neotree-hidden-file-face ((t (:family "Source Sans Pro" :height 1.0 :foreground "#525254"))))
 '(doom-neotree-media-file-face ((t (:family "Source Sans Pro" :height 1.0 :foreground "#66d9ef"))))
 '(doom-neotree-text-file-face ((t (:family "Source Sans Pro" :height 1.0))))
 '(org-date ((t (:family "SauceCodePro Nerd Font" :height 0.8 :foreground "#bbb"))))
 '(org-document-info ((t (:height 1.2 :slant italic))))
 '(org-document-info-keyword ((t (:height 0.8 :foreground "#bbb"))))
 '(org-document-title ((t (:inherit nil :family "EtBembo" :height 1.8 :foreground "#1c1e1f" :underline nil))))
 '(org-done ((t (nil))))
 '(org-ellipsis ((t (:underline nil :foreground "#525254"))))
 '(org-hide ((t (:foreground "#fbf8ef"))))
 '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
 '(org-level-1 ((t (:inherit nil :family "EtBembo" :height 1.6 :weight normal :slant normal :foreground "#1c1e1f"))))
 '(org-level-2 ((t (:inherit nil :family "EtBembo" :height 1.3 :weight normal :slant italic :foreground "#1c1e1f"))))
 '(org-level-3 ((t (:inherit nil :family "EtBembo" :height 1.2 :weight normal :slant italic :foreground "#1c1e1f"))))
 '(org-level-4 ((t (:inherit nil :family "EtBembo" :height 1.1 :weight normal :slant italic :foreground "#1c1e1f"))))
 '(org-level-5 ((t nil)))
 '(org-level-6 ((t nil)))
 '(org-level-7 ((t nil)))
 '(org-level-8 ((t nil)))
 '(org-link ((t (:foreground "#1c1e1f" :underline t))))
 '(org-list-dt ((t (:foreground "#1c1e1f"))))
 '(org-special-keyword ((t (:family "SauceCodePro Nerd Font" :height 0.8))))
 '(org-tag ((t (:foreground "#727280"))))
 '(org-todo ((t (:family "SauceCodePro Nerd Font" :height 0.8 :weight normal :foreground "#1c1e1f"))))
 '(variable-pitch ((t (:family "EtBembo" :background nil :foreground "#1c1e1f" :height 1.7)))))
(require 'all-the-icons) ;; all-the-icons
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-smart-open t) ;Move towards current file
(add-hook 'neo-after-create-hook
   #'(lambda (_)
       (with-current-buffer (get-buffer neo-buffer-name)
         (setq truncate-lines t)
         (setq word-wrap nil)
         (make-local-variable 'auto-hscroll-mode)
         (setq auto-hscroll-mode nil))))
(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode) ;; Indent shit https://github.com/Malabarba/aggressive-indent-mode
;; Doom Theme
(require 'doom-themes)
;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
(load-theme 'doom-solarized-light t)
(doom-themes-org-config); Corrects (and improves) org-mode's native fontification.
(doom-themes-neotree-config); requires neotree and all the icons

(setq scroll-bar-mode nil) ; Bye bye scroll bar
(setq-default cursor-type 'bar) ; Make cursor to be a bar
; Use left option key for mac and left option key for emacs
;(setq ns-option-modifier 'meta
;      ns-right-alternate-modifier 'none)
(setq inhibit-startup-screen t) ; Disable the stupid splash screen
(add-to-list 'default-frame-alist '(fullscreen . maximized)) ; Apparentlty sets initial frame size big.
(add-hook 'after-init-hook #'global-emojify-mode); Set emojify mode for all buffers
(add-hook 'after-init-hook 'global-company-mode) ; Enable company mode in all backends.
(setq company-idle-delay 0.1)
;; Sublime-Text and Apple-Inbox Replication
;; First we make sure that everything is backed up somewhere else.
;; Then we make sure that it is easy to create a file backup anonymous
;; buffer, then we create a daily buffer.
(define-key (current-global-map) (kbd "C-c u") ;; I need my £
				(lookup-key key-translation-map (kbd "C-x 8")))
(desktop-save-mode 1) ; Save desktop
(savehist-mode 1) ; Minibuffer history save
(setq history-length t) ; Unlimited command history
(let ((icloud "~/Library/Mobile Documents/com~apple~CloudDocs/")
      (Emacs-suffix "Emacs-Backups/")
      (EagleFiler-suffix "Documents/Files/@Write/"))
      (setq EagleFiler (concat icloud EagleFiler-suffix))
      (setq Emacs-Backups (concat icloud Emacs-suffix))
      (setq version-control t ;; Use version numbers for backups.
        kept-new-versions 10 ;; Number of newest versions to keep.
        kept-old-versions 0 ;; Number of oldest versions to keep.
        delete-old-versions t ;; Don't ask to delete excess backup versions.
        backup-by-copying t ;; Copy all files, don't rename them. Maybe needed to preserve finder tags.
        backup-directory-alist `(("" . ,Emacs-Backups)))
      (defun now-buffer ()
        "Create a new empty file backed buffer with a timestamp name."
        (interactive)
        (let ((now-name (format-time-string "%a-W%V-%Y-%H-%M-%S")))
          (find-file (expand-file-name (concat EagleFiler now-name ".org")))))
      (defun daily-buffer ()
        "Create a daily file backed buffer with a timestamp name"
      (interactive)
      (let ((daily-name (format-time-string "%a-W%V-%Y")))
      (find-file (expand-file-name (concat EagleFiler daily-name ".org")))))
      (global-set-key (kbd "C-c n") #'now-buffer)
      (global-set-key (kbd "C-c d") #'daily-buffer))
;;Org-mode
(require 'org) ; Enable Org mode
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(add-hook 'org-mode-hook 'variable-pitch-mode) ;variable-pitch-mode only inorg-mode
(add-hook 'org-mode-hook (lambda () (setq line-spacing 0.1))); line-spacing only in org-mode
(add-hook 'org-mode-hook (lambda () (progn
  (setq left-margin-width 2)
  (setq right-margin-width 2)
  (set-window-buffer nil (current-buffer))))) ; In theory this centers shit
(add-hook 'org-mode-hook (lambda () (setq mouse-highlight nil)))
(setq-default org-display-custom-times t) ; time stamps
(setq org-use-speed-commands t) ; Activate speed commands
(setq org-ellipsis "⤶" ; folding symbol
 org-bullets-bullet-list '(" ") ; no bullets
 org-fontify-whole-heading-line t ; Whole heading diff face
 org-fontify-done-headline t; Different face for done
 org-fontify-quote-and-verse-blocks t; Different faces for quotes
 org-time-stamp-custom-formats '("<%a W%V-%Y>" . "<%a W%V-%Y %H:%M>") ; Week View
 org-startup-indented t; Hopefully ensures that I have indentation.
 org-todo-keywords
	  '((sequence "Next-Action(t)" "W(w)" "|" "FIN(f)" "DEP(d)" "ND(n)")); Use my keywords
 org-log-done 'time; Timestamp in done
 org-hide-emphasis-markers t; Hides the emphasis delimiters */
 org-pretty-entities t; Converts \alpha into unicode
 org-odd-levels-only t; This means that each heading will have odd number of stars and odd number of spaces, IDK how this is useful.
 org-loop-over-headlines-in-active-region t; I believe this should ensure that I can select a bunch of things and do the same thing to them.
 org-tags-column 0; keep tags next to headings
 )
(let  ((bg-white           "#fbf8ef")
  (bg-dark            "#1c1e1f")
(gray          "#bbb")
(comment            "#525254")
 (keyword            "#f92672")
 (type               "#66d9ef")
 (doc                "#727280")
 (sans-mono-font     "SauceCodePro Nerd Font")
 (sans-font          "Source Sans Pro")
 (et-font            "EtBembo")
 (slate              "#8FA1B3")
 (hide-flag              1))
(custom-theme-set-faces 'user
   `(variable-pitch
   ((t (:family ,et-font
            :background nil
            :foreground ,bg-dark
            :height 1.7)))) ; Rogue had this set to 1.7
     `(doom-neotree-dir-face
   ((t (:family ,sans-font
            :height 1.0))))
      `(doom-neotree-file-face
   ((t (:family ,sans-font
            :height 1.0))))
       `(doom-neotree-text-file-face
   ((t (:family ,sans-font
            :height 1.0))))
      `(doom-neotree-hidden-file-face
   ((t (:family ,sans-font
            :height 1.0
            :foreground ,comment))))
  `(doom-neotree-media-file-face
   ((t (:family ,sans-font
            :height 1.0
            :foreground ,type))))
  `(doom-neotree-data-file-face
   ((t (:family ,sans-font
            :height 1.0
            :foreground ,doc))))
  `(org-document-title
 	((t (:inherit nil
 				:family ,et-font
 				:height 1.8
 				:foreground ,bg-dark
 				:underline nil))))
    '(org-document-info
   ((t (:height 1.2
            :slant italic))))
 `(org-level-1
   ((t (:inherit nil
             :family ,et-font
             :height 1.6
             :weight normal
             :slant normal
             :foreground ,bg-dark))))
  `(org-level-2
   ((t (:inherit nil
             :family ,et-font
             :height 1.3
             :weight normal
             :slant italic
             :foreground ,bg-dark))))
    `(org-level-3
   ((t (:inherit nil
             :family ,et-font
             :height 1.2
             :weight normal
             :slant italic
             :foreground ,bg-dark))))
    `(org-level-4
   ((t (:inherit nil
             :family ,et-font
             :height 1.1
             :weight normal
             :slant italic
             :foreground ,bg-dark))))
    '(org-level-5 ((t nil)))
    '(org-level-6 ((t nil)))
       '(org-level-7 ((t nil)))
          '(org-level-8 ((t nil)))
      `(org-document-info-keyword
   ((t (:height 0.8
            :foreground ,gray))))
      `(org-link
        ((t (:foreground ,bg-dark :underline t)))
			)
        `(org-special-keyword
   ((t (:family ,sans-mono-font
            :height 0.8))))
        `(org-todo ((t (:family ,sans-mono-font :height 0.8 :weight normal :foreground ,bg-dark))))
        '(org-done ((t (nil))))
      `(org-hide ((t (:foreground ,bg-white))))
       '(org-indent
   ((t (:inherit (org-hide fixed-pitch)))))
`(org-ellipsis ((t (:underline nil
               :foreground ,comment))))
  `(org-date
   ((t (:family ,sans-mono-font
            :height 0.8 :foreground ,gray)))
   )
  `(org-tag ((t (:foreground ,doc))))
  `(org-list-dt
	((t ( :foreground ,bg-dark)))))
(defun org-hide-tags ()
  (interactive)
  (setq hide-flag (% (+ 1 hide-flag) 2))
  (if (eq 1 hide-flag)
	(custom-theme-set-faces 'user `(org-tag ((t (:foreground ,bg-white)))))
	(custom-theme-set-faces 'user `(org-tag ((t (:foreground ,doc))))))))

;; Undo tree
(global-undo-tree-mode)
(setq-default tab-width 4) ; Set Tab to appear like 4 spaces in Emacs
(setq auto-save-visited-interval 1) ; Autosave after 1 second since I will have auto-save-visited-mode enabled.
(setq auto-save-visited-file-name nil) ; Apparently autosave is orthogonal to auto-save-visited-mode and having this variable to a non-nil value means auto-save mode will go away
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1)) ; Bye bye tool bar,
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1)); bye bye menu bar
; Helm minimal config from http://tuhdo.github.io/helm-intro.html
(require 'helm-config)
(helm-mode 1)
; Some spacemacs thing
(which-key-mode)
(setq bookmark-save-flag 1) ;Save bookmarks each time one is created.
