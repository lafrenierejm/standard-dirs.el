;;; directories.el --- Provide platform-specific paths for configuration, cache, and other data

;; Copyright (C) 2018 Joseph M LaFreniere

;; Author: Joseph M LaFreniere <joseph@lafreniere.xyz>
;; Maintainer: Joseph M LaFreniere <joseph@lafreniere.xyz>
;; License: GPL3+
;; URL: https://github.com/lafrenierejm/directories-elisp
;; Version: 0.0.1
;; Keywords: files
;; Package-Requires: ((f))

;; This program is free software; you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free Software
;; Foundation, either version 3 of the License, or (at your option) any later
;; version.

;; This program is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
;; FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
;; details.

;; You should have received a copy of the GNU General Public License along with
;; this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; The purpose of this package is to provide platform-specfic, paths for reading
;; and writing configuration, cache, and other data.

;; On Linux (`gnu/linux'), the directory paths conform to the XDG base directory
;; and XDG user directory specifications as published by the freedesktop.org
;; project.

;; On macOS (`darwin'), the directory paths conform to Apple's documentation at
;; https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPFileSystem/Articles/WhereToPutFiles.html.

;;; Code:
(eval-when-compile
  (require 'env)
  (require 'f)
  (require 'files)
  (case system-type
    ('gnu/linux
     (require 'xdg))))

(defgroup directories)

(defun directories--make-directory (dir)
  "Create and return the directory DIR."
  (make-directory dir t)
  (file-name-as-directory dir))

(defconst directories-user-home
  (file-name-as-directory
   (case system-type
     ('gnu/linux
      (getenv "HOME"))
     ('darwin
      (getenv "HOME"))))
  "The current user's home directory.")

(defconst directories-user-cache-home
  (file-name-as-directory
   (case system-type
     ('gnu/linux
      (xdg-cache-home))
     ('darwin
      (f-join (list directories-user-home "Library" "Caches")))))
  "The base directory for user-specific cache files.")

(provide 'directories)
;;; directories.el ends here
