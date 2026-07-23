import sys

try:
    from pyaux import madness
except ImportError:
    print("E: No pyaux", file=sys.stderr)
else:
    madness._olt_into_builtin()

c = get_config()  # noqa: F821

c.TerminalIPythonApp.display_banner = False
c.InteractiveShell.history_length = 10000000
