ARG os=7.9.2009
FROM aursu/rpmbuild:${os}-base-kernel

ENV kernel_build=0.rc2.23.fc39
ENV kernel_source=linux-6.4-rc2.tar.xz

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN cd ${BUILD_TOPDIR} \
    && mkdir -p kernel-6.4.0-${kernel_build} && cd kernel-6.4.0-${kernel_build} \
    && curl -O https://kojipkgs.fedoraproject.org//packages/kernel/6.4.0/${kernel_build}/src/kernel-6.4.0-${kernel_build}.src.rpm \
    && rpm2cpio kernel-6.4.0-${kernel_build}.src.rpm | cpio -idmv \
    && mv ${kernel_source} ${BUILD_TOPDIR}/SOURCES \
    && rm -rf ${BUILD_TOPDIR}/kernel-6.4.0-${kernel_build} \
    && cd ${BUILD_TOPDIR}/SOURCES \
    && sha256sum -c sha256sums.asc

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER
ENTRYPOINT ["/usr/bin/rpmbuild", "kernel.spec"]
CMD ["-ba"]
