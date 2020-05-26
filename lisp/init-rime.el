;; init-rime.el --- Initialize emacs-rime configurations.	-*- lexical-binding: t -*-

(defun +rime--char-before-to-string (num)
  "得到光标前第 `num' 个字符，并将其转换为字符串。"
  (let* ((point (point))
         (point-before (- point num)))
    (when (and (> point-before 0)
               (char-before point-before))
      (char-to-string (char-before point-before)))))

(defun +rime--string-match-p (regexp string &optional start)
  "与 `string-match-p' 类似，如果 REGEXP 和 STRING 是非字符串时，
不会报错。"
  (and (stringp regexp)
       (stringp string)
       (string-match-p regexp string start)))

(defun +rime--probe-auto-english ()
  "激活这个探针函数后，使用下面的规则自动切换中英文输入：

1. 当前字符为英文字符（不包括空格）时，输入下一个字符为英文字符
2. 当前字符为中文字符或输入字符为行首字符时，输入的字符为中文字符
3. 以单个空格为界，自动切换中文和英文字符
   即，形如 `我使用 emacs 编辑此函数' 的句子全程自动切换中英输入法"
  (let ((str-before-1 (+rime--char-before-to-string 0))
        (str-before-2 (+rime--char-before-to-string 1)))
    (unless (string= (buffer-name) " *temp*")
      (if (> (point) (save-excursion (back-to-indentation)
                                     (point)))
          (or (if (+rime--string-match-p " " str-before-1)
                  (+rime--string-match-p "\\cc" str-before-2)
                (not (+rime--string-match-p "\\cc" str-before-1))))))))

(defun +rime--evil-mode-p ()
  "检测当前是否在 `evil' 模式下。"
  (or (evil-normal-state-p)
      (evil-visual-state-p)
      (evil-motion-state-p)
      (evil-operator-state-p)))

(defun +rime-english-prober()
  "自定义英文输入探针函数，用于在不同mode下使用不同的探针列表"
  (let ((use-en (or (button-at (point))
                    (+rime--evil-mode-p))))
    (if (derived-mode-p 'telega-chat-mode)
        (setq use-en (or use-en
                         (+rime--probe-auto-english)))
      (when (derived-mode-p 'text-mode)
        (setq use-en (or use-en
                         (+rime--probe-auto-english))))
      (when (derived-mode-p 'prog-mode 'conf-mode)
        (setq use-en (or use-en
                         (rime--after-alphabet-char-p))))
      (setq use-en (or use-en
                       (rime--prog-in-code-p))))
    use-en))

(use-package rime
  :custom
  (default-input-method "rime")
  :config
  (setq rime-disable-predicates '(+rime-english-prober))
  :bind
  (:map rime-mode-map
   ("C-`" . #'rime-send-keybinding)
   ("C-S-f" . #'rime-force-enable)))

(provide 'init-rime)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-rime.el ends here
