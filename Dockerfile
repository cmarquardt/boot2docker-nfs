#--------------------------------------------------------------------------------
# boot2docker-nfs - A modified boot2docker image
# Copyright (C) 2017  Christian Marquardt
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#--------------------------------------------------------------------------------

FROM boot2docker/boot2docker:17.12.1-ce

# Notes:
# - ROOTFS is inherited from master container
# - IP address range routed through bridged interface is hardcoded,
#   and only meaningful for EUMETSAT's internal purposes

# Add a /etc/rc.d/nfs-client script (including additional routing entries)
RUN echo "#!/bin/sh\n" > $ROOTFS/etc/rc.d/nfs-client && \
    echo "# Provide additional routes through eth2\n" >> $ROOTFS/etc/rc.d/nfs-client && \
    echo "ip route add 10.11.8.0/24 dev eth2\n" >> $ROOTFS/etc/rc.d/nfs-client && \
    echo "# Startup NFS client\n" >> $ROOTFS/etc/rc.d/nfs-client && \
    echo "/usr/local/etc/init.d/nfs-client start" >> $ROOTFS/etc/rc.d/nfs-client && \
    chmod +x $ROOTFS/etc/rc.d/nfs-client

# Insert NFS client launcher
RUN mv $ROOTFS/opt/bootscript.sh $ROOTFS/opt/bootscript.sh.orig && \
    awk  '/^# Launch Docker/ {print "# Launch NFS client\n/etc/rc.d/nfs-client\n"}1' \
              $ROOTFS/opt/bootscript.sh.orig > $ROOTFS/opt/bootscript.sh && \
    chmod +x $ROOTFS/opt/bootscript.sh

# Create a new ISO image
RUN /tmp/make_iso.sh
