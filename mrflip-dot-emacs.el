                                        ; *** elisp ***
;;
;; convenience
;; (normal-erase-is-backspace-mode)
;; (setq x-select-enable-clipboard t)
;; (setq interprogram-paste-function 'x-cut-buffer-or-selection-value) 
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;   Set Window Font, Size and Position
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(setq default-frame-alist '( (left . -1) (top . 0) (width . 90)  (height . 50) )) 
(setq initial-frame-alist '( (left . 0)  (top . 0) (width . 110) (height . 60) ))

(setq myfont "-apple-bitstream vera sans mono-medium-r-normal--0-0-0-0-m-0-iso10646-1")
;;(set-default-font "fixed")
;; (setq myfont "Bitstream Vera Sans Mono-9")
;; (set-default-font "-*-bitstream vera sans mono bold-bold-r-normal--*-132-*-*-m-*-*-*")
(if emacs22up 
    (progn (set-default-font myfont)
           (add-to-list 'default-frame-alist (cons 'font myfont)) )
  ;;else
  (set-default-font "fixed") ) 

;; Several mysterious but important customizations.
(set-input-mode t nil t)
(put 'eval-expression	 'disabled nil)
(put 'narrow-to-region	 'disabled nil)
(put 'upcase-region	 'disabled nil)
(put 'downcase-region	 'disabled nil)

;; yasnippet
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")

(provide 'mrflip-dot-emacs)
