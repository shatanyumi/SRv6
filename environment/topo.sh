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

# ======================================
# Switch topo
# ======================================
echo_r "==== Set up all Switches ！ ===="

# router1
echo_g "---- Set up router1 ----"

echo_b "sudo vpp -c ./vRouters/router1.conf"
sudo vpp -c ./vRouters/router1.conf
echo "waiting..."
sleep 5
ls /run/vpp

router1="sudo vppctl -s /run/vpp/router1.sock"

echo_y "$router1 create memif socket id 11 filename /run/vpp/memif11.sock"
$router1 create memif socket id 11 filename /run/vpp/memif11.sock
echo_y "$router1 create memif socket id 12 filename /run/vpp/memif12.sock"
$router1 create memif socket id 12 filename /run/vpp/memif12.sock
ls /run/vpp

echo_g "add loopback interface"
echo_y " $router1 loopback create-interface"
$router1 loopback create-interface

echo_y "$router1 create interface memif id 1 socket-id 11 master"
$router1 create interface memif id 1 socket-id 11 slave
echo_y "$router1 set int name memif11/1 left1"
$router1 set int name memif11/1 left1
echo_y "$router1 create interface memif id 2 socket-id 12 master"
$router1 create interface memif id 2 socket-id 12 master
echo_y "$router1 set int name memif12/2 right"
$router1 set int name memif12/2 right
$router1 show int 

echo_g "---- router1 config done ----"

# router2
echo_g "---- Set up router2 ----"

echo_b "sudo vpp -c ./vRouters/router2.conf"
sudo vpp -c ./vRouters/router2.conf
echo "waiting..."
sleep 5
ls /run/vpp

router2="sudo vppctl -s /run/vpp/router2.sock"

echo_y "$router2 create memif socket id 12 filename /run/vpp/memif12.sock"
$router2 create memif socket id 12 filename /run/vpp/memif12.sock
echo_y "$router2 create memif socket id 12 filename /run/vpp/memif12.sock"
$router2 create memif socket id 13 filename /run/vpp/memif13.sock
echo_y "$router2 create memif socket id 14 filename /run/vpp/memif14.sock"
$router2 create memif socket id 14 filename /run/vpp/memif14.sock
ls /run/vpp

echo_g "add loopback interface"
echo_y " $router2 loopback create-interface"
$router2 loopback create-interface

echo_y "$router2 create interface memif id 2 socket-id 12 slave"
$router2 create interface memif id 2 socket-id 12 slave
echo_y "$router2 set int name memif12/2 left"
$router2 set int name memif12/2 left
echo_y "$router2 create interface memif id 3 socket-id 13 master"
$router2 create interface memif id 3 socket-id 13 master
echo_y "$router2 set int name memif13/3 right1"
$router2 set int name memif13/3 right1
echo_y "$router2 create interface memif id 4 socket-id 14 master"
$router2 create interface memif id 4 socket-id 14 master
echo_y "$router2 set int name memif14/4 right2"
$router2 set int name memif14/4 right2
$router2 show int

echo_g "---- router2 config done ----"

# router3
echo_g "---- Set up router3 ----"

echo_b "sudo vpp -c ./vRouters/router3.conf"
sudo vpp -c ./vRouters/router3.conf
echo "waiting..."
sleep 5
ls /run/vpp

router3="sudo vppctl -s /run/vpp/router3.sock"

echo_y "$router3 create memif socket id 13 filename /run/vpp/memif13.sock"
$router3 create memif socket id 13 filename /run/vpp/memif13.sock
echo_y "$router3 create memif socket id 15 filename /run/vpp/memif15.sock"
$router3 create memif socket id 15 filename /run/vpp/memif15.sock
echo_y "$router3 create memif socket id 16 filename /run/vpp/memif16.sock"
$router3 create memif socket id 16 filename /run/vpp/memif16.sock
ls /run/vpp

echo_g "add loopback interface"
echo_y " $router3 loopback create-interface"
$router3 loopback create-interface

