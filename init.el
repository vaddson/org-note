;; Директория конфигов:
(setq my/config-dir (concat (getenv "HOME") "/.config/org-note"))

;; Собирает имя файла конфига по его базовому имени:
(defun my/make-config-filename (filename)
    (concat my/config-dir "/" filename))

;; Подцепим репозиторий melpa.
(require 'package)
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;; Действия перед загрузкой пакетов. (Если какой-то пакет по
;; прошествии времени упорно не находится в репозиториях, спасает
;; ручной вызов функции =package-refresh-contents=.
(setq package-enable-at-startup nil)
(package-initialize)
(unless package-archive-contents
    (package-refresh-contents))

;; Пакеты будем цеплять через =use-package=. Установим его.
(if (not (package-installed-p 'use-package))
    (progn (package-refresh-contents)
           (package-install 'use-package)))

;; Подцепим работу с qelpa.
(use-package quelpa-use-package
    :ensure t)
(require 'quelpa-use-package)

;; Установим темы заранее для того, чтобы загружать их через customize.
(use-package doom-themes
    :ensure t)
(use-package modus-themes
    :ensure t)
(use-package ef-themes
    :ensure t)

;; Напишем свою загрузку org-конфигов для ускорения.
;;   EL-файл не будет пересобираться, если в том не будет необходимости.
(defun my/org-babel-load-file (base-filename-without-org)
    (let ((org-filename (concat (my/make-config-filename base-filename-without-org)
                                ".org"))
          (el-filename (concat (my/make-config-filename base-filename-without-org)
                               ".el")))
        (if (file-newer-than-file-p org-filename el-filename)
            (org-babel-load-file org-filename)
            (load-file el-filename))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Читаем первый литературный конфиг:
(my/org-babel-load-file "literate-init")
