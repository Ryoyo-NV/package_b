# syntax=docker/dockerfile:1

FROM ros:jazzy

SHELL ["/bin/bash", "-lc"]

# Avoid interactive prompts only while building the image.
ARG DEBIAN_FRONTEND=noninteractive

# Basic development tools, shell completion, USB utilities, and ROS 2 packages.
RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y --no-install-recommends \
    bash-completion \
    build-essential \
    git \
    python3-argcomplete \
    python3-colcon-common-extensions \
    python3-pip \
    python3-rosdep \
    python3-vcstool \
    usbutils \
    vim \
    vim-gtk3 \
    ros-jazzy-moveit \
    ros-jazzy-moveit-configs-utils \
    ros-jazzy-ros2-controllers \
    ros-jazzy-topic-tools \
 && rm -rf /var/lib/apt/lists/*

# The official ROS image may already contain rosdep configuration.
RUN rosdep init 2>/dev/null || true \
 && rosdep update --rosdistro jazzy

WORKDIR /root/ros2_ws
RUN mkdir -p src

RUN --mount=type=bind,source=.,target=/tmp/ros2_src,ro \
    source /opt/ros/jazzy/setup.bash \
 && apt-get update \
 && rosdep install \
      --from-paths /tmp/ros2_src \
      --ignore-src \
      --rosdistro jazzy \
      -r -y \
 && rm -rf /var/lib/apt/lists/*


RUN <<'EOF'
cat >> /etc/bash.bashrc <<'BRC'

# ---- bash completion ----
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

# ---- ROS 2 Jazzy ----
if [ -f /opt/ros/jazzy/setup.bash ]; then
  . /opt/ros/jazzy/setup.bash
fi

# ---- colcon argcomplete ----
if [ -f /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash ]; then
  . /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
fi
BRC
EOF

CMD ["bash"]
