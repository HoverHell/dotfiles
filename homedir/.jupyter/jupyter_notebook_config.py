# coding: utf8

c = get_config()
# c.NotebookApp.profile = u'default'

c.ServerApp.ip = '127.0.0.1'
# c.ServerApp.ip = '*'
c.ServerApp.port = 9880
c.ServerApp.open_browser = False
c.ExtensionApp.open_browser = False

# c.IPKernelApp.pylab = 'inline'
# c.NotebookApp.certfile = u'.ipython/profile_default/cert.pem'

# # from IPython.lib import passwd; passwd()
# c.NotebookApp.password = 'sha1:cd...'
