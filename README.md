# Lisp-Emacs

---

## Lisp


[SBCL](http://www.sbcl.org)

[CLiki -- a Common Lisp wiki ](https://www.cliki.net)

---

## Emacs & emacs-lisp

[The Emacs Editor](https://www.gnu.org/software/emacs/manual/html_node/emacs/index.html#SEC_Contents)

[Running Shell Commands from Emacs](https://www.gnu.org/software/emacs/manual/html_node/emacs/Shell.html)

[An Introduction to Programming in Emacs Lisp](https://www.gnu.org/software/emacs/manual/html_node/eintr/index.html#SEC_Contents)

[GNU Emacs](https://www.gnu.org/software/emacs/)

[GNU](https://www.gnu.org)

==

[Org Mode](https://orgmode.org)

[emacs org-mode 的使用](https://www.wenhui.space/docs/02-emacs/emacs_org_mode/)

[Org Mode - 年轻人的第一堂时间管理课程](https://juejin.cn/post/6844904167446675469)

[Emacs给Go一个更好的Playground](https://www.jianshu.com/p/c5467b24ee54)

---

## Emacs server and  Emacsclient

```
# emacs server and emacsclient
alias es='emacs -nw --daemon=st-emacs'
alias ec='emacsclient -s st-emacs'
```

[Using Emacs as a Server](https://www.gnu.org/software/emacs/manual/html_node/emacs/Emacs-Server.html)

Run Emacs as a daemon, using one of the ‘--daemon’ command-line options. See [Initial Options](https://www.gnu.org/software/emacs/manual/html_node/emacs/Initial-Options.html). When Emacs is started this way, it calls server-start after initialization and does not open an initial frame. It then waits for edit requests from clients.

‘-daemon’

‘--daemon[=name]’

‘--bg-daemon[=name]’

‘--fg-daemon[=name]’

Start Emacs as a daemon: after Emacs starts up, it starts the Emacs server without opening any frames. You can then use the emacsclient command to connect to Emacs for editing. (Optionally, you can specify an explicit name for the server; if you do, you will need to specify the same name when you invoke emacsclient, via its --socket-name option, see emacsclient Options.) See Using Emacs as a Server, for information about using Emacs as a daemon. A “background” daemon disconnects from the terminal and runs in the background (‘--daemon’ is an alias for ‘--bg-daemon’).

        emacs --daemon[=NAME]

[emacsclient Options](https://www.gnu.org/software/emacs/manual/html_node/emacs/emacsclient-Options.html)

‘--parent-id=id’

Open an emacsclient frame as a client frame in the parent X window with id id, via the XEmbed protocol. Currently, this option is mainly useful for developers.

==

‘-s server-name’

‘--socket-name=server-name’

Connect to the Emacs server named server-name. (This option is not supported on MS-Windows.) The server name is given by the variable server-name on the Emacs server. If this option is omitted, emacsclient connects to the default socket. If you set server-name of the Emacs server to an absolute file name, give the same absolute file name as server-name to this option to instruct emacsclient to connect to that server. You need to use this option if you started Emacs as daemon (see Initial Options) and specified the name for the server started by the daemon.

Alternatively, you can set the EMACS_SOCKET_NAME environment variable to point to the server socket. (The command-line option overrides the environment variable.)

        emacsclient --socket-name=NAME
        
        emacsclient -s NAME

---

