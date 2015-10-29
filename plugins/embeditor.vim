if !has('python')
	echo "Error: Required vim compiled with +python"
	finish
endif

function! StartServer()
python << endpython
import vim
import xmlrpclib
from SimpleXMLRPCServer import SimpleXMLRPCServer
import threading
import os

def get_content():
   filecontent = '\n'.join(vim.current.buffer)
   return filecontent

def save_and_quit():
   vim.command('[wq]')

def can_complete():
   if 'i' == vim.eval('mode()'):
   	return True
   else:
        return False

def get_cursor():
   return vim.current.window.cursor

def navigate(row, column):
  row = int(row)+1
  column = int(column)+1
  if len(vim.current.buffer) >= row:
          vim.current.window.cursor = (row, 1)
          if len(vim.current.buffer[row]) >= column:
              vim.current.window.cursor = (row, column)
   
def start_server(host, port):
    try:
        server = SimpleXMLRPCServer((host, port), logRequests=False)
    except:
        raise

    server.register_function(get_cursor)
    server.register_function(save_and_quit)
    server.register_function(can_complete)
    server.register_function(get_content)
    server.register_function(navigate)

    server.serve_forever()

p = os.getenv('VIM_RPC_PORT')

if p is not None:
	server_thread = threading.Thread(target=start_server,
                                     name='ServerThread',
                                     args=('127.0.0.1', int(p)))
	server_thread.setDaemon(True)
	server_thread.start()
endpython
endfunction

call StartServer()