echo_y "$router3 create interface memif id 3 socket-id 13 slave"
$router3 create interface memif id 3 socket-id 13 slave
echo_y "$router3 set int name memif13/3 left1"
$router3 set int name memif13/3 left1
echo_y "$router3 create interface memif id 5 socket-id 15 master"
$router3 create interface memif id 5 socket-id 15 master
echo_y "$router3 set int name memif15/5 left2"
$router3 set int name memif15/5 left2
echo_y "$router3 create interface memif id 6 socket-id 16 master"
$router3 create interface memif id 6 socket-id 16 master
echo_y "$router3 set int name memif16/6 right"
$router3 set int name memif16/6 right
$router3 show int

echo_g "---- router3 config done ----"

# router4
echo_g "---- Set up router4 ----"

echo_b "sudo vpp -c ./vRouters/router4.conf"
sudo vpp -c ./vRouters/router4.conf
echo "waiting..."
sleep 5
ls /run/vpp

router4="sudo vppctl -s /run/vpp/router4.sock"

echo_y "$router4 create memif socket id 14 filename /run/vpp/memif14.sock"
$router4 create memif socket id 14 filename /run/vpp/memif14.sock
echo_y "$router4 create memif socket id 15 filename /run/vpp/memif15.sock"
$router4 create memif socket id 15 filename /run/vpp/memif15.sock
ls /run/vpp

echo_g "add loopback interface"
echo_y " $router4 loopback create-interface"
$router4 loopback create-interface

echo_y "$router4 create interface memif id 4 socket-id 14 slave"
$router4 create interface memif id 4 socket-id 14 slave
echo_y "$router4 set int name memif14/4 left"
$router4 set int name memif14/4 left
echo_y "$router4 create interface memif id 5 socket-id 15 slave"
$router4 create interface memif id 5 socket-id 15 slave
echo_y "$router4 set int name memif15/5 right"
$router4 set int name memif15/5 right
$router4 show int

echo_g "---- router4 config done ----"

# router5
echo_g "---- Set up router5 ----"

echo_b "sudo vpp -c ./vRouters/router5.conf"
sudo vpp -c ./vRouters/router5.conf
echo "waiting..."
sleep 5
ls /run/vpp

router5="sudo vppctl -s /run/vpp/router5.sock"

echo_y "$router5 create memif socket id 16 filename /run/vpp/memif16.sock"
$router5 create memif socket id 16 filename /run/vpp/memif16.sock
echo_y "$router5 create memif socket id 17 filename /run/vpp/memif17.sock"
$router5 create memif socket id 17 filename /run/vpp/memif17.sock
ls /run/vpp

echo_g "add loopback interface"
echo_y " $router5 loopback create-interface"
$router5 loopback create-interface

echo_y "$router5 create interface memif id 6 socket-id 16 slave"
$router5 create interface memif id 6 socket-id 16 slave
echo_y "$router5 set int name memif16/6 left"
$router5 set int name memif16/6 left
echo_y "$router5 create interface memif id 7 socket-id 17 master"
$router5 create interface memif id 7 socket-id 17 master
echo_y "$router5 set int name memif17/7 right"
$router5 set int name memif17/7 right
$router5 show int

echo_g "---- router5 config done ----"

# ======================================
# CPE topo
# ======================================
echo_r "===== Set up all CPE ! ====="
# cpe1 
echo_g "---- Set up cpe1 ----"

echo_b "sudo vpp -c ./vRouters/cpe1.conf"
sudo vpp -c ./vRouters/cpe1.conf
echo "waiting..."
sleep 5
ls /run/vpp

cpe1="sudo vppctl -s /run/vpp/cpe1.sock"

echo_y "$cpe1 create memif socket id 10 filename /run/vpp/memif10.sock"
$cpe1 create memif socket id 10 filename /run/vpp/memif10.sock
echo_y "$cpe1 create memif socket id 11 filename /run/vpp/memif11.sock"
$cpe1 create memif socket id 11 filename /run/vpp/memif11.sock
ls /run/vpp

echo_g "add loopback interface"
echo_y " $cpe1 loopback create-interface"
$cpe1 loopback create-interface

echo_y "$cpe1 create interface memif id 0 socket-id 10 master"
$cpe1 create interface memif id 0 socket-id 10 master
echo_y "$cpe1 set int name memif10/0 left"
$cpe1 set int name memif10/0 left
echo_y "$cpe1 create interface memif id 1 socket-id 11 master"
$cpe1 create interface memif id 1 socket-id 11 master
echo_y "$cpe1 set int name memif11/1 right"
$cpe1 set int name memif11/1 right
$cpe1 show int
echo_g "---- cpe1 config done ----"

