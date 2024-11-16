#!/bin/bash

cat << 'EOF' >> ~/.bashrc

# full
alias stop='sudo systemctl stop slam infra'
alias start='sudo systemctl start slam infra'
alias enable='sudo systemctl enable roscore infra slam'
alias disable='sudo systemctl disable infra slam'
# roscore
alias start_core='sudo systemctl start roscore'
alias stop_core='sudo systemctl stop roscore'
alias enable_core='sudo systemctl enable roscore'
alias disable_core='sudo systemctl disable roscore'
# infra
alias start_infra='sudo systemctl start infra'
alias stop_infra='sudo systemctl stop infra'
alias enable_infra='sudo systemctl enable roscore infra'
# utils
alias test='~/catkin_ws/src/agri_resources/scripts/fcu_comm.sh'
alias network='~/catkin_ws/src/agri_resources/scripts/network_switch.sh'
alias cui='sudo systemctl set-default multi-user'
alias gui='sudo systemctl set-default graphical'

EOF

source ~/.bashrc