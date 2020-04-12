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

;;; User Directories
;; Retrieve paths of the standard user directories defined by the platform's
;; standards.

;;;###autoload
(defun directories-user ()
  "Get the current user's home directory."
  (file-name-as-directory
   (case system-type
     ('gnu/linux
      (getenv "HOME"))
     ('darwin
      (getenv "HOME")))))

;;;###autoload
(defun directories-user-cache ()
  "Get the base directory for user-specific cache files."
  (file-name-as-directory
   (case system-type
     ('gnu/linux
      (xdg-cache-home))
     ('darwin
      (f-join (directories-user) "Library" "Caches")))))

;;;###autoload
(defun directories-user-config ()
  "Get the base directory for user-specific configuration files."
  (file-name-as-directory
   (case system-type
     ('gnu/linux
      (xdg-config-home))
     ('darwin
      (f-join (directories-user) "Library" "Preferences")))))

;;;###autoload
(defun directories-user-data ()
  "Get the base directory for user-specific data files."
  (file-name-as-directory
   (case system-type
     ('gnu/linux
      (xdg-data-home))
     ('darwin
      (f-join (directories-user) "Library")))))

;;;###autoload
(defun directories-user-audio ()
  "Get the base directory for the current user's audio files."
  (file-name-as-directory
   (case system-type
     ('gnu/linux
      (xdg-user-dir "MUSIC"))
     ('darwin
      (f-join (directories-user) "Music")))))

;;;###autoload
(defun directories-user-desktop ()
  "Get the base directory for the current user's desktop files."
  (file-name-as-directory
   (case system-type
     ('gnu/linux
      (xdg-user-dir "DESKTOP"))
     ('darwin
      (f-join (directories-user) "DESKTOP")))))

;;;###autoload
(defun directories-user-document ()
  "Get the base directory for the current user's document files."
  (file-name-as-directory
   (case system-type
     ('gnu/linux
      (xdg-user-dir "DOCUMENTS"))
     ('darwin
      (f-join (directories-user) "Documents")))))

;;;###autoload
(defun directories-user-downloads ()
  "Get the base directory for the current user's downloaded files."
  (file-name-as-directory
   (case system-type
     ('gnu/linux
      (xdg-user-dir "DOWNLOAD"))
     ('darwin
      (f-join (directories-user) "Downloads")))))

;;;###autoload
(defun directories-user-font ()
  "Get the base directory for the current user's fonts."
  (file-name-as-directory
   (case system-type
     ('gnu/linux
      (f-join (directories-user-data) "fonts"))
     ('darwin
      (f-join (directories-user) "Library" "Fonts")))))

;;;###autoload
(defun directories-user-picture ()
  "Get the base directory for the current user's picture files."
  (file-name-as-directory
   (case system-type
     ('gnu/linux
      (xdg-user-dir "PICTURES"))
     ('darwin
      (f-join (directories-user) "Pictures")))))

;;;###autoload
(defun directories-user-public ()
  "Get the base directory for the current user's public files."
  (file-name-as-directory
   (case system-type
     ('gnu/linux
      (xdg-user-dir "PUBLICSHARE"))
     ('darwin
      (f-join (directories-user) "Public")))))

;;;###autoload
(defun directories-user-template ()
  "Get the base directory for the current user's template files."
  (file-name-as-directory
   (case system-type
     ('gnu/linux
      (xdg-user-dir "TEMPLATES")))))

;;;###autoload
(defun directories-user-video ()
  "Get the base directory for the current user's video files."
  (file-name-as-directory
   (case system-type
     ('gnu/linux
      (xdg-user-dir "VIDEOS"))
     ('darwin
      (f-join (directories-user) "Movies")))))

(provide 'directories)
;;; directories.el ends here
