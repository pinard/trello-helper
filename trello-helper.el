;;;; Bits for handling Org files produced by trello-helper.
;;;; See https://github.com/pinard/trello-helper for details.

(defvar trello-helper-command "trello-helper"
  "Name, or possibly path, or the trello-helper script")

(defvar trello-helper-mode-hook nil
  "List of hooks to run on trello-helper Org files.")

(defconst trello-helper-inline-id-regexp
  " *:PROPERTIES: {\"orgtrello-id\":[^}\n]+}")

(defconst trello-helper-propery-id-regexp
  "^:orgtrello-id:")

(defun trello-helper-hook-runner ()
  (when (save-excursion
          (goto-char (point-min))
          (re-search-forward
           (concat trello-helper-inline-id-regexp
                   "\\|"
                   trello-helper-propery-id-regexp)
           nil t))
    (run-hooks 'trello-helper-mode-hook)))

(add-hook 'org-mode-hook 'trello-helper-hook-runner)

(defun trello-helper-hide-trello-ids ()
  ;; Hide inline information about Trello ids.  If you temporarily
  ;; need to see it, toggle using the M-x visible-mode command.
  (font-lock-add-keywords
   nil `((,trello-helper-inline-id-regexp
          (0 (add-text-properties (match-beginning 0) (match-end 0)
                                  '(invisible org-link)))))))

(add-hook 'trello-helper-mode-hook 'trello-helper-hide-trello-ids)

(defun trello-helper-to-clipboard (start end)
  ;; Copy region to clipboard, rewriting it to Markdown while doing so.
  (when (equal start end)
    (error "Please select a region first!"))
  (interactive "r")
  (shell-command-on-region
   start end (concat trello-helper-command " -m")))

