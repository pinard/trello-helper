;;;; Bits for handling Org files produced by trello-helper.
;;;; See https://github.com/pinard/trello-helper for details.

(defvar trello-helper-command "trello-helper"
  "Name, or possibly path, or the trello-helper script")

(defun trello-helper-org-mode-hook ()
  ;; Hide inline information about Trello ids.  If you temporarily
  ;; need to see it, toggle using the M-x visible-mode command.
  (font-lock-add-keywords
   nil '((" *:PROPERTIES: {\"orgtrello-id\":[^}\n]+}"
          (0 (add-text-properties (match-beginning 0) (match-end 0)
                                  '(invisible org-link)))))))

(add-hook 'org-mode-hook 'trello-helper-org-mode-hook)

(defun trello-helper-to-clipboard (start end)
  ;; Copy region to clipboard, rewriting it to Markdown while doing so.
  (when (equal start end)
    (error "Please select a region first!"))
  (interactive "r")
  (shell-command-on-region
   start end (concat trello-helper-command " -m")))