# cpe2
echo_g "---- Set up cpe2 ----"

echo_b "sudo vpp -c ./vRouters/cpe2.conf"
sudo vpp -c ./vRouters/cpe2.conf
echo "waiting..."
sleep 5
ls /run/vpp

cpe2="sudo vppctl -s /run/vpp/cpe2.sock"

echo_y "$cpe2 create memif socket id 17 filename /run/vpp/memif17.sock"
$cpe2 create memif socket id 17 filename /run/vpp/memif17.sock
echo_y "$cpe2 create memif socket id 18 filename /run/vpp/memif18.sock"
$cpe2 create memif socket id 18 filename /run/vpp/memif18.sock
ls /run/vpp

echo_g "add loopback interface"
echo_y " $cpe2 loopback create-interface"
$cpe2 loopback create-interface

echo_y "$cpe2 create interface memif id 7 socket-id 17 slave"
$cpe2 create interface memif id 7 socket-id 17 slave
echo_y "$cpe2 set int name memif17/7 left"
$cpe2 set int name memif17/7 left
echo_y "$cpe2 create interface memif id 8 socket-id 18 master"
$cpe2 create interface memif id 8 socket-id 18 master
echo_y "$cpe2 set int name memif18/8 right"
$cpe2 set int name memif18/8 right
$cpe2 show int
echo_g "---- cpe2 config done ----"

echo_r "===== CPE setup done ! ====="
# ==================================
# host
# ==================================
echo_g "==== Set up hosts ===="

# host1
echo_g "---- Set up host1 ----"

echo_b "sudo vpp -c ./vRouters/host1.conf"
sudo vpp -c ./vRouters/host1.conf
echo "waiting..."
sleep 5
ls /run/vpp

host1="sudo vppctl -s /run/vpp/host1.sock"

echo_y "$host1 create memif socket id 10 filename /run/vpp/memif10.sock"
$host1 create memif socket id 10 filename /run/vpp/memif10.sock
ls /run/vpp

echo_y "$host1 create interface memif id 0 socket-id 10 slave"
$host1 create interface memif id 0 socket-id 10 slave
echo_y "$host1 set int name memif10/0 G"
$host1 set int name memif10/0 G
$host1 show int

echo_g "---- host1 config done ----"

# host2
echo_g "---- Set up host2 ----"

echo_b "sudo vpp -c ./vRouters/host2.conf"
sudo vpp -c ./vRouters/host2.conf
echo "waiting..."
sleep 5
ls /run/vpp

host2="sudo vppctl -s /run/vpp/host2.sock"

echo_y "$host2 create memif socket id 18 filename /run/vpp/memif18.sock"
$host2 create memif socket id 18 filename /run/vpp/memif18.sock
ls /run/vpp

echo_y "$host2 create interface memif id 8 socket-id 18 slave"
$host2 create interface memif id 8 socket-id 18 slave
echo_y "$host2 set int name memif18/8 G"
$host2 set int name memif18/8 G
$host2 show int

echo_g "---- host2 config done ----"

echo_g "==== hosts setup done ===="

echo_r "==== Switches setup done ！ ===="

# ====================
# config ip
# ====================
echo_r "==== config ip ===="
# host1
echo_g "---- config host1 ip ----"

echo_y "$host1 set int state G up"
$host1 set int state G up
echo_y "$host1 set int ip addr G 10.10.2.2/24"
$host1 set int ip addr G 10.10.2.2/24
echo_y "$host1 ip route add 10.10.1.0/24 table 0 via 10.10.2.1 G"
$host1 ip route add 10.10.1.0/24 table 0 via 10.10.2.1 G
$host1 show int addr
echo_g "---- host1 ip config done ----"

# host2
echo_g "---- config host2 ip ----"

echo_y "$host2 set int state G up"
$host2 set int state G up
echo_y "$host2 set int ip addr G 10.10.1.2/24"
$host2 set int ip addr G 10.10.1.2/24
echo_y "$host2 ip route add 10.10.2.0/24 table 0 via 10.10.1.1 G"
$host2 ip route add 10.10.2.0/24 table 0 via 10.10.1.1 G
$host2 show int addr
echo_g "---- host2 ip config done ----"

