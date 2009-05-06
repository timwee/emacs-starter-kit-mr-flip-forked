
;;
;;; This alist applies to files whose first line starts with `#!'
;;
(setq interpreter-mode-alist
      (append
       '(("python"  . python-mode))
       '(("python2" . python-mode))
       '(("ruby"    . ruby-mode))
       '(("perl"    . cperl-mode))
       interpreter-mode-alist))

(add-to-list 'load-path "~/.emacs.d/elpa-to-submit/cucumber-mode")
(autoload    'feature-mode "cucumber-mode" "Mode for editing cucumber files" t)

;; (insert (prin1-to-string auto-mode-alist))
(setq auto-mode-alist (append (list
    '("\\(M\\|m\\|GNUm\\)akefile\\([.-].*\\)?\\'" . makefile-mode)
    '("\\.\\(xml\\|xsl\\|xsd\\|kml\\|rng\\|mxml\\)\\(\\.erb\\)?\\'" . nxml-mode)
    '("\\.as\\'"                       . actionscript-mode)
    '("\\.\\(i|xs\\)\\'"               . c-mode)
    '("\\.\\([pP][LlMm]\\|al\\)\\'"    . cperl-mode)
    '("\\.css\\(\\.erb\\)?\\'"         . css-mode)
    '("\\.feature\\'"                  . feature-mode)
    '("\\.m\\'"                        . matlab-mode)
    '("\\.[rsx]html?\\(\\.erb\\)?\\'"  . nxhtml-mode)
    '("\\.py.?\\'"                     . python-mode)
    '("\\([cC]ap\\|[Rr]ake\\)file\\'"  . ruby-mode)
    '("\\.gemspec$"                    . ruby-mode)
    '("\\.sass$"                       . sass-mode)
    '("\\.pig\\'"                      . sql-mode)
    '("\\.ya?ml\\'"                    . yaml-mode)
    '("\.feature\(\.erb\)?$"           . feature-mode)
    ;; add more modes here
    ) auto-mode-alist))


;; if it's a shebang script, make is exemacutable
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; ;;
;; ;; ------------------ Add extensions to Mode list ----------------
;; ;;
;; (autoload 'actionscript-mode "actionscript-mode.el"  "Major mode for Flex/Actionscript .as files." t)
;; (autoload 'longlines-mode    "longlines.el"          "Minor mode for automatically wrapping long lines." t)
;; (autoload 'nxml-mode         "nxml-mode.el"          "Major mode for XML files." t)
;; (autoload 'css-mode          "css-mode.el"           "Major mode for CSS files." t)
;; ;; (autoload 'matlab-mode    "matlab-mode"           "Enter Matlab mode." t)
;; (autoload 'python-mode       "python-mode"           "Mode for editing python files." t)
;; (autoload 'yaml-mode         "yaml-mode"             "Mode for editing YAML files." t)
;; (autoload 'ruby-mode         "ruby-mode"             "Ruby editing mode." t)
;; (autoload 'run-ruby          "inf-ruby"              "Run an inferior Ruby process" t)
;; (autoload 'inf-ruby-keys     "inf-ruby"              "Set local key defs for inf-ruby in ruby-mode" t)
;; (autoload 'sass-mode         "sass-mode"             "Mode for SASS (CSS done right)" t)
;; (autoload 'haml-mode         "haml-mode"             "Mode for HAML" t)
;; (autoload 'feature-mode      "cucumber-mode"         "Mode for editing cucumber files" t)

(defun ruby-eval-buffer () (interactive)
  "Evaluate the buffer with ruby."
  (shell-command-on-region (point-min) (point-max) "ruby"))
(add-hook 'ruby-mode-hook
  (lambda()
    (add-hook 'local-write-file-hooks '(lambda() (save-excursion (untabify (point-min) (point-max)) (delete-trailing-whitespace) )))
    ;; (set (make-local-variable 'indent-tabs-mode) 'nil)
    (imenu-add-to-menubar "IMENU")
    ;; (require 'ruby-electric)
    (ruby-electric-mode t)
    (inf-ruby-keys)
    ;; (rails-minor-mode)
    ))
;; (add-hook 'ruby-mode-hook 'turn-on-font-lock)
(add-hook 'haml-mode-hook (lambda () (set (make-local-variable 'indent-tabs-mode) 'nil) ))

(provide 'mrflip-modes)
