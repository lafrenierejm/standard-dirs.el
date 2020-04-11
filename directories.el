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
;;
;;; Commentary:
;; The purpose of this package is to provide platform-specfic, paths for reading
;; and writing configuration, cache, and other data.
;;
;; On Linux (`gnu/linux'), the directory paths conform to the XDG base directory
;; and XDG user directory specifications as published by the freedesktop.org
;; project.
;;
;; On macOS (`darwin'), the directory paths conform to Apple's documentation at
;; https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPFileSystem/Articles/WhereToPutFiles.html.
;;
;;; Code:
(eval-when-compile
  (require 'env)
  (require 'files)
  (case system-type
    ('gnu/linux
     (require 'xdg))
    ('darwin
     (require 'cl-seq))))

(defgroup directories)

(defun directories--make-directory (dir)
  "Create and return the directory DIR."
  (make-directory dir t)
  (file-name-as-directory dir))

(defun directories--reduce-path (default-directory name)
  "Combine DIRS into a single path."
  (expand-file-name name default-directory))

(defconst directories-user-home
  (file-name-as-directory
   (case system-type
     ('gnu/linux
      (getenv "HOME"))
     ('darwin
      (getenv "HOME"))))
  "The current user's home directory.")

(defconst directories-user-cache
  (directories--make-directory
   (case system-type
     ('gnu/linux
      (xdg-cache-home))
     ('darwin
      (reduce #'directories--reduce-path
              (list (getenv "HOME") "Library" "Caches")))))
  "The base directory for user-specific cache files.")

(provide 'directories)
;;; directories.el ends here
