;;; directories.el --- Provide platform-specific paths for configuration, cache, and other data
;;
;; Copyright (C) 2018 Joseph M LaFreniere
;;
;; Author: Joseph M LaFreniere <joseph@lafreniere.xyz>
;; Maintainer: Joseph M LaFreniere <joseph@lafreniere.xyz>
;; License: ISC
;; URL: https://github.com/lafrenierejm/directories-elisp
;; Version: 0.0.1
;; Keywords: files
;; Package-Requires: ((anaphora "1.0.0"))
;;
;;; Commentary:
;; The purpose of this package is to provide platform-specfic,
;; user-accessible locations for reading and writing configuration,
;; cache, and other data.
;; On Linux, this package conforms to the XDG base directory and XDG
;; user directory specifications published by the freedesktop.org
;; project.
;;
;;; Code:
(require 'anaphora)

(defconst user-home-directory
  (cond ((eq system-type 'gnu/linux)
         (file-name-as-directory (getenv "HOME"))))
  "The absolute path of the user's home directory.")

(provide 'directories)
;;; directories.el ends here
