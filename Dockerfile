FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install -y git sshfs archivemount encfs aufs-tools nfs-client
RUN echo '[ -d /root/.bash ] || git clone git://github.com/spencertipping/dotbash /root/.bash' >> /root/.bashrc \
 && echo '. /root/.bash/init' >> /root/.bashrc

VOLUME /data
CMD /bin/bash
