;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "MysticalDevil"
      user-mail-address "jinpeng7981@outlook.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Fira Code" :size 15 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "MesloLGS Nerd Font" :size 15))
(setq doom-symbol-font doom-font)
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
(use-package good-scroll
  :hook (doom-first-input . good-scroll-mode)
  :config
  (defun good-scroll--convert-line-to-step (line)
    (cl-typecase line
      (integer (* line (line-pixel-height)))
      ((or null (member -))
       (- (good-scroll--window-usable-height)
          (* next-screen-context-lines (line-pixel-height))))
      (t (line-pixel-height))))

  (defadvice! good-scroll--scroll-up (&optional arg)
    :override 'scroll-up
    (good-scroll-move (good-scroll--convert-line-to-step arg)))

  (defadvice! good-scroll--scroll-down (&optional arg)
    :override 'scroll-down
    (good-scroll-move (- (good-scroll--convert-line-to-step arg)))))

(setq auto-save-default t)
(run-with-idle-timer 5 t #'save-some-buffers t)
(setq make-backup-files nil)
(setq confirm-kill-emacs nil)
(set-frame-position (selected-frame) 0 0)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq initial-frame-alist '((top . 1) (left . 1) (width . 114) (height .32)))

;; Org mode
(setq org-export-coding-system 'utf-8)
(setq org-src-fontify-natively t)
(setq org-html-doctype "html5")
(setq org-html-xml-declaration nil)
(setq-default prettify-symbols-alist '(("#+BEGIN_SRC" . "†")("#+END_SRC" . "†")("#+begin_src" . "†") ("#+end_src" . "†") (">=" . "≥")("=>" . "⇨")))
(setq prettify-symbols-unprettify-at-point 'right-edge)
(add-hook 'org-mode-hook 'prettify-symbols-mode)
(setq org-adapt-indentation nil)

;;auto-wrap
(global-visual-line-mode 1)  ;1 for on, 0 for off.

;; language evniroment
(set-language-environment 'UTF-8)
(set-locale-environment "UTF-8")
(define-coding-system-alias 'UTF-8 'utf-8)