# cpe1
echo_g "---- config cpe1 ip ----"

echo_y "$cpe1 set int state left up"
$cpe1 set int state left up
echo_y "$cpe1 set int ip address left 10.10.2.1/24"
$cpe1 set int ip address left 10.10.2.1/24
echo_y "$cpe1 set int state right up"
$cpe1 set int state right up
echo_y "$cpe1 set int ip address right fdaa::1/96"
$cpe1 set int ip address right fdaa::1/96
echo_y "$cpe1 set int state loop0 up"
$cpe1 set int state loop0 up
echo_y "$cpe1 set int ip address loop0 fc01::1/96"
$cpe1 set int ip address loop0 fc01::1/96
$cpe1 show int addr

echo_y "$cpe1 ip route add 10.10.2.0/24 via fdaa::2"
$cpe1 ip route add 10.10.2.0/24 via fdaa::2
echo_y "$cpe1 ip route add fdaa::/96 via 10.10.2.2"
$cpe1 ip route add fdaa::/96 via 10.10.2.2

echo_g "---- cpe1 ip config done ----"

# cpe2 
echo_g "---- config cpe2 ip ----"

echo_y "$cpe2 set int state left up"
$cpe2 set int state left up
echo_y "$cpe2 set int ip address left fdba::2/96"
$cpe2 set int ip address left fdba::2/96
echo_y "$cpe2 set int state right up"
$cpe2 set int state right up
echo_y "$cpe2 set int ip address right 10.10.1.1/24"
$cpe2 set int ip address right 10.10.1.1/24
echo_y "$cpe2 set int state loop0 up"
$cpe2 set int state loop0 up
echo_y "$cpe2 set int ip address loop0 fc07::1/96"
$cpe2 set int ip address loop0 fc07::1/96
$cpe2 show int addr

echo_y "$cpe2 ip route add 10.10.1.0/24 via fdba::1"
$cpe2 ip route add 10.10.1.0/24 via fdba::1
echo_y "$cpe2 ip route add fdba::/96 via 10.10.1.2"
$cpe2 ip route add fdba::/96 via 10.10.1.2

echo_g "---- cpe2 ip config done ----"

# router1
echo_g "---- config router1 ip ----"

echo_y "$router1 set int state left1 up"
$router1 set int state left1 up
echo_y "$router1 set int ip addr left1 fdaa::2/96"
$router1 set int ip addr left1 fdaa::2/96
echo_y "$router1 set int state right up"
$router1 set int state right up
echo_y "$router1 set int ip addr right fdab::1/96"
$router1 set int ip addr right fdab::1/96
echo_y "$router1 set int state loop0 up"
$router1 set int state loop0 up
echo_y "$router1 set int ip addr loop0 fc02::1/96"
$router1 set int ip addr loop0 fc02::1/96
$router1 show int addr

echo_y "$router1 ip route add fdaa::/96 via fdab::2"
$router1 ip route add fdaa::/96 via fdab::2
echo_y "$router1 ip route add fdab::/96 via fdaa::1"
$router1 ip route add fdab::/96 via fdaa::1
echo_g "---- router1 ip config done ----"

# router2
echo_g "---- config router2 ip ----"

echo_y "$router2 set int state left up"
$router2 set int state left up
echo_y "$router2 set int ip addr left fdab::2/96"
$router2 set int ip addr left fdab::2/96
echo_y "$router2 set int state right1 up"
$router2 set int state right1 up
echo_y "$router2 set int ip addr right1 fdac::1/96"
$router2 set int ip addr right1 fdac::1/96
$router2 set int state right2 up
echo_y "$router2 set int ip addr right2 fdad::1/96"
$router2 set int ip addr right2 fdad::1/96
echo_y "$router2 set int state loop0 up"
$router2 set int state loop0 up
echo_y "$router2 set int ip addr loop0 fc03::1/96"
$router2 set int ip addr loop0 fc03::1/96
$router2 show int addr

