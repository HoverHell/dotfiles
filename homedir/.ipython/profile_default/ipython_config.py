# coding: utf8

from __future__ import print_function

import sys


# __into_builtin = True
# import os
# execfile(os.path.join(os.path.dirname(os.path.realpath(__file__)), 'startup', '13-olt.py'))


try:
    from pyaux import madness
except ImportError:
    print("E: No pyaux", file=sys.stderr)
else:
    madness._olt_into_builtin()


c = get_config()


try:
    import Cython as __tmp
except Exception:
    pass
else:
    # print("I: Adding Cython extension", file=sys.stderr)
    c.InteractiveShellApp.extensions.append('Cython')


c.TerminalIPythonApp.display_banner = False
c.InteractiveShell.history_length = 10000000

# try:
#     from IPython.terminal.prompts import Prompts
# except Exception as _exc:
#     print("W: No 5.x prompts:", _exc, file=sys.stderr)
# else:

#     class MyPrompts(Prompts):
#         """ http://ipython.readthedocs.io/en/stable/config/details.html#custom-prompts """

#         def continuation_prompt_tokens(self, *args, **kwargs):
#             return []


#     c.TerminalInteractiveShell.prompts_class = MyPrompts

#     def _hax(*args, **kwargs):
#         print("I: Patching the layout", args, kwargs, file=sys.stderr)
#         result = _hax._wrapped(*args, **kwargs)
#         # Attempt to make the long lines input copypasteable.
#         # Problem: it still inserts line breaks at the terminal width.
#         result['multiline'] = False
#         return result

#     from IPython.terminal.interactiveshell import TerminalInteractiveShell
#     _hax._wrapped = TerminalInteractiveShell._layout_options
#     TerminalInteractiveShell._layout_options = _hax


# c.PrefilterManager.multi_line_specials = False
