ARG os=8.7.20221112
FROM aursu/rpmbuild:${os}-build-systemd

RUN dnf -y install \
        grub2 \
        grubby \
        initscripts \
        linux-firmware \
    && dnf clean all && rm -rf /var/cache/dnf

RUN dnf -y --enablerepo bintray-custom install \
        kmod \
    && dnf clean all && rm -rf /var/cache/dnf

RUN /usr/bin/systemd-machine-id-setup \
    && :> /etc/fstab \
    && systemctl enable systemd-journald