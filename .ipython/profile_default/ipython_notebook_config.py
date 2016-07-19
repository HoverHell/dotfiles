# coding: utf8

c = get_config()
# c.NotebookApp.profile = u'default'
c.NotebookApp.ip = '127.0.0.1'
# c.NotebookApp.ip = '*'
c.IPKernelApp.pylab = 'inline'
# c.NotebookApp.certfile = u'.ipython/profile_default/cert.pem'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 9880
# # from IPython.lib import passwd; passwd()
# c.NotebookApp.password = 'sha1:cd...'
