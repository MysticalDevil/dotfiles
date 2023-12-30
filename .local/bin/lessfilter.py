#!/usr/bin/env python3

import mimetypes
import os
import subprocess


def has_cmd(cmd: str):
    return (
        subprocess.call(
            "type " + cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE
        )
        == 0
    )


def missing_cmd(cmd):
    if not has_cmd(cmd):
        print(
            f"The '{cmd}' command is missing, please install the corresponding package."
        )
        exit(1)


def show_directory(path):
    missing_cmd("eza")
    subprocess.run(["eza", "--git", "-hl", "--color=always", "--icons", path])


def show_image_file(path):
    missing_cmd("chafa")
    missing_cmd("exiftool")
    subprocess.run(["chafa", path])
    subprocess.run(["exiftool", path])


def highlight_file(path, data):
    if has_cmd("pygmentize"):
        highlighted = subprocess.check_output(
            ["pygmentize", "-O", "style=one-dark", "-f", "256", "-g", path]
        )
        print(highlighted.decode())
    else:
        print(data.decode())


def show_text_file(path):
    if has_cmd("pygmentize"):
        highlighted = subprocess.check_output(
            ["pygmentize", "-O", "style=one-dark", "-f", "256", "-g", path]
        )
        highlight_file(path, highlighted)
    else:
        with open(path) as f:
            print(f.read())


def show_pdf_file(path):
    missing_cmd("pdftotext")
    data = subprocess.check_output(["pdftotext", "-nopgbrk", "-q", path, "-"])
    highlight_file(path, data)


def show_office_file(path):
    missing_cmd("wv")
    missing_cmd("pandoc")
    html = subprocess.check_output(["wv", "-p", "-c", "-nw", "-f", "text/html", path])
    text = subprocess.check_output(["pandoc", "-t", "plain"], input=html)
    highlight_file(path, text)


def show_video_file(path):
    missing_cmd("mediainfo")
    subprocess.run(["mediainfo", path])


def show_other_file(path):
    missing_cmd("file")
    missing_cmd("highlight")
    kind = (
        subprocess.check_output(["file", "--brief", "--mime-type", path])
        .decode()
        .strip()
    )

    if kind == "text/plain":
        data = subprocess.check_output(["highlight", "-O", "ansi", path])
        highlight_file(path, data)
    else:
        print(f"File type is {kind}")


def main(path):
    mime_type = mimetypes.guess_type(path)[0]
    category, kind = mime_type.split("/") if mime_type else (None, None)

    if os.path.isdir(path):
        show_directory(path)
    elif category == "image":
        show_image_file(path)
    elif category == "text":
        show_text_file(path)
    elif category == "application":
        if kind == "vnd.gentoo.ebuild":
            show_text_file(path)
        elif kind in ["pdf", "json"]:
            globals()[f"show_{kind}_file"](path)
        elif kind in [
            "vnd.ms-word",
            "vnd.openxmlformats-officedocument.wordprocessingml.document",
            "vnd.ms-excel",
            "vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            "vnd.ms-powerpoint",
            "vnd.openxmlformats-officedocument.presentationml.presentation",
        ]:
            show_office_file(path)
        else:
            show_other_file(path)
    elif category == "video":
        show_video_file(path)
    else:
        show_other_file(path)


if __name__ == "__main__":
    import sys

    main(sys.argv[1])
