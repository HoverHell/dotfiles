
# __into_builtin = True
# import os
# execfile(os.path.join(os.path.dirname(os.path.realpath(__file__)), 'startup', '13-olt.py'))


try:
    from pyaux import madness
except ImportError:
    print("XXX: No pyaux")
else:
    madness._olt_into_builtin()
