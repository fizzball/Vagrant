FROM nginx

ENV HOME /root
ENV PATH $PATH:/usr/local/nginx/bin
WORKDIR /root

COPY bashrc .bashrc
ADD nginx_config /etc/nginx/conf.d/

EXPOSE 80 443
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
