
;;
;; ------------------ Handy functions --------------
;;

(defun fixnewlines  ()             "Turn ^M into ^J."  (interactive) (replace-string "\C-M" "\C-j"))
(defun set-tab-width-2 ()          "Sets tab width to 2" (interactive) (setq tab-width 2) (font-lock-and-redraw))
(defun set-tab-width-4 ()          "Sets tab width to 4" (interactive) (setq tab-width 4) (font-lock-and-redraw))
(defun set-tab-width-8 ()          "Sets tab width to 8" (interactive) (setq tab-width 8) (font-lock-and-redraw))
(defun Buffer-menu-sort-by-path () "Sort buffer menu by pathname"  (interactive) (Buffer-menu-sort 5))

(defun font-lock-and-redraw ()          "Force a font-lock-fontify-buffer and then do the redraw" (interactive) (font-lock-fontify-buffer) (recenter) )

;; (defun imw-find-file ()
;;  "Prompt for a `name' and scan the `lib' and `spec' directories in the IMW root directory ($IMW_ROOT) and open the first file matching `name.rb'"
;;  (interactive)
;;  (let* ((name (read-from-minibuffer "IMW File: "))
;;                 (files (split-string
;;                                 (concat
;;                                  (shell-command-to-string "find $IMW_ROOT/lib")
;;                                  (shell-command-to-string "find $IMW_ROOT/spec"))
;;                                 "\n")))
;;        (find-file (catch 'break
;;                                 (dolist (file files)
;;                                   (if (string-match (concat "/" name "\\.rb$") file)
;;                                           (throw 'break file)))))))
;; (define-key ruby-mode-map "\C-cf" 'imw-find-file)



(defun count-words-region (beginning end)
  "Print number of words in the region."
  (interactive "r")
  (message "Counting words in region ... ")
  ;;; 1. Set up appropriate conditions.
  (save-excursion
    (let ((count 0)) (goto-char beginning)
  ;;; 2. Run the while loop.
      (while (and (< (point) end) (re-search-forward "\\w+\\W*" end t)) (setq count (1+ count)))
  ;;; 3. Send a message to the user.
      (cond ((zerop count)   (message "The region does NOT have any words."))
            ((= 1 count)     (message "The region has 1 word."))
            (t               (message "The region has %d words." count))))))
;;; Bug: kills line and newline. o wells
(defun delete-line () "deletes the line forward"
  (interactive "")
  (save-excursion
    (delete-region (point) (progn (forward-visible-line 1) (point))) ))
(defun delete-next-word () "deletes (without copying) the next word"
  (interactive "")
  (save-excursion
    (delete-region (point) (progn (forward-word) (point))) ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;   Indentation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; http://www.jwz.org/doc/tabs-vs-spaces.html
;; In Emacs, to set the mod-N indentation used when you hit the TAB
;; key, do this:
;;      (setq c-basic-indent 2)
;; To cause the TAB file-character to be interpreted as mod-N
;; indentation, do this:
;;      (setq tab-width 4)
;; To cause TAB characters to not be used in the file for compression,
;; and for only spaces to be used, do this:
(setq indent-tabs-mode nil)
(defun indent-buffer ()
  "Indent the current buffer."
  (interactive)
  (indent-region (point-min) (point-max) nil)
)
(defun right-justify-line ()
  "Justify the current line to the right"
  (interactive)
  (justify-current-line 'right)
)
(defun indent-line-or-region-rigidly   (b e n) "indent-rigidly by arg tab-widths"
  (interactive "r\np")
  (save-excursion
    (let (deactivate-mark)
      (if (or (= b e) (not mark-active))
          (progn
            (end-of-line)
            (let ((eol (point)))
              (beginning-of-line)
              (indent-rigidly (point) eol (* tab-width n))))
        (indent-rigidly b e (* tab-width n))))))
(defun unindent-line-or-region-rigidly (b e n) "(un)indent-rigidly by -arg tab-widths"
  (interactive "r\np")
  (indent-line-or-region-rigidly b e (* -1 n)))


;;
;;
;; -- Make Flymake sane in Tramp --
;;

(defun flymake-create-temp-intemp (file-name prefix)
  "Return file name in temporary directory for checking FILE-NAME.
This is a replacement for `flymake-create-temp-inplace'. The
difference is that it gives a file name in
`temporary-file-directory' instead of the same directory as
FILE-NAME.

For the use of PREFIX see that function.

Note that not making the temporary file in another directory
\(like here) will not if the file you are checking depends on
relative paths to other files \(for the type of checks flymake
makes)."
  (unless (stringp file-name)
    (error "Invalid file-name"))
  (or prefix
      (setq prefix "flymake"))
  (let* ((name (concat
                (file-name-nondirectory
                 (file-name-sans-extension file-name))
                "_" prefix))
         (ext  (concat "." (file-name-extension file-name)))
         (temp-name (make-temp-file name nil ext))
         )
    (flymake-log 3 "create-temp-intemp: file=%s temp=%s" file-name temp-name)
    temp-name))

(defun flymake-ruby-init ()
  (condition-case er
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
                         ;; 'flymake-create-temp-inplace
                         'flymake-create-temp-intemp
                         ))
             (local-file  (file-relative-name
                           temp-file
                           (file-name-directory buffer-file-name))))
        (list rails-ruby-command (list "-c" local-file)))
    ('error ())))
(provide 'mrflip-defuns)
