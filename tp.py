# import tkinter as tk
import os
import subprocess
from tkinter import *
import tkinter as tk

def analyser():
	os.system("flex LexicalAnalyser.l ")
	os.system("bison -d SyntaxicAnalyser.y")
	os.system("gcc -o execute.exe SyntaxicAnalyser.tab.c lex.yy.c")
	batcmd="execute.exe  <ex.txt"
	# result = subprocess.check_output(batcmd, shell=True , stderr=subprocess.STDOUT)
	
	try:
	    # grepOut = subprocess.check_output("grep " + "test" + " tmp", shell=True)                       
		result = subprocess.check_output(batcmd, shell=True , stderr=subprocess.STDOUT)
	except subprocess.CalledProcessError as grepexc:                                                                                                   
	    print("error code", grepexc.returncode, grepexc.output)
	    result=grepexc.output
	finally:
		f = open("file.txt", "wb")
		f.write(result)
		f.close()    

def refresh(T):
	with open('file.txt', 'r') as file:
		data = file.read().rstrip()
	T.insert(tk.END, data)



root = Tk()
root.geometry('1000x700')

l = Label(root, text = "analyseur syntaxique")
l.config(font =("Courier", 14))
T = Text(root, height =18, width = 80)
T2 = Text(root, height =16, width = 80)

button = Button(root, text = "analyser",command = analyser())
button2 = Button(root, text = "refresh",command = refresh(T2))

button.pack(side=LEFT)
button2.pack(side=LEFT)
l.pack()
T.pack(padx=20, pady=20)
T2.pack(padx=20, pady=20)

T2.insert(tk.END, "")

# analyser(T2,'file.txt')


with open('ex.txt', 'r') as file:
    data = file.read().rstrip()
T.insert(tk.END, data)

root.mainloop()




# text = Label(root, textvariable = "kazhefza ")
# text.pack()
# frm = ttk.Frame(root,width =800, height =50)

# ttk.Label(frm, text="Hello World!").grid(column=20, row=15)
# ttk.Button(frm, text="Quit", command=root.destroy).grid(column=1, row=0)




# canv = tk.Canvas(root, bg="white", height=200, width=200)
#flex LexicalAnalyser.l
#bison -d SyntaxicAnalyser.y
#gcc -o parser.exe SyntaxicAnalyser.tab.c lex.yy.c