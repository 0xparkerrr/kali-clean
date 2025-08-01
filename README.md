# Kali-Clean

My clone of xct's kali-clean repo for personal use. Goal is to create a Kali installer that works just the way I like it. Feel free to give it a try yourself :)  
> `install.sh` updates kali and installs a lot of stuff, so it will take a while.

## Installation
Just run this as the default kali user:
```
git clone https://github.com/jazzpizazz/kali-clean.git /tmp/kali-clean && cd /tmp/kali-clean && bash ./install.sh
```

After the script is done reboot and select i3 (top right corner) on the login screen. Then open a terminal (`ctrl+return`) run `lxappearance` and select ark-dark theme and change the icons to whatever you like (I used papyrus).

## Post-Installation Steps (optional)
I now use Hyper-V as my hypervisor and noticed it requires the user to use an Enhanced Session (XRDP) in order to use the bi-directional clipboard (which I heavily rely on).

However, when connecting via XRDP, it uses the default window manager that comes with Kali instead of i3. The following solution was found in [this Reddit thread](https://www.reddit.com/r/i3wm/comments/77huzd/i3_remote_desktop_with_rdp/):

1. Create the `.xsession` file in your home directory:
```
echo "i3" > ~/.xsession
chmod +x ~/.xsession
```

2. Omit the last two lines in `/etc/xrdp/startwm.sh`:
```
test -x /etc/X11/Xsession && exec /etc/X11/Xsession
exec /bin/sh /etc/X11/Xsession
```

3. Add the following to the end of `/etc/xrdp/startwm.sh`:
```
if [ -r ~/.xsession ]; then
	exec /bin/bash --login ~/.xsession
elif command -v i3 >/dev/null 2>&1; then
	exec i3
else
	exec /etc/X11/Xsession
fi
```


## Credits
All credits for the actual script and config go to [jazzpizzaz](https://github.com/jazzpizazz) and [xct](https://github.com/xct). I just tweaked it for personal usage.
