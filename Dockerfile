ARG os=7.9.2009
FROM aursu/rpmbuild:${os}-base-kernel

# ENV tarfile_release=6.4.0

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
# ADD https://www.kernel.org/pub/linux/kernel/v6.x/linux-${tarfile_release}.tar.xz ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER
ENTRYPOINT ["/usr/bin/rpmbuild", "kernel.spec"]
CMD ["-ba"]
