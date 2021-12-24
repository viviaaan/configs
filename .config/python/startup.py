import os, readline

#stuff commented out check for extra variables if one is not found
# try:
histfile = os.environ["PYTHONHISTFILE"]
# except (KeyError):
#     try:
#         histfile = os.path.join(os.environ["XDG_DATA_HOME"], "python/history")
#     except (KeyError):
#         histfile = os.path.join(os.environ["HOME"], ".python_history")

try:
    readline.read_history_file(histfile)
except (IOError) as err:
    print(err)

import atexit
atexit.register(readline.write_history_file, histfile)
