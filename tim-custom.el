(defun indent-or-expand (arg)
  "Either indent according to mode, or expand the word preceding
point."
  (interactive "*P")
  (if (and
       (or (bobp) (= ?w (char-syntax (char-before))))
       (or (eobp) (not (= ?w (char-syntax (char-after))))))
      (dabbrev-expand arg)
    (indent-according-to-mode)))
 
(defun my-tab-fix ()
  (local-set-key [tab] 'indent-or-expand))
 
;; add hooks for modes you want to use the tab completion for:
(add-hook 'c-mode-hook          'my-tab-fix)
(add-hook 'sh-mode-hook         'my-tab-fix)
(add-hook 'emacs-lisp-mode-hook 'my-tab-fix)
(add-hook 'clojure-mode-hook    'my-tab-fix)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))


(add-to-list 'load-path "./vendor/mmm-mode")
;;(require 'mmm-mako)

;;(add-to-list 'auto-mode-alist '("\\.mako\\'" . html-mode))
;;(mmm-add-mode-ext-class 'html-mode "\\.mako\\'" 'mako)

(require 'gccsense)

(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)


(defun set-exec-path-from-shell-PATH () 
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'"))) 
    (setenv "PATH" path-from-shell) 
    (setq exec-path (split-string path-from-shell path-separator)))) 
(when (equal system-type 'darwin) 
  ;; When started from Emacs.app or similar, ensure $PATH 
  ;; is the same the user would see in Terminal.app 

(setq rinari-tags-file-name "TAGS")

  (if window-system (set-exec-path-from-shell-PATH))) 

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq-default py-indent-offset 2)

;; (setq python-mode-hook
;;           '(lambda () (progn
;;                         (set-variable 'py-indent-offset 2)
;;                         (set-variable 'py-smart-indentation nil)
;;                         (set-variable 'indent-tabs-mode nil) )))
(provide 'tim-custom)

