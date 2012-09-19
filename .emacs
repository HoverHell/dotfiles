
;; NOTE: http://stackoverflow.com/questions/778716/how-can-i-make-emacs-start-up-faster/779145#779145
;; NOTE: see 'XXX' marks (and the NOTE marks, ofc).

;; XXX: cycle between buffers with opened files instead of all buffers?
;; XXX: Bind 'C-u M-|' to 'M-?'?  ; shell-command-on-region
;; XXX: Open same file in several buffers? (on binds)
;; XXX: rainbow-delimiters full region background color?

;(defun mytst()
;  (interactive (let (string) (unless (mark) (error "The mark is not set now, so there is no region")) (setq string (read-shell-command "Shell command on region: ")) (list (region-beginning) (region-end) string current-prefix-arg current-prefix-arg shell-command-default-error-buffer t)))

;(define-ibuffer-op
;  "Replace the contents of marked buffers with output of pipe to COMMAND."
;  (:interactive "sPipe to shell command (replace): "
;   :opstring "Buffer contents replaced in"
;   :active-opstring "replace buffer contents in"
;   :dangerous t
;   :modifier-p t) 
;  (with-current-buffer buf
;    (shell-command-on-region (point-min) (point-max)
;                             command nil t)))



;; NOTE: Remove line-wrap (newline) character:
; M-: (set-display-table-slot standard-display-table 'wrap ?\ )
; M-: (set-display-table-slot standard-display-table 'wrap ?\b )

;; don't open the scratch buffer (I need a editor, not a console
;; environment).
(kill-buffer "*scratch*")

;; Directory with various extra files.
(add-to-list 'load-path "~/.emacs.d/lib/")


;; Various personal keybindings.
(global-set-key "\M-[1;5A" 'previous-buffer); Ctrl+up => previous buffer
(global-set-key "\M-[1;5B" 'next-buffer)    ; Ctrl+down  => next buffer
(global-set-key [(control up)] 'previous-buffer); Ctrl+up => previous buffer
(global-set-key [(control down)] 'next-buffer)    ; Ctrl+down e => next buffer
(global-set-key "\M-[1;5C" 'forward-word)   ; Ctrl+right => forward word
(global-set-key "\M-[1;5D" 'backward-word)  ; Ctrl+left  => backward word
; (global-set-key (kbd "C-x TAB") 'indent-rigidly)  ;; default
(global-set-key (kbd "C-x TAB") 'other-window)
; 'fix' for xterm-like home/end in rxvt with TERM=xterm-256color
(global-set-key "\M-[H" 'move-beginning-of-line)
(global-set-key "\M-[F" 'move-end-of-line)
(global-set-key "\M-[1~" 'move-beginning-of-line)
(global-set-key "\M-[4~" 'move-end-of-line)
(global-set-key [select] 'move-end-of-line)  ;; dunno wtf.
; 'suspend-frame' is usually useless anyway.
(global-set-key (kbd "C-z") 'other-window)


;; Auto-indent possibilities:
;(define-key global-map (kbd "RET") 'newline-and-indent)
;(define-key global-map (kbd "C-j") 'newline)
;; or
; (defun set-newline-and-indent () (local-set-key (kbd "RET") 'newline-and-indent))
;; http://www.emacswiki.org/emacs/AutoIndentation


;; Remembering positions in files
(setq save-place-file "~/.emacs.d/saveplace") ;; keep my ~/ clean
(setq-default save-place t)                   ;; activate it for all buffers
(require 'saveplace)                          ;; get the package


;; Don't show menu bar
(menu-bar-mode 0)

;; Aux.
(defun yank-and-indent ()
  "Yank and then indent the newly formed region according to mode."
  (interactive)
  (yank)
  (call-interactively 'indent-region))

;; ===== Set standard indent to 2 rather that 4 ====
; (setq standard-indent 2)


;; ===== Turn off tab character =====
;; Emacs normally uses both tabs and spaces to indent lines. If you
;; prefer, all indentation can be made from spaces only. To request this,
;; set `indent-tabs-mode' to `nil'. This is a per-buffer variable;
;; altering the variable affects only the current buffer, but it can be
;; disabled for all buffers.
;;
;; Use (setq ...) to set value locally to a buffer
;; Use (setq-default ...) to set value globally 
(setq-default indent-tabs-mode nil) 


;; ========== Prevent Emacs from making backup files ==========
; (setq make-backup-files nil)

;; ========== Place Backup Files in Specific Directory ==========
;; Enable backup files.
(setq make-backup-files t)
;; Enable versioning with default values (keep five last versions, I think!)
(setq version-control t)
;; Save all backup file in this directory.
(setq backup-directory-alist (quote ((".*" . "~/.tmp/emacs_backups/"))))
(setq delete-old-versions t)


;; ========== Enable Line and Column Numbering ==========
;; Show line-number in the mode line
(line-number-mode 1)
;; Show column-number in the mode line
(column-number-mode 1)


;; backwards-undo - probably obsolete
;(require 'redo)
;(global-set-key [(meta backspace)] 'undo)
;(global-set-key [(meta shift backspace)] 'redo)


;; undo-tree - read the file for documentation.
(require 'undo-tree)
(global-undo-tree-mode)


;; ========== Set the fill column ==========
(setq-default fill-column 72)


;; ===== Turn on Auto Fill mode automatically in all modes =====
;;   Auto-fill-mode the the automatic wrapping of lines and insertion of
;; newlines when the cursor goes over the column limit.
;;   This should actually turn on auto-fill-mode by default in all major
;; modes. The other way to do this is to turn on the fill for specific modes
;; via hooks.
(setq auto-fill-mode 1)


;; ===== Make Text mode the default mode for new buffers =====
; (setq default-major-mode 'text-mode)


;; ========= Set colours ==========
;; Set cursor and mouse-pointer colours
;(set-cursor-color "red")
;(set-mouse-color "goldenrod")
;; Set region background colour
;(set-face-background 'region "blue")
;; Set emacs background colour
;(set-background-color "black")
;; Set comment color
;(set-face-foreground 'font-lock-comment-face "red")


;; nuke-line
;(require 'nuke-line)
;; (autoload function filename docstring interactive type)
(autoload 'nuke-line "nuke-line" "Kill an entire line, including the trailing newline character" t)
(global-set-key (kbd "M-K") 'nuke-line)
(global-set-key [f8] 'nuke-line)


;; indentations
(autoload 'my-unindent "indent")
(autoload 'my-indent "indent")
(define-key global-map "\t" 'my-indent)
(define-key global-map [S-tab] 'my-unindent)
(define-key global-map [backtab] 'my-unindent)

;;;; Format-specific stuff. 
;;; python-mode
(add-to-list 'load-path "~/.emacs.d/lib/python-mode")
(setq py-shell-name "ipython")
;; XXX: do not start python shell on it?
;(autoload 'python-mode "python-mode" "Python Mode." t) 
;(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;;; cython-mode
(autoload 'cython-mode "cython-mode" "Mode for editing Cython source files")
(add-to-list 'auto-mode-alist '("\\.pyx\\'" . cython-mode))
(add-to-list 'auto-mode-alist '("\\.pxd\\'" . cython-mode))
(add-to-list 'auto-mode-alist '("\\.pxi\\'" . cython-mode))
;;; Octave/matlab
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
;;; coffee
(autoload 'coffee-mode "coffee-mode" "Coffee Mode." t)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

;;;; NOTE: disable vc (Version Control) autodetect
; (require 'vc)
; (remove-hook 'find-file-hooks 'vc-find-file-hook)
(eval-after-load "vc" '(remove-hook 'find-file-hooks 'vc-find-file-hook))


;; Highlight parentheses
(require 'highlight-parentheses)
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)
;(add-hook 'highlight-parentheses-mode-hook
;          '(lambda ()
;             (setq autopair-handle-action-fns
;                   (append
;                    (if autopair-handle-action-fns
;                        autopair-handle-action-fns
;                        '(autopair-default-handle-action))
;                    '((lambda (action pair pos-before)
;                        (hl-paren-color-update)))))))
;(define-globalized-minor-mode global-highlight-parentheses-mode
;  highlight-parentheses-mode
;  (lambda ()
;    (highlight-parentheses-mode t)))
;(global-highlight-parentheses-mode t)
(setq hl-paren-colors
      '(;"#8f8f8f" ; this comes from Zenburn
                   ; and I guess I'll try to make the far-outer parens look like this
        "orange1" "yellow1" "greenyellow" "green1"
        "springgreen1" "cyan1" "slateblue1" "magenta1" "purple"))
(show-paren-mode t)
(setq show-paren-style 'expression)

;; Theming, etc.
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(frame-background-mode (quote dark)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(font-lock-builtin-face ((((class color) (min-colors 88) (background dark)) (:foreground "#ffbb30" :weight bold))))
 '(font-lock-comment-face ((t (:foreground "green"))))
 '(font-lock-function-name-face ((((class color) (min-colors 88) (background dark)) (:foreground "#99ff99" :weight bold))))
 '(font-lock-keyword-face ((((class color) (min-colors 88) (background dark)) (:foreground "white" :weight bold))))
 '(font-lock-string-face ((((class color) (min-colors 88) (background dark)) (:foreground "cyan"))))
 '(rainbow-delimiters-depth-1-face ((((background dark)) (:background "#262626"))))
 '(rainbow-delimiters-depth-2-face ((((background dark)) (:background "#444444"))))
 '(rainbow-delimiters-depth-3-face ((((background dark)) (:background "#626262"))))
 '(rainbow-delimiters-depth-4-face ((((background dark)) (:background "#808080"))))
 '(rainbow-delimiters-depth-5-face ((((background dark)) (:background "#87005f"))))
 '(rainbow-delimiters-depth-6-face ((((background dark)) (:background "#875f5f"))))
 '(rainbow-delimiters-depth-7-face ((((background dark)) (:background "#8700d7"))))
 '(rainbow-delimiters-depth-8-face ((((background dark)) (:background "#875fff"))))
 '(rainbow-delimiters-unmatched-face ((((background dark)) (:foreground "#ee1122" :weight bold)))))

;; Somehow, the setting above (or even in a custom theme defined here) does not work.
(set-face-foreground 'font-lock-comment-face "#11dd11")


; (a(b(c(d(e(f(g(h(i(j(k(l(m((((()))))m)l)k)j)i)h)g)f)e)d)c)b)a)
