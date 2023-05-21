# Lisp-Emacs

---

## Lisp


[SBCL](http://www.sbcl.org)

[CLiki -- a Common Lisp wiki ](https://www.cliki.net)

---
## Emacs server emacsclient

[Using Emacs as a Server](https://www.gnu.org/software/emacs/manual/html_node/emacs/Emacs-Server.html)

Run Emacs as a daemon, using one of the ‘--daemon’ command-line options. See [Initial Options](https://www.gnu.org/software/emacs/manual/html_node/emacs/Initial-Options.html). When Emacs is started this way, it calls server-start after initialization and does not open an initial frame. It then waits for edit requests from clients.

‘-daemon’
‘--daemon[=name]’
‘--bg-daemon[=name]’
‘--fg-daemon[=name]’

Start Emacs as a daemon: after Emacs starts up, it starts the Emacs server without opening any frames. You can then use the emacsclient command to connect to Emacs for editing. (Optionally, you can specify an explicit name for the server; if you do, you will need to specify the same name when you invoke emacsclient, via its --socket-name option, see emacsclient Options.) See Using Emacs as a Server, for information about using Emacs as a daemon. A “background” daemon disconnects from the terminal and runs in the background (‘--daemon’ is an alias for ‘--bg-daemon’).

        emacd --daemon[=name]



---

## Emacs & emacs-lisp

[An Introduction to Programming in Emacs Lisp](https://www.gnu.org/software/emacs/manual/html_node/eintr/index.html#SEC_Contents)

[GNU Emacs](https://www.gnu.org/software/emacs/)

[GNU](https://www.gnu.org)

==

[Org Mode](https://orgmode.org)

[emacs org-mode 的使用](https://www.wenhui.space/docs/02-emacs/emacs_org_mode/)

[Org Mode - 年轻人的第一堂时间管理课程](https://juejin.cn/post/6844904167446675469)

[Emacs给Go一个更好的Playground](https://www.jianshu.com/p/c5467b24ee54)
