;;;; Bits for handling Org files produced by trello-helper.
;;;; See https://github.com/pinard/trello-helper for details.

(defun trello-helper-org-mode-hook ()
  ;; Hide inline information about Trello ids.  If you temporarily
  ;; need to see it, toggle using the M-x visible-mode command.
  (font-lock-add-keywords
   nil '((" *:PROPERTIES: {\"orgtrello-id\":[^}\n]+}"
          (0 (add-text-properties (match-beginning 0) (match-end 0)
                                  '(invisible org-link)))))))

(add-hook 'org-mode-hook 'trello-helper-org-mode-hook)
