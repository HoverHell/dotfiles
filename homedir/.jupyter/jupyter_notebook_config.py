c = get_config()  # noqa: F821
# c.NotebookApp.profile = u'default'

c.ServerApp.ip = "127.0.0.1"
# c.ServerApp.ip = '*'
c.ServerApp.port = 9880
c.ServerApp.open_browser = False
c.ExtensionApp.open_browser = False

# # from IPython.lib import passwd; passwd()
# c.NotebookApp.password = 'sha1:cd...'
