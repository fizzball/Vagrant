FROM nginx

ENV HOME /root
ENV PATH /usr/local/nginx/bin:$PATH
WORKDIR /root

ADD web_content /usr/share/nginx/html/
ADD nginx_config /etc/nginx/
COPY bashrc /root/.bashrc

EXPOSE 80 443
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
