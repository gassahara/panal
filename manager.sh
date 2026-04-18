#!/bin/bash
pasa=0
nomprograma=$0
slash=$(echo "$nomprograma"| ./stdbuscaarg_donde_hasta "/" )
while [ -n "$slash" ];do
    nomprograma=$(echo "$nomprograma"| ./stdcdr "/" )
    slash=$(echo "$nomprograma" | ./stdbuscaarg_donde_hasta "/" )
done

PrPWD="$PWD"

selected=0
total_items=2

mkdir -p logs
if command -v screen >/dev/null 2>&1; then
    HAS_SCREEN=1
else
    HAS_SCREEN=0
fi

while true; do
    ./stdtermclear

    ./stdtermgoto 2 2
    ./stdtermcolor 37 44 # White on Blue
    echo -n "===================================="
    ./stdtermgoto 3 2
    echo -n "     NUBE BILLBOARDS MANAGER        "
    ./stdtermgoto 4 2
    echo -n "===================================="
    ./stdtermreset
    
    ./stdtermgoto 6 2
    echo -n "Controls: UP/DOWN select, SPACE toggle, V or L to View Logs, Q to exit."

    # Loop and draw the billboards
    for (( i=0; i<total_items; i++ )); do
        consumer=$(./stdprintarrayval billboards.c consumers $i)
        status=$(./stdprintarrayval billboards.c status $i)
        
        row=$(( 8 + i * 2 ))
        ./stdtermgoto $row 4
        
        if [ "$i" -eq "$selected" ]; then
            ./stdtermcolor 30 47 # Black on White
            echo -n " > $consumer : [$status] "
            ./stdtermreset
        else
            if [ "$status" = "enabled" ]; then
                ./stdtermcolor 32 # Green
            else
                ./stdtermcolor 31 # Red
            fi
            echo -n "   $consumer : [$status] "
            ./stdtermreset
        fi
    done
    
    ./stdtermgoto $(( 10 + total_items * 2 )) 2

    key=$(./stdtermreadkey)
    
    case "$key" in
        "UP")
            if [ $selected -gt 0 ]; then selected=$((selected - 1)); fi
            ;;
        "DOWN")
            if [ $selected -lt $((total_items - 1)) ]; then selected=$((selected + 1)); fi
            ;;
        "SPACE")
            consumer=$(./stdprintarrayval billboards.c consumers $selected)
            status=$(./stdprintarrayval billboards.c status $selected)
            if [ "$status" = "enabled" ]; then
                ./stdreplacearrayval billboards.c status $selected "disabled"
                
                # Stop the daemon
                if [ "$HAS_SCREEN" -eq 1 ]; then
                    screen -S "$consumer" -X quit 2>/dev/null
                fi
                pid=$(ps -ef | grep "$consumer" | grep -v "grep" | grep -v "screen" | awk '{print $2}' | head -n 1)
                if [ -n "$pid" ]; then
                    kill -9 $pid 2>/dev/null
                fi
            else
                ./stdreplacearrayval billboards.c status $selected "enabled"
                
                # Start the daemon
                pid=$(ps -ef | grep "$consumer" | grep -v "grep" | grep -v "screen" | awk '{print $2}' | head -n 1)
                if [ -z "$pid" ]; then
                    if [ "$HAS_SCREEN" -eq 1 ]; then
                        screen -dmS "$consumer" bash -c "./$consumer > logs/$consumer.log 2>&1"
                    else
                        ./$consumer > logs/$consumer.log 2>&1 &
                    fi
                fi
            fi
            ;;
        "LOGS")
            consumer=$(./stdprintarrayval billboards.c consumers $selected)
            if [ -f "logs/$consumer.log" ]; then
                ./stdtermclear
                echo "Viewing live logs for $consumer..."
                echo "--> Press [Ctrl+C] to stop viewing and return to Manager <--"
                echo "================================================================="
                trap '' SIGINT
                tail -f "logs/$consumer.log"
                trap - SIGINT
            else
                ./stdtermgoto $(( 12 + total_items * 2 )) 2
                ./stdtermcolor 31
                echo -n "No log file found yet for $consumer"
                ./stdtermreset
                sleep 2
            fi
            ;;
        "QUIT")
            ./stdtermclear
            exit 0
            ;;
    esac
done
