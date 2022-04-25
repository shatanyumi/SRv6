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
echo_g "${ctl_A} create memif socket id 9 filename /run/vpp/memif9_vcpea_vroutera.sock"
$ctl_A create memif socket id 9 filename /run/vpp/memif9_vcpea_vroutera.sock
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

#if false;then
# ===========================
# config ip 
# ===========================
echo_r "==== Config vRouters IP ===="

# --------------------------
# vRouterA
# --------------------------
echo_g "---- Config vRouterA ----"
echo_g "set G0 interface"
echo_y "${ctl_A} set int state G0 up"
$ctl_A set int state G0 up
echo_y "${ctl_A} set int ip address G0 fdab::1/96"
$ctl_A set int ip address G0 fdab::1/96

echo_g "set route rules"
echo_y "${ctl_A} ip route add ::/0 via fdab::2"
$ctl_A ip route add ::/0 via fdab::2
$ctl_A show int address 

echo_g "set G1 interface"
echo_y "${ctl_A} set int state G1 up"
$ctl_A set int state G1 up
echo_y "${ctl_A} set int ip address G1 10.10.10.1/24"
$ctl_A set int ip address G1 10.10.10.1/24
$ctl_A show int address

echo_g "add loopback interface"
echo_y "${ctl_A} loopback create-interface"
$ctl_A loopback create-interface
echo_y "${ctl_A} set interface state loop0 up"
$ctl_A set interface state loop0 up
echo_y "${ctl_A} set interface ip address loop0 fc10::1/96"
$ctl_A set interface ip address loop0 fc10::1/96
$ctl_A show int address

# --------------------------
# vRouterB
# --------------------------
echo_g "---- Config vRouterB ----"
echo_g "set G0 interface"
echo_y "${ctl_B} set int state G0 up"
$ctl_B set int state G0 up
echo_y "${ctl_B} set int ip address G0 fdab::2/96"
$ctl_B set int ip address G0 fdab::2/96
$ctl_B show int address

echo_g "set route rules"
echo_y "${ctl_B} ip route add ::/0 via fdab::1"
$ctl_B ip route add ::/0 via fdab::1
$ctl_B show int address

echo_g "set G1 interface"
echo_y "${ctl_B} set int state G1 up"
${ctl_B} set int state G1 up
echo_y "${ctl_B} set int ip address G1 10.10.1.1/24"
$ctl_B set int ip address G1 10.10.1.1/24
$ctl_B show int address

echo_g "add loopback interface"
echo_y "${ctl_B} loopback create-interface"
${ctl_B} loopback create-interface
echo_y "${ctl_B} set interface state loop0 up"
$ctl_B set interface state loop0 up
echo_y "${ctl_B} set interface ip address loop0 fc01::1/96"
$ctl_B set interface ip address loop0 fc01::1/96
$ctl_B show int address


# --------------------------
# vCPEA
# --------------------------
echo_g "---- Config vCPEA ----"

echo_y "${ctl_cpe_a} set int state G up"
$ctl_cpe_a set int state G up
$ctl_cpe_a show int
echo_y "${ctl_cpe_a} set int ip address G 10.10.10.2/24"
$ctl_cpe_a set int ip address G 10.10.10.2/24
$ctl_cpe_a show int address
echo_y "${ctl_cpe_a} ip route add 10.10.1.0/24 via 10.10.10.1"
$ctl_cpe_a ip route add 10.10.1.0/24 table 0 via 10.10.10.1 G

# --------------------------
# vCPEB
# --------------------------
echo_g "---- Config vCPEB ----"

echo_y "${ctl_cpe_b} set int state G up"
$ctl_cpe_b set int state G up
$ctl_cpe_b show int
echo_y "${ctl_cpe_b} set int ip address G 10.10.1.2/24"
$ctl_cpe_b set int ip address G 10.10.1.2/24
$ctl_cpe_b show int address
echo_y "${ctl_cpe_b} ip route add 10.10.10.0/24 table 0 via 10.10.1.1 G"
$ctl_cpe_b ip route add 10.10.10.0/24 table 0 via 10.10.1.1 G


# ===========================
# config SR 
# ===========================

# --------------------------
# vRouterA
# --------------------------
#if false;then
echo_r "==== Config SR ===="

echo_g "---- Config vRouterA SR----"

echo_y "${ctl_A} sr localsid address fc10::1a behavior end.dx4 G1 10.10.10.2"
$ctl_A sr localsid address fc10::1a behavior end.dx4 G1 10.10.10.2
echo_y "${ctl_A} sr policy add bsid fe10::1a next fc01::1a "
$ctl_A sr policy add bsid fe10::1a next fc01::1a
echo_y "${ctl_A} sr steer l3 10.10.1.0/24 via bsid fe10::1a"
$ctl_A sr steer l3 10.10.1.0/24 via bsid fe10::1a
$ctl_A show sr localsid

# ----------------------------
# vRouterB
# ----------------------------
echo_g "---- Config vRouterB SR ----"
echo_y "${ctl_B} sr localsid address fc01::1a behavior end.dx4 G1 10.10.1.2"
$ctl_B sr localsid address fc01::1a behavior end.dx4 G1 10.10.1.2
echo_y "${ctl_B} sr policy add bsid fe01::1a next fc10::1a"
$ctl_B sr policy add bsid fe01::1a next fc10::1a
echo_y "${ctl_B} sr steer l3 10.10.10.0/24 via bsid fe01::1a"
$ctl_B sr steer l3 10.10.10.0/24 via bsid fe01::1a
$ctl_B show sr localsid
#fi

# =======
# test
# =======
echo_g "sr test: "
$ctl_cpe_a ping 10.10.1.2
$ctl_A show sr localsid
$ctl_B show sr localsid
