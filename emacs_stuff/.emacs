;; Set up autocomplete so that it activates at chracter 0 if possible

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (dichromacy)))
 '(custom-safe-themes
   (quote
    ("a63355b90843b228925ce8b96f88c587087c3ee4f428838716505fd01cf741c8" default)))
 '(magit-diff-use-overlays nil)
 '(menu-bar-mode nil)
 '(org-agenda-files (quote ("~/Documents/bc/bc.org")))
 '(package-selected-packages
   (quote
    (nyan-mode indium elfeed smooth-scroll autotetris-mode magit exwm org-plus-contrib package-build shut-up epl git commander f dash s cask undercover ert-runner let-alist org-ref org ox-reveal counsel swiper ace-window org-bullets which-key try ac-helm helm helm-bibtex helm-c-yasnippet helm-emmet helm-flycheck helm-git helm-git-files helm-git-grep helm-github-stars helm-gitignore helm-gitlab helm-gtags helm-projectile helm-themes helm-tramp helm-unicode elpy htmlize flycheck-plantuml plantuml-mode isend-mode xref-js2 js2-refactor writeroom-mode company-tern company web-mode ac-c-headers yasnippet-snippets ac-clang ac-emmet ac-html ac-html-bootstrap ac-js2 ac-octave tern-auto-complete js2-mode pdf-tools flycheck flycheck-clang-analyzer flycheck-clang-tidy flycheck-clangcheck flycheck-color-mode-line evil ggtags flx-ido highlight-indent-guides multiple-cursors latex-preview-pane emmet-mode projectile matlab-mode hlinum linum-relative)))
 '(python-check-command "/home/dominik/.local/bin/pyflakes")
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(setq package-enable-at-startup nil)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))
(put 'narrow-to-region 'disabled nil)
