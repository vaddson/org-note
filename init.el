;; Директория конфигов:
(setq my/config-dir (concat (getenv "HOME") "/.config/org-note"))

;; Собирает имя файла конфига по его базовому имени:
(defun my/make-config-filename (filename)
    (concat my/config-dir "/" filename))

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

;; Читаем первый литературный конфиг:
(my/org-babel-load-file "literate-init")
