FROM ubuntu:17.04
RUN apt-get update -y && apt-get install -y unzip inetutils-ping dnsutils curl vim xvfb x11vnc x11-apps default-jre fonts-wqy-zenhei
RUN apt-get install -y wget supervisor
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get update -y
RUN apt-get install -y google-chrome-stable
ENV DISPLAY :1
RUN cd /tmp && wget https://goo.gl/hWYjHR && mv hWYjHR selenium.tar
RUN cd /tmp && wget https://chromedriver.storage.googleapis.com/2.32/chromedriver_linux64.zip && unzip chromedriver_linux64.zip
RUN ln -s /tmp/chromedriver /usr/local/bin/chromedriver
COPY supervisord.conf /etc/supervisord.conf
RUN mkdir -p /var/log/supervisor
RUN groupadd -r chrome && useradd -r -g chrome -G audio,video chrome && mkdir -p /home/chrome/Downloads && chown -R chrome:chrome /home/chrome
USER chrome
CMD ["/usr/bin/supervisord"]
