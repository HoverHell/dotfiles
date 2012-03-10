
;; NOTE: http://stackoverflow.com/questions/778716/how-can-i-make-emacs-start-up-faster/779145#779145
;; NOTE: see 'XXX' marks (and the NOTE marks, ofc).

;; XXX: cycle between buffers with opened files instead of all buffers?

;; NOTE: Remove line-wrap character:
; M-: (set-display-table-slot standard-display-table 'wrap ?\ )
; M-: (set-display-table-slot standard-display-table 'wrap ?\b )

;; don't open the scratch buffer (I need a editor, not a console
;; environment).
(kill-buffer "*scratch*")

;; Directory with various extra files.
(add-to-list 'load-path "~/.emacs.d/lib/")


;; Various personal keybindings.
(global-set-key "\M-[1;5A" 'previous-buffer); Ctrl+right => previous buffer
(global-set-key "\M-[1;5B" 'next-buffer)    ; Ctrl+down  => next buffer
(global-set-key "\M-[1;5C" 'forward-word)   ; Ctrl+right => forward word
(global-set-key "\M-[1;5D" 'backward-word)  ; Ctrl+left  => backward word
; (global-set-key (kbd "C-x TAB") 'indent-rigidly)  ;; default
(global-set-key (kbd "C-x TAB") 'other-window)  ;; default
; C-z?


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
(set-face-foreground 'font-lock-comment-face "red")


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

 
;; python-mode
(add-to-list 'load-path "~/.emacs.d/lib/python-mode")
(setq py-shell-name "ipython")
;; XXX: do not start python shell on it?
;(autoload 'python-mode "python-mode" "Python Mode." t) 
; (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
