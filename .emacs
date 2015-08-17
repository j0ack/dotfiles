;;    ______                          
;;   |  ____|                         
;;   | |__   _ __ ___   __ _  ___ ___ 
;;   |  __| | '_ ` _ \ / _` |/ __/ __|
;; _ | |____| | | | | | (_| | (__\__ \
;;(_)|______|_| |_| |_|\__,_|\___|___/
;;                                      


;; packages
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))
(require 'package)
(package-initialize)

;; themes
(load-theme 'zenburn t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a444b2e10bedc64e4c7f312a737271f9a2f2542c67caa13b04d525196562bf38" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; 80 chars
(require 'whitespace)
(setq whitespace-line-column 80)
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)

;; python
(require 'python-mode)
(require 'python-pep8)
(require 'python-pylint)
(require 'company)
(eval-after-load "company"
  '(progn
        (add-to-list 'company-backends 'company-anaconda)))
(add-to-list 'auto-mode-alist '("\.py\'" . python-mode))
(add-hook 'python-mode-hook 'global-company-mode)
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; web
(require 'web-mode)
(require 'emmet-mode)
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tmpl\\'" . web-mode))
(add-hook 'web-mode-hook 'emmet-mode)

;; filetree
(require 'neotree)
(global-set-key (kbd "<f8>") 'neotree-toggle)

;; snippets
(require 'yasnippet)
(yas-global-mode 1)

;; keyboard shortcuts
(global-set-key (kbd "<f2>") 'goto-line)
(global-set-key (kbd "M-n") 'next-error)
(global-set-key (kbd "M-p") 'previous-error)
