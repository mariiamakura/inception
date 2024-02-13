FROM alpine:3.19

ARG FTP_USR \
    FTP_PWD

RUN apk update && apk upgrade && \
    apk add --no-cache vsftpd

RUN adduser -h /var/www -s /bin/false -D ${FTP_USR} && \
    echo "${FTP_USR}:${FTP_PWD}" | /usr/sbin/chpasswd && \
    adduser ${FTP_USR} root

RUN sed -i "s|#chroot_local_user=YES|chroot_local_user=YES|g" /etc/vsftpd/vsftpd.conf && \
    sed -i "s|#local_enable=YES|local_enable=YES|g" /etc/vsftpd/vsftpd.conf && \
    sed -i "s|#write_enable=YES|write_enable=YES|g" /etc/vsftpd/vsftpd.conf && \
    # umask controls the default permissions for newly created files. 
    # Changing it to 007 ensures that files uploaded by users 
    # are writable only by the owner and group, but not by others.
    sed -i "s|#local_umask=022|local_umask=007|g" /etc/vsftpd/vsftpd.conf

RUN echo "allow_writeable_chroot=YES" >> /etc/vsftpd/vsftpd.conf && \
    #Disabling resolve compatibility issues with certain configurations.
    echo 'seccomp_sandbox=NO' >> /etc/vsftpd/vsftpd.conf && \
    #server listens for data connections from the client, rather than initiating them
    echo 'pasv_enable=YES' >> /etc/vsftpd/vsftpd.conf

WORKDIR /var/www

EXPOSE 21

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]