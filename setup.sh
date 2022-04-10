#!/bin/sh
echo_r () {
    echo "\033[31m$1\033[0m"
}
echo_g () {
    echo  "\033[32m$1\033[0m"
}
echo_y () {
    echo  "\033[33m$1\033[0m"
}
echo_b () {
    echo  "\033[34m$1\033[0m"
}

echo_r "==== Set up all vRouters ===="

# --------------------------------------
# vRouterA
# --------------------------------------
echo_g "---- start vRouterA ----"
sudo /usr/bin/vpp -c ./vRouters/vRouterA.conf
echo "waiting..."
sleep 5
ls /run/vpp

ctl_A="sudo vppctl -s /run/vpp/vRouterA.sock"
echo_b "${ctl_A} show int"
$ctl_A show int

echo_g "Check above interface"

echo_y "create memif socket for vRouterA-G0 and vRouterB-G0"
echo_g "${ctl_A} create memif socket id 10 filename /run/vpp/memif10_vroutera_vrouterb.sock"
$ctl_A create memif socket id 10 filename /run/vpp/memif10_vroutera_vrouterb.sock
ls /run/vpp

echo_g "${ctl_A} create interface memif id 0 socket-id 10 master"
$ctl_A create interface memif id 0 socket-id 10 master
$ctl_A show int
echo_y "rename interface memif10/0 to G0"
$ctl_A set interface name memif10/0 G0
$ctl_A show int

echo_y "create memif socket for vRouterA-G1 and vCPEA-G"
echo_g "${ctl_A} create memif socket id 9 filename /run/vpp/memif9_cpea_vroutera.sock"
$ctl_A create memif socket id 9 filename /run/vpp/memif9_cpea_vroutera.sock
ls /run/vpp

echo_g "${ctl_A} create interface memif id 1 socket-id 11 master"
$ctl_A create interface memif id 1 socket-id 9 master
$ctl_A show int

echo_y "rename interface memif9/1 to G1"
$ctl_A set interface name memif9/1 G1
$ctl_A show int

# ------------------------------------------------
# vRouterB
# ------------------------------------------------
echo_g "---- start vRouterB ----"
sudo /usr/bin/vpp -c ./vRouters/vRouterB.conf
echo "waiting..."
sleep 5
ls /run/vpp

ctl_B="sudo vppctl -s /run/vpp/vRouterB.sock"
echo_b "${ctl_B} show int"
$ctl_B show int

echo_g "Check above interface"

echo_y "Connect vRouterB-G0 memif socket to memif10_vroutera_vrouterb.sock"
echo_g "${ctl_B} create memif socket id 0 filename /run/vpp/memif10_vroutera_vrouterb.sock"
$ctl_B create memif socket id 10 filename /run/vpp/memif10_vroutera_vrouterb.sock
ls /run/vpp

echo_g "${ctl_B} create interface memif id 0 socket-id 10 slave"
$ctl_B create interface memif id 0 socket-id 10 slave
$ctl_B show int
echo_y "rename interface memif10/0 to G0"
$ctl_B set interface name memif10/0 G0
$ctl_B show int

echo_y "create memif sock for vRouterB-G1 and vCPEB-G"
echo_g "${ctl_B} create memif socket id 11 filename /run/vpp/memif11_vcpeb_vrouterb.sock"
$ctl_B create memif socket id 11 filename /run/vpp/memif11_vcpeb_vrouterb.sock
ls /run/vpp

echo_g "${ctl_B} create interface memif id 2 socket-id 11 master"
$ctl_B create interface memif id 2 socket-id 11 master
$ctl_B show int

echo_y "rename interface memif11/2 to G1"
$ctl_B set interface name memif11/2 G1
$ctl_B show int

# -------------------------------------
# vCPEA
# -------------------------------------
echo_g "---- start vCPEA ----"
sudo /usr/bin/vpp -c ./vRouters/vCPEA.conf
echo "waiting..."
sleep 5
ls /run/vpp

ctl_cpe_a="sudo vppctl -s /run/vpp/vCPEA.sock"
echo_b "${ctl_cpe_a} show int"
$ctl_cpe_a show int
echo_g "Check above interface"

echo_y "Connect vCPEA-G memif socket to memif9_vcpea_vroutera.sock"
echo_g "${ctl_cpe_a} create memif socket id 9 filename /run/vpp/memif9_vcpea_vroutera.sock"
$ctl_cpe_a create memif socket id 9 filename /run/vpp/memif9_vcpea_vroutera.sock
ls /run/vpp

echo_y "${ctl_cpe_a} create interface memif id 1 socket-id 9 slave"
$ctl_cpe_a create interface memif id 1 socket-id 9 slave
$ctl_cpe_a show int

echo_y "rename interface memif9/1 to G"
$ctl_cpe_a set interface name memif9/1 G
$ctl_cpe_a show int

# -------------------------------------
# vCPEA
# -------------------------------------
echo_g "---- start vCPEB ----"
sudo /usr/bin/vpp -c ./vRouters/vCPEB.conf
echo "waiting..."
sleep 5
ls /run/vpp

ctl_cpe_b="sudo vppctl -s /run/vpp/vCPEB.sock"
echo_b "${ctl_cpe_b} show int"
$ctl_cpe_b show int
echo_g "Check above interface"

echo_y "Connect vCPEB-G memif socket to memif11_vcpeb_vrouterb.sock"
echo_g "${ctl_cpe_b} create memif socket id 11 filename /run/vpp/memif11_vcpeb_vrouterb.sock"
$ctl_cpe_b create memif socket id 11 filename /run/vpp/memif11_vcpeb_vrouterb.sock
ls /run/vpp

echo_y "${ctl_cpe_b} create interface memif id 2 socket-id 11 slave"
$ctl_cpe_b create interface memif id 2 socket-id 11 slave
$ctl_cpe_b show int

echo_y "rename interface memif11/2 to G"
$ctl_cpe_b set interface name memif11/2 G
$ctl_cpe_b show int

echo_r "==== All vRouter start done! ===="
