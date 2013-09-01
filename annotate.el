(defun goto-end-of-buffer ()
  "Sets position to end of buffer, for appending"
  (goto-char (point-max)))

(defun create-annotation (buffer-name line-number annotation)
  "Adds actual annotation to anno file associated with given buffer.
Annotation is in the form of <line number><tab><annotation>"
  (with-current-buffer (find-file (concat buffer-name ".anno"))
    (goto-end-of-buffer)
    
    ; Insert annotation, save and bury buffer
    (insert (format "%d\t%s\n" line-number annotation))
    (save-buffer)
    (bury-buffer)))

(defun anno-file-exists? (buffer-name)
  "Checks for anno file. If available, return t, else nil"
  (file-exists-p (concat buffer-name ".anno")))

(defun open-annotations (anno-buffer-name)
  "Opens the annotate file and displays it in a
new frame created with split (vertical)"
  ; Open the annotate file but bury it and display it
  ; in a new frame instead. Should look into a cleaner
  ; way of doing this.
  (with-current-buffer (find-file anno-buffer-name)
    (bury-buffer))
  (display-buffer anno-buffer-name))

(defun load-annotations (buffer-name)
  "Loads annotations if available, returns nil if not found."
  (if (anno-file-exists? buffer-name)
      (open-annotations (concat buffer-name ".anno"))
    nil))

(defun annotate (annotation-content)
  "Interactive function that takes annotation
input and adds annotation to anno file"
  (interactive "sAnnotation: ")
  (create-annotation (buffer-name)
		     (line-number-at-pos (line-beginning-position))
		     annotation-content))

(provide 'annotate)