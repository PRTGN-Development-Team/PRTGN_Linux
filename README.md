https://github.com/OSInside/kiwi-descriptions

https://osinside.github.io/kiwi/

https://pagure.io/fedora-kiwi-descriptions


--

# Install the boxed plugin
>pip install kiwi-boxed-plugin

# Then build using boxbuild instead of the normal build command
>sudo kiwi-ng --type iso system boxbuild
     --box fedora \
     -- \
     --description ./distro-config \
     --target-dir ./var/kiwi/output