echo_y "$router2 ip route add fdab::/96 via fdac::2"
$router2 ip route add fdab::/96 via fdac::2
echo_y "$router2 ip route add fdab::/96 via fdad::2"
$router2 ip route add fdab::/96 via fdad::2
echo_y "$router2 ip route add fdac::/96 via fdab::1"
$router2 ip route add fdac::/96 via fdab::1
echo_y "$router2 ip route add fdad::/96 via fdab::1"
$router2 ip route add fdad::/96 via fdab::1

echo_g "---- router2 ip config done ----"

# router3
echo_g "---- config router3 ip ----"

echo_y "$router3 set int state left1 up"
$router3 set int state left1 up
echo_y "$router3 set int ip addr left1 fdac::2/96"
$router3 set int ip addr left1 fdac::2/96
echo_y "$router3 set int state left2 up"
$router3 set int state left2 up
echo_y "$router3 set int ip addr left2 fdae::1/96"
$router3 set int ip addr left2 fdae::1/96
echo_y "$router3 set int state right up"
$router3 set int state right up
echo_y "$router3 set int ip addr right fdaf::1/96"
$router3 set int ip addr right fdaf::1/96
echo_y "$router3 set int state loop0 up"
$router3 set int state loop0 up
echo_y "$router3 set int ip addr loop0 fc05::1/96"
$router3 set int ip addr loop0 fc05::1/96
$router3 show int addr

echo_y "$router3 ip route add fdac::/96 via fdaf::2"
$router3 ip route add fdac::/96 via fdaf::2
echo_y "$router3 ip route add fdae::/96 via fdaf::2"
$router3 ip route add fdae::/96 via fdaf::2
echo_y "$router3 ip route add fdaf::/96 via fdac::1"
$router3 ip route add fdaf::/96 via fdac::1
echo_y "$router3 ip route add fdaf::/96 via fdae::2"
$router3 ip route add fdaf::/96 via fdae::2

echo_g "---- router3 ip config done ----"

# router4
echo_g "---- config router4 ip ----"

echo_y "$router4 set int state left up"
$router4 set int state left up
echo_y "$router4 set int ip addr left fdad::2/96"
$router4 set int ip addr left fdad::2/96
echo_y "$router4 set int state right up"
$router4 set int state right up
echo_y "$router4 set int ip addr right fdae::2/96"
$router4 set int ip addr right fdae::2/96
echo_y "$router4 set int state loop0 up"
$router4 set int state loop0 up
echo_y "$router4 set int ip addr loop0 fc04::1/96"
$router4 set int ip addr loop0 fc04::1/96
$router4 show int addr

echo_y "$router4 ip route add fdad::/96 via fdae::1"
$router4 ip route add fdad::/96 via fdae::1
echo_y "$router4 ip route add fdae::/96 via fdad::1"
$router4 ip route add fdae::/96 via fdad::1
echo_g "---- router4 ip config done ----"

# router5
echo_g "---- config router5 ip ----"

echo_y "$router5 set int state left up"
$router5 set int state left up
echo_y "$router5 set int ip addr left fdaf::2/96"
$router5 set int ip addr left fdaf::2/96
echo_y "$router5 set int state right up"
$router5 set int state right up
echo_y "$router5 set int ip addr right fdba::1/96"
$router5 set int ip addr right fdba::1/96
echo_y "$router5 set int state loop0 up"
$router5 set int state loop0 up
echo_y "$router5 set int ip addr loop0 fc06::1/96"
$router5 set int ip addr loop0 fc06::1/96
$router5 show int addr

echo_y "$router5 ip route add fdaf::/96 via fdba::2"
$router5 ip route add fdaf::/96 via fdba::2
echo_y "$router5 ip route add fdba::/96 via fdaf::1"
$router5 ip route add fdba::/96 via fdaf::1
echo_g "---- router5 ip config done ----"

echo_r "==== ip config done ===="

# ip config test
if false;then
echo_r "==== ip config ping test ===="

echo_g "host1 to cpe1"
$host1 ping 10.10.2.1
echo_g "cpe1 to host1"
$cpe1 ping 10.10.2.2

echo_g "cpe1 to router1"
$cpe1 ping fdaa::2
echo_g "router1 to cpe1"
$router1 ping fdaa::1

