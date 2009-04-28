;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Set Paths
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(setq load-path
      (append load-path (list
	(expand-file-name "~/.emacs.d")
	(expand-file-name "~/.emacs.d/cucumber-mode")
	(expand-file-name "~/pub/site-lisp")
	(expand-file-name "/usr/local/site-lisp")
	(expand-file-name "/sw/share/emacs/site-lisp/")
	(expand-file-name "~/.emacs.d/flip-custom")
	(expand-file-name "~/.emacs.d/yaml-mode")
	(expand-file-name "/sw/share/emacs/site-lisp/rails")
	)))
;;
(require 'info)
(setq Info-directory-list
      (append Info-directory-list (list
	(expand-file-name "/usr/info")
	(expand-file-name "/usr/local/info")
	(expand-file-name "/usr/share/info")
	(expand-file-name "/usr/share/doc/python-docs-2.2.1/info/")
	(expand-file-name "~/pub/info")
	)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; remote file access
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'tramp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Collection of Emacs Dev Tools
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(when (locate-library "filecache")		(require 'filecache))
(when (and (locate-library "cedet") emacs22up)  (require 'snippet)  )
(setq hippie-expand-try-functions-list  '(try-complete-abbrev	try-complete-file-name	try-expand-dabbrev))
(when (and (locate-library "predictive") emacs22up)
  (progn
    (require 'predictive)
    (set-default 'predictive-auto-add-to-dict t)
    (autoload    'predictive-setup-html "predictive-html.el" "predictive html dictionary" t)    ;; html
    (setq 
	  predictive-auto-learn t
	  predictive-add-to-dict-ask nil
	  predictive-use-auto-learn-cache nil
	  predictive-which-dict t)
    ))

;; Prepare Desktop; load with F5, save with C-F5
;; (load-library "desktop")
;; (desktop-load-default)
;;; If you ever have to load a file and see the ^M's exec this line
;(set-variable inhibit-eol-conversion t)   ;; see  ^M's
;(set-variable inhibit-eol-conversion nil) ;; hide ^M's
;; Initialize sunrise/sunset settings. Capitol dome coordinates.
;; (setq calendar-latitude	 [30 16 north])
;; (setq calendar-longitude [97 44 west ])
;; (setq calendar-location-name "Austin, TX")
;;Occasionally useful:
;; Add Line numbers when printing (GREAT when printing out code)
;;(setq ps-line-number t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;   Set Hiliting  (should be before modes)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(if emacs20up
    (progn
      (global-font-lock-mode t) 			  ;; Turn on font-lock in all modes that support it
      (setq font-lock-maximum-decoration t)		  ;; Maximum colors
      ;; used (describe-key-briefly "\C-l") to discover what ^L is bound to, namely recenter
      ;; done right, this would not rely on that fact.
      (global-set-key	(kbd "C-l")	 'font-lock-and-redraw)
      (defun font-lock-and-redraw ()
	"Force a font-lock-fontify-buffer and then do the redraw"
	(interactive)
	(font-lock-fontify-buffer)
	(recenter)
	)
) nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;   Set Modes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; ------------------ Magic for Ruby Mode ----------------
;;
;; If you have Emacs 19.2x or older, use rubydb2x
;; (autoload 'rubydb "rubydb3x" "Ruby debugger" t)
;; uncomment the next line if you want syntax highlighting

;; ------------------ Magic for Rails Mode ----------------
(if emacs22up (require  'rails))


;;
;; ------------------ Magic for Text Mode ----------------
;;
(setq text-mode-hook
      '(lambda ()
	 (setq fill-column 80)
	 (text-mode-hook-identify)
	 ))
;;	 (turn-on-auto-fill)

;;
;; ------------------ Magic for C Mode ----------------------
;;
(defconst my-c-style
  '((c-basic-offset . 2)
    (c-comment-only-line-offset . (0 . 0))
    (c-offsets-alist . ((statement-block-intro . +)
			(knr-argdecl-intro . 4)
			(substatement-open . +)
			(label . 0)
			(statement-case-open . +)
			(statement-cont . +)
			(arglist-intro . c-lineup-arglist-intro-after-paren)
			(arglist-close . c-lineup-arglist)
			(inline-open . 0)
			(brace-list-open . +)
			))
    (c-special-indent-hook . c-gnu-impose-minimum)
    (c-block-comment-prefix . "")
    (c-tab-always-indent    . nil)		   ; Tab, midline, gives actual tab?
    (c-cleanup-list	    . (brace-else-brace))  ; fix "} else {"
    (c-hanging-braces-alist . ((brace-list-open)
			       (brace-entry-open)
			       (substatement-open after)
			       (block-close . c-snug-do-while)))
    ;; Be verbose
    (c-echo-syntactic-information-p . t)
    )
  "Flip's C Programming Style")
;; Customizations for all modes in CC Mode.
(defun my-c-mode-common-hook ()
  ;; adds and sets my-c-style
  (c-add-style "personal" my-c-style t)
  ;; other customizations
  (setq tab-width 8  indent-tabs-mode nil)
  (c-toggle-hungry-state -1)
  (c-toggle-auto-state	 -1)
  (define-key c-mode-base-map "\C-m"	'c-context-line-break)
  (define-key c-mode-base-map "\M-q"	'indent-region)
  (define-key c-mode-base-map "\M-\C-q" 'c-fill-paragraph)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; ------------------ Magic for Other Modes ----------------
(set-variable 'comint-scroll-to-bottom-on-input t)
;; javascript mode
(add-hook 'javascript-mode-hook
      '(lambda ()
         (setq tab-width 8 indent-tabs-mode nil)
         ))
;; nxhtml mode
(add-hook 'nxml-mode-hook
      '(lambda ()
         (setq tab-width 8 indent-tabs-mode nil)
         (set-variable 'nxml-child-indent 2)
         (set-variable 'nxml-attribute-indent 2)
         ))
(add-hook 'nxhtml-mode-hook
  '(lambda ()
     '(define-key 	  nxhtml-mode-map (kbd "C-/") 'nxml-complete)
     '(define-key 	  nxhtml-mode-map (kbd "C->") 'nxml-finish-element)
     ;; '(define-key nxhtml-mode-map "C-<" ')
     ))

;;
;; ------------------ Python-mode ----------------
;;
;; Make with the flymake for python
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name))))
      (list "emacs-pylint.py" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pylint-init)))


;;
;; ------------------ Mode-specific keys ----------------
;;
(setq python-mode-hook 
      '(lambda ()
	 (define-key py-mode-map		[C-f9]		'execute-extended-command)
	 (define-key py-mode-map		[C-f8]		'fill-paragraph)
	 (define-key py-mode-map		(kbd "C-M-,")	'tags-loop-continue)
	 (define-key py-mode-map	   	(kbd "C-M-x")	'execute-extended-command)
	 ))
(setq lisp-mode-hook 
      '(lambda ()
	 (define-key lisp-mode-shared-map	[C-f9]		'execute-extended-command)
	 (define-key lisp-mode-shared-map	[C-f8]		'fill-paragraph)
	 (define-key lisp-mode-shared-map	(kbd "C-M-,")	'tags-loop-continue)
	 (define-key lisp-mode-map      	(kbd "C-M-x")	'execute-extended-command)
	 ))
(setq emacs-lisp-mode-hook 
      '(lambda ()
	 (define-key emacs-lisp-mode-map	[C-f9]		'execute-extended-command)
	 (define-key emacs-lisp-mode-map	[C-f8]		'fill-paragraph)
	 (define-key emacs-lisp-mode-map	(kbd "C-M-,")	'tags-loop-continue)
	 (define-key emacs-lisp-mode-map	(kbd "C-M-x")	'execute-extended-command)
	 ))
(add-hook 'yaml-mode-hook
	  '(lambda ()
	     (set (make-local-variable 'indent-tabs-mode) 'nil)
	     (set (make-local-variable 'indent-tabs-mode) 'nil)
	     (define-key yaml-mode-map "\C-m" 'newline-and-indent)
	     ))

;;
;; To see the auto-mode-list type "auto-mode-alist" into *scratch*
;; and hit C-x-e, C-j...
;;
(modify-coding-system-alist 'file "\\.\\(rb|py|pl|pm|PM|PL|js|as|xs\\)$"    'utf-8)
(modify-coding-system-alist 'file "\\.[rs]html\\(\\.erb\\)?$" 'utf-8)
(modify-coding-system-alist 'file "\\.\\(xml\\|xsl\\|xsd\\|kml\\|rng\\|[rsx]html?\\|mxml\\)\\(\\.erb\\)?$" 'utf-8 )


;;
;; ------------------ End of .emacs ----------------
;;


;; time display is last because during .emacs debugging if .emacs file is OK
;; then time will display, otherwise I know that entire .emacs file was not read
;; Display time in the mode line
(display-time)
