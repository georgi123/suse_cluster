#!/bin/bash

echo "Use $1 to set first cluster node"
echo "Use $2 to set second cluster node"
echo "Use $3 to set pathing bundel"
echo "If you understand varibles press enter to proceed"
#command=$(if [ -f /root/scripts/mk_syscopy.sh ];then /root/scripts/./mk_syscopy.sh;elif [ -f /usr/sbin/alternate_boot ]; then /usr/sbin/alternate_boot -c; else ehco "Not match backup scripts."; fi)

echo "setting up patching bundle"

/opt/susemgr-scripts/./ChangeSoftwareChannel.py -n $1 -c $3

/opt/susemgr-scripts/ChangeSoftwareChannel.py  -n $2 -c $3

echo "copping scripts on both nodes"

salt -L "$1, $2" state.sls copy-cluster-scripts



ssh $1 /root/scripts/cluster_project/cluster_patch_first.node
echo "##############################################################"
echo "##############################################################"
echo "##############################################################"
echo Wait when second cluster NODE is up and running
echo After you sure press enter to procced with start_cluster script
echo "##############################################################"
echo "##############################################################"
echo "##############################################################"


#read
yes "" | command

ssh $1 /root/scripts/cluster_project/start_cluster
