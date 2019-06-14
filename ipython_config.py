# ~/.ipython/profile_default/ipython_config.py
c = get_config()

c.InteractiveShellApp.matplotlib = 'qt5'
c.InteractiveShellApp.exec_lines = [
    'import numpy as np',
    'import matplotlib.pyplot as plt'
]
