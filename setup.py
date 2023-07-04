from distutils.core import setup
import py2exe

py2exe.freeze(
    console = {'main.py'},
    options={
    'packages': ["sys", "json"],
    'compressed': 1,
    'optimize': 2,
    'bundle_files': 1,
    },
    zipfile = None,
)