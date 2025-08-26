(setq debug-on-error t)
; Enable Org-mode
(require 'org)

; get OneDrive folder & set default directories
(if (file-exists-p "~/OneDrive - Raytheon Technologies/OrgMode/")
    (setq oneDrive "~/OneDrive - Raytheon Technologies/OrgMode/")
  (setq oneDrive "~/OneDrive - RTX/OrgMode/")
  )
(setq default-directory oneDrive)
(setq org-directory oneDrive)
; move backup files one level deeper
(setq backup-directory-alist
      `((".*" . ,(concat org-directory "backups/"))))
;; Enable agenda view and list files with agendas
(setq org-agenda-files (list (concat oneDrive "jcarmody.org")
			     (concat oneDrive "tasks.org")
			     (concat oneDrive "m3k.org")
			     (concat oneDrive "M23K_transfer.org")))
;; Optional: Better visuals
(setq org-startup-indented t)
(setq org-startup-folded t)
(setq org-todo-keywords
      '((sequence "TODO(t)" "DOING(g)" "|" "DONE(d)")))
;; enable org-capture
(setq org-default-notes-file (concat org-directory "/notes.org"))
;; wrap long lines at window edge
(setq truncate-lines nil)
;; org-capture stuff
(setq org-log-done 'time)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-capture-templates
      '(("t" "Task" entry
         `(file+headline ,(concat oneDrive "tasks.org") "Inbox")
         "* TODO %?\n  :PROPERTIES:\n  :CREATED: %U\n  :END:\n  SCHEDULED: %^t\n  DEADLINE: %^d\n")
        ("n" "Note" entry
         (file+headline org-default-notes-file "Notes")
         "* %u   %?"))) ;; "* %?\n  %u\n  %i\n  %a"
;;

(defun my-default-layout ()
  "Set up my preferred default window layout."
  (interactive)
  (org-agenda-list)
  (delete-other-windows)
  (split-window-vertically)
  (split-window-horizontally)
  ;(other-window 1)
  (find-file (concat oneDrive "jcarmody.org"))
  (other-window 1)
  (find-file (concat oneDrive "m3k.org")))
(global-set-key (kbd "C-c m") 'my-default-layout)

(add-hook 'emacs-startup-hook 'my-default-layout)

