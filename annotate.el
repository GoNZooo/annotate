(defun goto-end-of-buffer ()
  "Sets position to end of buffer, for appending"
  (goto-char (point-max)))

(defun create-annotation (buffer-name line-number annotation)
  "Adds actual annotation to anno file associated with current buffer"
  (with-current-buffer (find-file (concat buffer-name ".anno"))
    (goto-end-of-buffer)
    
    ; Insert annotation, save and bury buffer
    (insert (format "%d\t%s\n" line-number annotation))
    (save-buffer)
    (bury-buffer)))

(defun annotate (annotation-content)
  "Interactive function that takes annotation input and adds annotation to anno file"
  (interactive "sAnnotation: ")
  (create-annotation (buffer-name)
		     (line-number-at-pos (line-beginning-position))
		     annotation-content))