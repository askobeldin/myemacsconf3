;;;; -*- coding: utf-8, lexical-binding: t -*-
;;;; my config: min 5
;;;; 2023-01-21
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)

;;(add-to-list 'load-path (concat user-emacs-directory "config"))
;;(add-to-list 'load-path (concat user-emacs-directory "elisp"))
;;(add-to-list 'load-path (concat user-emacs-directory "config" "/languages"))

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; powerline status bar
;;
(use-package powerline
  :ensure t
  :config
  (powerline-default-theme))

;; Place custom settings in their own file.
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file 'noerror))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; some functions
;;
(defun my-system-is-linux ()
    "Linux system checking."
    (interactive)
    (string-equal system-type "gnu/linux"))

(defun my-system-is-mac ()
    "Mac OS X system checking."
    (interactive)
    (string-equal system-type "darwin"))

(defun my-system-is-windows ()
    "MS Windows system checking."
    (interactive)
    (string-equal system-type "windows-nt"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Environment settings.
;;
(setq user-full-name   "askobeldin")
(setq user-mail-adress "askobeldin@gmail.com")

;; Coding-system
(set-language-environment 'UTF-8)

(if (or (my-system-is-linux) (my-system-is-mac))
    (progn
        (setq default-buffer-file-coding-system 'utf-8)
        (setq-default coding-system-for-read    'utf-8)
        (setq file-name-coding-system           'utf-8)
        (set-selection-coding-system            'utf-8)
        (set-keyboard-coding-system        'utf-8-unix)
        (set-terminal-coding-system             'utf-8)
        (prefer-coding-system                   'utf-8))
    (progn
        ; (setq default-buffer-file-coding-system 'windows-1251)
        (setq default-buffer-file-coding-system 'utf-8)
        ; (setq-default coding-system-for-read    'windows-1251)
        (setq file-name-coding-system           'windows-1251)
        (set-selection-coding-system            'windows-1251)
        (set-keyboard-coding-system        'windows-1251-unix)
        (set-terminal-coding-system             'windows-1251)
        (prefer-coding-system                   'utf-8)))

;; Если не отменить make-backup-files, Emacs будет засорять
;; файловую систему бэкапами.
(setq-default make-backup-files nil)

;; lockfiles are evil.
(setq create-lockfiles nil)

;; Это включает автосохранение - пока вы работаете с файлом,
;; Emacs время от времени автоматически создает копию, и удаляет её
;; как только вы сохрание файл с которым работаете.
(setq-default auto-save-defaults t)
(setq auto-save-interval 500
      auto-save-timeout 0)

;; Директория для автосохранения файлов
(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

;; Indent with spaces by default
(setq-default indent-tabs-mode nil)

;; require a trailing newline
(setq require-final-newline nil)

;'Woman' > 'man'.
;(defalias 'man 'woman)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; user interface
;;
;; Disable GUI components
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

(tooltip-mode      -1)
; (menu-bar-mode     -1)

(blink-cursor-mode t)

;; Don't use dialog boxes
(setq use-dialog-box     nil)

(setq redisplay-dont-pause t)

;; Keyboard: input method
;; toggle keys:   C-\
(setq default-input-method 'russian-computer)

;; Syntax highlighting
(require 'font-lock)
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;; Window size. Set font
(if (my-system-is-windows)
  ;; my windows machine
  (progn
      (add-to-list 'default-frame-alist '(height . 50))
      (add-to-list 'default-frame-alist '(width . 100)))
  ;; linux
  (add-to-list 'default-frame-alist '(fullscreen . maximized)))

(setq initial-frame-alist '((left . 0) (top . 0)))

(when (member "DejaVu Sans Mono" (font-family-list))
    (set-frame-font "DejaVu Sans Mono-10:antialias=natural" nil t))

;; Hide startup messages
(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      inhibit-startup-message t)

;; Scrolling
(setq scroll-conservatively 9999
      scroll-preserve-screen-position t
      scroll-step 1
      scroll-margin 2)

;; Let me write `y` or `n` even for important stuff that would normally require
;; me to fully type `yes` or `no`.
(defalias 'yes-or-no-p 'y-or-n-p)
(setq use-short-answers t)

;; Flash the frame to represent a bell.
(setq visible-bell t)

;; nevermind that's annoying
(setq ring-bell-function 'ignore)

;; Это настраивает подсветку парных скобок
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'parenthesis)

;; Electric-mode
(electric-pair-mode   -1)
(electric-indent-mode -1)

;; break long lines at word boundaries
(visual-line-mode 1)

;; number columns in the status bar
(column-number-mode)

;; Fringe
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(set-fringe-style '(8 . 8))
;(setq-default indicate-empty-lines t)
;(setq-default indicate-buffer-boundaries 'left)

;; Scratch buffer
(setq initial-scratch-message "")

;; Global clipboard
(setq x-select-enable-clipboard t)

(if (my-system-is-windows)
    (set-clipboard-coding-system 'utf-16le-dos))

;; Highlight search results
(setq search-highlight t)

;; Make recentering behave more similiar to other programs
;; Try it out yourself by hitting C-l
(setq recenter-positions '(middle top bottom))

;; Unconditionally kill subprocesses at exit
(setq confirm-kill-processes nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Theme my-classic
;;
(add-to-list 'custom-theme-load-path
          (concat user-emacs-directory "themes"))

(load-theme 'my-classic t t)
(enable-theme 'my-classic)

;; Global highlight current textline
(global-hl-line-mode t)

;; Reconfigure highlight line's color
(set-face-background 'hl-line "#3e4446")
(set-face-foreground 'highlight nil)

;; Cursor (for default emacs mode)
(setq-default cursor-type '(bar . 3))
;;(setq-default cursor-type '(hbar . 3))
;;(set-cursor-color "#ffff00")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Evil config
(use-package evil
  :ensure t
  :init
      (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
      (setq evil-want-keybinding nil)
  :hook 
      ('prog-mode . #'hs-minor-mode)
  :config
      (evil-mode 1)
      (setq evil-want-C-u-scroll t)
      (setq evil-want-C-w-in-emacs-state t)
      (setq evil-search-module 'isearch)
      (setq evil-magic 'very-magic)
      (setq evil-want-fine-undo t)
      (setq evil-want-change-word-to-end t))

(defun my-hop-around-buffers ()
  "Swap the current buffer with the previous one."
  (interactive)
  (switch-to-buffer (other-buffer "*Ibuffer*")))

(use-package evil-leader
  :after evil
  :ensure t
  :config
    (progn
        (evil-leader/set-leader "<SPC>")
        (global-evil-leader-mode t)))

(evil-leader/set-key
        "w"          'save-buffer
        "qq"         'kill-this-buffer
        "qw"         'evil-window-delete
        "Q"          'kill-buffer-and-window

        ">"          'find-file-at-point

        "\\"         'split-window-horizontally
        "-"          'split-window-vertically
        ","          'other-window

        "#"          'linum-mode
        ;;"x"          'smex

        ;; evil-nerd-commenter config
        "cc"         'evilnc-comment-or-uncomment-lines

        ;; Dired
        "d"          'dired

        ;; buffers and switching
        "TAB"        'my-hop-around-buffers
        "b"          'ibuffer
        "B"          'switch-to-buffer
        ;; "jb"         'ace-jump-thefiles-buffers

        ;; popup-switcher config
        ;;"pb"         'psw-switch-buffer
        ;;"pr"         'psw-switch-recentf
        ;;"pn"         'psw-navigate-files
        ;;"pf"         'psw-switch-function
        ; "pp"         'psw-switch-projectile-files

        ;; helm
        ;"hs"         'helm-swoop
        ;"hi"         'helm-imenu

        ;; ido
        ;;"l"          'ido-goto-symbol
        ;;"f"          'ido-find-file
)

(use-package evil-nerd-commenter
      :after evil
      :ensure t
      :commands (evilnc-comment-or-uncomment-lines))

(use-package evil-matchit
      :after evil
      :ensure t
      :commands evilmi-jump-items
      :config
        (progn
          (setq global-evil-matchit-mode t)
          (define-key evil-normal-state-map "%" 'evilmi-jump-items)))
          
(use-package evil-collection
  :after evil
  :ensure t
  :init
      (setq evil-want-keybinding nil)
  :config
      (evil-collection-init)
  :custom
       (evil-collection-want-unimpaired-p nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;      
;;;; тестирование поведения lispy-mode
;;;;
(use-package evil-lispy
  :after evil
  :ensure t
  :config
      (progn
          (define-key lispy-mode-map "q" 'special-lispy-ace-paren)
          ;; make evil-lispy start in the modes you want
          ;;(add-hook 'emacs-lisp-mode-hook    #'evil-lispy-mode)
          ;;(add-hook 'elisp-mode-hook   #'evil-lispy-mode)
          ;;(add-hook 'ielm-mode-hook    #'evil-lispy-mode)
          (add-hook 'lisp-mode-hook    #'evil-lispy-mode)))

;;;; без evil-lispy ;;;;;;;;;;;;;;;;;;;;;;;         
;;;;(defun my-lispy-mode ()
;;;;    (electric-pair-local-mode 1)
;;;;    (lispy-mode 1)
;;;;    ;;(require 'evil-collection-lispy)
;;;;    (evil-collection-lispy-setup))
;;;;    
;;;;(add-hook 'lisp-mode-hook    #'my-lispy-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;          

;; Evil cursor config
(setq evil-default-cursor       '("#ffff00" box))
(setq evil-normal-state-cursor  '("#ffff00" box))
(setq evil-insert-state-cursor  '("#ffff00" (hbar . 3)))
(setq evil-replace-state-cursor '("#ffff00" box))
(setq evil-motion-state-cursor  '("#ffff00" box))
;;(setq evil-lispy-state-cursor '("#c1ffc1" box))       ;; DarkSeaGreen1 color
(setq evil-lispy-state-cursor '("#c1ffc1" (bar . 3)))   ;; DarkSeaGreen1 color

;; Unique buffer names
;; Change buffer names:
;; Makefile|directory1 Makefile|directory2
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)        ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*")     ; don't muck with special buffers

;; Ibuffer
(setq ibuffer-expert t)       ; expert mode

;; my filter groups
(setq ibuffer-saved-filter-groups
          (quote (("default"
                   ("Dired" (mode . dired-mode))
                   ("Code" (or 
                             (mode . python-mode)
                             (mode . emacs-lisp-mode)
                             (mode . perl-mode)
                             (mode . c-mode)
                             (mode . js-mode)
                             (mode . lisp-mode)))
                   ("Planner" (or
                                 (name . "^\\*Calendar\\*$")
                                 (name . "^diary$")
                                 (mode . org-mode)))
                   ("emacs" (or
                              (name . "^\\*scratch\\*$")
                              (name . "^\\*Messages\\*$")))
                   ("Web" (or 
                              (mode . html-mode)
                              (mode . json-mode)
                              (mode . css-mode)))
                   ("Help" (or
                             (name . "\*Help\*")
                             (name . "\*Apropos\*")
                             (name . "\*info\*")))
                   ("emacs created" (or
                                      (name . "^\\*")))))))

;; don't show empty filter groups
(setq ibuffer-show-empty-filter-groups nil)

;; apply 
(add-hook 'ibuffer-mode-hook
    (lambda ()
         (hl-line-mode t)
         (ibuffer-switch-to-saved-filter-groups "default")))

;; Allow for multiple Emacs daemons
;; Although I'm pretty sure I won't make use of this, I prefer using local TCP connections over socket files. Another benefit of this setting is that it would allow me to make use of emacsclient to access a remote Emacs daemon.
(setq server-use-tcp t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Remember buffer/notes
(setq remember-notes-bury-on-kill nil)
(setq remember-notes-initial-major-mode 'org-mode)
;;;;(setq initial-buffer-choice 'remember-notes)
(add-hook 'remember-notes-mode-hook 'visual-line-mode)

;; There is a bit of mismatch between the keybindings of remember-notes-mode 
;; and org-mode, so let's fix that:
(with-eval-after-load 'remember
  (define-key remember-notes-mode-map (kbd "C-c C-c") nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Recent files
(recentf-mode t)
(setq recentf-max-saved-items 50)
(setq recentf-auto-cleanup 'never)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Calendar
(setq calendar-week-start-day 1)
(setq calendar-day-header-array ["Вс" "Пн" "Вт" "Ср" "Чт" "Пт" "Сб"])
(setq calendar-month-name-array ["Январь" "Февраль" "Март" "Апрель" 
                                 "Май" "Июнь" "Июль" "Август" "Сентябрь" 
                                 "Октябрь" "Ноябрь" "Декабрь"])

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Whitespace config
(setq whitespace-display-mappings
       ;; all numbers are Unicode codepoint in decimal. try (insert-char 182 ) to see it
      '((space-mark 32 [183] [46]) ; 32 SPACE, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
        (newline-mark 10 [182 10]) ; 10 LINE FEED
        (tab-mark 9 [9655 9] [92 9]) ; 9 TAB, 9655 WHITE RIGHT-POINTING TRIANGLE 「▷」 
        ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IDO mode
(require 'ido)
(ido-mode t)
(setq ido-everywhere t)
(setq ido-enable-prefix nil)
(setq ido-use-virtual-buffers t)      ; visit recently closed files?
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-show-dot-for-dired t)
(setq ido-confirm-unique-completion nil)
(setq ido-enable-last-directory-history nil)
(setq ido-use-filename-at-point 'guess)
(setq ido-save-directory-list-file
     (concat user-emacs-directory ".cache/ido.last"))

;; Ido's default behavior when there is no matching file in the current
;; directory is to look in recent working directories
(setq ido-auto-merge-work-directories-length -1)    ;; disable auto-merge

;; Extensions ordering and ignored ones
(setq ido-file-extensions-order     '(".c" ".h" ".org"
                                      ".el" ".lisp"))
(setq completion-ignored-extensions '(".o" ".elc" "~" ".bin" ".bak"
                                      ".obj" ".map" ".a" ".so" ".fasl"
                                      ".mod" ".aux" ".out" ".pyg"))
(setq ido-ignore-extensions t)

;; Keep annoying buffers out of search
(setq ido-ignore-buffers (list (rx (or (and bos  " ")
                                       (and bos
                                            (or "*Completions*"
                                                "*Shell Command Output*"
                                                "*vc-diff*")
                                            eos)))))

;; Allow spaces when using ido-find-file
(add-hook 'ido-make-file-list-hook
          (lambda ()
            (define-key ido-file-dir-completion-map (kbd "SPC") 
			             'self-insert-command)))

(use-package ido-vertical-mode
      :ensure ido-vertical-mode
      :init
        (progn
          (ido-vertical-mode 1)))
          
(defun my-ido-jump-to-home ()
      "Jump to the user's home directory in ido."
      (interactive)
      (ido-set-current-directory "~/")
      (setq ido-exit 'refresh)
      (exit-minibuffer))

(defun my-setup-ido ()
   "Configure ido my way"
   ;; On ido-find-file, let `~` mean `~/` for fastness.
   (define-key ido-file-dir-completion-map "~" 'my-ido-jump-to-home)
   (define-key ido-file-dir-completion-map [tab] 'ido-complete)
   (define-key ido-file-dir-completion-map (kbd "RET") 'exit-minibuffer)
   (define-key ido-file-dir-completion-map (kbd "C-i") 'ido-select-text)
   (define-key ido-completion-map (kbd "RET") 'exit-minibuffer)
   (define-key ido-completion-map (kbd "TAB") 'ido-complete)
   (define-key ido-completion-map (kbd "C-j") 'ido-next-match)
   (define-key ido-completion-map (kbd "C-i") 'ido-select-text)
   (define-key ido-completion-map (kbd "C-k") 'ido-prev-match)
   (define-key ido-completion-map (kbd "M-p") 'ido-toggle-prefix))

(add-hook 'ido-setup-hook 'my-setup-ido)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; smex - ido for M-x.
(use-package smex
  :ensure smex
  :config
    (progn
      (global-set-key (kbd "M-x") 'smex)
      (setq smex-save-file (concat user-emacs-directory ".cache/smex-items"))
      (smex-initialize)

      ;; The following is from <http://www.emacswiki.org/emacs/Smex>.
      ;; Typing SPC inserts a hyphen:
      (defadvice smex (around space-inserts-hyphen activate compile)
        (let ((ido-cannot-complete-command
             `(lambda ()
                (interactive)
                (if (string= " " (this-command-keys))
                    (insert ?-)
                  (funcall ,ido-cannot-complete-command)))))
          ad-do-it))

       ;; Update less often.
       (defun smex-update-after-load (unused)
         (when (boundp 'smex-cache)
               (smex-update)))
       
       (add-hook 'after-load-functions 'smex-update-after-load)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; evil keyboard shortcuts
;;
(define-key evil-normal-state-map (kbd "C-w }")   'evil-window-rotate-downwards)
(define-key evil-normal-state-map (kbd "C-w {")   'evil-window-rotate-upwards)
(define-key evil-normal-state-map (kbd "C-h")     'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j")     'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k")     'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l")     'evil-window-right)
(define-key evil-normal-state-map (kbd "C-<tab>") 'evil-next-buffer)
(define-key evil-normal-state-map (kbd "S-<tab>") 'evil-prev-buffer)
;;;;(define-key evil-normal-state-map "a"             'evil-append)
;;;;(define-key evil-normal-state-map "/"             'evil-search-forward)
;;;;
;;;;(define-key evil-motion-state-map "h"             'evil-backward-char)
;;;;(define-key evil-motion-state-map "j"             'evil-next-visual-line)
;;;;(define-key evil-motion-state-map "k"             'evil-previous-visual-line)
;;;;(define-key evil-motion-state-map "l"             'evil-forward-char)
;;;;(define-key evil-motion-state-map "$"             'evil-end-of-line)
;;;;(define-key evil-motion-state-map "0"             'evil-beginning-of-line)
;;;;
;;;;(evil-ex-define-cmd "Q"  'evil-quit)
;;;;(evil-ex-define-cmd "Qa" 'evil-quit-all)
;;;;(evil-ex-define-cmd "QA" 'evil-quit-all)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; slime config
;;
(use-package slime
  :ensure t
  :init   (load (expand-file-name "~/quicklisp/slime-helper.el"))
  :config (setq slime-net-coding-system 'utf-8-unix))

;;;;(load (expand-file-name "~/quicklisp/slime-helper.el"))
                    
(if (my-system-is-windows)
    (progn
      ;; (setq inferior-lisp-program windows-sbcl-bin)
      (setq inferior-lisp-program (executable-find "sbcl"))
      (setq common-lisp-hyperspec-root (concat "file:///" (expand-file-name "~/hyperspec/"))))
    (progn
      (setq inferior-lisp-program (executable-find "sbcl"))
      (setq common-lisp-hyperspec-root (expand-file-name "/usr/share/doc/hyperspec/"))
      (setq common-lisp-hyperspec-symbol-table 
            (expand-file-name "/usr/share/doc/hyperspec/Data/Map_Sym.txt"))))

(if (my-system-is-windows)
    (progn
      (message "%s" "my-slime: system is windows.")))

(if (my-system-is-linux)
    (progn
      (message "%s" "my-slime: system is linux.")))

;;;;(use-package company
;;;;  :ensure t
;;;;  :init
;;;;    (progn
;;;;      (global-company-mode)))
;;;;(add-hook 'after-init-hook 'global-company-mode)

(use-package slime-company
  :after (slime company)
  :init  (global-company-mode)
  :config (progn                
            ;;(define-key company-active-map (kbd "\C-n") 'company-select-next)
            ;;(define-key company-active-map (kbd "\C-p") 'company-select-previous)
            (define-key company-active-map (kbd "\C-d") 'company-show-doc-buffer)
            (define-key company-active-map (kbd "M-.")  'company-show-location)))

(require 'slime)
(require 'slime-autoloads)
;;;;(require 'slime-fancy)
;;;;(require 'slime-company)

(slime-setup '(slime-fancy
               slime-scratch
               slime-asdf
               slime-banner
               slime-company))
               
;;;;(setq slime-contribs '(slime-fancy slime-banner slime-autodoc slime-company))

(eval-after-load "slime"
      '(progn
              (setq lisp-indent-function 'common-lisp-indent-function
                    slime-complete-symbol-function 'slime-fuzzy-complete-symbol
                    slime-fuzzy-completion-in-place t
                    slime-enable-evaluate-in-emacs t
                    slime-autodoc-use-multiline-p t)
               (define-key slime-mode-map (kbd "TAB") 'slime-indent-and-complete-symbol)
               (define-key slime-mode-map (kbd "C-c i") 'slime-inspect)
               (define-key slime-mode-map (kbd "C-c C-s") 'slime-selector)))


;;;;(add-hook 'slime-repl-mode-hook (lambda () 
;;;;                                   (slime-mode t)
;;;;                                   (evil-lispy-mode)
;;;;                                   (company-mode 1)))
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))

;;;;(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

;;;;(add-hook 'slime-mode-hook (lambda ()
;;;;                             (unless (slime-connected-p)
;;;;                                (save-excursion (slime)))))

;;;;(add-hook 'slime-mode-hook (lambda () (slime-mode t)))
;;;;(add-to-list 'auto-mode-alist '("\\.lisp\\'" . lisp-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Folding
;; evil-mode users have pre-defined keys: 
;;
;; za to toggle visibility, 
;; zc (close), 
;; zm (close all), 
;; zr (open all).
;; 
;; They are an interface to other folding packages, most notably hideshow. The value 
;; of the variable evil-fold-list determines which backend is used for which major or 
;; minor modes, and what functions are available for those backends.	  
(setq evil-fold-list
  `(((hs-minor-mode)
     :open-all   hs-show-all
     :close-all  hs-hide-all
     :toggle     hs-toggle-hiding
     :open       hs-show-block
     :open-rec   nil
     :close      hs-hide-block)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package "eldoc"
  :diminish eldoc-mode
  :commands turn-on-eldoc-mode
  :defer t
  :init
    (progn
      (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
      (add-hook 'elisp-mode-hook 'turn-on-eldoc-mode)
      (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; highlighting for lisp language
;;
;; Change the following faces:
;; highlight-defined-function-name-face
;; highlight-defined-builtin-function-name-face
;; highlight-defined-special-form-name-face
;; highlight-defined-macro-name-face
;; highlight-defined-variable-name-face
;; highlight-defined-face-name-face
;;
;; If you want to highlight face name by the face itself, 
;; set highlight-defined-face-use-itself to a non-nil value.
(use-package highlight-defined
  :ensure t
  :config
      (add-hook 'lisp-mode-hook 'highlight-defined-mode)
      (add-hook 'emacs-lisp-mode-hook 'highlight-defined-mode)
      (add-hook 'elisp-mode-hook 'highlight-defined-mode)
      (add-hook 'ielm-mode-hook 'highlight-defined-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; eww browser
(setq browse-url-browser-function 'eww-browse-url)
