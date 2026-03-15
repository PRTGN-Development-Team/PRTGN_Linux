>[!INFO]
> Everything in this repository is licenced under the terms of LICENCE.md except for the assets folder. The assets folder has appropriate licences in the credits.md file.




https://github.com/OSInside/kiwi-descriptions

https://osinside.github.io/kiwi/

https://pagure.io/fedora-kiwi-descriptions


--

sudo sentenforce 0

sudo kiwi-ng --type iso system build \
    --description ./distro-config \
    --target-dir ./kiwi-output

sudo sentenforce 1


<!-- # Install the boxed plugin -->
<!-- >pip install kiwi-boxed-plugin -->

<!-- # Then build using boxbuild instead of the normal build command -->
<!-- >sudo kiwi-ng --type iso system boxbuild -->
<!--      --box fedora \ -->
<!--      -- \ -->
<!--      --description ./distro-config \ -->
<!--      --target-dir ./var/kiwi/output -->
