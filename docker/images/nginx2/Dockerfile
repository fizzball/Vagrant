FROM nginx2

ENV HOME /root
ENV PATH /usr/local/nginx/bin:$PATH
WORKDIR /root

EXPOSE 80 443
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
