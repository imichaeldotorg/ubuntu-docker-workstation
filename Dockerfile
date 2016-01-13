# Pull base image.
FROM ubuntu:trusty

# Install LXDE and VNC server.
RUN apt-get update
RUN apt-get -y dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y xfce4 xfce4-goodies wget tightvncserver
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y shimmer-themes gnome-icon-theme-full tango-icon-theme

# Install Google Chrome
RUN /bin/bash -c 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -' 
RUN /bin/bash -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update
RUN apt-get -y install google-chrome-stable

# Install sudo, and give passwordless privileges to wsuser
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y sudo
RUN useradd -ms /bin/bash wsuser
RUN /bin/bash -c 'echo "wsuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'
USER wsuser 
ENV USER wsuser 


# Configure VNC - replace "YOURPASSWORD" here with a preferred VNC password
RUN echo 'YOURPASSWORD' >/tmp/pwd && echo 'YOURPASSWORD' >> /tmp/pwd && vncpasswd < /tmp/pwd && rm /tmp/pwd

# Default Command starts a 1080p VNC session.
CMD /bin/bash -c "vncserver :1 -geometry 1920x1080 -depth 24 && tail -F /root/.vnc/*.log"

# The VNC server listens on 5901.  You still need to expose the port at runtime. 
EXPOSE 5901

# To build this dockerfile, use the following command:
# docker build -t workstation .

# To run this dockerfile, use the following command:
# docker run -d -p "5901:5901" workstation

# If you want to have a persistent volume between different runs, use this command instead:
# docker run -d -v /home/$USER/.workstation:/home/wsuser -p "5901:5901" workstation
