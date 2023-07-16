FROM ubuntu:jammy

RUN apt update \
&& apt install wget -y \
&& wget https://github.com/jgm/pandoc/releases/download/3.0.1/pandoc-3.0.1-1-amd64.deb \
&& wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.jammy_amd64.deb \
&& apt install ./pandoc-3.0.1-1-amd64.deb -y \
&& apt install ./wkhtmltox_0.12.6.1-2.jammy_amd64.deb -y