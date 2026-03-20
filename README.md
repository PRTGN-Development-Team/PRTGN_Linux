> [!NOTE]
> Everything in this repository is licenced under the terms of LICENCE.md unless separately stated with a credits.md file or metadata.json file.




https://github.com/OSInside/kiwi-descriptions

https://osinside.github.io/kiwi/

https://pagure.io/fedora-kiwi-descriptions


--

sudo setenforce 0

sudo kiwi-ng --debug --type iso system build \
    --description ./distro-config \
    --target-dir ./kiwi-output

sudo setenforce 1

--

git add .

git commit

git push

<!-- # Install the boxed plugin -->
<!-- >pip install kiwi-boxed-plugin -->

<!-- # Then build using boxbuild instead of the normal build command -->
<!-- >sudo kiwi-ng --type iso system boxbuild -->
<!--      --box fedora \ -->
<!--      -- \ -->
<!--      --description ./distro-config \ -->
<!--      --target-dir ./var/kiwi/output -->
