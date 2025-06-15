---
title: "MacOS Mojave Review (Developer Beta)"
date: 2018-06-26T16:43:59+05:30
tags: ["MacOS", "Mojave"]
---
Hi everyone,

So this blog post is basically about the first impressions of the macOS mojave which is currently in developer beta.

At first when I installed the beta it asks which appearance would you like to choose? **Dark (obvious, eh)**, after all, this was one of the biggest features for which I wanted to try out MacOS Mojave.

After the OS boots up, I did feel a bit of **changes in animations** here and there, also some things opened up quicker than before.

Here's a look at the desktop with the dynamic dark Mojave Wallpaper:
![MacOS Mojave dark mode desktop](/images/post-2/mojave-desktop.png "MacOS Mojave Dark Mode")

Even the trash can's dark 😉 🗑.

So, the dark mode has some issues here and there, for example this file picker window in VS Code: 

![MacOS Mojave File Picker glitch](/images/post-2/mojave-file-picker.png "MacOS Mojave File Picker glitch")

Now, there are some breaking changes in this beta version. For some reason, **WebTorrent** doesn't work. Also, I don't know if its me or others also, ```/usr/include``` directory was missing even after installing the **CommandLineTools**.

And so I wasn't able to install some tools like GNU GCC. Although, there might be some work around which I don't know. Also System Integrity Protection won't allow even a root user to create ```/usr/include/```, so tough luck there 😐.

The only work around was to use the existing apple provided clang. So I quicky created ```bits/stdc++.h``` and with some aliases for C++-14 and a small shell command, everything is fine for now.

Also the dark mode is too dark in some apps, for instance, see how iTunes looks:

![MacOS Mojave iTunes in dark mode](/images/post-2/mojave-itunes-dark-mode.png "MacOS Mojave iTunes with Dark Mode")

The touchBar expanding animation also has a small change with the borders removed in the standard set of icons:

![MacOS Mojave Touch Bar](/images/post-2/mojave-touch-bar.png "MacOS Mojave Touch Bar buttons")

The lock screen fonts look bigger too and it looks more cleaner now.

Also one of the most important points was that it has elevated security now. Apps now ask you permissions before accessing your contacts or any other apps.

Overall, this beta is something which I will still not recommend a normal person to run, since there have been times the betas crash badly and which may require a full fresh installtion. So install at your own risk.

Thanks for reading this post!

**Kumar Shubham 👋🏻**







