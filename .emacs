(setq debug-on-error t)
; Enable Org-mode
(require 'org)

;; set computer-specific variables
(when (string-equal (system-name) "USM107864")
  (setq oneDrive "~/OneDrive - Raytheon Technologies/OrgMode/")
  (setq default-directory oneDrive)
  (setq org-directory oneDrive)
  (setq backup-directory-alist `((".*" . ,(concat org-directory "backups/"))))
  (setq org-agenda-files (list (concat oneDrive "jcarmody.org")
			       (concat oneDrive "tasks.org")
			       (concat oneDrive "m3k.org")
			       (concat oneDrive "M23K_transfer.org")))
  (defun my-default-layout ()
  "Set up my preferred default window layout."
  (interactive)
  (org-agenda-list)
  (delete-other-windows)
  (split-window-vertically)
  (split-window-horizontally)
  (find-file (concat oneDrive "jcarmody.org"))
  (other-window 1)
  (find-file (concat oneDrive "m3k.org"))))

(when (string-equal (system-name) "penguin")
  (setq default-directory "~/emacs/")
  (setq org-directory default-directory)
  (setq backup-directory-alist `((".*" . ,(concat default-directory "backups/"))))
  (setq org-agenda-files (list (concat default-directory "jim.org")
			       (concat default-directory "tasks.org")
			       (concat default-directory "home.org")))
  (defun my-default-layout ()
  "Set up my preferred default window layout."
  (interactive)
  (org-agenda-list)
  (delete-other-windows)
  (split-window-vertically)
  (split-window-horizontally)
  (find-file (concat default-directory "jim.org"))
  (other-window 1)
  (find-file (concat default-directory  "home.org"))))

;; Optional: Better visuals
(global-visual-line-mode)
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
(setq org-capture-templates
      '(("t" "Task" entry
         `(file+headline ,(concat default-directory "tasks.org") "Inbox")
         "* TODO %?\n  :PROPERTIES:\n  :CREATED: %U\n  :END:\n  SCHEDULED: %^t\n  DEADLINE: %^d\n")
        ("n" "Note" entry
         (file+headline org-default-notes-file "Notes")
         "* %u   %?"))) ;; "* %?\n  %u\n  %i\n  %a"
;;
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c C-x C-i") 'org-clock-in)
(global-set-key (kbd "C-c C-x C-o") 'org-clock-out)
(global-set-key (kbd "C-c C-x C-x") 'org-clock-cancel)
(global-set-key (kbd "C-c C-x C-r") 'org-clock-report)
(global-set-key (kbd "C-c m") 'my-default-layout)
(add-hook 'emacs-startup-hook 'my-default-layout)