echo_g "router1 to router2"
$router1 ping fdab::2
echo_g "router2 to router1"
$router2 ping fdab::1

echo_g "router2 to router3"
$router2 ping fdac::2
echo_g "router3 to router2"
$router3 ping fdac::1

echo_g "router2 to router4"
$router2 ping fdad::2
echo_g "router4 to router2"
$router4 ping fdad::1

echo_g "router4 to router3"
$router4 ping fdae::1
echo_g "router3 to router4"
$router4 ping fdae::2

echo_g "router3 to router5"
$router3 ping fdaf::2
echo_g "router5 to router3"
$router5 ping fdaf::1

echo_g "router5 to cpe2"
$router5 ping fdba::2
echo_g "cpe2 to router5"
$cpe2 ping fdba::1

echo_g "cpe2 to host2"
$cpe2 ping 10.10.1.2
echo_g "host2 to cpe2"
$host2 ping 10.10.1.1

fi

if false;then
# ====================
# config sr
# ====================
echo_r "==== config sr ===="

# router1
echo_g "---- config router1 sr ----"
echo_y "$router1 sr localsid address fc02::1a behavior end"
$router1 sr localsid address fc02::1a behavior end
$router1 show sr localsid
echo_g "---- router1 sr config done ----"


# router2
echo_g "---- config router2 sr ----"
echo_y "$router2 sr localsid address fc03::1a behavior end"
$router2 sr localsid address fc03::1a behavior end
$router2 show sr localsid
echo_g "---- router2 sr config done ----"

# router3
echo_g "---- config router3 sr ----"
echo_y "$router3 sr localsid address fc05::1a behavior end"
$router3 sr localsid address fc05::1a behavior end
$router3 show sr localsid
echo_g "---- router3 sr config done ----"

# router4
echo_g "---- config router4 sr ----"
echo_y "$router4 sr localsid address fc04::1a behavior end"
$router4 sr localsid address fc04::1a behavior end
$router4 show sr localsid
echo_g "---- router1 sr config done ----"

# router5
echo_g "---- config router5 sr ----"
echo_y "$router5 sr localsid address fc06::1a behavior end"
$router5 sr localsid address fc06::1a behavior end
$router5 show sr localsid
echo_g "---- router1 sr config done ----"

# cpe1
echo_g "---- config cpe1 sr ----"
echo_y "$cpe1 sr localsid address fc01::1a behavior end.dx4 left 10.10.2.2"
$cpe1 sr localsid address fc01::1a behavior end.dx4 left 10.10.2.2
echo_y "$cpe1 sr policy add bsid fe10::1a next fc02::1a next fc03::1a next fc05::1a next fc06::1a next fc07::1a encap"
$cpe1 sr policy add bsid fe10::1a next fc02::1a next fc03::1a next fc05::1a next fc06::1a next fc07::1a encap
echo_y "$cpe1 sr steer l3 10.10.2.0/24 via bsid fe10::1a"
$cpe1 sr steer l3 10.10.2.0/24 via bsid fe10::1a
echo_y "$cpe1 show sr localsid"
$cpe1 show sr localsid
echo_g "---- cpe1 config sr done ----"

# cpe2
echo_g "---- config cpe2 sr ----"
echo_y "$cpe2 sr localsid address fc07::1a behavior end.dx4 right 10.10.1.2"
$cpe2 sr localsid address fc07::1a behavior end.dx4 right 10.10.1.2
echo_y "$cpe2 sr policy add bsid fe01::1a next fc06::1a next fc05::1a next fc04::1a next fc03::1a next fc02::1a next fc01::1a encap"
$cpe2 sr policy add bsid fe01::1a next fc06::1a next fc05::1a next fc04::1a next fc03::1a next fc02::1a next fc01::1a encap
echo_y "$cpe2 sr steer l3 10.10.1.0/24 via bsid fe01::1a"
$cpe2 sr steer l3 10.10.1.0/24 via bsid fe01::1a
echo_y "$cpe2 show sr localsid"
$cpe2 show sr localsid
echo_g "---- cpe2 config sr done ----"

echo_r "==== sr config done ===="
fi

# =======================
# sr test
# =======================
if true;then
echo_g "sr ping test:"
$host1 ping 10.10.1.2
fi
