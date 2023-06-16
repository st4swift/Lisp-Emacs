;;; init.el --- Load the full configuration. by st .June 2023

;;; Package repositories: Melpa, gun, org 插件仓库,包管理
(require 'package)
(setq package-archives
      '(("melpa"  . "https://melpa.org/packages/")
        ("gnu"    . "https://elpa.gnu.org/packages/")
        ("org"    . "https://orgmode.org/elpa/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;;;使用use-package来管理包的配置与加载
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;;use-package 进行管理插件
(eval-when-compile
  (require 'use-package))

;;;exec-path-from-shell: A GNU Emacs library to ensure environment variables inside Emacs look the same as in the user's shell.  https://github.com/purcell/exec-path-from-shell
(use-package exec-path-from-shell
  :ensure t)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;;;setup ido mode: ido 改变了在 minibuffer 中操作文件操方式
;;ido 会让文件的工作变得很简单.通常，你在 Emacs 中处理文件不需要使用一个单独的访达或文件资源管理器的窗口.相反，你可以用编辑器的命令来创建、打开和保存文件.
;(require 'ido)
;(setq ido-enable-flex-matching t)
;(setq ido-everywhere t)
;(ido-mode 1)

;;;Consult provides search and navigation commands based on the Emacs completion function completing-read.
(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
         ("\C-x \C-f" . counsel-find-file)))
;; swiper
(use-package swiper
  :ensure t
  :bind (("\C-s" . swiper))
  )

;;;winner-mode是一个全局的minor mode，它的主要功能是记录窗体的变动。例如当前有 2 个窗口，然后你关了一个，这时可以通过winner-undo来恢复。还可以再winner-redo 来撤销刚才的undo.
;;它默认按键绑定为:
;;C-c Left winner-undo
;;C-c Right winner-redo
(use-package winner-mode
  :ensure nil
  :hook (after-init . winner-mode))

;;;saveplace记录了上次打开文件时光标停留在第几行、第几列。如果不想每次打开文件都 要再次跳转到上次编辑的位置，这个mode可以轻松地应对这种情况
(use-package saveplace
  :ensure nil
  :hook (after-init . save-place-mode))

;;;recentf保存了历史以来访问过的文件，开启之后可以通过recentf-open-files来打开。 当然如果你使用ivy全家桶，也可以通过counsel-recentf访问
(use-package recentf
  :ensure nil
  :hook (after-init . recentf-mode)
  :custom
  (recentf-filename-handlers '(abbreviate-file-name))
  (recentf-exclude `("/ssh:"
                     "/TAGS\\'"
                     "COMMIT_EDITMSG\\'")))

;;; newcomment.如果你想要一个足够简单的注释与反注释功能，那么自带的newcomment就可以做到
;;;  keymap: M+;
(use-package newcomment
  :ensure nil
  :bind ([remap comment-dwim] . #'comment-or-uncomment)
  :config
  (defun comment-or-uncomment ()
    (interactive)
    (if (region-active-p)
        (comment-or-uncomment-region (region-beginning) (region-end))
      (if (save-excursion
            (beginning-of-line)
            (looking-at "\\s-*$"))
          (call-interactively 'comment-dwim)
        (comment-or-uncomment-region (line-beginning-position) (line-end-position)))))
  :custom
  (comment-auto-fill-only-comments t))

;;;hideshow 隐藏、显示结构化数据，如{ }里的内容。对于单函数较长的情况比较有用
;; 默认按键前缀为C-c @，这里放一个默认的按键与经过 evil-mode的版本的对比表格:
;;      功能	      原生	      evil-mode
;; hs-hide-block	C-c @ C-h	    zc
;; hs-show-block	C-c @ C-s	    zo
;; hs-hide-all	    C-c @ C-M-h	    zm
;; hs-show-all	    C-c @ C-M-s	    zr
;; hs-hide-level	C-c @ C-l	    无
;; hs-toggle-hiding	C-c @ C-c	    za
(use-package hideshow
  :ensure nil
  :diminish hs-minor-mode
  :hook (prog-mode . hs-minor-mode))
;; hideshow 扩展: 显示被折叠的代码行数.默认情况下hideshow对于显示的代码是以... overlay的形式显示的，而且 hideshow给予了自定义的能力，通过设置hs-set-up-overlay变量即可
;; 这里额外启用了 :box t 属性使得提示更加明显
(defconst hideshow-folded-face '((t (:inherit 'font-lock-comment-face :box t))))
(defun hideshow-folded-overlay-fn (ov)
    (when (eq 'code (overlay-get ov 'hs))
      (let* ((nlines (count-lines (overlay-start ov) (overlay-end ov)))
             (info (format " ... #%d " nlines)))
        (overlay-put ov 'display (propertize info 'face hideshow-folded-face)))))
(setq hs-set-up-overlay 'hideshow-folded-overlay-fn)

;;;whitespace 显示空白字符，如\t \f \v 空格等等。可以配置在prog-mode，markdown-mode和conf-mode下，显示行尾的空白字符
;; (use-package whitespace
;;   :ensure nil
;;   :hook ((prog-mode markdown-mode conf-mode) . whitespace-mode)
;;   :config
;;   (setq whitespace-style '(face trailing)))


;;;====DOOM THEMES
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
;;;==== doom theme


;;;开启Emacs 自带的括号匹配,Emacs 自带的 electric-pair-mode 已经足够好用，只不过默认没有开启
(setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)
(add-hook 'prog-mode-hook #'electric-pair-mode)
;;设置缩进
(setq-default tab-width 4
              indent-tabs-mode nil)

;;(setq confirm-kill-emacs #'yes-or-no-p)      ; 在关闭 Emacs 前询问是否确认关闭，防止误触
;;(electric-pair-mode t)                       ; 自动补全括号

(column-number-mode t)                       ; 在 Mode line 上显示列号
(global-auto-revert-mode t)                  ; 当另一程序修改了文件时，让 Emacs 及时刷新 Buffer
(delete-selection-mode t)                    ; 选中文本后输入文本会替换文本（更符合我们习惯了的其它编辑器的逻辑）
(setq inhibit-startup-message t)             ; 关闭启动 Emacs 时的欢迎界面
(setq make-backup-files nil)                 ; 关闭文件自动备份

(fset 'yes-or-no-p 'y-or-n-p)                ;yes--y, no--n.

(global-display-line-numbers-mode 1)         ; 在 Window 显示行号
;;(tool-bar-mode -1)                           ; （熟练后可选）关闭 Tool bar
(when (display-graphic-p) (toggle-scroll-bar -1)) ; 图形界面时关闭滚动条

;; (savehist-mode 1)                            ; （可选）打开 Buffer 历史记录保存
;; (setq display-line-numbers-type 'relative)   ; （可选）显示相对行号
;; (add-to-list 'default-frame-alist '(width . 90))  ; （可选）设定启动图形界面时的初始 Frame 宽度（字符数）
;; (add-to-list 'default-frame-alist '(height . 55)) ; （可选）设定启动图形界面时的初始 Frame 高度（字符数）

(setq tool-bar-open nil)
(setq menu-bar-open nil)

;; (add-hook 'text-mode-hook 'flyspell-mode );Text mode 检查拼写

(add-hook 'prog-mode-hook #'hs-minor-mode)   ; 编程模式下，可以折叠代码块
(add-hook 'prog-mode-hook #'show-paren-mode) ; 编程模式下，光标在括号上时高亮另一个括号



;;; Faster move cursor
(defun next-ten-lines()
  "move cursor to next 10 lines"
  (interactive)
  (next-line 10))
(defun previous-ten-lines()
  "move cursor to previous 10 lines"
  (interactive)
  (previous-line 10))
;; 绑定到快捷键
(global-set-key (kbd "M-n") 'next-ten-lines)     ; 光标向下移动 10 行
(global-set-key (kbd "M-p") 'previous-ten-lines) ; 光标向上移动 10 行

;;;Show which key can be pressed after an initial keystroke
(use-package  which-key  :ensure t  :init  (which-key-mode))


;;; ~/.emacs.d/lisp, user lisp code
(add-to-list 'load-path "~/.emacs.d/lisp/")

;(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))


;;;====IDE (1)golang (2)rust
;;;在使用任何编辑器/IDE开发时，最核心的需求无非以下几点：
;;     括号的自动匹配
;;     代码的自动补全
;;     查找定义、引用
;;     静态检查
;;     在项目中模糊查找（文件/字符串）
;;; 参考： https://404cn.github.io/2021-08-13-Emacs-Golang-开发环境配置.html

;;;Rust
;;Rustic: https://github.com/brotzeit/rustic   [based on rust-mode and provides additional features]
;;rust-mode: https://github.com/rust-lang/rust-mode   [rust-mode makes editing Rust code with Emacs enjoyable. It requires Emacs 25 or later, and is included in both Emacs Prelude and Spacemacs by default.]
;; key: C-c C-c ...
(use-package rustic  :ensure t)
;;ob-rust enables Org-Babel support for evaluating Rust code. It was created based on the usage of ob-C and ob-go.
;;https://github.com/micanzhang/ob-rust
;;Babel:  https://orgmode.org/worg/org-contrib/babel/intro.html
(use-package ob-rust :ensure t)


;; support for markdown
(use-package markdown-mode :ensure t)





;;;Golang
;;;设置 major-mode https://github.com/dominikh/go-mode.el
(use-package go-mode
      :ensure t
      :mode (("\\.go\\'" . go-mode)))

;;;使用 goimports 代替 gofmt 在文件保存后自动格式化代码
(setq gofmt-command "goimports")  ;;[ go install golang.org/x/tools/cmd/goimports@latest ]
(add-hook 'before-save-hook #'gofmt-before-save)

;;;代码补全、跳转. 安装 company-mode ，在补全时可以使用C-p C-n或者 TAB 进行选择，回车完成补全
;;; http://company-mode.github.io/
(use-package company
     :ensure t)
(add-hook 'prog-mode-hook #'company-mode)
(setq company-tooltip-limit 10
      company-tooltip-align-annotations t
      company-tooltip-width-grow-only t
      company-abort-manual-when-too-short t
      company-require-match nil
      company-backends '(company-capf)
      company-tooltip-margin 0)
(with-eval-after-load "company"
  (define-key company-active-map [tab] 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (define-key company-active-map (kbd "C-n") #'company-select-next))

;;;安装 eglot ，一个 Emacs 中轻量级的 LSP 客户端
;;;Eglot is the more minimalistic and lightweight LSP client for Emacs, integrates well with existing Emacs functionality and will be built into Emacs starting from release 29.
;;; https://github.com/joaotavora/eglot
(use-package eglot
     :ensure t)
(add-hook 'go-mode-hook #'eglot-ensure)  ;;Go gopls language-server [go install golang.org/x/tools/gopls@latest]
;;rust-analyzer: [  rustup component add rust-src ] && [ rustup component add rust-analyzer ]
;;https://rust-analyzer.github.io/manual.html
(add-hook 'rust-mode-hook #'eglot-ensure) ;;Rust

(setq eglot-ignored-server-capabilites '(:documentHighlightProvider)
      read-process-output-max (* 1024 1024))


(use-package yasnippet
     :ensure t)
(add-hook 'prog-mode-hook #'yas-minor-mode)
;;;======IDE


(provide 'init)
;;;init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("631c52620e2953e744f2b56d102eae503017047fb43d65ce028e88ef5846ea3b" "2e05569868dc11a52b08926b4c1a27da77580daa9321773d92822f7a639956ce" "8d3ef5ff6273f2a552152c7febc40eabca26bae05bd12bc85062e2dc224cde9a" "60ada0ff6b91687f1a04cc17ad04119e59a7542644c7c59fc135909499400ab8" default))
 '(package-selected-packages
   '(eglot go-rename go-guru go-eldoc company-go lsp-ui lsp-mode go-mode doom-themes use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
