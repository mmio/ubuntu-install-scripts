(setq inhibit-startup-message t)
(setq calendar-week-start-day 1)
(setq backup-inhibited t)
(setq tool-bar-mode nil)

(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)

(use-package try
  :ensure t)

(use-package which-key
  :ensure t 
  :config
  (which-key-mode))

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(defalias 'list-buffers 'ibuffer-other-window)
(use-package counsel
  :ensure t)

(use-package swiper
  :ensure t
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> l") 'counsel-find-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
    ))

(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char))

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)))
(setq ac-auto-start 1)

(use-package zone)
  ;; :config
  ;; (zone-when-idle 600))

(use-package smooth-scroll
  :ensure t
  :config
  (smooth-scroll-mode t))

(use-package elpy
  :ensure t
  :config
  (elpy-enable))

(use-package org
  :mode (("\\.org$" . org-mode))
  :ensure org-plus-contrib)

(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-src-preserve-indentation t
      org-log-done t)

(setq org-agenda-files (list "~/org/exercise.org"
                             "~/org/school.org" 
                             "~/org/bc.org"))

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(setq org-babel-python-command "python3")

(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh         . t)
   (latex      . t)
   (js         . t)
   (emacs-lisp . t)
   (python     . t)
   (css        . t)
   (plantuml   . t)
   (java       . t)
   (C          . t)))

;; bigger latex fragment
(plist-put org-format-latex-options :scale 2)

;; Use custom image sizes
(setq org-image-actual-width nil)

(use-package org-ref
  :ensure t)

(setq reftex-default-bibliography '("~/Documents/references/references.bib"))

;; see org-ref for use of these variables
(setq org-ref-default-bibliography '("~/Documents/references/references.bib")
      org-ref-pdf-directory "~/Documents/references/")

;; org-ref-bibliography-notes "~/Dropbox/bibliography/notes.org"

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package ox-reveal
  :ensure ox-reveal)
(setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
(setq org-reveal-mathjax t)

(use-package htmlize
  :ensure t)

(setq browse-url-browser-function 'browse-url-chromium)

(use-package elfeed
  :ensure t)
(global-set-key (kbd "C-x w") 'elfeed)

;; Feeds
(setq elfeed-feeds
      '("http://nullprogram.com/feed/"
	"https://news.ycombinator.com/rss"
        "http://planet.emacsen.org/atom.xml"))

;; If it doesn't work try reinstalling the package

(use-package let-alist
  :ensure t)

(use-package tablist
  :ensure t)

(use-package pdf-tools
  :magic ("%PDF" . pdf-view-mode)
  :config
  (pdf-tools-install))

(use-package linum-relative
  :ensure t
  :config
  (linum-relative-on))
(linum-on)

(use-package hlinum
  :ensure t
  :init
  (setq linum-highlight-in-all-buffersp t)
  :config
  (hlinum-activate))

(use-package cc-mode
  :init
  (setq-default c-basic-offset 8))

(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-x C-<" . mc/mark-all-like-this)
	 ("C-S-<mouse-1>" . mc/add-cursor-on-click)))

(use-package magit
  :ensure t
  :pin melpa-stable)
